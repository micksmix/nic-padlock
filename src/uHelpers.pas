unit uHelpers;

{$WEAKLINKRTTI ON}
{$RTTI EXPLICIT METHODS([]) PROPERTIES([]) FIELDS([])}

interface

uses
  SysUtils,
  IdGlobal,
  uGlobal,
  StrUtils,
  IdUDPClient,
  Classes,
  WinSock,
  ShlObj,
  PerlRegEx,
  uPing,
  AsyncCalls,
  SQLiteTable3,
  ActiveX,
  Variants,
  ComObj,
  Forms,
  LbCipher,
  LbString,
  ComCtrls,
  Registry,
  Windows;

procedure ThreadIsSystemOnlineNbt(sMachine: string; slIsOnline: TStringList); cdecl;
function IsSystemOnlineNbtPing(const sMachine: string; bNetBiosOnly: Boolean = False): Boolean;
function IsStrFloatNum(s: string): Boolean;
procedure HostToIP(sHost: string; slIP: TStringList); cdecl;
procedure ContactHost(sHost: string; slMsg: TStringList; const sTheHost, sTheGroup: string); cdecl;
procedure OnlyPing(sHost: string; slMsg: TStringList); cdecl;
function mgFileExists(const FileName: string): Boolean;
function mgContainsText(const AText, ASubText: string): Boolean;
function mgStartsText(const ASubText, AText: string): Boolean;
procedure MgSplitToStringList(const delimiter: Char; const value: string; const sl: TStringList);
function mgSplitString(wholeString: string; var firstItem: string; var theRest: string; splitOn: char
  = ' '): boolean;
function mgCountChar(S: string; C: Char): Integer;

//
function IfThen(AValue: Boolean; const ATrue: Integer; const AFalse: Integer = 0): Integer;
overload;
function IfThen(AValue: Boolean; const ATrue: Int64; const AFalse: Int64 = 0): Int64; overload;
function IfThen(AValue: Boolean; const ATrue: Double; const AFalse: Double = 0.0): Double; overload;
function StrToHex(const S: string): string;
function HexToString(aHex: string): string;
function GetRoamingUserAppDataPath: string;
function IsDirectoryWriteable(const AName: string): Boolean;
function HostToIPstr(sHost: string): string;
function MgDisconnectNetworkResource(const networkResource: string): boolean;
function MgConnectToNetworkResource(const networkResource: string; const username: string; const
  password: string; var sResultMsg: string): boolean;
function RetrieveIpFromDB(const sTheHost, sTheGroup: string): string;
procedure RetrieveDbAutoUpdateIp(const sHost, sGroup: string; var bAutoUpdateIp: boolean);
procedure AddNewResolvedIPs(var slRetrievedAddesses: TStringList; sTheHost, sTheGroup: string);
function RetrieveIpForHostAndUpdateDB(sTheHost, sTheGroup: string): string;
function GetSqlTableByQuery({var sqlitedb: TSQLiteDatabase;}var sTable: TSQLiteTable; sQuery:
  string): boolean;
function GetSqlUnicodeTableByQuery({var sqlitedb: TSQLiteDatabase;}var sUnicodeTable:
  TSQLiteUniTable; sQuery: string): boolean;
function ModifySqlTableBlobByQuery(sQuery: string; var memstream: TMemoryStream): boolean;
function ModifySqlTableByQuery({var sqlitedb: TSQLiteDatabase; }sQuery: string): boolean;
procedure RetrieveDbUserPass(const sGroup, sHost: string; var sUser: string; var sPass:
  string; var bUseAltUser: boolean);
function DecryptDbString(sCipherText: string): string;
function EncryptDbString(sValue: string): string;
//procedure RetrieveRemoteWinVersion(const sPass, sTheHost, sTheGroup: string;
//  bUseAltCreds: Boolean; const sHostToUse, sUser: string; hForm: THandle; slWinVersion:
//  TStringList); cdecl;
function GetWindowsVersion(const sHostname, sIp, sUser, sPass: string; bUsePassthruCredentials:
  boolean): string;
function IsAnIpAddress(sMachine: string; var bIsIpv6: boolean): boolean;
function VigenereExEncrypt(sSource, sKey: string; bDecrypt: Boolean = False; iTableSize: Integer =
  94): string;
procedure ListViewToCSV(theListView: TListView; const FileName: string);
procedure UpdateDbHostOnline(const sHost, sGroup: string; bOnline: Boolean);
function UpdateDeployResult(const sHost, sGroup, sMsg: string): string;
function FileLastModified(const TheFile: string): TDateTime;
function GetCurUserProfilePath(): string;
procedure Reg_WriteDateTime(dwRootKey: DWord; const sKey: string; const sField: string;
  aDate: TDateTime);
function Reg_ReadDateTime(dwRootKey: DWord; const sKey: string; const sField: string):
  TDateTime;
function FileCreatedTime(const fileName: string): TDateTime;
function GetBuildInfoAsString: string;
function StringToHex16(str: string): string;
function StringToHex(const S: string): string;
function HexToString16(const str: string): string;
function HexToStringUtf8(const str: string): string;
function StringToHexUtf8(str: string): string;
procedure DSiProcessMessages(hwnd: THandle; waitForWMQuit: boolean);

implementation

var
  Key128                      : TKey128;

  //

procedure DSiProcessMessages(hwnd: THandle; waitForWMQuit: boolean);
const
  WM_QUIT                     = $0012;
var
  bGet                        : longint;
  msg                         : TMsg;
begin
  if hwnd = 0 then
    Exit;
  repeat
    if not waitForWMQuit then
    begin
      if not PeekMessage(msg, hwnd, 0, 0, PM_REMOVE) then
        break; //repeat
    end
    else
    begin
      bGet := longint(GetMessage(msg, hwnd, 0, 0));
      if (bGet = 0) or (bGet = -1) then
        break; //repeat
    end;
    TranslateMessage(Msg);
    DispatchMessage(Msg);
  until msg.Message = WM_QUIT;
end; { DSiProcessMessages }

function HexToString16(const str: string): string;
var
  i, v                        : Integer;
  code                        : string;
begin
  Result := '';
  i := 1;
  while i < Length(str) do
  begin
    code := Copy(str, i, 4);
    Result := Result + Chr(StrToInt('$' + code));

    Inc(i, 4);
  end;
end;

function HexToStringUtf8(const str: string): string;
var
  i, v                        : Integer;
  code                        : string;
begin
  UTF8Decode(str);
  Result := '';
  i := 1;
  while i < Length(str) do
  begin
    code := Copy(str, i, 2);
    Result := Result + Chr(StrToInt(code));

    Inc(i, 2);
  end;
end;

function StringToHexUtf8(str: string): string;
var
  i                           : integer;
  s                           : string;
  u                           : RawByteString;
begin
  u := Utf8String(str);
  s := '';

  for i := 1 to length(u) do
  begin
    s := s + inttohex(Integer(u[i]), 2);
  end;
  result := s;

end;

function StringToHex(const S: string): string;
var
  Index                       : Integer;
begin
  Result := '';
  for Index := 1 to Length(S) do
    Result := Result + IntToHex(Byte(S[Index]), 2);
end;

function StringToHex16(str: string): string;
var
  i                           : integer;
  s                           : string;
begin
  s := '';

  for i := 1 to length(str) do
  begin
    s := s + inttohex(Integer(str[i]), 4);
  end;
  result := s;

end;

procedure GetBuildInfo(sFilename: string; var V1, V2, V3, V4: word);
var
  VerInfoSize, VerValueSize, Dummy: DWORD;
  VerInfo                     : Pointer;
  VerValue                    : PVSFixedFileInfo;
begin
  VerInfoSize := GetFileVersionInfoSize(PChar(ParamStr(0)), Dummy);
  if VerInfoSize > 0 then
  begin
    GetMem(VerInfo, VerInfoSize);
    try
      if GetFileVersionInfo(PChar(sFileName), 0, VerInfoSize, VerInfo) then
      begin
        VerQueryValue(VerInfo, '\', Pointer(VerValue), VerValueSize);
        with VerValue^ do
        begin
          V1 := dwFileVersionMS shr 16;
          V2 := dwFileVersionMS and $FFFF;
          V3 := dwFileVersionLS shr 16;
          V4 := dwFileVersionLS and $FFFF;
        end;
      end;
    finally
      FreeMem(VerInfo, VerInfoSize);
    end;
  end;
end;

function GetBuildInfoAsString: string;
var
  V1, V2, V3, V4              : word;
begin
  GetBuildInfo(ParamStr(0), V1, V2, V3, V4);
  Result := IntToStr(V1) + '.' + IntToStr(V2) + '.' +
    IntToStr(V3);// + '.' + IntToStr(V4);
end;

procedure Reg_WriteDateTime(dwRootKey: DWord; const sKey: string; const sField: string;
  aDate: TDateTime);
begin
  with TRegistry.Create(KEY_WRITE or KEY_WOW64_64KEY) do
    try
      RootKey := dwRootKey;
      if OpenKey(sKey, True) then
      begin
        try
          WriteBinaryData(sField, aDate, SizeOf(aDate));
        finally
          CloseKey;
        end;
      end;
    finally
      Free;
    end;
end;

// Read TDateTime from Registry

function Reg_ReadDateTime(dwRootKey: DWord; const sKey: string; const sField: string):
  TDateTime;
begin
  Result := 0; // default Return value
  with TRegistry.Create(KEY_READ or KEY_WOW64_64KEY) do
  begin
    RootKey := dwRootKey;
    if OpenKey(sKey, True) then
    begin
      try
        ReadBinaryData(sField, Result, SizeOf(Result));
      finally
        CloseKey;
      end;
    end;
    Free;
  end;
end;

function GetCurUserProfilePath(): string;
var
  r                           : Boolean;
  path                        : array[0..Max_Path] of Char;
begin
  Result := '-'; //default

  r := ShGetSpecialFolderPath(0, path, CSIDL_PROFILE, False);
  if not r then
    Exit;
  Result := ExcludeTrailingPathDelimiter(path);

  //if (dtLastMod - 15) < dtLastMod then
  //
end;

function DSiFileTimeToDateTime(fileTime: TFileTime; var dateTime: TDateTime): boolean;
var
  sysTime                     : TSystemTime;
begin
  Result := FileTimeToSystemTime(fileTime, sysTime);
  if Result then
    dateTime := SystemTimeToDateTime(sysTime);
end; { DSiFileTimeToDateTime }

function FileCreatedTime(const fileName: string): TDateTime;
{lastAccessTime, lastModificationTime: TDateTime}
var
  fileHandle                  : cardinal;
  fsCreationTime              : TFileTime;
  fsLastAccessTime            : TFileTime;
  fsLastModificationTime      : TFileTime;
  creationTime                : TDateTime;
begin
  fileHandle := CreateFile(PChar(fileName), GENERIC_READ, FILE_SHARE_READ, nil,
    OPEN_EXISTING, 0, 0);
  if fileHandle <> INVALID_HANDLE_VALUE then
    try
      //Result :=
      GetFileTime(fileHandle, @fsCreationTime, @fsLastAccessTime,
        @fsLastModificationTime); // and
      DSiFileTimeToDateTime(fsCreationTime, creationTime); //and
      //
      Result := creationTime;
      //DSiFileTimeToDateTime(fsLastAccessTime, lastAccessTime) and
      //DSiFileTimeToDateTime(fsLastModificationTime, lastModificationTime);
    finally
      CloseHandle(fileHandle);
    end;
end; { DSiGetFileTimes }

function FileLastModified(const TheFile: string): TDateTime;
var
  FileH                       : THandle;
  LocalFT                     : TFileTime;
  DosFT                       : DWORD;
  LastAccessedTime            : TDateTime;
  FindData                    : TWin32FindData;
begin
  //Result := '';
  Result := Now(); //default
  FileH := FindFirstFile(PChar(TheFile), FindData);
  if FileH <> INVALID_HANDLE_VALUE then
  begin
    Windows.FindClose(FileH);
    if (FindData.dwFileAttributes and
      FILE_ATTRIBUTE_DIRECTORY) = 0 then
    begin
      FileTimeToLocalFileTime
        (FindData.ftLastWriteTime, LocalFT);
      FileTimeToDosDateTime
        (LocalFT, LongRec(DosFT).Hi, LongRec(DosFT).Lo);
      LastAccessedTime := FileDateToDateTime(DosFT);
      Result := (LastAccessedTime);
    end;
  end;
end;

function UpdateDeployResult(const sHost, sGroup, sMsg: string): string;
var
  sSQL                        : string;
  sLastDeployed               : string;
  sDeployResult               : string;
  slMemo                      : TStringList;
  iCurLine                    : integer;
begin
  //
  sSQL := 'SELECT * From "' + INFO_TABLE + '" WHERE fldGroup = "' + sGroup
    + '" AND fldHostname = "' + sHost + '";';

  GetSqlTableByQuery(sltbInfo, sSQL);

  if sltbInfo.Count > 0 then
  begin
    while not sltbInfo.eof do
    begin
      sLastDeployed := sltbInfo.FieldByName['fldDeploymentResult'];
      if Length(sLastDeployed) >= 1 then
      begin
        sDeployResult := DateTimeToStr(Now()) + ': ' + sMsg + #13#10 +
          sLastDeployed;
      end
      else
      begin
        sDeployResult := DateTimeToStr(Now()) + ': ' + sMsg;
      end;

      sltbInfo.Next;
    end;
  end;

  slMemo := TStringList.Create;
  try
    slMemo.Text := sDeployResult;

    if (slMemo.Count - 1) > 10 then
    begin
      //let's reduce this to 10 lines
      //for sCurLine in slMemo do
      for iCurLine := 0 to slMemo.Count - 1 do
      begin
        //
        sDeployResult := slMemo[iCurLine] + #13#10 + sDeployResult;
      end;
    end;
  finally
    FreeAndNil(slMemo);
  end;

  sSQL := 'UPDATE  ' + INFO_TABLE + ' SET fldDeploymentResult = "' + sDeployResult +
    '" WHERE fldHostname = "' + sHost +
    '" and fldGroup = "' + sGroup + '";';

  ModifySqlTableByQuery(sSQL);

  Result := sDeployResult;
end;

procedure UpdateDbHostOnline(const sHost, sGroup: string; bOnline: Boolean);
var
  sSQL                        : string;
begin
  //
  sSQL := 'UPDATE  ' + INFO_TABLE
    + ' SET fldHostOnline = "' + BoolToStr(bOnline, True)
    + '" WHERE fldHostname = "' + sHost + '" AND fldGroup = "' + sGroup + '";';

  ModifySqlTableByQuery(sSQL);
end;

(* this procedure saves the content of a TListView *)
(*   to a CSV file *)

procedure ListViewToCSV(theListView: TListView; const FileName: string);
var
  item                        : TListItem;
  index                       : Integer;
  theFile                     : TStringList;
  Line                        : string;
begin
  (* initialize a TStringList *)
  theFile := TStringList.Create;
  (* loop to get all items of theListView *)
  for index := 0 to theListView.Items.Count - 1 do
  begin
    (* store the current item in a local variable *)
    item := theListView.Items[index];
    (* format the current line of the CSV *)
    Line := Format('%s,%s',
      [item.Caption, item.SubItems.CommaText]);
    (* add the line to CSV *)
    theFile.Add(Line);
  end;
  (* save the CSV file *)
  theFile.SaveToFile(FileName);
  (* free theFile variable *)
  FreeAndNil(theFile);
end;

(* this procedure loads the content of a CSV file *)
(* to a TListView *)

procedure ListViewFromCSV(theListView: TListView; const FileName: string);
var
  item                        : TListItem;
  index, comPos               : Integer;
  theFile                     : TStringList;
  Line                        : string;
begin
  (* initialize a TStringList *)
  theFile := TStringList.Create;
  (* then load it from FileName *)
  theFile.LoadFromFile(FileName);
  (* loop to get all lines *)
  for index := 0 to theFile.Count - 1 do
  begin
    (* store each line in a string variable *)
    Line := theFile[index];
    (* for every line add a item to the list *)
    item := theListView.Items.Add;
    (* get the first comma from the line *)
    comPos := Pos(',', Line);
    (* copy the value from start of string to *)
    (* the position of comma -1 *)
    item.Caption := Copy(Line, 1, comPos - 1);
    (* delete from Line starting from 1 to *)
    (* position of comma *)
    Delete(Line, 1, comPos);
    (* get the next comma *)
    comPos := Pos(',', Line);
    (* loop to get all values from the string *)
    (* 1 comma means 1 column *)
    while comPos > 0 do
    begin
      item.SubItems.Add(Copy(Line, 1, comPos - 1));
      Delete(Line, 1, comPos);
      comPos := Pos(',', Line);
    end;
    (* add last value as SubItem *)
    item.SubItems.Add(Line);
  end;
  (* free the TStringList *)
  FreeAndNil(theFile);
end;

function VigenereExEncrypt(sSource, sKey: string; bDecrypt: Boolean = False; iTableSize: Integer =
  94): string;
var
  i, iPosText, iPosKey        : Integer;
  sTable                      : string;
begin
  //Create our Cipher Table
  i := 32;
  while i<=(iTableSize + 32) do
  begin
    sTable := ConCat(sTable, Chr(i));
    inc(i);
  end;

  //Make the key the same size or greater than the Source
  while Length(sSource) >= Length(sKey) do
    sKey := ConCat(sKey, sKey);

  //Remove Line Feed & Carrage Returns from Cipher
  i := 0;
  while i <= Length(sSource) do
    if (sSource[i] = Chr(10)) or (sSource[i] = Chr(13)) then
      Delete(sSource, i, 1)
    else
      Inc(i);
  {Uncomment if you need to remove spaces
  //Remove Spaces from Cipher
    i:=0;
    while i<=Length(sSource) do
    if sSource[i]=' ' then
      Delete(sSource, i, 1)
    else
      Inc(i);
  }

  //Vegenere Encryption/Decryption routine
  i := 1;
  while i <= Length(sSource) do
  begin
    iPosText := pred(pos(sSource[i], sTable));
    iPosKey := pred(pos(sKey[i], sTable));
    //Encrypt or Decrypt(Default is Encrypt)
    case bDecrypt of
      False: Result := Result + sTable[((iPosText + iPosKey) mod iTableSize) + 1];
      True: Result := Result + sTable[(((iPosText + iTableSize) - iPosKey) mod iTableSize) + 1];
    end;
    inc(i);
  end;
end;

function GetWindowsVersion(const sHostname, sIp, sUser, sPass: string; bUsePassthruCredentials:
  boolean): string;
const
  wbemFlagForwardOnly         = $00000020;
var
  FSWbemLocator               : OLEVariant;
  FWMIService                 : OLEVariant;
  FWbemObject                 : OLEVariant;
  FWbemObjectSet              : OleVariant;
  sWindowsVersion             : string;
  oEnum                       : IEnumvariant;
  iValue                      : LongWord;
begin
  sWindowsVersion := '-'; //default
  FSWbemLocator := CreateOleObject('WbemScripting.SWbemLocator');
  FWMIService := FSWbemLocator.ConnectServer(sIp, 'root\CIMV2', sUser, sPass);
  FWbemObjectSet := FWMIService.ExecQuery('SELECT Version FROM Win32_OperatingSystem',
    'WQL', wbemFlagForwardOnly);
  //FWbemObject := FWMIService.Get('Win32_OperatingSystem=@');
  oEnum := IUnknown(FWbemObjectSet._NewEnum) as IEnumVariant;
  while oEnum.Next(1, FWbemObject, iValue) = 0 do
  begin
    sWindowsVersion := Trim(Format('%s', [FWbemObject.Version]));
    FWbemObject := Unassigned;
  end;
  Result := sWindowsVersion;
end;

function EncryptDbString(sValue: string): string;
const
  s1                          = '4X+zru';
  s2                          = 'VHA';
  s3                          = 'TkpsY';
  s4                          = 'Rg';
var
  origRandPwd                 : string;
  sEncrypted                  : string;
begin

  GenerateLMDKey(Key128, SizeOf(Key128), HexToString(sEncryptedPassVal));
  //decrypt using original value

  origRandPwd := RDLEncryptStringCBCEx(//this is the original RAND pwd that should not change
    HexToString(sEncryptedPassVal2),
    Key128,
    16,
    False
    );

  GenerateLMDKey(Key128, SizeOf(Key128), origRandPwd);
  //HexToString(main.sEncryptedPassVal2));  //encrypt using the 'rand' password
  sEncrypted := RDLEncryptStringCBCEx(
    sValue,
    Key128,
    16,
    True
    );

  Result := sEncrypted; //EncodePWDEx(sEncrypted, s3 + s1 + s4 + s2);
end;

function DecryptDbString(sCipherText: string): string;
var
  origRandPwd                 : string;
  sDecrypted                  : string;
begin
  GenerateLMDKey(Key128, SizeOf(Key128), HexToString(sEncryptedPassVal));
  //decrypt using original value

  origRandPwd := RDLEncryptStringCBCEx(//this is the original RAND pwd that should not change
    HexToString(sEncryptedPassVal2),
    Key128,
    16,
    False
    );

  GenerateLMDKey(Key128, SizeOf(Key128), origRandPwd);
  sDecrypted := RDLEncryptStringCBCEx(
    sCipherText,
    Key128,
    16,
    False
    );

  Result := sDecrypted; //DecodePWDEx(sDecrypted, s3 + s1 + s4 + s2);
end;

procedure RetrieveDbUserPass(const sGroup, sHost: string; var sUser: string; var sPass:
  string; var bUseAltUser: boolean);
var
  //sldb                        : TSQLiteDatabase;
  sSQL                        : string;
begin

  //sldb := TSQLiteDatabase.Create(slDBPath);
  try
    sSQL := 'SELECT * From "' + INFO_TABLE + '" WHERE fldGroup = "' + sGroup +
      '" AND fldHostname = "' + sHost + '";';

    GetSqlTableByQuery(sltbInfo, sSQL);

    if sltbInfo.Count <= 0 then
    begin
      Exit;
    end;

    while not sltbInfo.eof do
    begin
      bUseAltUser := StrToBool(sltbInfo.FieldByName['fldUseAltUser']);

      if bUseAltUser then
      begin
        sUser := DecryptDbString(sltbInfo.FieldByName['fldAltUser']);
        sPass := DecryptDbString(sltbInfo.FieldByName['fldAltPass']);
      end
      else
      begin
        sUser := '';
        sPass := '';
      end;
      sltbInfo.Next;
    end;
  finally
    if sltbInfo <> nil then
      FreeAndNil(sltbInfo);

    //sldb.Free;
  end;
end;

procedure AddNewResolvedIPs(var slRetrievedAddesses: TStringList; sTheHost, sTheGroup: string);
var
  slIpAddresses               : TStringList;
  j                           : Integer;
  sChecked                    : string;
  bFoundChecked               : boolean;
  sCurCommaText               : string;
  sQuery, sSQL                : string;
begin
  //
  bFoundChecked := False;
  slIpAddresses := TStringList.Create;
  try
    slIpAddresses.Sorted := True;
    slIpAddresses.Duplicates := dupIgnore;

    sSQL := 'SELECT * From "' + INFO_TABLE + '" WHERE fldGroup = "' + sTheGroup +
      '" AND fldHostname = "' + sTheHost + '";';

    GetSqlTableByQuery(sltbInfo, sSQL);

    if sltbInfo.Count <= 0 then
    begin
      Exit;
    end;

    //
    slIpAddresses.CommaText := sltbInfo.FieldByName['fldIpAddr'];

    sCurCommaText := ReplaceText(slIpAddresses.CommaText, '=1', '=0');
    //sCurCommaText := slIpAddresses.CommaText;

    if ((Length(Trim(sCurCommaText)) > 0) and (slRetrievedAddesses.Count > 0)) then
    begin
      sCurCommaText := sCurCommaText + ',';
    end;

    for j := 0 to slRetrievedAddesses.Count - 1 do
    begin
      if j = 0 then
      begin
        //none are checked. lets just take the 1st one then
        sCurCommaText := sCurCommaText + slRetrievedAddesses[j] + '=0';
        //we will check this one later
        sChecked := slRetrievedAddesses[j];
      end
      else
      begin
        sCurCommaText := sCurCommaText + slRetrievedAddesses[j] + '=0';
      end;

      if j <> slRetrievedAddesses.Count - 1 then
      begin
        sCurCommaText := sCurCommaText + ',';
      end;

    end;

    slIpAddresses.CommaText := sCurCommaText; //this needs to go into the DB
    slIpAddresses.CommaText := ReplaceText(slIpAddresses.CommaText, sChecked + '=0', sChecked +
      '=1');

    sQuery := 'UPDATE  ' + INFO_TABLE + ' SET fldIpAddr = "' + slIpAddresses.CommaText +
      '" WHERE fldHostname = "' +
      sTheHost + '" AND fldGroup = "' + sTheGroup + '";';

    ModifySqlTableByQuery(sQuery);

  finally
    FreeAndNil(slIpAddresses);

    if sltbInfo <> nil then
      FreeAndNil(sltbInfo);

    //sldb.Free;
  end;
  ///
end;

function RetrieveIpForHostAndUpdateDB(sTheHost, sTheGroup: string): string;
var
  slIpAddresses               : TStringList;
  sHost                       : string;
  asHostQuery                 : IAsyncCall;
  sSQL                        : string;
  i                           : integer;
begin
  Result := ''; //default
  sHost := sTheHost;
  slIpAddresses := TStringList.Create;
  try
    slIpAddresses.Sorted := True;
    slIpAddresses.Duplicates := dupIgnore;
    //
    asHostQuery := AsyncCall(@HostToIP, [sHost, slIpAddresses]);

    while AsyncMultiSync([asHostQuery], True, 10) = WAIT_TIMEOUT do
    begin
      Application.ProcessMessages;
    end;

    AddNewResolvedIPs(slIpAddresses, sTheHost, sTheGroup);
    try
      sSQL := 'SELECT * From "' + INFO_TABLE + '" WHERE fldGroup = "' + sTheGroup +
        '" AND fldHostname = "' + sTheHost + '";';

      GetSqlTableByQuery(sltbInfo, sSQL);

      if sltbInfo.Count <= 0 then
      begin
        Exit;
      end;

      while not sltbInfo.eof do
      begin
        Application.ProcessMessages;
        slIpAddresses.Clear;
        slIpAddresses.CommaText := sltbInfo.FieldByName['fldIpAddr'];

        for i := 0 to slIpAddresses.Count - 1 do
        begin
          if slIpAddresses.ValueFromIndex[i] = '0' then
          begin
            //SetCheckedListboxState(lbIpAddresses, i, False);
            Application.ProcessMessages;
          end
          else
          begin
            Result := Trim(slIpAddresses.Names[i]);
            Application.ProcessMessages;
            break;
          end;
        end;

        sltbInfo.Next;
      end;
    finally
      if sltbInfo <> nil then
        FreeAndNil(sltbInfo);

      //sldb.Free;
    end;
  finally
    FreeAndNil(slIpAddresses);
  end;
end;

procedure RetrieveDbAutoUpdateIp(const sHost, sGroup: string; var bAutoUpdateIp: boolean);
var
  sSQL                        : string;
begin
  try
    sSQL := 'SELECT * From "' + INFO_TABLE + '" WHERE fldGroup = "' + sGroup +
      '" AND fldHostname = "' + sHost + '";';

    GetSqlTableByQuery(sltbInfo, sSQL);

    if sltbInfo.Count <= 0 then
    begin
      Exit;
    end;

    while not sltbInfo.eof do
    begin
      bAutoUpdateIp := StrToBool(sltbInfo.FieldByName['fldAutoUpdateIp']);

      sltbInfo.Next;
    end;
  finally
    if sltbInfo <> nil then
      FreeAndNil(sltbInfo);

    //sldb.Free;
  end;
end;

function RetrieveIpFromDB(const sTheHost, sTheGroup: string): string;
var
  slIpAddresses               : TStringList;
  sHost                       : string;
  sSQL                        : string;
  i                           : integer;
begin
  Result := ''; //default

  sHost := sTheHost;
  slIpAddresses := TStringList.Create;
  try
    slIpAddresses.Sorted := True;
    slIpAddresses.Duplicates := dupIgnore;
    //
    try
      sSQL := 'SELECT * From "' + INFO_TABLE + '" WHERE fldGroup = "' + sTheGroup +
        '" AND fldHostname = "' + sTheHost + '";';

      GetSqlTableByQuery(sltbInfo, sSQL);

      if sltbInfo.Count <= 0 then
      begin
        Exit;
      end;

      while not sltbInfo.eof do
      begin
        slIpAddresses.Clear;
        slIpAddresses.CommaText := sltbInfo.FieldByName['fldIpAddr'];

        //lblRemoteIpAddress.Caption := ''; //default
        for i := 0 to slIpAddresses.Count - 1 do
        begin
          if slIpAddresses.ValueFromIndex[i] = '0' then
          begin
            //SetCheckedListboxState(lbIpAddresses, i, False);
          end
          else
          begin
            Result := Trim(slIpAddresses.Names[i]);
            //lblRemoteIpAddress.Caption := slIpAddresses.Names[i];
            break;
          end;
        end;

        sltbInfo.Next;
      end;
    finally
      if sltbInfo <> nil then
        FreeAndNil(sltbInfo);

      //sldb.Free;
    end;
  finally
    FreeAndNil(slIpAddresses);
  end;
end;

function ModifySqlTableByQuery(sQuery: string): boolean;
var
  sqlite_query                : TSQLiteQuery;
  //sqlitedb                    : TSQLiteDatabase;
begin
  Crit_UpdateDb.Enter;
  Result := False; //default
  try
    //sqlitedb := TSQLiteDatabase.Create(slDBPath);
    try
      try
        //http://bobby-tables.com/delphi.html
        //sqlitedb.ExecSQL('PRAGMA temp_store = MEMORY;');

        if not StrUtils.EndsStr(';', sQuery) then
          sQuery := sQuery + ';';

        sqlite_query := sqlitedb.PrepareSQL(sQuery);
        sqlitedb.BeginTransaction;
        sqlitedb.ExecSQL(sqlite_query.SQL);
        sqlitedb.Commit;
        Result := True;
      except
        on E: Exception do
        begin
          //if Assigned(sqlitedb) then
          //  FreeAndNil(sqlitedb);
          try
            sqlitedb := TSQLiteDatabase.Create(slDBPath);
            //
            sqlite_query := sqlitedb.PrepareSQL(sQuery);
            sqlitedb.BeginTransaction;
            sqlitedb.ExecSQL(sqlite_query.SQL);
            sqlitedb.Commit;
            Result := True;
          except
            //
          end;

          //MessageBox(0, PChar(e.Message), '', MB_ICONSTOP or MB_OK);
          //OutputDebugString(PChar('error: ' + e.ClassName + ' = ' + e.Message));
        end;
      end;
    finally

      //sqlitedb.Free;
    end;
  finally
    Crit_UpdateDb.Leave;
  end;
end;

function ModifySqlTableBlobByQuery(sQuery: string; var memstream: TMemoryStream): boolean;
var
  sqlite_query                : TSQLiteQuery;
  //sqlitedb                    : TSQLiteDatabase;
begin
  Crit_UpdateDb.Enter;
  try
    //sqlitedb := TSQLiteDatabase.Create(slDBPath);
    try
      try
        //http://bobby-tables.com/delphi.html
        //sqlitedb.ExecSQL('PRAGMA temp_store = MEMORY;');

        if not StrUtils.EndsStr(';', sQuery) then
          sQuery := sQuery + ';';

        sqlite_query := sqlitedb.PrepareSQL(sQuery);
        sqlitedb.BeginTransaction;
        sqlitedb.UpdateBlob(sqlite_query.SQL, memstream);
        sqlitedb.Commit;
      except
        on E: Exception do
        begin
          //if Assigned(sqlitedb) then
          //  FreeAndNil(sqlitedb);
          try
            sqlitedb := TSQLiteDatabase.Create(slDBPath);
            //
            sqlite_query := sqlitedb.PrepareSQL(sQuery);
            sqlitedb.BeginTransaction;
            sqlitedb.UpdateBlob(sqlite_query.SQL, memstream);
            sqlitedb.Commit;
          except
            //
          end;

          //MessageBox(0, PChar(e.Message), '', MB_ICONSTOP or MB_OK);
          //OutputDebugString(PChar('error: ' + e.ClassName + ' = ' + e.Message));
        end;
      end;
    finally
      //sqlitedb.Free;
    end;
  finally
    Crit_UpdateDb.Leave;
  end;
end;

function GetSqlUnicodeTableByQuery({var sqlitedb: TSQLiteDatabase;}var sUnicodeTable:
  TSQLiteUniTable; sQuery: string): boolean;
//var
  //sqlitedb                    : TSQLiteDatabase;
begin
  Crit_UpdateDb.Enter;
  try
    //sqlitedb := TSQLiteDatabase.Create(slDBPath);
    try
      try
        //        if sUnicodeTable <> nil then
        //        begin
        //          //FreeAndNil(sUnicodeTable);
        //          sUnicodeTable.Destroy;
        //        end;

        if not StrUtils.EndsStr(';', sQuery) then
          sQuery := sQuery + ';';

        sUnicodeTable := sqlitedb.GetUniTable(sQuery);
      except
        on E: Exception do
        begin
          //if Assigned(sqlitedb) then
          //  FreeAndNil(sqlitedb);

          sqlitedb := TSQLiteDatabase.Create(slDBPath);
          //
          try
            sUnicodeTable := sqlitedb.GetUniTable(sQuery);
          except
            //
          end;

          //MessageBox(0, PChar(e.Message), '', MB_ICONSTOP or MB_OK);
          //OutputDebugString(PChar('error: ' + e.ClassName + ' = ' + e.Message));
        end;
      end;
    finally
      //sqlitedb.Free;
    end;
  finally
    Crit_UpdateDb.Leave;
  end;
end;

function GetSqlTableByQuery({var sqlitedb: TSQLiteDatabase;}var sTable: TSQLiteTable; sQuery:
  string): boolean;
//var
//  sqlitedb                    : TSQLiteDatabase;
begin
  Crit_UpdateDb.Enter;
  try
    //sqlitedb := TSQLiteDatabase.Create(slDBPath);
    try
      try
        if sTable <> nil then
          FreeAndNil(sTable);

        if not StrUtils.EndsStr(';', sQuery) then
          sQuery := sQuery + ';';

        sTable := sqlitedb.GetTable(sQuery);
      except
        on E: Exception do
        begin
          //if Assigned(sqlitedb) then
          //  FreeAndNil(sqlitedb);

          sqlitedb := TSQLiteDatabase.Create(slDBPath);
          //
          try
            sTable := sqlitedb.GetTable(sQuery);
          except
            //
          end;
          //MessageBox(0, PChar(e.Message), '', MB_ICONSTOP or MB_OK);
          //OutputDebugString(PChar('error: ' + e.ClassName + ' = ' + e.Message));
        end;
      end;
    finally
      //sqlitedb.Free;
    end;
  finally
    Crit_UpdateDb.Leave;
  end;
end;

function MgDisconnectNetworkResource(const networkResource: string): boolean;
var
  ErrCode                     : Cardinal;
begin
  //
  Result := False;
  //default
  ErrCode := WNetCancelConnection2(PChar(networkResource), 0, True);

  if (ErrCode = NO_ERROR) then
    Result := True; // indicate success

end;
{:Connects to a network resource and optionally maps drive letter to it.
  @author  gabr
  @since   2008-05-05
}

function MgConnectToNetworkResource(const networkResource: string; const username: string; const
  password:
  string; var sResultMsg: string): boolean;
var
  netResource                 : TNetResource;
  ErrCode                     : Cardinal;
begin
  Result := false;

  FillChar(netResource, SizeOf(netResource), 0);
  netResource.dwScope := RESOURCE_GLOBALNET;
  netResource.dwType := RESOURCETYPE_DISK;
  netResource.dwDisplayType := RESOURCEDISPLAYTYPE_SHARE;
  netResource.dwUsage := RESOURCEUSAGE_CONNECTABLE;

  //    if mappedLetter <> '' then
  //    begin
  //      driveName := mappedLetter + ':'#0;
  //      netResource.lpLocalName := PChar(@driveName[1]);
  //    end;

  netResource.lpRemoteName := PChar(networkResource); //eg: \\192.168.1.1\share
  //Result := (WNetAddConnection2(netResource, PChar(password), PChar(username), 0) = NO_ERROR);
  ErrCode := WNetAddConnection2(netResource, PChar(password), PChar(username), 0);

  Result := False; //default
  if ErrCode <> 0 then
  begin
    sResultMsg := SysErrorMessage(ErrCode);
  end
  else
  begin
    sResultMsg := 'Success';
    Result := True;
  end;
end; { DSiConnectToNetworkResource }

function IsDirectoryWriteable(const AName: string): Boolean;
var
  FileName                    : string;
  H                           : THandle;
begin
  FileName := IncludeTrailingPathDelimiter(AName) + 'chk.tmp';
  H := CreateFile(PChar(FileName), GENERIC_READ or GENERIC_WRITE, 0, nil,
    CREATE_NEW, FILE_ATTRIBUTE_TEMPORARY or FILE_FLAG_DELETE_ON_CLOSE, 0);
  Result := H <> INVALID_HANDLE_VALUE;
  if Result then
    CloseHandle(H);
end;

function GetRoamingUserAppDataPath: string;
// works so long as people have at least IE 4.  (and Win95 or better)
var
  r                           : Bool;
  path                        : array[0..Max_Path] of Char;
begin
  r := ShGetSpecialFolderPath(0, path, CSIDL_APPDATA, False);
  if r then
    result := ExcludeTrailingPathDelimiter(path)
  else
    result := '';
end;

//function StringToHex(const S: string): string;

function StrToHex(const S: string): string;
var
  Index                       : Integer;
begin
  Result := '';
  for Index := 1 to Length(S) do
    Result := Result + IntToHex(Byte(S[Index]), 2);
end;

function TransChar(AChar: Char): Integer;
begin
  if AChar in ['0'..'9'] then
    Result := Ord(AChar) - Ord('0')
  else
    Result := 10 + Ord(AChar) - Ord('A');
end;

function HexToString(aHex: string): string;
var
  I                           : Integer;
  CharValue                   : Word;
begin
  Result := '';
  for I := 1 to Trunc(Length(aHex) / 2) do
  begin
    Result := Result + ' ';
    CharValue := TransChar(aHex[2 * I - 1]) * 16 + TransChar(aHex[2 * I]);
    Result[I] := Char(CharValue);
  end;
end;

function IsStrFloatNum(s: string): Boolean;
begin
  if ContainsText(s, '.') then
  begin
    Result := True;
  end
  else
  begin
    Result := False;
  end;
end;

procedure OnlyPing(sHost: string; slMsg: TStringList); cdecl;
var
  bPing                       : Boolean;
  sPingStatus                 : string;
  sMessage                    : string;
begin
  //
  bPing := True; //default
  bPing := uPing.Ping(sHost); //, 3000);
  //
  sPingStatus := 'Could not reach'; //default
  slMsg.Add(BoolToStr(bPing));
end;

procedure ContactHost(sHost: string; slMsg: TStringList; const sTheHost, sTheGroup: string); cdecl;
var
  bPing                       : Boolean;
  bNbt                        : Boolean;
  sPingStatus, sNbtStatus     : string;
  sMessage                    : string;
begin
  //
  bPing := True; //default
  bNbt := True;

  bPing := uPing.Ping(sHost); //, 3000);
  //
  //Application.ProcessMessages;
  //
  bNbt := uHelpers.IsSystemOnlineNbtPing(sHost, True);

  sPingStatus := 'Could not reach'; //default
  sNbtStatus := 'Could not reach'; //default

  if bPing then
    sPingStatus := 'ONLINE';

  if bNbt then
    sNbtStatus := 'ONLINE';

  sMessage := 'Host: ' + sHost
    + #13#10
    + #13#10
    + 'Ping: ' + sPingStatus
    + #13 + #10
    + 'NetBIOS Query: ' + sNbtStatus;

  if bPing or bNbt then
    UpdateDbHostOnline(sTheHost, sTheGroup, True)
  else
    UpdateDbHostOnline(sTheHost, sTheGroup, False);

  slMsg.Text := sMessage;
end;

procedure HostToIP(sHost: string; slIP: TStringList); cdecl; //: Boolean;
var
  aHostName                   : array[0..255] of AnsiChar;
  pcAddr                      : PAnsiChar;
  HostEnt                     : PHostEnt;
  wsData                      : TWSAData;
  sTheHost                    : string;
begin
  try
    WSAStartup($0101, wsData);
    try
      GetHostName(aHostName, SizeOf(aHostName));
      StrPCopy(aHostName, sHost);
      hostEnt := GetHostByName(aHostName);
      if Assigned(HostEnt) then
        if Assigned(HostEnt^.H_Addr_List) then
        begin
          pcAddr := HostEnt^.H_Addr_List^;
          if Assigned(pcAddr) then
          begin
            sHost := Format('%d.%d.%d.%d', [Byte(pcAddr[0]), Byte(pcAddr[1]),
              Byte(pcAddr[2]), Byte(pcAddr[3])]);

            slIP.Add(sHost);
            //Result := True;
          end
          else
            //Result := False;
        end
        else
          //Result := False
      else
      begin
        //Result := False;
      end;
    finally
      WSACleanup;
    end;
  except on E: Exception do
    begin
      //suppress
    end;

  end;
end;

function HostToIPstr(sHost: string): string;
var
  aHostName                   : array[0..255] of AnsiChar;
  pcAddr                      : PAnsiChar;
  HostEnt                     : PHostEnt;
  wsData                      : TWSAData;
  sTheHost                    : string;
begin
  //
  //only supports ipv4 right now
  //
  Result := '';
  try
    WSAStartup($0101, wsData);
    try
      GetHostName(aHostName, SizeOf(aHostName));
      StrPCopy(aHostName, sHost);
      hostEnt := GetHostByName(aHostName);
      if Assigned(HostEnt) then
        if Assigned(HostEnt^.H_Addr_List) then
        begin
          pcAddr := HostEnt^.H_Addr_List^;
          if Assigned(pcAddr) then
          begin
            sHost := Format('%d.%d.%d.%d', [Byte(pcAddr[0]), Byte(pcAddr[1]),
              Byte(pcAddr[2]), Byte(pcAddr[3])]);

            Result := sHost;

            //Result := True;
          end
          else
            //Result := False;
        end
        else
          //Result := False
      else
      begin
        //Result := False;
      end;
    finally
      WSACleanup;
    end;
  except on E: Exception do
    begin
      //suppress
    end;

  end;
end;

function IsAnIpAddress(sMachine: string; var bIsIpv6: boolean): boolean;
var
  Regex                       : TPerlRegex;
  bMatch                      : boolean;
begin
  bIsIpv6 := False; //default
  Regex := TPerlRegEx.Create(nil);
  try
    Regex.RegEx :=
      '\b(?:(?:25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])\.){3}(?:25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])\b';
    Regex.Options := [preSingleLine, preCaseless, preMultiLine];
    Regex.Subject := sMachine;
    bMatch := Regex.Match;

    if not bMatch then
    begin
      //this may be an ipv6 address
      Regex.RegEx :=
        '\b(?:(?:25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])\.){3}(?:25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])\b';
      Regex.Options := [preSingleLine, preCaseless, preMultiLine];
      Regex.Subject := sMachine;
      bMatch := Regex.Match;

      bIsIpv6 := True;
    end;

  finally
    FreeAndNil(Regex);
  end;

  Result := bMatch;
end;

function IsSystemOnlineNbtPing(const sMachine: string; bNetBiosOnly: Boolean = False): Boolean;
var
  bOnline                     : Boolean;
  asNbtQuery                  : IAsyncCall;
  asHostPing                  : IAsyncCall;
  slIsOnline                  : TStringList;
  sCur                        : string;
begin
  bOnline := False; //default
  slIsOnline := TStringList.Create;
  try
    asNbtQuery := AsyncCall(@ThreadIsSystemOnlineNbt, [sMachine, slIsOnline]);

    while AsyncMultiSync([asNbtQuery], True, 10) = WAIT_TIMEOUT do
    begin
      if Assigned(Application) then
        Application.ProcessMessages;
    end;

    for sCur in slIsOnline do
    begin
      bOnline := StrToBool(sCur);
    end;

  finally
    FreeAndNil(slIsOnline);
  end;

  if (not bOnline) and (not bNetBiosOnly) then
  begin
    //nbtscan came up with nothing --- lets also ping to be sure

    slIsOnline := TStringList.Create;
    try
      asHostPing := AsyncCall(@OnlyPing, [sMachine, slIsOnline]);
      while AsyncMultiSync([asHostPing], True, 10) = WAIT_TIMEOUT do
      begin
        if Assigned(Application) then
          Application.ProcessMessages;
      end;

      for sCur in slIsOnline do
      begin
        bOnline := StrToBool(sCur);
      end;
    finally
      FreeAndNil(slIsOnline);
    end;
  end;

  Result := bOnline;
end;

procedure ThreadIsSystemOnlineNbt(sMachine: string; slIsOnline: TStringList); cdecl;
const
  NB_REQUEST                  =
    #$A2#$48#$00#$00#$00#$01#$00#$00 +
    #$00#$00#$00#$00#$20#$43#$4B#$41 +
    #$41#$41#$41#$41#$41#$41#$41#$41 +
    #$41#$41#$41#$41#$41#$41#$41#$41 +
    #$41#$41#$41#$41#$41#$41#$41#$41 +
    #$41#$41#$41#$41#$41#$00#$00#$21 +
    #$00#$01;

  NB_PORT                     = 137;
  NB_BUFSIZE                  = 8192;
var
  Buffer                      : TIdBytes;
  I                           : Integer;
  RepName                     : string;
  UDPClient                   : TIdUDPClient;
  bOnline                     : boolean;
  bIsIpv6                     : boolean;
begin

  bOnline := False; //default
  RepName := '';
  //UDPClient := nil;

  //check if sMachine is an IP address or not
  if not IsAnIpAddress(sMachine, bIsIpv6) then
  begin
    sMachine := HostToIPstr(sMachine);

    if not IsAnIpAddress(sMachine, bIsIpv6) then
    begin
      bOnline := False;
    end;
  end;

  try
    UDPClient := TIdUDPClient.Create(nil);
    try
      if bIsIpv6 then
        UDPClient.IPVersion := TIdIpVersion.Id_IPv6
      else
        UDPClient.IPVersion := TIdIpVersion.Id_IPv4;

      UDPClient.Host := Trim(sMachine);
      UDPClient.Port := NB_PORT;

      UDPClient.Send(NB_REQUEST);

      SetLength(Buffer, NB_BUFSIZE);
      if (0 < UDPClient.ReceiveBuffer(Buffer, 3000)) then
      begin

        for I := 1 to 15 do
          RepName := RepName + Chr(Buffer[56 + I]);

        if StartsText(#0, RepName) then
        begin
          RepName := '';
        end
        else
        begin
          bOnline := True;
        end;

        //RepName := Trim(RepName);
        //FHostname := RepName;
      end;
    finally
      if Assigned(UDPClient) then
        FreeAndNil(UDPClient);
    end;
  except
    //Result := False;
  end;

  slIsOnline.Add(BoolToStr(bOnline));
end;

//function CreateNetResourceList(ResourceType: DWord; NetResource: PNetResource; out Entries: DWord; out List:
//  PNetResourceArray): Boolean;
//var
//  EnumHandle        : THandle;
//  BufSize           : DWord;
//  Res               : DWord;
//begin
//  Result := False;
//  List := nil;
//  Entries := 0;
//  if WNetOpenEnum(RESOURCE_GLOBALNET,
//    ResourceType,
//    0,
//    NetResource,
//    EnumHandle) = NO_ERROR then
//  begin
//    try
//      BufSize := $4000;                 // 16 kByte
//      GetMem(List, BufSize);
//      try
//        repeat
//          Entries := DWord(-1);
//          FillChar(List^, BufSize, 0);
//          Res := WNetEnumResource(EnumHandle, Entries, List, BufSize);
//          if Res = ERROR_MORE_DATA then
//          begin
//            ReAllocMem(List, BufSize);
//          end;
//        until Res <> ERROR_MORE_DATA;
//        Result := Res = NO_ERROR;
//        if not Result then
//        begin
//          FreeMem(List);
//          List := nil;
//          Entries := 0;
//        end;
//      except
//        FreeMem(List);
//        raise;
//      end;
//    finally
//      WNetCloseEnum(EnumHandle);
//    end;
//  end;
//end;
//
//procedure GetComputerList(List: TStrings);
//
//procedure ScanLevel(ResourceType, DisplayType: DWord; NetResource: PNetResource);
//  var
//    Entries         : DWord;
//    NetResourceList : PNetResourceArray;
//    i               : Integer;
//  begin
//    if CreateNetResourceList(ResourceType, NetResource, Entries, NetResourceList) then
//      try
//        for i := 0 to Integer(Entries) - 1 do
//        begin
//          if (DisplayType = RESOURCEDISPLAYTYPE_GENERIC) or
//            (NetResourceList[i].dwDisplayType = DisplayType) then
//          begin
//            List.AddObject(NetResourceList[i].lpRemoteName,
//              Pointer(NetResourceList[i].dwDisplayType));
//          end;
//          if (NetResourceList[i].dwUsage and RESOURCEUSAGE_CONTAINER) <> 0 then
//            ScanLevel(RESOURCETYPE_DISK, RESOURCEDISPLAYTYPE_SERVER, @NetResourceList[i]);
//        end;
//      finally
//        FreeMem(NetResourceList);
//      end;
//  end;
//begin
//  ScanLevel(RESOURCETYPE_DISK, RESOURCEDISPLAYTYPE_SERVER, nil);
//end;
//

function IfThen(AValue: Boolean; const ATrue: Integer; const AFalse: Integer): Integer;
begin
  if AValue then
    Result := ATrue
  else
    Result := AFalse;
end;

function IfThen(AValue: Boolean; const ATrue: Int64; const AFalse: Int64): Int64;
begin
  if AValue then
    Result := ATrue
  else
    Result := AFalse;
end;

function IfThen(AValue: Boolean; const ATrue: Double; const AFalse: Double): Double;
begin
  if AValue then
    Result := ATrue
  else
    Result := AFalse;
end;

procedure MgSplitToStringList(const delimiter: Char; const value: string; const sl: TStringList);
var
  dx                          : integer;
  ns                          : string;
  txt                         : string;
  delta                       : integer;
begin
  try
    delta := Length(delimiter);
    txt := value + delimiter;
    sl.BeginUpdate;
    sl.Clear;
    try
      while Length(txt) > 0 do
      begin
        dx := Pos(delimiter, txt);
        ns := Copy(txt, 0, dx - 1);
        sl.Add(ns);
        txt := Copy(txt, dx + delta, MaxInt);
      end;
    finally
      sl.EndUpdate;
    end;
  except on E: Exception do
    begin
      //OutputDebugString(PChar(' >> split: ' + E.Message));
    end;
  end;
end;

function mgCountChar(S: string; C: Char): Integer;
var
  i                           : Integer;
begin
  Result := 0;
  for i := 1 to Length(S) do
    if S[i] = C then
      Inc(Result);
end;

function mgSplitString(wholeString: string; var firstItem: string; var theRest:
  string; splitOn: char = ' '): boolean;
var
  retval                      : boolean;
begin
  firstItem := wholeString;
  if pos(splitOn, wholeString) > 0 then
  begin
    firstItem := copy(wholeString, 1, (pos(splitOn, wholeString) - 1));
    theRest := copy(wholeString, length(firstItem) + length(splitOn) + 1,
      (length(wholeString) - (length(firstItem) + length(splitOn))));
    retval := TRUE;
  end
  else
  begin
    theRest := '';
    retval := (firstItem <> '');
  end;

  Result := retval;
end;

//procedure FreeStringListObjects(const strings: TStrings);
//var
//  idx               : integer;
//begin
//  for idx := 0 to Pred(strings.Count) do
//  begin
//    strings.Objects[idx].Free;
//    strings.Objects[idx] := nil;
//  end;
//end;

function mgFileExists(const FileName: string): Boolean;
var
  Attr                        : Cardinal;
begin
  if FileName <> '' then
  begin
    // FileGetSize is very slow, GetFileAttributes is much faster
    Attr := GetFileAttributes(Pointer(Filename));
    Result := (Attr <> $FFFFFFFF) and (Attr and FILE_ATTRIBUTE_DIRECTORY = 0);
  end
  else
    Result := False;
end;

function mgContainsText(const AText, ASubText: string): Boolean;
begin
  Result := AnsiPos(AnsiUppercase(ASubText), AnsiUppercase(AText)) > 0;
end;

function mgStartsText(const ASubText, AText: string): Boolean;
var
  P                           : PChar;
  L, L2                       : Integer;
begin
  P := PChar(AText);
  L := Length(ASubText);
  L2 := Length(AText);
  if L > L2 then
    Result := False
  else
    Result := CompareString(LOCALE_USER_DEFAULT, NORM_IGNORECASE,
      P, L, PChar(ASubText), L) = 2;
end;

end.

