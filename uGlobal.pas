unit uGlobal;

{$I nldefine.inc}

{$WEAKLINKRTTI ON}
{$RTTI EXPLICIT METHODS([]) PROPERTIES([]) FIELDS([])}

interface

uses
  SyncObjs,
  Classes,
  SQLiteTable3,
  Messages,
  SysUtils;

const
  WM_THRD_SITE_MSG            = WM_USER + 5;
  WM_POSTED_MSG               = WM_USER + 8;
  WM_THRD_NBTSCAN_MSG         = WM_USER + 9;
  WM_THRD_DEPLOYSVC_DONE      = WM_USER + 10;
  WM_THRD_DEPLOYSVC_PROCESS_LOG = WM_USER + 11;
  WM_THRD_CLOSE_PROCESS_FORM  = WM_USER + 12;
  WM_THRD_PROGRESS_MSG        = WM_USER + 13;
  WM_PROGRESS_FORM_MSG        = WM_USER + 14;
  WM_PROGRESS_FORM_STOP       = WM_USER + 15;
  WM_PROGRESS_FORM_CLOSE      = WM_USER + 16;
  WM_THRD_RETRIEVE_HOST_INFO  = WM_USER + 17;
  WM_THRD_RETRIEVE_HOST_DONE  = WM_USER + 18;
  SERVICE_NAME                = 'NPLSvc';
  SERVICE_EXE                 = 'npadlock.exe';
  //
  INFO_TABLE                  = 'NLInfo';
  GROUP_TABLE                 = 'NLGroups';
  DB_INFO_TABLE               = 'NLDBInfo';
{$IFDEF LITE_VERSION}
  SQLITE_DATA_FILE            = 'nicpadlocktrialdb.sqlite';
{$ELSE}
  SQLITE_DATA_FILE            = 'nicpadlockdb.sqlite';
{$ENDIF}
  VKEY                        = 'pXMxFar2jFG4PjwUz';
  //TRIAL_REENABLE_MIN          = 30;
  TRIAL_HOSTS_ALLOWED         = 5;
  TRIAL_REENABLE_MIN          = 5;

  //

var
  sqlitedb                    : TSQLiteDatabase;
  sltbInfo, sltbGroups, sltbDbInfo: TSQLiteTable;
  Crit_UpdateDb               : TCriticalSection;
  //crit_WmiQuery_NicInfo       : TCriticalSection;
  //crit_WmiQuery_AutoStart     : TCriticalSection;
  //crit_WmiQuery_SysInfo       : TCriticalSection;
  //
  MAX_NBT_THREADS             : integer = 15;
  MAX_DEPLOYSVC_THREADS       : integer = 4;
  MAX_RETRIVE_HOST_INFO_THREADS: integer = 4;
  //
  slDBPath                    : string;
  //
  sHashedPass                 : string;
  sEncryptedPassVal           : string;
  sEncryptedPassVal2          : string;
  sUserSuppliedHashedPass     : string;

type
  TWmiCallArgs = record
    sHostname: string;
    sIp: string;
    sUser: string;
    sPass: string;
    sGroup: string;
    sWinVersion: string;
    bUsePassthruCredentials: boolean;
    hMsgForm: THandle;
    iMessage: integer;
  end;

type
  TIPSegments = array[1..4] of byte;

type
  PWMUCommand = ^TWMUCommand;

  TWMUCommand = record
    host: string;
    ip: string;
    bOnline: boolean;
  end;

type
  PWMDeploySvcCommand = ^TWMDeploySvcCommand;

  TWMDeploySvcCommand = record
    host: string;
    group: string;
    result: string;
  end;

type
  PWMRetrieveInfoCmd = ^TWMRetrieveInfoCmd;

  TWMRetrieveInfoCmd = record
    host: string;
    group: string;
    result: string;
  end;

type
  PWMMgMessageLog = ^TWMMgMessageLog;

  TWMMgMessageLog = record
    host: string;
    group: string;
    msg: string;
  end;

type
  PNetbiosTask = ^TNetbiosTask;

  TNetbiosTask = record
    sAddress: string;
    sHostname: string;
    bOnline: boolean;
    iTimeout: Integer;
  end;

type
  PHostRec = ^THostRec;

  THostRec = packed record
    AHostname: string;
    AGroupname: string;
    ALevel: integer;
    AbOnline: integer; //0=online, 1=offline, -1=unknown
  end;

  TCmdParams = record
    sHostAddr: string;
    sHostName: string;
    sGroup: string;
    bAltCreds: boolean;
    sUser: string;
    sPass: string;
    sUserMessage: string;
    bAutoUpdateIp: boolean;
    bDisplayUserMessage: boolean;
    bDisableAllAdapters: Boolean;
    bEnableAllAdapters: Boolean;
    bModifySomeAdapterState: Boolean;
    bReEnableAdapters: Boolean;
    sReEnableTime: string;
    //bReEnableSomeAdapter: Boolean;
    iReEnableAfterMins: Cardinal;
    sProxyServer: string;
    bUseCimv2: Boolean;
    bSetImagePath: Boolean;
    sImagePath: string;
    arrAdapterGuids: array of string; // TStringList;
    bPingTheHost: boolean;
  end;

type
  PRemoteTask = ^TRemoteTask;

  TRemoteTask = record
    Params: TCmdParams;
  end;

  //type
  //  PRetriveHostInfoTask = ^TRetriveHostInfoTask;
  //
  //  TRetriveHostInfoTask = record
  //    //sHost: string;
  //    //sGroup: string;
  //    Params: TCmdParams;
  //  end;

type
  TSvcStatus = (ssUnknown, // enumeration of service status
    ssStopped,
    ssStartPending,
    ssStopPending,
    ssRunning,
    ssContinuePending,
    ssPausePending,
    ssPaused,
    ssError);

type
  TSimpleNicInfo = packed record
    sGUID: string[150];
    sMac: string[50];
    sIp: string[255];
  end;

  TRemoteSysInfo = packed record
    sName: string[50];
    sDomain: string[50];
    sUsername: string[50];
    sManufacturer: string[100];
    sModel: string[50];
    sPrimaryOwnerName: string[100];
    sSystemType: string[100];
    sTotalPhysicalMemory: string[50];
    sOsVersion: string[20];
    sSerialNumber: string[30];
  end;

  //Service,Status,Name,Manufacturer,DeviceID,InfName,Signer
  TRemoteStartupInfo = packed record
    sCaption: string[250];
    sCommand: string[250];
    sUser: string[150];
    sLocation: string[250];
  end;

  TRemoteNic = packed record
    sAdapterType: string[50];
    sCaption: string[100];
    sGuid: string[50];
    sMac: string[30];
    sIpAddress: string[100];
    sManufacturer: string[100];
    sName: string[100];
    bDisableAdapter: boolean;
    bEnableAdapter: boolean;
  end;

type
  TRemoteNicArray = array of TRemoteNic;
  TRemoteSysInfoArray = array of TRemoteSysInfo;
  TSimpleNicInfoArray = array of TSimpleNicInfo;
  TRemoteStartupInfoArray = array of TRemoteStartupInfo;

  //var
    //MyCmdParams       : TCmdParams;

function IPToNumber(ip: string): Cardinal;
function NumberToIP(Number: Cardinal): string;

implementation

function NumberToSegments(Number: Cardinal): TIPSegments;
var
  j                           : 0..4;
begin
  for j := 4 downto 1 do
  begin
    ;
    result[j] := Number mod 256;
    Number := Number div 256;
  end;
end;

function IPToSegments(ip: string): TIPSegments;
var
  i                           : byte;
  j                           : 0..4;
  s                           : string;
begin
  ;
  for j := 1 to 4 do
  begin
    ;
    i := pos('.', ip);
    if j < 4 then
      s := copy(ip, 1, i - 1)
    else
      s := ip;
    delete(ip, 1, i); //remove '.'
    result[j] := StrToInt(s);
  end;
end;

function IPToNumber(ip: string): Cardinal;
var
  segment                     : TIPSegments;
  i                           : 1..4;
begin
  ;
  segment := IPToSegments(ip);
  result := 0;
  for i := 1 to 4 do
    result := result * 256 + segment[i];
end;

function NumberToIP(Number: Cardinal): string;
var
  segment                     : TIPSegments;
begin
  result := '';
  segment := NumberToSegments(Number);
  result := Format('%d.%d.%d.%d', [segment[1], segment[2], segment[3], segment[4]]);
end;

procedure GetIPList(const IPStr, MaskStr: string; Strings: TStringList);
var
  IP, Mask, MaskBits          : Cardinal;
  WildCard, NetMask           : Cardinal;
  i, w                        : Cardinal;
begin
  ;
  IP := IPToNumber(IPStr);
  Mask := IPToNumber(MaskStr);

  // calculate Maskbits
  MaskBits := 32;
  while (Mask and 1) = 0 do
  begin
    Dec(MaskBits);
    Mask := Mask shr 1;
  end;

  WildCard := 1 shl (32 - MaskBits) - 1;
  NetMask := not WildCard;

  for w := 1 to WildCard - 1 do
  begin
    ;
    i := IP or w;
    Strings.Add(NumberToIP(i));
  end;
end;

end.

