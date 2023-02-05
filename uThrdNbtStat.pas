unit uThrdNbtStat;

{$WEAKLINKRTTI ON}
{$RTTI EXPLICIT METHODS([]) PROPERTIES([]) FIELDS([])}

interface

uses
  Classes,
  SysUtils,
  StrUtils,
  Windows,
  uGlobal,
  IdGlobal,
  IdUDPClient,



  ThreadUtilities;

type
  TNbtstatCheck = class(TObject) //class(TThread)
  strict private
    FFormHandle: THandle;
    FThreadPool: TThreadPool;
    //procedure UpdateCaption;
  private
    procedure PrepareThreadVars;
    procedure ExecuteWork(Data: Pointer; AThread: TThread);
    procedure UpdateCaption;
    {
    function GetStatusCodeStr(statusCode: integer): string;
    function Ping(const Address: string; Retries, BufferSize: Word): boolean;
    }
    { Private declarations }
  public
    procedure BeginWork(athrdtask: PNetbiosTask);
    constructor Create(formHandle: THandle);
    destructor Destroy; override;
  end;

threadvar
  FCurThreadTask              : PNetbiosTask;
  FHostname                   : string;

implementation

{
function TNbtstatCheck.GetStatusCodeStr(statusCode: integer): string;
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

//The form of the Address parameter can be either the computer name (wxyz1234), IPv4 address (192.168.177.124), or IPv6 address (2010:836B:4179::836B:4179).

function TNbtstatCheck.Ping(const Address: string; Retries, BufferSize: Word): boolean;
var
  FSWbemLocator               : OLEVariant;
  FWMIService                 : OLEVariant;
  FWbemObjectSet              : OLEVariant;
  FWbemObject                 : OLEVariant;
  oEnum                       : IEnumvariant;
  iValue                      : LongWord;
  i                           : Integer;

  PacketsReceived             : Integer;
  Minimum                     : Integer;
  Maximum                     : Integer;
  Average                     : Integer;
begin
  Result := False; //default

  PacketsReceived := 0;
  Minimum := 0;
  Maximum := 0;
  Average := 0;
  //Writeln('');
  //Writeln(Format('Pinging %s with %d bytes of data:', [Address, BufferSize]));
  FSWbemLocator := CreateOleObject('WbemScripting.SWbemLocator');
  FWMIService := FSWbemLocator.ConnectServer('localhost', 'root\CIMV2', '', '');
  //FWMIService   := FSWbemLocator.ConnectServer('192.168.52.130', 'root\CIMV2', 'user', 'password');
  for i := 0 to Retries - 1 do
  begin
    FWbemObjectSet :=
      FWMIService.ExecQuery(Format('SELECT * FROM Win32_PingStatus where Address=%s AND BufferSize=%d',
      [QuotedStr(Address), BufferSize]), 'WQL', 0);
    oEnum := IUnknown(FWbemObjectSet._NewEnum) as IEnumVariant;

    if oEnum.Next(1, FWbemObject, iValue) = 0 then
    begin
      if FWbemObject.StatusCode = 0 then
      begin
        //        if FWbemObject.ResponseTime > 0 then
        //        begin
        //          Writeln(Format('Reply from %s: bytes=%s time=%sms TTL=%s', [FWbemObject.ProtocolAddress,
        //            FWbemObject.ReplySize, FWbemObject.ResponseTime, FWbemObject.TimeToLive]));
        //        end
        //        else
        //        begin
        //          Writeln(Format('Reply from %s: bytes=%s time=<1ms TTL=%s', [FWbemObject.ProtocolAddress,
        //            FWbemObject.ReplySize, FWbemObject.TimeToLive]));
        //        end;

        Inc(PacketsReceived);

        if FWbemObject.ResponseTime > Maximum then
        begin
          Maximum := FWbemObject.ResponseTime;
        end;

        if Minimum = 0 then
        begin
          Minimum := Maximum;
        end;

        if FWbemObject.ResponseTime < Minimum then
        begin
          Minimum := FWbemObject.ResponseTime;
        end;

        Average := Average + FWbemObject.ResponseTime;
        //      end
        //      else if not VarIsNull(FWbemObject.StatusCode) then
        //      begin
        //        Writeln(Format('Reply from %s: %s', [FWbemObject.ProtocolAddress,
        //          GetStatusCodeStr(FWbemObject.StatusCode)]));
        //      end
        //      else
        //      begin
        //        Writeln(Format('Reply from %s: %s', [Address, 'Error processing request']));
      end;
    end;

    FWbemObject := Unassigned;
    FWbemObjectSet := Unassigned;
    //Sleep(500);
  end;

  //  Writeln('');
  //  Writeln(Format('Ping statistics for %s:', [Address]));
  //  Writeln(Format('    Packets: Sent = %d, Received = %d, Lost = %d (%d%% loss),', [Retries,
  //    PacketsReceived, Retries - PacketsReceived, Round((Retries - PacketsReceived) * 100 /
  //      Retries)]));

  if PacketsReceived > 0 then
  begin
    //Writeln('Approximate round trip times in milli-seconds:');
    //Writeln(Format('    Minimum = %dms, Maximum = %dms, Average = %dms', [Minimum, Maximum,
    //  Round(Average / PacketsReceived)]));
    Result := True;
  end;
end;
}

procedure TNbtstatCheck.PrepareThreadVars();
begin
  FHostname := '';
end;

constructor TNbtstatCheck.Create(formHandle: THandle);
begin
  FFormHandle := formHandle;
  FThreadPool := TThreadPool.Create(ExecuteWork, MAX_NBT_THREADS); //MAX_PV_THREADS);

  inherited Create;
end;

destructor TNbtstatCheck.Destroy;
begin
  FThreadPool.Free;
  inherited;
end;

procedure TNbtstatCheck.BeginWork(athrdtask: PNetbiosTask);
begin
  FThreadPool.Add(athrdtask);
end;

procedure TNbtstatCheck.UpdateCaption();
var
  msg_prm                     : PWMUCommand;
begin
  New(msg_prm);
  msg_prm.host := FHostname;
  msg_prm.ip := FCurThreadTask.sAddress;
  msg_prm.bOnline := Length(FHostname) > 0;

  if not PostMessage(FFormHandle, WM_POSTED_MSG, WM_THRD_NBTSCAN_MSG, integer(msg_prm)) then
  begin
    Sleep(35);
    PostMessage(FFormHandle, WM_POSTED_MSG, WM_THRD_NBTSCAN_MSG, integer(msg_prm));
    if not PostMessage(FFormHandle, WM_POSTED_MSG, WM_THRD_NBTSCAN_MSG, integer(msg_prm)) then
    begin
      Sleep(35);
      if not PostMessage(FFormHandle, WM_POSTED_MSG, WM_THRD_NBTSCAN_MSG, integer(msg_prm)) then
      begin
        Dispose(msg_prm);
      end;
    end;
  end;
end;

procedure TNbtstatCheck.ExecuteWork(Data: Pointer; AThread: TThread);
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
begin
  { Place thread code here }

  New(FCurThreadTask);
  try
    //Sleep(50);
    //
    PrepareThreadVars();
    FCurThreadTask.sAddress := TNetbiosTask(Data^).sAddress;
    FCurThreadTask.iTimeout := TNetbiosTask(Data^).iTimeout;

    begin
      RepName := '';
      UDPClient := nil;

      try
        UDPClient := TIdUDPClient.Create(nil);
        UDPClient.Host := Trim(FCurThreadTask.sAddress);
        UDPClient.Port := NB_PORT;

        UDPClient.Send(NB_REQUEST);

        SetLength(Buffer, NB_BUFSIZE);
        if (0 < UDPClient.ReceiveBuffer(Buffer, FCurThreadTask.iTimeout)) then
        begin

          for I := 1 to 15 do
            RepName := RepName + Chr(Buffer[56 + I]);

          if StartsText(#0, RepName) then
            RepName := '';

          RepName := Trim(RepName);
          FHostname := RepName;
        end;
      except
        //Result := False;
      end;

      if Assigned(UDPClient) then
        FreeAndNil(UDPClient);
    end;

    UpdateCaption;
  finally
    Dispose(FCurThreadTask);
  end;
end;

end.

