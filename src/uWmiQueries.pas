unit uWmiQueries;

{$I nldefine.inc}

{$WEAKLINKRTTI ON}
{$RTTI EXPLICIT METHODS([]) PROPERTIES([]) FIELDS([])}

interface

uses
  SysUtils,
  Windows,
  uWmiDelphiClass,
  ComCtrls,
  StdCtrls,
  uGlobal,
  Classes,
  uHelpers,
  SQLiteTable3,
  ActiveX,

  ComObj,
  StrUtils,
  Variants,
  uWin32_NetworkAdapterConfiguration,

  uWin32_NetworkAdapter;

procedure GetNicInfo(const sHostname, sIp, sUser, sPass, sGroup: string; const
  bUsePassthruCredentials: boolean; hMsgForm: THandle = 0; iMessage: integer =
  WM_PROGRESS_FORM_MSG); cdecl;
//
procedure GetSysInfo(const sHostname, sIp, sUser, sPass, sGroup: string; {sWinVersion: string;}
  bUsePassthruCredentials: boolean; hMsgForm: THandle = 0; iMessage: integer =
  WM_PROGRESS_FORM_MSG); cdecl;

procedure GetAutoStartInfo(const sHostname, sIp, sUser, sPass, sGroup: string;
  {sWinVersion: string; }
  bUsePassthruCredentials: boolean; hMsgForm: THandle = 0; iMessage: integer =
  WM_PROGRESS_FORM_MSG); cdecl;

function Invoke_StdRegProv_GetValue(const sServer, sUser, sPass, sSubKeyName, sValueName, sMethod:
  string; bUseCimv2: boolean = False): string;
function Invoke_StdRegProv_CheckAccess(const sServer, sUser, sPass, sSubKeyName: string; bUseCimv2:
  boolean = False): boolean;
function Invoke_StdRegProv_SetValue(const sServer, sUser, sPass, sSubKeyName, sValueName, sValue,
  sMethod: string; bUseCimv2: boolean = False): string;
function Invoke_StdRegProv_CreateKey(const sServer, sUser, sPass, sSubKeyName: string; bUseCimv2:
  boolean = False): boolean;
procedure UpdateFormProgressCaption(sHostname, sGroup, sResult: string; hForm: THandle = 0;
  iMessage: integer = WM_PROGRESS_FORM_MSG);

function StreamToString(aStream: TStream): string;
//function GetMgAutoStartInfo(Parameter: Pointer): Integer;
procedure CoUninit(Success: HResult);

implementation

procedure CoUninit(Success: HResult);
begin
  case Success of
    S_OK, S_FALSE: CoUninitialize;
  end;
end;

procedure GetAutoStartInfo(const sHostname, sIp, sUser, sPass, sGroup: string;
  {sWinVersion: string; }
  bUsePassthruCredentials: boolean; hMsgForm: THandle = 0; iMessage: integer =
  WM_PROGRESS_FORM_MSG); cdecl;
  procedure GetWin32_StartupCommandInfo(const sHostname, sIp, sUser, sPass, sGroup: string; var
    MgStartupArray: TRemoteStartupInfoArray);
  const
    wbemFlagForwardOnly       = $00000020;
  var
    FSWbemLocator             : OLEVariant;
    FWMIService               : OLEVariant;
    FWbemObjectSet            : OLEVariant;
    FWbemObject               : OLEVariant;
    oEnum                     : IEnumvariant;
    iValue                    : LongWord;
    idx                       : integer;
    slStartup, slSplit        : TStringList;
    sLine                     : string;
    //
    dx                        : integer;
    ns                        : string;
    txt                       : string;
    delta                     : integer;
    sLineCaption, sLineLocation, sLineCommand, sLineUser: string;
  begin
    // try
    FSWbemLocator := CreateOleObject('WbemScripting.SWbemLocator');
    FWMIService := FSWbemLocator.ConnectServer(sIp, 'root\CIMV2', sUser, sPass);

    FWbemObjectSet :=
      FWMIService.ExecQuery('SELECT Caption,Command,Location,User FROM Win32_StartupCommand',
      'WQL', wbemFlagForwardOnly);
    oEnum := IUnknown(FWbemObjectSet._NewEnum) as IEnumVariant;

    idx := 0;
    slStartup := TStringList.Create;
    slSplit := TStringList.Create;
    try
      while oEnum.Next(1, FWbemObject, iValue) = 0 do
      begin
        MgStartupArray[0].sCaption := Format('%s', [FWbemObject.Caption]);
        MgStartupArray[0].sCommand := Format('%s', [FWbemObject.Command]);
        MgStartupArray[0].sLocation := Format('%s', [FWbemObject.Location]);
        MgStartupArray[0].sUser := Format('%s', [FWbemObject.User]);

        slStartup.Add(
          '"' + ReplaceText(MgStartupArray[0].sCaption, '"', '') + '"|' +
          '"' + ReplaceText(MgStartupArray[0].sCommand, '"', '') + '"|' +
          '"' + ReplaceText(MgStartupArray[0].sLocation, '"', '') + '"|' +
          '"' + ReplaceText(MgStartupArray[0].sUser, '"', '') + '"'
          );

        InterlockedIncrement(idx);
        FWbemObject := Unassigned;
      end;

      SetLength(MgStartupArray, 0); //clear
      SetLength(MgStartupArray, slStartup.Count);

      for idx := 0 to slStartup.Count - 1 do
      begin
        //MgSplitToStringList('|', slStartup[idx], slSplit);
        slSplit.Delimiter := '|';
        slSplit.DelimitedText := slStartup[idx];
        //        try
        //          delta := Length('|');
        //          txt := slStartup[idx] + '|';
        //          slSplit.Clear;
        //
        //          while Length(txt) > 0 do
        //          begin
        //            dx := Pos('|', txt);
        //            ns := Copy(txt, 0, dx - 1);
        //            slSplit.Add(ns);
        //            txt := Copy(txt, dx + delta, MaxInt);
        //          end;
        //
        //        except on E: Exception do
        //          begin
        //            //OutputDebugString(PChar(' >> split: ' + E.Message));
        //          end;
        //        end;

        if slSplit.Count >= 4 then
        begin
          //try
          sLineCaption := slSplit[0];
          if Length(sLine) >= SizeOf(MgStartupArray[idx].sCaption) - 1 then
            SetLength(sLine, SizeOf(MgStartupArray[idx].sCaption) - 2);

          //            if Length(sLine) >= 2 then
          //            begin
          //              Delete(sLine, 1, 1);
          //              Delete(sLine, Length(sLine), 1);
          //            end;
          MgStartupArray[idx].sCaption := sLineCaption;

          sLineCommand := slSplit[1];
          if Length(sLine) >= SizeOf(MgStartupArray[idx].sCommand) - 1 then
            SetLength(sLine, SizeOf(MgStartupArray[idx].sCommand) - 2);

          //            if Length(sLine) >= 2 then
          //            begin
          //              Delete(sLine, 1, 1);
          //              Delete(sLine, Length(sLine), 1);
          //            end;
          MgStartupArray[idx].sCommand := sLineCommand;

          sLineLocation := slSplit[2];
          if Length(sLine) >= SizeOf(MgStartupArray[idx].sLocation) - 1 then
            SetLength(sLine, SizeOf(MgStartupArray[idx].sLocation) - 2);

          //            if Length(sLine) >= 2 then
          //            begin
          //              Delete(sLine, 1, 1);
          //              Delete(sLine, Length(sLine), 1);
          //            end;
          MgStartupArray[idx].sLocation := sLineLocation;

          sLineUser := slSplit[3];
          if Length(sLine) >= SizeOf(MgStartupArray[idx].sUser) - 1 then
            SetLength(sLine, SizeOf(MgStartupArray[idx].sUser) - 2);

          //            if Length(sLine) >= 2 then
          //            begin
          //              Delete(sLine, 1, 1);
          //              Delete(sLine, Length(sLine), 1);
          //            end;
          MgStartupArray[idx].sUser := sLineUser;
          //          except on E: Exception do
          //            begin
          //              //OutputDebugString(PChar(' >> autorun: ' + E.Message));
          //            end;
          //          end;
        end;
      end;

    finally
      FreeAndNil(slStartup);
      FreeAndNil(slSplit);
    end;
    //  except on E: Exception do
    //    begin
    //      //OutputDebugString(PChar(' >> autorun error: ' + E.Classname + ': ' + E.Message));
    //    end;
    //  end;
  end;

var
  i, idx                      : integer;
  sQuery                      : string;
  strm                        : TMemoryStream;
  SQLQuery                    : TSQLiteQuery;
  sMsg                        : string;
  MgStartupInfo               : TRemoteStartupInfoArray;
begin
  //crit_WmiQuery_AutoStart.Enter;
  try
    try
      SetLength(MgStartupInfo, 1);
      try
        ////CoInitialize(nil);
        try
          GetWin32_StartupCommandInfo(
            sHostname,
            sIp,
            sUser,
            sPass,
            sGroup,
            MgStartupInfo);
          //GetWin32_StartupCommandInfo2(sHostname, sIp, sUser, sPass, sGroup, MgStartupInfo,
          //  bUsePassthruCredentials);
        finally
          //CoUninitialize;
        end;
      except
        on E: Exception do
        begin
          //OutputDebugString(PChar(Format('>>mg Exception %s', [E.Message])));
          sMsg := E.Message;

          sMsg := 'Retrieving information from host failed.' + #13#10
            + 'Possible reasons are:' + #13#10
            + ' * incorrect username or password' + #13#10
            + ' * firewall on remote host' + #13#10
            + ' * "Use Simple File Sharing" is enabled on remote host' + #13#10
            + '   - To disable, on remote host click ' + #13#10
            + '      Start | My Computer | Tools | Folder Options | View' + #13#10
            + '   - Then scroll to bottom and un-check "Use Simple File Sharing"' + #13#10
            + '      and click "OK"';

          if hMsgForm <> 0 then
          begin
            UpdateFormProgressCaption(sHostname, sGroup, sMsg,
              hMsgForm, iMessage);
          end;

          Exit;
        end;
      end;

      strm := TMemoryStream.Create();
      try
        i := Length(MgStartupInfo);
        strm.WriteBuffer(i, 4);
        strm.WriteBuffer(Pointer(MgStartupInfo)^, (Length(MgStartupInfo) *
          SizeOf(TRemoteStartupInfo)) + 4);
        //this is working
        strm.Position := 0;

        sQuery := 'UPDATE ' + INFO_TABLE + ' SET fldStartupInfo = ? WHERE fldHostname = "' +
          sHostname + '" AND fldGroup = "' + sGroup + '";';

        ModifySqlTableBlobByQuery(sQuery, strm);
      finally
        FreeAndNil(strm);
      end;
    except
      on E: Exception do
      begin
        //OutputDebugString(PChar(' >> get autostart error: ' + E.Classname + ': ' + E.Message));
      end;
    end;
  finally
    //crit_WmiQuery_AutoStart.Leave;
  end;
end;

// The CheckAccess method verifies that the user possesses the specified
// permissions. The method returns a uint32 which is 0 if successful or some other
// value if any other error occurred.

function Invoke_StdRegProv_CheckAccess(const sServer, sUser, sPass, sSubKeyName: string; bUseCimv2:
  boolean = False): boolean;
var
  FSWbemLocator               : OLEVariant;
  FWMIService                 : OLEVariant;
  FWbemObjectSet              : OLEVariant;
  FInParams                   : OLEVariant;
  FOutParams                  : OLEVariant;
begin
  Result := False; //default
  FSWbemLocator := CreateOleObject('WbemScripting.SWbemLocator');
  //http://msdn.microsoft.com/en-us/library/aa393664%28v=vs.85%29.aspx
  //StdRegProv is preinstalled in the WMI namespaces root\default and root\cimv2.
  //Windows Server 2003, Windows XP, Windows 2000, Windows NT 4.0, and Windows Me/98/95:  StdRegProv is available only in root\default namespace.
  if not bUseCimv2 then
  begin
    FWMIService := FSWbemLocator.ConnectServer(sServer, 'root\default', sUser, sPass)
  end
  else
  begin
    //For Windows Vista or Windows 7 you must use the  root\CIMV2 namespace
    FWMIService := FSWbemLocator.ConnectServer(sServer, 'root\CIMV2', sUser, sPass);
  end;

  FWbemObjectSet := FWMIService.Get('StdRegProv');
  FInParams := FWbemObjectSet.Methods_.Item('CheckAccess').InParameters.SpawnInstance_();
  FInParams.hDefKey := HKEY_LOCAL_MACHINE;
  FInParams.sSubKeyName := sSubKeyName; //'SYSTEM\CurrentControlSet';
  FInParams.uRequired := KEY_QUERY_VALUE;

  FOutParams := FWMIService.ExecMethod('StdRegProv', 'CheckAccess', FInParams);
  //OutputDebugString(PChar(Format('bGranted              %s', [FOutParams.bGranted])));
  //OutputDebugString(PChar(Format('ReturnValue           %s', [FOutParams.ReturnValue])));

  Result := FOutParams.bGranted;
end;

function Invoke_StdRegProv_CreateKey(const sServer, sUser, sPass, sSubKeyName: string; bUseCimv2:
  boolean = False): boolean;
var
  FSWbemLocator               : OLEVariant;
  FWMIService                 : OLEVariant;
  FWbemObjectSet              : OLEVariant;
  FInParams                   : OLEVariant;
  FOutParams                  : OLEVariant;
begin
  Result := False; //default
  FSWbemLocator := CreateOleObject('WbemScripting.SWbemLocator');
  //http://msdn.microsoft.com/en-us/library/aa393664%28v=vs.85%29.aspx
  //StdRegProv is preinstalled in the WMI namespaces root\default and root\cimv2.
  //Windows Server 2003, Windows XP, Windows 2000, Windows NT 4.0, and Windows Me/98/95:  StdRegProv is available only in root\default namespace.
  if not bUseCimv2 then
  begin
    FWMIService := FSWbemLocator.ConnectServer(sServer, 'root\default', sUser, sPass)
  end
  else
  begin
    //For Windows Vista or Windows 7 you must use the  root\CIMV2 namespace
    FWMIService := FSWbemLocator.ConnectServer(sServer, 'root\CIMV2', sUser, sPass);
  end;

  FWbemObjectSet := FWMIService.Get('StdRegProv');
  FInParams := FWbemObjectSet.Methods_.Item('CreateKey').InParameters.SpawnInstance_();
  FInParams.hDefKey := HKEY_LOCAL_MACHINE;
  FInParams.sSubKeyName := sSubKeyName; //'SYSTEM\CurrentControlSet';
  //FInParams.uRequired := KEY_QUERY_VALUE;

  FOutParams := FWMIService.ExecMethod('StdRegProv', 'CreateKey', FInParams);
  //OutputDebugString(PChar(Format('bGranted              %s', [FOutParams.bGranted])));
  //OutputDebugString(PChar(Format('ReturnValue           %s', [FOutParams.ReturnValue])));

  Result := FOutParams.ReturnValue;
end;

// The GetStringValue method returns the data value for a named value whose data
// type is REG_SZ.

function Invoke_StdRegProv_GetValue(const sServer, sUser, sPass, sSubKeyName, sValueName, sMethod:
  string; bUseCimv2: boolean): string;
/// sMethod:
///  GetBinaryValue
///  GetDWORDValue
///  GetExpandedStringValue
///  GetMultiStringValue
///  GetStringValue
///
///  http://msdn.microsoft.com/en-us/library/aa393664%28v=vs.85%29.aspx
var
  FSWbemLocator               : OLEVariant;
  FWMIService                 : OLEVariant;
  FWbemObjectSet              : OLEVariant;
  FInParams                   : OLEVariant;
  FOutParams                  : OLEVariant;
begin
  FSWbemLocator := CreateOleObject('WbemScripting.SWbemLocator');
  //http://msdn.microsoft.com/en-us/library/aa393664%28v=vs.85%29.aspx
  //StdRegProv is preinstalled in the WMI namespaces root\default and root\cimv2.
  //Windows Server 2003, Windows XP, Windows 2000, Windows NT 4.0, and Windows Me/98/95:  StdRegProv is available only in root\default namespace.
  if not bUseCimv2 then
  begin
    FWMIService := FSWbemLocator.ConnectServer(sServer, 'root\default', sUser, sPass)
  end
  else
  begin
    //For Windows Vista or Windows 7 you must use the  root\CIMV2 namespace
    FWMIService := FSWbemLocator.ConnectServer(sServer, 'root\CIMV2', sUser, sPass);
  end;

  FWbemObjectSet := FWMIService.Get('StdRegProv');
  FInParams := FWbemObjectSet.Methods_.Item(sMethod
    {'GetStringValue'}).InParameters.SpawnInstance_();
  FInParams.hDefKey := HKEY_LOCAL_MACHINE;
  FInParams.sSubKeyName := sSubKeyName; //'SOFTWARE\Borland\Delphi\5.0';
  FInParams.sValueName := sValueName; //'App';

  FOutParams := FWMIService.ExecMethod('StdRegProv', sMethod {'GetStringValue'}, FInParams);
  Result := FOutParams.sValue;
  //Writeln(Format('sValue                %s', [FOutParams.sValue]));
  //Writeln(Format('ReturnValue           %s', [FOutParams.ReturnValue]));
end;

// The SetStringValue method sets the data value for a named value whose data type
// is REG_SZ.

function Invoke_StdRegProv_SetValue(const sServer, sUser, sPass, sSubKeyName, sValueName, sValue,
  sMethod: string; bUseCimv2: boolean = False): string;
/// sMethod:
///  SetBinaryValue
///  SetDWORDValue
///  SetExpandedStringValue
///  SetMultiStringValue
///  SetStringValue
///
///  http://msdn.microsoft.com/en-us/library/aa393664%28v=vs.85%29.aspx
var
  FSWbemLocator               : OLEVariant;
  FWMIService                 : OLEVariant;
  FWbemObjectSet              : OLEVariant;
  FInParams                   : OLEVariant;
  FOutParams                  : OLEVariant;
begin
  Result := ''; //default

  FSWbemLocator := CreateOleObject('WbemScripting.SWbemLocator');

  if not bUseCimv2 then
  begin
    FWMIService := FSWbemLocator.ConnectServer(sServer, 'root\DEFAULT', sUser, sPass)
  end
  else
  begin
    //For Windows Vista or Windows 7 you can use the  root\CIMV2 namespace
    FWMIService := FSWbemLocator.ConnectServer(sServer, 'root\CIMV2', sUser, sPass);
  end;

  FWbemObjectSet := FWMIService.Get('StdRegProv');
  FInParams := FWbemObjectSet.Methods_.Item(sMethod
    {'SetStringValue'}).InParameters.SpawnInstance_();
  FInParams.hDefKey := HKEY_LOCAL_MACHINE;
  FInParams.sSubKeyName := sSubKeyName; //'SOFTWARE\Borland\Delphi\5.0';
  FInParams.sValueName := sValueName; //'Dummy';

  if sMethod = 'SetStringValue' then
    FInParams.sValue := sValue //'ADummyValue';
  else if sMethod = 'SetDWORDValue' then
    FInParams.sValue := StrToInt(sValue);

  FOutParams := FWMIService.ExecMethod('StdRegProv', sMethod {'SetStringValue'}, FInParams);
  //OutputDebugString(PChar(Format('ReturnValue           %s', [FOutParams.ReturnValue])));

  Result := FOutParams.ReturnValue;
end;

///
///
///

function StreamToString(aStream: TStream): string;
var
  SS                          : TStringStream;
begin
  if aStream <> nil then
  begin
    SS := TStringStream.Create('');
    try
      aStream.Position := 0;
      SS.CopyFrom(aStream, aStream.Size);
      Result := SS.DataString;
    finally
      SS.Free;
    end;
  end
  else
  begin
    Result := '';
  end;
end;

function VarArrayToStr(const vArray: variant): string;

  function _VarToStr(const V: variant): string;
  var
    Vt                        : integer;
  begin
    Vt := VarType(V);
    case Vt of
      varSmallint,
        varInteger: Result := IntToStr(integer(V));
      varSingle,
        varDouble,
        varCurrency: Result := FloatToStr(Double(V));
      varDate: Result := VarToStr(V);
      varOleStr: Result := WideString(V);
      varBoolean: Result := VarToStr(V);
      varVariant: Result := VarToStr(Variant(V));
      varByte: Result := char(byte(V));
      varString: Result := string(V);
      varArray: Result := VarArrayToStr(Variant(V));
    end;
  end;

var
  i                           : integer;
begin
  Result := '[';
  if (VarType(vArray) and VarArray) = 0 then
    Result := _VarToStr(vArray)
  else
    for i := VarArrayLowBound(vArray, 1) to VarArrayHighBound(vArray, 1) do
      if i = VarArrayLowBound(vArray, 1) then
        Result := Result + _VarToStr(vArray[i])
      else
        Result := Result + '|' + _VarToStr(vArray[i]);

  Result := Result + ']';
end;

procedure UpdateFormProgressCaption(sHostname, sGroup, sResult: string; hForm: THandle = 0;
  iMessage: integer = WM_PROGRESS_FORM_MSG);
var
  msg_prm                     : PWMDeploySvcCommand;
begin
  New(msg_prm);
  msg_prm.host := sHostname;
  msg_prm.group := sGroup;
  msg_prm.result := sResult;

  if not PostMessage(hForm, iMessage, WM_THRD_PROGRESS_MSG,
    integer(msg_prm)) then
  begin
    Sleep(35);
    PostMessage(hForm, iMessage, WM_THRD_PROGRESS_MSG, integer(msg_prm));
    if not PostMessage(hForm, iMessage, WM_THRD_PROGRESS_MSG,
      integer(msg_prm)) then
    begin
      Sleep(35);
      if not PostMessage(hForm, iMessage, WM_THRD_PROGRESS_MSG, integer(msg_prm)) then
      begin
        Dispose(msg_prm);
      end;
    end;
  end;

end;

procedure GetWin32_ComputerSystemInfo(const sHostname, sIp, sUser, sPass, sGroup: string; var
  MgSysInfo: TRemoteSysInfoArray);
const
  wbemFlagForwardOnly         = $00000020; // = 32 decimal
var
  FSWbemLocator               : OLEVariant;
  FWMIService                 : OLEVariant;
  FWbemObjectSet              : OLEVariant;
  FWbemObject                 : OLEVariant;
  oEnum                       : IEnumvariant;
  iValue                      : LongWord;
  sMemory                     : string;
  iMemory                     : Int64;
  sLine                       : string;
begin
  FSWbemLocator := CreateOleObject('WbemScripting.SWbemLocator');
  FWMIService := FSWbemLocator.ConnectServer(sIp, 'root\CIMV2', sUser, sPass);
  FWbemObjectSet :=
    FWMIService.ExecQuery('SELECT Name,Domain,UserName,Manufacturer,Model,PrimaryOwnerName,SystemType,TotalPhysicalMemory FROM Win32_ComputerSystem', 'WQL',
    wbemFlagForwardOnly);
  oEnum := IUnknown(FWbemObjectSet._NewEnum) as IEnumVariant;

  while oEnum.Next(1, FWbemObject, iValue) = 0 do
  begin
    sLine := Trim(Format('%s', [FWbemObject.Name]));

    if Length(sLine)>=(SizeOf(MgSysInfo[0].sName) - 1) then
      SetLength(sLine, SizeOf(MgSysInfo[0].sName) - 2);

    MgSysInfo[0].sName := sLine;
    //
    sLine := Trim(Format('%s', [FWbemObject.Domain]));

    if Length(sLine)>=(SizeOf(MgSysInfo[0].sDomain) - 1) then
      SetLength(sLine, SizeOf(MgSysInfo[0].sDomain) - 2);

    MgSysInfo[0].sDomain := sLine;
    //
    sLine := Trim(Format('%s', [FWbemObject.UserName]));

    if Length(sLine)>=(SizeOf(MgSysInfo[0].sUsername) - 1) then
      SetLength(sLine, SizeOf(MgSysInfo[0].sUsername) - 2);

    MgSysInfo[0].sUsername := sLine;
    //
    sLine := Trim(Format('%s', [FWbemObject.Manufacturer]));

    if Length(sLine)>=(SizeOf(MgSysInfo[0].sManufacturer) - 1) then
      SetLength(sLine, SizeOf(MgSysInfo[0].sManufacturer) - 2);

    MgSysInfo[0].sManufacturer := sLine;
    //
    sLine := Trim(Format('%s', [FWbemObject.Model]));

    if Length(sLine)>=(SizeOf(MgSysInfo[0].sModel) - 1) then
      SetLength(sLine, SizeOf(MgSysInfo[0].sModel) - 2);

    MgSysInfo[0].sModel := sLine;
    //
    sLine := Trim(Format('%s', [FWbemObject.PrimaryOwnerName]));

    if Length(sLine)>=(SizeOf(MgSysInfo[0].sPrimaryOwnerName) - 1) then
      SetLength(sLine, SizeOf(MgSysInfo[0].sPrimaryOwnerName) - 2);

    MgSysInfo[0].sPrimaryOwnerName := sLine;
    //
    sLine := Trim(Format('%s', [FWbemObject.SystemType]));

    if Length(sLine)>=(SizeOf(MgSysInfo[0].sSystemType) - 1) then
      SetLength(sLine, SizeOf(MgSysInfo[0].sSystemType) - 2);

    MgSysInfo[0].sSystemType := sLine;
    //
    sMemory := VarToStr(FWbemObject.TotalPhysicalMemory);
    iMemory := StrToInt64(sMemory); //) / 1024);
    iMemory := Round(iMemory / 1024 / 1024);

    sLine := IntToStr(iMemory) + ' mb';

    if Length(sLine)>=(SizeOf(MgSysInfo[0].sTotalPhysicalMemory) - 1) then
      SetLength(sLine, SizeOf(MgSysInfo[0].sTotalPhysicalMemory) - 2);

    MgSysInfo[0].sTotalPhysicalMemory := sLine;
    //
    FWbemObject := Unassigned;
  end;

  FWbemObjectSet := FWMIService.ExecQuery('SELECT SerialNumber FROM Win32_SystemEnclosure', 'WQL',
    wbemFlagForwardOnly);

  oEnum := IUnknown(FWbemObjectSet._NewEnum) as IEnumVariant;
  while oEnum.Next(1, FWbemObject, iValue) = 0 do
  begin
    MgSysInfo[0].sSerialNumber := Trim(Format('%s', [FWbemObject.SerialNumber]));
    FWbemObject := Unassigned;
  end;
end;

procedure GetSysInfo(const sHostname, sIp, sUser, sPass, sGroup: string; {sWinVersion: string;}
  bUsePassthruCredentials: boolean; hMsgForm: THandle = 0; iMessage: integer =
  WM_PROGRESS_FORM_MSG);
  cdecl;
var
  i                           : integer;
  sQuery                      : string;
  MgSysInfo                   : TRemoteSysInfoArray;
  strm                        : TMemoryStream;
  iKb                         : Cardinal;
  SQLQuery                    : TSQLiteQuery;
  sMsg                        : string;
begin

  //crit_WmiQuery_SysInfo.Enter;
  try
    try
      SetLength(MgSysInfo, 1);
      try
        //CoInitialize(nil);
        try
          GetWin32_ComputerSystemInfo(sHostname, sIp, sUser, sPass, sGroup, MgSysInfo);
        finally
          //CoUninitialize;
        end;
      except
        //      on E: EOleException do
        //        Writeln(Format('EOleException %s %x', [E.Message, E.ErrorCode]));
        on E: Exception do
        begin
          sMsg := E.Message;

          sMsg := 'Retrieving information from host failed.' + #13#10
            + 'Possible reasons are:' + #13#10
            + ' * incorrect username or password' + #13#10
            + ' * firewall on remote host' + #13#10
            + ' * "Use Simple File Sharing" is enabled on remote host' + #13#10
            + '   - To disable, on remote host click ' + #13#10
            + '      Start | My Computer | Tools | Folder Options | View' + #13#10
            + '   - Then scroll to bottom and un-check "Use Simple File Sharing"' + #13#10
            + '      and click "OK"';

          if hMsgForm <> 0 then
          begin
            UpdateFormProgressCaption(sHostname, sGroup, sMsg, hMsgForm, iMessage);
          end;

          Exit;
        end;
      end;

      //if Length(sWinVersion) <= 2 then
      begin
        try
          //CoInitialize(nil);
          try
            MgSysInfo[0].sOsVersion := uHelpers.GetWindowsVersion(sHostname, sIp, sUser, sPass,
              bUsePassthruCredentials);
          finally
            //CoUninitialize;
          end;
        except
          on E: Exception do
          begin
            sMsg := E.Message;

            sMsg := 'Retrieving information from host failed.' + #13#10
              + 'Possible reasons are:' + #13#10
              + ' * incorrect username or password' + #13#10
              + ' * firewall on remote host' + #13#10
              + ' * "Use Simple File Sharing" is enabled on remote host' + #13#10
              + '   - To disable, on remote host click ' + #13#10
              + '      Start | My Computer | Tools | Folder Options | View' + #13#10
              + '   - Then scroll to bottom and un-check "Use Simple File Sharing"' + #13#10
              + '      and click "OK"';

            if hMsgForm <> 0 then
            begin
              UpdateFormProgressCaption(sHostname, sGroup, sMsg, hMsgForm, iMessage);
            end;

            Exit;
          end;
        end;
        //end
        //else
        //begin
        //  MgSysInfo[0].sOsVersion := sWinVersion;
      end;

      strm := TMemoryStream.Create();
      //sldb := TSQLiteDatabase.Create(slDBPath);
      try
        i := Length(MgSysInfo);
        strm.WriteBuffer(i, 4);
        strm.WriteBuffer(Pointer(MgSysInfo)^, (Length(MgSysInfo) * SizeOf(TRemoteSysInfo)) + 4);
        //this is working
        strm.Position := 0;

        sQuery := 'UPDATE ' + INFO_TABLE + ' SET fldSystemDetails = ? WHERE fldHostname = "' +
          sHostname + '" AND fldGroup = "' + sGroup + '";';

        //sldb.UpdateBlob(sQuery, strm);
        ModifySqlTableBlobByQuery(sQuery, strm);
        //sldb.UpdateBlob(sQuery, strm);
      finally
        FreeAndNil(strm);
        //sldb.Free;
      end;

      //main.Form1.PopulateLastQueriedDisplay();
    except
      on E: Exception do
      begin
        Exit;
        //OutputDebugString(PChar(E.Classname + ': ' + E.Message));
      end;
    end;
  finally
    //crit_WmiQuery_SysInfo.Leave;
  end;
end;

procedure GetNicInfo(const sHostname, sIp, sUser, sPass, sGroup: string; const
  bUsePassthruCredentials: boolean; hMsgForm: THandle = 0; iMessage: integer =
  WM_PROGRESS_FORM_MSG); cdecl;
var
  RemoteNicInfo               : TWin32_NetworkAdapter;
  RemoteIpInfo                : TWin32_NetworkAdapterConfiguration;
  i, j                        : integer;
  iCount                      : Integer;
  sGuid, sAdapterType         : string;
  sQuery                      : string;
  MgNicArray                  : TRemoteNicArray;
  strm                        : TMemoryStream;
  sMacIp, sMacGuid, sCurIp, sIpInfo, sMac: string;
  slMacIpList, slMacGuidList  : TStringList;
  NicItem                     : TListItem;
  cbEnable, cbDisable         : TCheckbox;
  AdapterInfo                 : TSimpleNicInfoArray;
  bAddMac                     : boolean;
  SQLQuery                    : TSQLiteQuery;
  iColCount                   : integer;
  sItemIp                     : string;
  sMsg                        : string;
begin
  slMacIpList := TStringList.Create;
  slMacGuidList := TStringList.Create;
  try
    slMacIpList.Sorted := True;
    slMacIpList.Duplicates := dupIgnore;

    slMacGuidList.Sorted := True;
    slMacGuidList.Duplicates := dupIgnore;
    try
      RemoteIpInfo := TWin32_NetworkAdapterConfiguration.Create(False);
      try
        RemoteIpInfo.WmiConnection.WmiServer := sIp;

        if not bUsePassthruCredentials then
        begin
          RemoteIpInfo.WmiConnection.WmiUser := sUser;
          RemoteIpInfo.WmiConnection.WmiPass := sPass;
        end;

        try
          RemoteIpInfo.LoadWmiData('SELECT IPAddress,MACAddress,SettingID',
            'WHERE MACAddress <> NULL AND SettingID <> NULL');
        except on E: Exception do
          begin
            sMsg := E.Message;
            sMsg := 'Retrieving information from host failed.' + #13#10
              + 'Possible reasons are:' + #13#10
              + ' * incorrect username or password' + #13#10
              + ' * firewall on remote host' + #13#10
              + ' * "Use Simple File Sharing" is enabled on remote host' + #13#10
              + '   - To disable, on remote host click ' + #13#10
              + '      Start | My Computer | Tools | Folder Options | View' + #13#10
              + '   - Then scroll to bottom and un-check "Use Simple File Sharing"' + #13#10
              + '      and click "OK"';

            if hMsgForm <> 0 then
            begin
              UpdateFormProgressCaption(sHostname, sGroup, sMsg, hMsgForm, iMessage);
            end;

            Exit;
          end;
        end;

        if RemoteIpInfo.WmiConnection.WmiConnected then
        begin
          SetLength(AdapterInfo, RemoteIpInfo.GetCollectionCount);
          for i := 0 to RemoteIpInfo.GetCollectionCount - 1 do
          begin
            RemoteIpInfo.SetCollectionIndex(i);
            sCurIp := '-';
            sGuid := '-';

            for j := 0 to RemoteIpInfo.IPAddress.Count - 1 do
            begin
              if j > 0 then
                AdapterInfo[i].sIp := AdapterInfo[i].sIp + '|' + RemoteIpInfo.IPAddress[j]
              else
                sCurIp := RemoteIpInfo.IPAddress[j]
            end;

            sMac := Trim(RemoteIpInfo.MACAddress);
            sGuid := Trim(RemoteIpInfo.SettingID); //this is GUID

            bAddMac := True; //default
            for j := 0 to Length(AdapterInfo) - 1 do
            begin
              if Length(AdapterInfo[j].sMac) <= 0 then
              begin
                bAddMac := True;
                break;
              end;

              if Length(sMac) <= 0 then
              begin
                bAddMac := False;
                break;
              end;

              if SameText(AdapterInfo[j].sMac, sMac) then
              begin
                bAddMac := False;
                if sCurIp <> '-' then
                begin
                  if Length(AdapterInfo[j].sIp) > 1 then
                  begin
                    if AdapterInfo[j].sIp = '-' then
                      AdapterInfo[j].sIp := sCurIp
                    else
                    begin
                      if not SameText(AdapterInfo[j].sIp, sCurIp) then
                      begin
                        AdapterInfo[j].sIp := AdapterInfo[j].sIp + '|' + sCurIp;
                      end;
                    end;
                  end
                  else
                  begin
                    AdapterInfo[j].sIp := sCurIp;
                  end;
                  sCurIp := '-';
                  break;
                end;
              end;

            end;

            if bAddMac then
            begin
              if Length(sMac) > 0 then
              begin
                for j := 0 to Length(AdapterInfo) - 1 do
                begin
                  if SameText(AdapterInfo[j].sMac, sMac) then
                  begin
                    bAddMac := False;
                  end;
                end;
                if bAddMac then
                begin
                  AdapterInfo[i].sMac := sMac;
                  AdapterInfo[i].sIp := sCurIp;
                  AdapterInfo[i].sGUID := sGuid;
                end;
              end;
            end;
          end;

          for j := 0 to Length(AdapterInfo) - 1 do
          begin
            if Length(AdapterInfo[j].sMac) > 0 then
            begin
              sMacGuid := sMacGuid + AdapterInfo[j].sMac + '=' + AdapterInfo[j].sGUID;
              sMacIp := sMacIp + AdapterInfo[j].sMac + '=' + AdapterInfo[j].sIp;

              if j <> Length(AdapterInfo) - 1 then
              begin
                sMacIp := sMacIp + ',';
                sMacGuid := sMacGuid + ',';
              end;

            end;

          end;
          slMacIpList.CommaText := sMacIp;
          slMacGuidList.CommaText := sMacGuid;
        end
        else
          Exit;
      finally
        RemoteIpInfo.Free;
      end;

      RemoteNicInfo := TWin32_NetworkAdapter.Create(False);
      try
        RemoteNicInfo.WmiConnection.WmiServer := sIp;
        if not bUsePassthruCredentials then
        begin
          RemoteNicInfo.WmiConnection.WmiUser := sUser;
          RemoteNicInfo.WmiConnection.WmiPass := sPass;
        end;

        RemoteNicInfo.LoadWmiData('SELECT *',
          'WHERE AdapterType <> NULL AND NetConnectionID <> NULL'); // AND'

        //http://msdn.microsoft.com/en-us/library/aa394216%28v=vs.85%29.aspx
        //NetConnectionID does not exist on Windows 2000

        if RemoteNicInfo.WmiConnection.WmiConnected then
        begin
          //idx := 0;

          iColCount := RemoteNicInfo.GetCollectionCount;
          if iColCount < 0 then
            Exit;

          SetLength(MgNicArray, iColCount);
          for i := 0 to RemoteNicInfo.GetCollectionCount - 1 do
          begin
            RemoteNicInfo.SetCollectionIndex(i);

            sAdapterType := Trim(RemoteNicInfo.AdapterType);
            if (Length(sGuid) > 0) and (Length(sAdapterType) > 0) then
            begin
              sItemIp := slMacIpList.Values[RemoteNicInfo.MACAddress];
              sGuid := slMacGuidList.Values[RemoteNicInfo.MACAddress];

              MgNicArray[i].bEnableAdapter := False;
              MgNicArray[i].bDisableAdapter := False;
              //end;

              MgNicArray[i].sAdapterType := sAdapterType;
              MgNicArray[i].sCaption := RemoteNicInfo.Caption;
              MgNicArray[i].sGuid := sGuid;
              MgNicArray[i].sMac := RemoteNicInfo.MACAddress;
              MgNicArray[i].sManufacturer := RemoteNicInfo.Manufacturer;
              MgNicArray[i].sName := RemoteNicInfo.Name;
              MgNicArray[i].sIpAddress := sItemIp;
            end;
          end;

          strm := TMemoryStream.Create();
          //sldb := TSQLiteDatabase.Create(slDBPath);
          try
            i := Length(MgNicArray);
            strm.WriteBuffer(i, 4);
            strm.WriteBuffer(Pointer(MgNicArray)^, (Length(MgNicArray) * SizeOf(TRemoteNic)) + 4);
            //this is working
            strm.Position := 0;
            sQuery := 'UPDATE ' + INFO_TABLE + ' SET fldNicDetails = ? WHERE fldHostname = "' +
              sHostname + '" AND fldGroup = "' + sGroup + '";';

            ModifySqlTableBlobByQuery(sQuery, strm);
          finally
            FreeAndNil(strm);
          end;
        end;
      finally
        RemoteNicInfo.Free;
      end;
    except
      on E: Exception do
      begin
        //OutputDebugString(PChar(E.Classname + ': ' + E.Message));
      end;
    end;

  finally
    FreeAndNil(slMacIpList);
    FreeAndNil(slMacGuidList);
  end;
end;

end.

