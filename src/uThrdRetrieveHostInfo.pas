unit uThrdRetrieveHostInfo;

{$WEAKLINKRTTI ON}
{$RTTI EXPLICIT METHODS([]) PROPERTIES([]) FIELDS([])}

interface

uses
  Classes,
  SysUtils,
  StrUtils,
  Windows,
  uGlobal,
  uWmiQueries,
  ActiveX,
  SyncObjs,
  uHelpers,
  ComObj,

  Variants,
  AsyncCalls,

  ThreadUtilities;

type
  TRetrieveHostInfo = class(TObject) //class(TThread)
  strict private
    FFormHandle: THandle;
    FThreadPool: TThreadPool;
    //procedure UpdateCaption;
  private
    crit_ThrdSendMsg: TCriticalSection;
    procedure PrepareThreadVars;
    procedure ExecuteWork(Data: Pointer; AThread: TThread);
    procedure RefreshHostDetails(Params: TCmdParams);
    //procedure UpdateCaption;
    procedure SendProcessLogMsg(sMsg: string);
    procedure UpdateDeploymentResult(Params: TCmdParams);
    {
    function GetStatusCodeStr(statusCode: integer): string;
    function Ping(const Address: string; Retries, BufferSize: Word): boolean;
    }
    { Private declarations }
  public
    procedure BeginWork(athrdtask: PRemoteTask);
    constructor Create(formHandle: THandle);
    destructor Destroy; override;
  end;

threadvar
  FCurThreadTask              : PRemoteTask;
  FResult                     : string;

  //FHostname                   : string;

implementation

procedure TRetrieveHostInfo.PrepareThreadVars();
begin
  FResult := '';
end;

constructor TRetrieveHostInfo.Create(formHandle: THandle);
begin
  FFormHandle := formHandle;
  FThreadPool := TThreadPool.Create(ExecuteWork, MAX_RETRIVE_HOST_INFO_THREADS);
  crit_ThrdSendMsg := TCriticalSection.Create;

  inherited Create;
end;

destructor TRetrieveHostInfo.Destroy;
begin
  FThreadPool.Free;
  FreeAndNil(crit_ThrdSendMsg);
  inherited;
end;

procedure TRetrieveHostInfo.BeginWork(athrdtask: PRemoteTask);
begin
  FThreadPool.Add(athrdtask);
end;

procedure TRetrieveHostInfo.RefreshHostDetails(Params: TCmdParams);
var
  //  sldb                        : TSQLiteDatabase;
  sQuery                      : string;
  asNicInfo                   : IAsyncCall;
  asSysInfo                   : IAsyncCall;
  asAutostartInfo             : IAsyncCall;
  sFormattedUser              : string;
  //bUseAltCreds                : boolean;
//  Data                        : PHostRec;
  bAutoUpdateIp               : boolean;
  hMsgForm                    : THandle;
  //sWinVersion                 : string;
  idx                         : Integer;
  bUsePassthruCreds           : boolean;
  ThreadHandle                : integer;
  ThreadId                    : LongWord;
  WmiCallInfo                 : TWmiCallArgs;
  Success                     : HRESULT;
begin

  bUsePassthruCreds := not Params.bAltCreds;
  hMsgForm := 0; //default

  sFormattedUser := Trim(Params.sUser);
  if Length(sFormattedUser) > 0 then
  begin
    if not ContainsText(sFormattedUser, '\') then
    begin
      sFormattedUser := Params.sHostName + '\' + Trim(Params.sUser);
    end;
  end;
  //

  //sWinVersion := '';
  try
    //CoInitialize(nil);
    Success := CoInitialize(nil); //, COINIT_MULTITHREADED);
    try
      {sWinVersion := }uHelpers.GetWindowsVersion(Params.sHostName, Params.sHostAddr, Params.sUser,
        Params.sPass, bUsePassthruCreds);
    finally
      //CoUninitialize;
      CoUninit(Success);
    end;
  except
    on E: Exception do
    begin
      OutputDebugString(PChar(E.Message));
      FResult := E.Message;
      SendProcessLogMsg(FResult);
      //UpdateDeploymentResult(FCurThreadTask.Params);
      Exit;
    end;
  end;

  Success := CoInitializeEx(nil, COINIT_MULTITHREADED);
  try

    asNicInfo := AsyncCall(@GetNicInfo, [
      Params.sHostName,
        Params.sHostAddr,
        sFormattedUser,
        Params.sPass,
        Params.sGroup,
        bUsePassthruCreds,
        hMsgForm,
        WM_PROGRESS_FORM_MSG]);

    asSysInfo := AsyncCall(@GetSysInfo, [
      Params.sHostName,
        Params.sHostAddr,
        sFormattedUser,
        Params.sPass,
        Params.sGroup,
        bUsePassthruCreds,
        hMsgForm,
        WM_PROGRESS_FORM_MSG]);

    asAutostartInfo := AsyncCall(@GetAutoStartInfo, [
      Params.sHostName,
        Params.sHostAddr,
        sFormattedUser,
        Params.sPass,
        Params.sGroup,
        bUsePassthruCreds,
        hMsgForm,
        WM_PROGRESS_FORM_MSG]);

    while AsyncMultiSync([asSysInfo, asNicInfo, asAutostartInfo], True, 10) = WAIT_TIMEOUT do
    begin
      //
    end;
  finally
    CoUninit(Success);
  end;

  sQuery := 'UPDATE  ' + INFO_TABLE + ' SET fldLastQueried = "' + DateTimeToStr(Now()) +
    '" WHERE fldHostname = "' + Params.sHostName + '" AND fldGroup = "' + Params.sGroup + '";';

  ModifySqlTableByQuery(sQuery);

  FResult := 'Completed Succesfully!';
  SendProcessLogMsg(FResult);
  //UpdateDeploymentResult(FCurThreadTask.Params);

  Exit;
end;

 procedure TRetrieveHostInfo.UpdateDeploymentResult(Params: TCmdParams);
var
  msg_prm                     : PWMMgMessageLog;
begin

  crit_ThrdSendMsg.Enter;
  try
    New(msg_prm);
    msg_prm.host := Params.sHostName;
    msg_prm.group := Params.sGroup;
    msg_prm.msg := FResult;

    if not PostMessage(FFormHandle, WM_POSTED_MSG, WM_THRD_RETRIEVE_HOST_DONE, integer(msg_prm))
      then
    begin
      Sleep(35);
      //PostMessage(FFormHandle, WM_POSTED_MSG, WM_THRD_RETRIEVE_HOST_DONE, integer(msg_prm));
      if not PostMessage(FFormHandle, WM_POSTED_MSG, WM_THRD_RETRIEVE_HOST_DONE, integer(msg_prm))
        then
      begin
        Sleep(35);
        if not PostMessage(FFormHandle, WM_POSTED_MSG, WM_THRD_RETRIEVE_HOST_DONE, integer(msg_prm))
          then
        begin
          //couldnt send data --- need to clean it up then
          Dispose(msg_prm);
        end;
      end;
    end;
    FResult := '';
  finally
    crit_ThrdSendMsg.Leave;
  end;
end;

procedure TRetrieveHostInfo.SendProcessLogMsg(sMsg: string);
var
  msg_prm                     : PWMMgMessageLog;
begin

  crit_ThrdSendMsg.Enter;
  try
    New(msg_prm);
    msg_prm.host := FCurThreadTask.Params.sHostName;
    msg_prm.group := FCurThreadTask.Params.sGroup;
    msg_prm.msg := sMsg;

    if not PostMessage(FFormHandle, WM_POSTED_MSG, WM_THRD_RETRIEVE_HOST_INFO, integer(msg_prm))
      then
    begin
      Sleep(35);
      //PostMessage(FFormHandle, WM_POSTED_MSG, WM_THRD_RETRIEVE_HOST_INFO, integer(msg_prm));
      if not PostMessage(FFormHandle, WM_POSTED_MSG, WM_THRD_RETRIEVE_HOST_INFO, integer(msg_prm))
        then
      begin
        Sleep(35);
        if not PostMessage(FFormHandle, WM_POSTED_MSG, WM_THRD_RETRIEVE_HOST_INFO, integer(msg_prm))
          then
        begin
          Dispose(msg_prm);
        end;
      end;
    end;
  finally
    crit_ThrdSendMsg.Leave;
  end;
end;

procedure TRetrieveHostInfo.ExecuteWork(Data: Pointer; AThread: TThread);
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
        SendProcessLogMsg('host is online, performing retrieval...');
      end;
    end;

    RefreshHostDetails(FCurThreadTask.Params);
    UpdateDeploymentResult(FCurThreadTask.Params);

  finally
    Dispose(FCurThreadTask);
  end;

end;

end.

