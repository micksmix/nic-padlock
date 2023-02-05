unit uPing;

{$WEAKLINKRTTI ON}
{$RTTI EXPLICIT METHODS([]) PROPERTIES([]) FIELDS([])}

interface

uses
  SysUtils,
  ActiveX,
  ComObj,
  Variants;

{
uses
  Windows,
  SysUtils,
  Classes;

type
  TSunB = packed record
    s_b1, s_b2, s_b3, s_b4: byte;
  end;

  TSunW = packed record
    s_w1, s_w2: word;
  end;

  PIPAddr = ^TIPAddr;
  TIPAddr = record
    case integer of
      0: (S_un_b: TSunB);
      1: (S_un_w: TSunW);
      2: (S_addr: longword);
  end;

  IPAddr = TIPAddr;

function IcmpCreateFile: THandle; stdcall; external 'icmp.dll';
function IcmpCloseHandle(icmpHandle: THandle): boolean; stdcall; external 'icmp.dll';
function IcmpSendEcho
  (IcmpHandle: THandle; DestinationAddress: IPAddr; RequestData: Pointer;
  RequestSize: smallint; RequestOptions: pointer; ReplyBuffer: Pointer;
  ReplySize: DWORD; Timeout: DWORD): DWORD; stdcall; external 'icmp.dll';

function Ping(InetAddress: AnsiString; iTimeout: cardinal): boolean;
}

function Ping(InetAddress: string): Boolean;

implementation

procedure CoUninit(Success: HResult);
begin
  case Success of
    S_OK, S_FALSE: CoUninitialize;
  end;
end;

function GetStatusCodeStr(statusCode: integer): string;
begin
  case statusCode of
    0: Result := 'Success';
    11001: Result := 'Buffer Too Small';
    11002: Result := 'Destination Net Unreachable';
    11003: Result := 'Destination Host Unreachable';
    11004: Result := 'Destination Protocol Unreachable';
    11005: Result := 'Destination Port Unreachable';
    11006: Result := 'No Resources';
    11007: Result := 'Bad Option';
    11008: Result := 'Hardware Error';
    11009: Result := 'Packet Too Big';
    11010: Result := 'Request Timed Out';
    11011: Result := 'Bad Request';
    11012: Result := 'Bad Route';
    11013: Result := 'TimeToLive Expired Transit';
    11014: Result := 'TimeToLive Expired Reassembly';
    11015: Result := 'Parameter Problem';
    11016: Result := 'Source Quench';
    11017: Result := 'Option Too Big';
    11018: Result := 'Bad Destination';
    11032: Result := 'Negotiating IPSEC';
    11050: Result := 'General Failure'
  else
    result := 'Unknow';
  end;
end;

{
uses
  WinSock;

function Fetch(var AInput: string; const ADelim: string = ' ';
  const ADelete: boolean = True): string;
var
  iPos                        : integer;
begin
  if ADelim = #0 then
  begin
    // AnsiPos does not work with #0
    iPos := Pos(ADelim, AInput);
  end
  else
  begin
    iPos := Pos(ADelim, AInput);
  end;
  if iPos = 0 then
  begin
    Result := AInput;
    if ADelete then
    begin
      AInput := '';
    end;
  end
  else
  begin
    Result := Copy(AInput, 1, iPos - 1);
    if ADelete then
    begin
      Delete(AInput, 1, iPos + Length(ADelim) - 1);
    end;
  end;
end;

procedure TranslateStringToTInAddr(AIP: AnsiString; var AInAddr);
var
  phe                         : PHostEnt;
  pac                         : PAnsiChar;
  GInitData                   : TWSAData;
begin
  WSAStartup($101, GInitData);
  try
    phe := GetHostByName(PAnsiChar(AIP));
    if Assigned(phe) then
    begin
      pac := phe^.h_addr_list^;
      if Assigned(pac) then
      begin
        with TIPAddr(AInAddr).S_un_b do
        begin
          s_b1 := byte(pac[0]);
          s_b2 := byte(pac[1]);
          s_b3 := byte(pac[2]);
          s_b4 := byte(pac[3]);
        end;
      end
      else
      begin
        raise Exception.Create('Error getting IP from HostName');
      end;
    end
    else
    begin
      raise Exception.Create('Error getting HostName');
    end;
  except
    FillChar(AInAddr, SizeOf(AInAddr), #0);
  end;
  WSACleanup;
end;
}

//The form of the Address parameter can be either the computer name (wxyz1234), IPv4 address (192.168.177.124), or IPv6 address (2010:836B:4179::836B:4179).

function WmiPing(const Address: string; Retries, BufferSize: Word; bSimplePing: boolean = False):
  boolean;
var
  FSWbemLocator               : OLEVariant;
  FWMIService                 : OLEVariant;
  FWbemObjectSet              : OLEVariant;
  FWbemObject                 : OLEVariant;
  oEnum                       : IEnumvariant;
  iValue                      : LongWord;
  i                           : Integer;
begin
  Result := False; //default
  FSWbemLocator := CreateOleObject('WbemScripting.SWbemLocator');
  FWMIService := FSWbemLocator.ConnectServer('localhost', 'root\CIMV2', '', '');
  for i := 0 to Retries - 1 do
  begin
    if bSimplePing then
    begin
      FWbemObjectSet :=
        FWMIService.ExecQuery(Format('SELECT * FROM Win32_PingStatus where Address=%s',
        [QuotedStr(Address)]), 'WQL', 0);
    end
    else
    begin
      FWbemObjectSet :=
        FWMIService.ExecQuery(Format('SELECT * FROM Win32_PingStatus where Address=%s AND BufferSize=%d',
        [QuotedStr(Address), BufferSize]), 'WQL', 0);
    end;

    oEnum := IUnknown(FWbemObjectSet._NewEnum) as IEnumVariant;
    if oEnum.Next(1, FWbemObject, iValue) = 0 then
    begin
      if FWbemObject.StatusCode = 0 then
      begin
        Result := True; //ping success
      end
      else if not VarIsNull(FWbemObject.StatusCode) then
      begin
        Result := False; //fail
      end
      else
      begin
        Result := False;
      end;
    end;
    FWbemObject := Unassigned;
    FWbemObjectSet := Unassigned;
  end;
end;

function Ping(InetAddress: string): Boolean; // iTimeout: cardinal): boolean;
var
  Success                     : HRESULT;
begin
  Result := False; //default
  try
    CoInitialize(nil);
    try
      //Ping('192.168.52.130',4,32);
      Result := WmiPing(InetAddress, 2, 32);
    finally
      //CoUninitialize;
      CoUninit(Success);
    end;
  except
    on E: Exception do
    begin
      try
        WmiPing(InetAddress, 2, 32, True);
      except
        on E: Exception do
        begin
          Result := False;
        end;
      end;
    end;
  end;
end;

{
function Ping(InetAddress: AnsiString; iTimeout: cardinal): boolean;
var
  Handle                      : THandle;
  InAddr                      : IPAddr;
  DW                          : DWORD;
  rep                         : array[1..128] of byte;
begin
  Result := False;
  Handle := IcmpCreateFile;
  if Handle = INVALID_HANDLE_VALUE then
    Exit;
  TranslateStringToTInAddr(InetAddress, InAddr);
  DW := IcmpSendEcho(Handle, InAddr, nil, 0, nil, @rep, 128, iTimeout); //0);
  Result := (DW <> 0);
  IcmpCloseHandle(Handle);
end;
}
end.

