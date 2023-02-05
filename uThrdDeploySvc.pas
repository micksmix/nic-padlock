unit uThrdDeploySvc;

{$WEAKLINKRTTI ON}
{$RTTI EXPLICIT METHODS([]) PROPERTIES([]) FIELDS([])}

interface

uses
  Classes,
  SysUtils,
  StrUtils,
  Windows,
  uGlobal,
  uHelpers,
  PerlRegEx,
  Registry,
  Variants,
  ActiveX,
  ComObj,
  uRemoteNicMgrUtils,
  WinSvc,
  ThreadUtilities;

type
  TDeploySvc = class(TObject) //class(TThread)
  strict private
    FFormHandle: THandle;
    FThreadPool: TThreadPool;
    //procedure UpdateCaption;
  private
    procedure PrepareThreadVars;
    procedure ExecuteWork(Data: Pointer; AThread: TThread);
    procedure UpdateDeploymentResult(Params: TCmdParams);
    procedure DeployNetLockerSvc(Params: TCmdParams);
    procedure SetSvcLaunchParameters(LaunchParams: TCmdParams);
    procedure InstallService(const sServiceName, sDisplayName, sMachineName,
      FileName: string; const Silent: Boolean);
    function IsServiceInstalled(sMachine, sService: string): Boolean;
    function DoStopService(sMachine, sServiceName: string): TSvcStatus;
    function GetServiceStatus(sMachine, sServiceName: string): TSvcStatus;
    function DoStartService(sMachine, sServiceName: string): TSvcStatus;
    procedure SendProcessLogMsg(sMsg: string);
    { Private declarations }
  public
    procedure BeginWork(athrdtask: PRemoteTask);
    constructor Create(formHandle: THandle);
    destructor Destroy; override;
  end;

threadvar
  FCurThreadTask              : PRemoteTask;
  FResult                     : string;

implementation

procedure CoUninit(Success: HResult);
begin
  case Success of
    S_OK, S_FALSE: CoUninitialize;
  end;
end;

constructor TDeploySvc.Create(formHandle: THandle);
begin
  FFormHandle := formHandle;
  FThreadPool := TThreadPool.Create(ExecuteWork, MAX_DEPLOYSVC_THREADS);

  inherited Create;
end;

destructor TDeploySvc.Destroy;
begin
  FThreadPool.Free;
  inherited;
end;

procedure TDeploySvc.PrepareThreadVars();
begin
  FResult := '';
end;

procedure TDeploySvc.BeginWork(athrdtask: PRemoteTask);
begin
  FThreadPool.Add(athrdtask);
end;

function TDeploySvc.DoStartService(sMachine, sServiceName: string): TSvcStatus;
var
  hService                    : SC_HANDLE;
  SCManager                   : SC_HANDLE;
  pDummy                      : PChar;
  Tries                       : Integer;
begin
  Result := GetServiceStatus(sMachine, sServiceName);
  if Result <> ssStopped then
    Exit;

  SCManager := OpenSCManager(PChar(sMachine), nil, SC_MANAGER_ALL_ACCESS);
  if SCManager = 0 then
    Exit;

  try
    begin
      hService := OpenService(SCManager, PChar(sServiceName), SERVICE_START);

      if hService = 0 then
        Exit;

      try
        pDummy := nil;
        if StartService(hService, 0, pDummy) then
        begin
          Tries := 10;
          repeat
            Sleep(1000);
            Result := GetServiceStatus(sMachine, sServiceName);
            Dec(Tries);
          until (Tries = 0) or (Result = ssRunning);
        end
        else
        begin
          Result := ssError;
        end;
      finally
        CloseServiceHandle(hService);
      end;
    end;
  finally
    CloseServiceHandle(SCManager);
  end;
end;

function TDeploySvc.GetServiceStatus(sMachine, sServiceName: string): TSvcStatus;
var
  dwStatus                    : DWord;
  hService                    : SC_HANDLE;
  SCManager                   : SC_HANDLE;
  ServiceStatus               : TServiceStatus;
begin
  dwStatus := 0;

  SCManager := OpenSCManager(PChar(sMachine), nil, SC_MANAGER_CONNECT);
  if SCManager = 0 then
    Exit;

  try
    hService := OpenService(SCManager, PChar(sServiceName), SERVICE_QUERY_STATUS);
    if hService = 0 then
      Exit;

    try
      if QueryServiceStatus(hService, ServiceStatus) then
      begin
        dwStatus := ServiceStatus.dwCurrentState;
      end;
    finally
      CloseServiceHandle(hService);
    end;

  finally
    CloseServiceHandle(SCManager);
  end;
  Result := TSvcStatus(dwStatus);
end;

function TDeploySvc.DoStopService(sMachine, sServiceName: string): TSvcStatus;
var
  hService                    : SC_HANDLE;
  SCManager                   : SC_HANDLE;
  ServiceStatus               : TServiceStatus;
  Tries                       : Integer;
begin
  Result := GetServiceStatus(sMachine, sServiceName);
  if Result <> ssRunning then
    Exit;

  SCManager := OpenSCManager(PChar(sMachine), nil, SC_MANAGER_ALL_ACCESS);
  if SCManager = 0 then
    Exit;

  try
    hService := OpenService(SCManager, PChar(sServiceName), GENERIC_EXECUTE);

    if hService = 0 then
      Exit;

    try
      if ControlService(hService, SERVICE_CONTROL_STOP, ServiceStatus) then
      begin
        Tries := 10;
        repeat
          Sleep(1000);
          Dec(Tries);
          Result := GetServiceStatus(sMachine, sServiceName);
        until (Tries = 0) or (Result = ssStopped);
      end
      else
      begin
        Result := ssError;
      end;
    finally
      CloseServiceHandle(hService);
    end;
  finally
    CloseServiceHandle(SCManager);
  end;
end;

procedure TDeploySvc.SendProcessLogMsg(sMsg: string);
var
  msg_prm                     : PWMMgMessageLog;
begin
  New(msg_prm);
  msg_prm.host := FCurThreadTask.Params.sHostName;
  msg_prm.group := FCurThreadTask.Params.sGroup;
  msg_prm.msg := sMsg;

  if not PostMessage(FFormHandle, WM_POSTED_MSG, WM_THRD_DEPLOYSVC_PROCESS_LOG, integer(msg_prm))
    then
  begin
    Sleep(35);
    PostMessage(FFormHandle, WM_POSTED_MSG, WM_THRD_DEPLOYSVC_PROCESS_LOG, integer(msg_prm));
    if not PostMessage(FFormHandle, WM_POSTED_MSG, WM_THRD_DEPLOYSVC_PROCESS_LOG, integer(msg_prm))
      then
    begin
      Sleep(35);
      PostMessage(FFormHandle, WM_POSTED_MSG, WM_THRD_DEPLOYSVC_PROCESS_LOG, integer(msg_prm));
    end;
  end;
end;

procedure TDeploySvc.UpdateDeploymentResult(Params: TCmdParams);
var
  msg_prm                     : PWMDeploySvcCommand;
begin
  New(msg_prm);
  msg_prm.host := Params.sHostName;
  msg_prm.group := Params.sGroup;
  msg_prm.result := FResult;

  if not PostMessage(FFormHandle, WM_POSTED_MSG, WM_THRD_DEPLOYSVC_DONE, integer(msg_prm)) then
  begin
    Sleep(35);
    PostMessage(FFormHandle, WM_POSTED_MSG, WM_THRD_DEPLOYSVC_DONE, integer(msg_prm));
    if not PostMessage(FFormHandle, WM_POSTED_MSG, WM_THRD_DEPLOYSVC_DONE, integer(msg_prm)) then
    begin
      Sleep(35);
      PostMessage(FFormHandle, WM_POSTED_MSG, WM_THRD_DEPLOYSVC_DONE, integer(msg_prm));
    end;
  end;
  FResult := '';
end;

procedure TDeploySvc.InstallService(const sServiceName, sDisplayName, sMachineName: string; const
  FileName: string; const Silent: Boolean);
const
  cInstallMsg                 = 'Service was successfully installed.';
  cSCMError                   = '*** Error accessing the service controller';
var
  SCMHandle                   : SC_HANDLE;
  SvHandle                    : SC_HANDLE;
  LoadOrder                   : PChar;
begin
  SCMHandle := OpenSCManager(PChar(sMachineName), nil, SC_MANAGER_ALL_ACCESS);

  if SCMHandle = 0 then
  begin
    //MessageBox(0, cSCMError, PChar(sServiceName), MB_ICONERROR or MB_OK or MB_TASKMODAL or MB_TOPMOST);
    SendProcessLogMsg(cSCMError);
    Exit;
  end;

  LoadOrder := 'ShellSvcGroup';
  try
    SvHandle := CreateService(SCMHandle,
      PChar(sServiceName),
      PChar(sDisplayName),
      SERVICE_ALL_ACCESS,
      SERVICE_WIN32_OWN_PROCESS,
      SERVICE_AUTO_START,
      SERVICE_ERROR_IGNORE,
      pchar(FileName),
      LoadOrder,
      nil,
      nil,
      nil,
      nil);
    CloseServiceHandle(SvHandle);

    SendProcessLogMsg(cInstallMsg);

    if not Silent then
      MessageBox(0, cInstallMsg, PChar(sServiceName), MB_ICONINFORMATION or MB_OK or MB_TASKMODAL or
        MB_TOPMOST);
  finally
    CloseServiceHandle(SCMHandle);
  end;
end;

function TDeploySvc.IsServiceInstalled(sMachine, sService: string): Boolean;
var
  SCManager                   : SC_HANDLE;
  SvcHandle                   : SC_HANDLE;
  bInstalled                  : boolean;
begin
  bInstalled := False;
  SCManager := OpenSCManager(PChar(sMachine), nil, SC_MANAGER_CONNECT);

  if SCManager = 0 then
    Exit;

  try
    SvcHandle := OpenService(SCManager, PChar(sService), SERVICE_QUERY_STATUS);
    if (SvcHandle > 0) then
    begin
      bInstalled := True;
      CloseServiceHandle(SvcHandle);
    end;
  finally

    CloseServiceHandle(SCManager);
  end;
  Result := bInstalled;
end;

procedure TDeploySvc.SetSvcLaunchParameters(LaunchParams: TCmdParams);
var
  FSWbemLocator               : OLEVariant;
  FWMIService                 : OLEVariant;
  FWbemObjectSet              : OLEVariant;
  FInParams                   : OLEVariant;
  FOutParams                  : OLEVariant;
  reg                         : TRegistry;
  sMachine                    : string;
  sMethod                     : string;
  sSubKeyName                 : string;
  sValueName                  : string;
  sValue                      : string;
  sCurAdapterGuid             : string;
  sAdapterGuids               : OLEVariant;
  ArrAdapterValue             : OLEVariant;
  iValue                      : Cardinal;
  idx                         : integer;
  Success                     : HRESULT;
begin

  Success := CoInitializeEx(nil, COINIT_MULTITHREADED); //   COINIT_APARTMENTTHREADED
  try
    FSWbemLocator := CreateOleObject('WbemScripting.SWbemLocator');
    sSubKeyName := 'SYSTEM\CurrentControlSet\Services\' + SERVICE_NAME + '\Parameters';

    if not LaunchParams.bUseCimv2 then
    begin
      FWMIService := FSWbemLocator.ConnectServer(LaunchParams.sHostAddr, 'root\default',
        LaunchParams.sUser,
        LaunchParams.sPass)
    end
    else
    begin
      //For Windows Vista or Windows 7 you should use the  root\CIMV2 namespace  (but dont have to)
      FWMIService := FSWbemLocator.ConnectServer(LaunchParams.sHostAddr, 'root\CIMV2',
        LaunchParams.sUser,
        LaunchParams.sPass);
    end;

    FWbemObjectSet := FWMIService.Get('StdRegProv');
    ///
    ///
    ///
    FInParams := FWbemObjectSet.Methods_.Item('CreateKey').InParameters.SpawnInstance_();
    FInParams.hDefKey := HKEY_LOCAL_MACHINE;
    FInParams.sSubKeyName := 'SYSTEM\CurrentControlSet\Services\' + SERVICE_NAME;

    FOutParams := FWMIService.ExecMethod('StdRegProv', 'CreateKey', FInParams);
    //OutputDebugString(PChar(Format('ReturnValue           %s', [FOutParams.ReturnValue])));
    ///
    ///
    ///
    FInParams := FWbemObjectSet.Methods_.Item('CreateKey').InParameters.SpawnInstance_();
    FInParams.hDefKey := HKEY_LOCAL_MACHINE;
    FInParams.sSubKeyName := sSubKeyName;

    FOutParams := FWMIService.ExecMethod('StdRegProv', 'CreateKey', FInParams);
    //OutputDebugString(PChar(Format('ReturnValue           %s', [FOutParams.ReturnValue])));
    ///
    ///
    ///
    sValueName := '';
    sValueName := uHelpers.VigenereExEncrypt('ShowUserMessage', VKEY);
    sMethod := 'SetDWORDValue';
    iValue := Ord(LaunchParams.bDisplayUserMessage);
    //
    FInParams := FWbemObjectSet.Methods_.Item(sMethod
      {'SetStringValue'}).InParameters.SpawnInstance_();
    FInParams.hDefKey := HKEY_LOCAL_MACHINE;
    FInParams.sSubKeyName := sSubKeyName; //'SOFTWARE\Borland\Delphi\5.0';
    FInParams.sValueName := sValueName; //'Dummy';
    FInParams.uValue := iValue; //'ADummyValue';

    FOutParams := FWMIService.ExecMethod('StdRegProv', sMethod {'SetStringValue'}, FInParams);
    //OutputDebugString(PChar(Format('ReturnValue           %s', [FOutParams.ReturnValue])));
    ///
    ///
    ///
    sValueName := '';
    sValueName := uHelpers.VigenereExEncrypt('UserMessage', VKEY);
    sMethod := 'SetStringValue';
    sValue := LaunchParams.sUserMessage;
    //
    FInParams := FWbemObjectSet.Methods_.Item(sMethod
      {'SetStringValue'}).InParameters.SpawnInstance_();
    FInParams.hDefKey := HKEY_LOCAL_MACHINE;
    FInParams.sSubKeyName := sSubKeyName; //'SOFTWARE\Borland\Delphi\5.0';
    FInParams.sValueName := sValueName; //'Dummy';
    FInParams.sValue := sValue; //'ADummyValue';

    FOutParams := FWMIService.ExecMethod('StdRegProv', sMethod {'SetStringValue'}, FInParams);
    //OutputDebugString(PChar(Format('ReturnValue           %s', [FOutParams.ReturnValue])));
    ///
    ///
    ///
    sValueName := '';
    sValueName := uHelpers.VigenereExEncrypt('EnumAdapters', VKEY);
    sMethod := 'SetDWORDValue';
    iValue := Ord(False);
    //
    FInParams := FWbemObjectSet.Methods_.Item(sMethod
      {'SetStringValue'}).InParameters.SpawnInstance_();
    FInParams.hDefKey := HKEY_LOCAL_MACHINE;
    FInParams.sSubKeyName := sSubKeyName; //'SOFTWARE\Borland\Delphi\5.0';
    FInParams.sValueName := sValueName; //'Dummy';
    FInParams.uValue := iValue; //'ADummyValue';

    FOutParams := FWMIService.ExecMethod('StdRegProv', sMethod {'SetStringValue'}, FInParams);
    //OutputDebugString(PChar(Format('ReturnValue           %s', [FOutParams.ReturnValue])));
    //Result := FOutParams.ReturnValue;
    ///
    ///
    ///
    sValueName := '';
    sValueName := uHelpers.VigenereExEncrypt('DisableAllAdapters', VKEY);
    sMethod := 'SetDWORDValue';
    iValue := Ord(LaunchParams.bDisableAllAdapters);
    //
    FInParams := FWbemObjectSet.Methods_.Item(sMethod
      {'SetStringValue'}).InParameters.SpawnInstance_();
    FInParams.hDefKey := HKEY_LOCAL_MACHINE;
    FInParams.sSubKeyName := sSubKeyName; //'SOFTWARE\Borland\Delphi\5.0';
    FInParams.sValueName := sValueName; //'Dummy';
    FInParams.uValue := iValue; //'ADummyValue';

    FOutParams := FWMIService.ExecMethod('StdRegProv', sMethod {'SetStringValue'}, FInParams);
    //OutputDebugString(PChar(Format('ReturnValue           %s', [FOutParams.ReturnValue])));
    //Result := FOutParams.ReturnValue;
    ///
    ///
    ///
    sValueName := '';
    sValueName := uHelpers.VigenereExEncrypt('EnableAllAdapters', VKEY);
    sMethod := 'SetDWORDValue';
    iValue := Ord(LaunchParams.bEnableAllAdapters);
    //
    FInParams := FWbemObjectSet.Methods_.Item(sMethod
      {'SetStringValue'}).InParameters.SpawnInstance_();
    FInParams.hDefKey := HKEY_LOCAL_MACHINE;
    FInParams.sSubKeyName := sSubKeyName; //'SOFTWARE\Borland\Delphi\5.0';
    FInParams.sValueName := sValueName; //'Dummy';
    FInParams.uValue := iValue; //'ADummyValue';

    FOutParams := FWMIService.ExecMethod('StdRegProv', sMethod {'SetStringValue'}, FInParams);
    //OutputDebugString(PChar(Format('ReturnValue           %s', [FOutParams.ReturnValue])));
    //Result := FOutParams.ReturnValue;
    ///
    ///
    ///
    sValueName := '';
    sValueName := uHelpers.VigenereExEncrypt('ModifySomeAdapter', VKEY);
    sMethod := 'SetDWORDValue';
    iValue := Ord(LaunchParams.bModifySomeAdapterState);
    //
    FInParams := FWbemObjectSet.Methods_.Item(sMethod
      {'SetStringValue'}).InParameters.SpawnInstance_();
    FInParams.hDefKey := HKEY_LOCAL_MACHINE;
    FInParams.sSubKeyName := sSubKeyName; //'SOFTWARE\Borland\Delphi\5.0';
    FInParams.sValueName := sValueName; //'Dummy';
    FInParams.uValue := iValue; //'ADummyValue';

    FOutParams := FWMIService.ExecMethod('StdRegProv', sMethod {'SetStringValue'}, FInParams);
    //OutputDebugString(PChar(Format('ReturnValue           %s', [FOutParams.ReturnValue])));
    //Result := FOutParams.ReturnValue;
    ///
    ///
    ///
    sValueName := '';
    sValueName := uHelpers.VigenereExEncrypt('ReEnableAllAdapters', VKEY);
    sMethod := 'SetDWORDValue';
    iValue := Ord(LaunchParams.bReEnableAdapters);
    //
    FInParams := FWbemObjectSet.Methods_.Item(sMethod
      {'SetStringValue'}).InParameters.SpawnInstance_();
    FInParams.hDefKey := HKEY_LOCAL_MACHINE;
    FInParams.sSubKeyName := sSubKeyName; //'SOFTWARE\Borland\Delphi\5.0';
    FInParams.sValueName := sValueName; //'Dummy';
    FInParams.uValue := iValue; //'ADummyValue';

    FOutParams := FWMIService.ExecMethod('StdRegProv', sMethod {'SetStringValue'}, FInParams);
    //OutputDebugString(PChar(Format('ReturnValue           %s', [FOutParams.ReturnValue])));
    //Result := FOutParams.ReturnValue;
    ///
    ///
    ///
//    sValueName := 'ReEnableSomeAdapter';
//    sMethod := 'SetDWORDValue';
//    iValue := Ord(LaunchParams.bReEnableSomeAdapter);
//    //
//    FInParams := FWbemObjectSet.Methods_.Item(sMethod
//      {'SetStringValue'}).InParameters.SpawnInstance_();
//    FInParams.hDefKey := HKEY_LOCAL_MACHINE;
//    FInParams.sSubKeyName := sSubKeyName; //'SOFTWARE\Borland\Delphi\5.0';
//    FInParams.sValueName := sValueName; //'Dummy';
//    FInParams.uValue := iValue; //'ADummyValue';

    FOutParams := FWMIService.ExecMethod('StdRegProv', sMethod {'SetStringValue'}, FInParams);
    //OutputDebugString(PChar(Format('ReturnValue           %s', [FOutParams.ReturnValue])));
    //Result := FOutParams.ReturnValue;
    ///
    ///
    ///
    //SetLength(arrAdapters, LaunchParams.slAdapterGuids.Count);
    //http://stackoverflow.com/questions/3619753/how-to-use-variant-arrays-in-delphi
  //  ArrAdapterValue := VarArrayCreate([0, LaunchParams.slAdapterGuids.Count - 1], varVariant);
    ArrAdapterValue := VarArrayCreate([0, Length(LaunchParams.arrAdapterGuids) - 1], varVariant);

    for idx := 0 to Length(LaunchParams.arrAdapterGuids) - 1 do
    begin
      sValueName := '';
      sValueName := uHelpers.VigenereExEncrypt(LaunchParams.arrAdapterGuids[idx], VKEY);
      ArrAdapterValue[idx] := sValueName;
      //    if idx = 0 then
      //      sAdapterGuids := LaunchParams.slAdapterGuids.Names[idx]
      //    else
      //      sAdapterGuids := LaunchParams.slAdapterGuids.Names[idx] + #13#10 + sAdapterGuids;
    end;

    sValueName := '';
    sValueName := uHelpers.VigenereExEncrypt('AdapterGuids', VKEY);
    sMethod := 'SetMultiStringValue'; //'SetStringValue';
    //sAdapterValue := sAdapterGuids;       //LaunchParams.sAdapterGuid;
    //
    FInParams := FWbemObjectSet.Methods_.Item(sMethod
      {'SetStringValue'}).InParameters.SpawnInstance_();
    FInParams.hDefKey := HKEY_LOCAL_MACHINE;
    FInParams.sSubKeyName := sSubKeyName; //'SOFTWARE\Borland\Delphi\5.0';
    FInParams.sValueName := sValueName; //'Dummy';
    FInParams.sValue := ArrAdapterValue; // sValue;           //'ADummyValue';

    FOutParams := FWMIService.ExecMethod('StdRegProv', sMethod {'SetStringValue'}, FInParams);
    //OutputDebugString(PChar(Format('ReturnValue           %s', [FOutParams.ReturnValue])));
    //Result := FOutParams.ReturnValue;
    ///
    ///
    ///
    sValueName := '';
    sValueName := uHelpers.VigenereExEncrypt('ProxyServer', VKEY);
    sMethod := 'SetStringValue';
    sValue := LaunchParams.sProxyServer;
    //
    FInParams := FWbemObjectSet.Methods_.Item(sMethod
      {'SetStringValue'}).InParameters.SpawnInstance_();
    FInParams.hDefKey := HKEY_LOCAL_MACHINE;
    FInParams.sSubKeyName := sSubKeyName; //'SOFTWARE\Borland\Delphi\5.0';
    FInParams.sValueName := sValueName; //'Dummy';
    FInParams.sValue := sValue; //'ADummyValue';

    FOutParams := FWMIService.ExecMethod('StdRegProv', sMethod {'SetStringValue'}, FInParams);
    //OutputDebugString(PChar(Format('ReturnValue           %s', [FOutParams.ReturnValue])));
    //Result := FOutParams.ReturnValue;
    ///
    ///
    ///
    sValueName := '';
    sValueName := uHelpers.VigenereExEncrypt('ReEnableAfter_X_Mins', VKEY);
    sMethod := 'SetDWORDValue';
    iValue := LaunchParams.iReEnableAfterMins;
    //
    FInParams := FWbemObjectSet.Methods_.Item(sMethod
      {'SetStringValue'}).InParameters.SpawnInstance_();
    FInParams.hDefKey := HKEY_LOCAL_MACHINE;
    FInParams.sSubKeyName := sSubKeyName; //'SOFTWARE\Borland\Delphi\5.0';
    FInParams.sValueName := sValueName; //'Dummy';
    FInParams.uValue := iValue; //'ADummyValue';

    FOutParams := FWMIService.ExecMethod('StdRegProv', sMethod {'SetStringValue'}, FInParams);
    //OutputDebugString(PChar(Format('ReturnValue           %s', [FOutParams.ReturnValue])));
    //Result := FOutParams.ReturnValue;

    SendProcessLogMsg('Launch parameters successfully set.');

  finally
    //CoUninitialize;
    CoUninit(Success);
  end;
end;

procedure TDeploySvc.DeployNetLockerSvc(Params: TCmdParams);
var
  sLocalSvcPath               : string;
  sRemoteImagePath            : string;
  sRemoteImageUncPath         : string;
  sRemoteVatNicMgrVer         : string;
  sSvcArguments               : string;
  Regex                       : TPerlRegex;
  bRemoteSvcInstalled         : boolean;
  idx                         : integer;
  sResultMsg                  : string;
  sIpcShare                   : string;
  RemoteKey                   : HKEY;
  bSetImagePath               : boolean;
  sShortUser                  : string;
begin
  //

  Params.bSetImagePath := False; //default
  Params.sImagePath := ''; //default

  {
  if not IsSystemOnlineNbt(Params.sHostAddr) then
  begin
    OutputDebugString(PChar('<' + Params.sHostAddr + '> is not online or could not be accessed!'));
    SendProcessLogMsg('<' + Params.sHostAddr + '> is not online or could not be accessed!');
    FResult := 'Host is not online or could not be accessed!';
    Exit;
  end;
  }

  if Params.bAltCreds then
  begin
    sIpcShare := '\\' + Params.sHostAddr + '\IPC$';
    MgDisconnectNetworkResource(sIpcShare);

    //sFormattedUser := Params.sUser;
    if not ContainsText(Params.sUser, '\') then
    begin
      Params.sUser := Params.sHostAddr + '\' + Params.sUser;
    end;

    if StartsText('.\', Params.sUser) then
    begin
      sShortUser := ReplaceText(Params.sUser, '.\', '');
      Params.sUser := Params.sHostAddr + '\' + sShortUser;
    end;

    if not MgConnectToNetworkResource(sIpcShare, Params.sUser, Params.sPass, sResultMsg) then
    begin
      if not SameText(sResultMsg, 'Success') then
      begin
        //OutputDebugString(PChar(sResultMsg));
        SendProcessLogMsg(sResultMsg);

        FResult := sResultMsg;
        Exit;
      end;

      sResultMsg := '';
    end
    else
      FResult := sResultMsg;
  end;

  try
    sLocalSvcPath := ExcludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0))) + '\' + SERVICE_EXE;
    bRemoteSvcInstalled := IsServiceInstalled(Params.sHostAddr, SERVICE_NAME);
    //
    SendProcessLogMsg('Preparing to copy service to remote host...');
    //
    if bRemoteSvcInstalled then
    begin
      DoStopService(Params.sHostAddr, SERVICE_NAME);

      //SetSvcLaunchParameters(Params);
      sRemoteImagePath := ReplaceText(Params.sImagePath, '"', '');

      Regex := TPerlRegEx.Create(nil);
      try
        Regex.RegEx := '^([a-z]:\\?(?:[^\\/:*?"<>|\r\n]+\\)+)';
        Regex.Options := [preCaseless, preMultiLine];
        Regex.Subject := sRemoteImagePath;
        if Regex.Match then
        begin
          sRemoteImagePath := ExcludeTrailingPathDelimiter(Regex.MatchedExpression);
        end;
      finally
        FreeAndNil(Regex);
      end;

      sRemoteImageUncPath := '\\' + Params.sHostAddr + '\' + ReplaceText(sRemoteImagePath, ':\',
        '$\');

      if not mgFileExists(sLocalSvcPath) then
      begin
        //OutputDebugString(PChar('*** Error: <' + sLocalSvcPath + '> was not found!'));
        SendProcessLogMsg('*** Error: <' + sLocalSvcPath + '> was not found!');

        Exit;
      end;

      //sLocalVatNicMgrVer := GetBuildInfoAsString(sLocalSvcPath);

      //
      if not mgFileExists(sRemoteImageUncPath + '\' + SERVICE_EXE) then
      begin
        sResultMsg := '';

        sResultMsg := CopyFileToRemoteSystem(
          sLocalSvcPath,
          sSvcArguments,
          Params.sHostAddr);

        if not SameText(sResultMsg, 'Success') then
        begin
          DoStopService(Params.sHostAddr, SERVICE_NAME);

          sResultMsg := '';
          sResultMsg := CopyFileToRemoteSystem(
            sLocalSvcPath,
            sSvcArguments,
            Params.sHostAddr);

          if not SameText(sResultMsg, 'Success') then
          begin
            //OutputDebugString(PChar('Could not access remote system: ' + sResultMsg));
            SendProcessLogMsg(('Could not access remote system: ' + sResultMsg));
            FResult := 'Could not access remote system: ' + sResultMsg;

            Exit;
          end;
        end;

      end
      else
      begin
        //sRemoteVatNicMgrVer := GetBuildInfoAsString(sRemoteImageUncPath + '\' + SERVICE_EXE);
        //if CompareVersionNumbers(sLocalVatNicMgrVer, sRemoteVatNicMgrVer) <> 0 then
        //begin
        if DoStopService(Params.sHostAddr, SERVICE_NAME) <> ssStopped then
        begin
          // this will delete old file and copy new service, but will *not* run it
          sResultMsg := '';

          sResultMsg := CopyFileToRemoteSystem(
            sLocalSvcPath,
            sSvcArguments,
            Params.sHostAddr);
          if not SameText(sResultMsg, 'Success') then
          begin

            //OutputDebugString(PChar('Could not access remote system: ' + sResultMsg));
            SendProcessLogMsg(('Could not access remote system: ' + sResultMsg));
            FResult := 'Could not access remote system: ' + sResultMsg;
            //              MessageBoxTimeout(Application.Handle, PChar('Could not access remote system: ' + sResultMsg),
            //                PChar('Complete'), MB_OK or MB_SETFOREGROUND or MB_SYSTEMMODAL or MB_ICONINFORMATION, 0,
            //                5000);
            Exit;
          end;
        end;
        //        end
        //        else
        //        begin
        //          DoStopService(Params.sHostAddr, SERVICE_NAME); // <> ssStopped;
        //        end;
      end;

      //
      Params.bSetImagePath := True;
      Params.sImagePath := '"' + sRemoteImagePath + '\' + SERVICE_EXE + '"';

      //      Invoke_StdRegProv_SetValue(Params.sHost, Params.sUser, Params.sPass,
      //        'SYSTEM\CurrentControlSet\Services\' + SERVICE_NAME, 'ImagePath', '"' + sRemoteImagePath + '\' +
      //        SERVICE_EXE + '"', 'SetStringValue', Params.bUseCimv2);
    end
    else
    begin
      sResultMsg := CopyFileToRemoteSystem(
        sLocalSvcPath,
        sSvcArguments,
        Params.sHostAddr);

      if not SameText(sResultMsg, 'Success') then
      begin
        SendProcessLogMsg(('Could not access remote system: ' + sResultMsg));
        FResult := 'Could not access remote system: ' + sResultMsg;

        Exit;
      end;
    end;

    SendProcessLogMsg('Service successfully copied to remote host...');
    SendProcessLogMsg('Preparing to set remote configuration ...');
    //
    SetSvcLaunchParameters(Params);
    //
    //SendProcessLogMsg('Configuration successfully set...');

    InstallService(SERVICE_NAME, SERVICE_NAME, Params.sHostAddr,
      IncludeTrailingPathDelimiter('%WINDIR%') + SERVICE_EXE, True);

    SendProcessLogMsg('Preparing to start the service...');

    if DoStartService(Params.sHostAddr, SERVICE_NAME) = ssRunning then // <> ssRunning then
    begin
      if not bRemoteSvcInstalled then
      begin
        SendProcessLogMsg('Remote service started successfully!');
        FResult := 'Remote service started successfully!';
      end
      else
      begin

        SendProcessLogMsg('Remote ' + SERVICE_NAME +
          ' service re-configured and started successfully!');

        FResult := 'Remote service re-configured and started successfully!';
      end;
    end
    else
    begin
      Sleep(2000);

      if DoStartService(Params.sHostAddr, SERVICE_NAME) = ssRunning then // <> ssRunning then
      begin
        if not bRemoteSvcInstalled then
        begin
          //OutputDebugString(PChar('Remote service started successfully!'));
          SendProcessLogMsg('Remote service started successfully!');

          FResult := 'Remote service started successfully!';
        end
        else
        begin
          //OutputDebugString(PChar('Remote ' + SERVICE_NAME +
          //  ' service re-configured and started successfully!'));

          SendProcessLogMsg('Remote ' + SERVICE_NAME +
            ' service re-configured and started successfully!');

          FResult := 'Remote service re-configured and started successfully!';
        end;
      end
      else
      begin
        //OutputDebugString(PChar('*** Error, could not start remote service!'));
        SendProcessLogMsg('*** Error, could not start remote service!');

        FResult := '*** Error, could not start remote service!';
        SendProcessLogMsg(SysErrorMessage(GetLastError));

      end;
    end;
  finally
    if Params.bAltCreds then
    begin
      MgDisconnectNetworkResource(sIpcShare);
    end;
  end;
end;

procedure TDeploySvc.ExecuteWork(Data: Pointer; AThread: TThread);
begin
  { Place thread code here }
  New(FCurThreadTask);
  try
    PrepareThreadVars();
    FCurThreadTask.Params := TRemoteTask(Data^).Params;

    if FCurThreadTask.Params.bPingTheHost then
    begin
      if not IsSystemOnlineNbtPing(FCurThreadTask.Params.sHostAddr, True) then
      begin

        UpdateDbHostOnline(FCurThreadTask.Params.sHostName, FCurThreadTask.Params.sGroup, False);
        SendProcessLogMsg('error: offline');
        FResult := 'error: offline';
        UpdateDeploymentResult(FCurThreadTask.Params);
        Exit;
      end
      else
      begin

        UpdateDbHostOnline(FCurThreadTask.Params.sHostName, FCurThreadTask.Params.sGroup, True);
        SendProcessLogMsg('host is online...');
      end;
    end;

    DeployNetLockerSvc(FCurThreadTask.Params);
    UpdateDeploymentResult(FCurThreadTask.Params);
    //SendProcessLogMsg('CLOSE_MSG_FORM');
  finally
    Dispose(FCurThreadTask);
  end;
end;

end.

