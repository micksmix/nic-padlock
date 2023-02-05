unit uRemoteNicMgrUtils;

{$WEAKLINKRTTI ON}
{$RTTI EXPLICIT METHODS([]) PROPERTIES([]) FIELDS([])}

interface

uses
  SysUtils,
  Windows,

  Variants,
  Registry,
  uHelpers,
  uWin32_Process,
  uWmiDelphiClass;

function CompareVersionNumbers(AVersion1, AVersion2: string): Integer;
function GetBuildInfoAsString(sFullFilePath: string): string;
function GetRegistryData(RootKey: HKEY; Key, Value, sMachine: string): string;
function CopyFileToRemoteSystem(sLocalFileWithPath, sArguments, sRemoteHost: string): string;
function RunProgram(sProgramName, sMachine, u, p: string): string;
//

implementation

procedure GetBuildInfo(var V1, V2, V3, V4: word; sFullFilePath: string);
var
  VerInfoSize, VerValueSize, Dummy: DWORD;
  VerInfo                     : Pointer;
  VerValue                    : PVSFixedFileInfo;
begin
  try
    VerInfoSize := GetFileVersionInfoSize(PChar(sFullFilePath), Dummy);
    GetMem(VerInfo, VerInfoSize);
    try
      GetFileVersionInfo(PChar(sFullFilePath), 0, VerInfoSize, VerInfo);
      VerQueryValue(VerInfo, '\', Pointer(VerValue), VerValueSize);
      with VerValue^ do
      begin
        V1 := dwFileVersionMS shr 16;
        V2 := dwFileVersionMS and $FFFF;
        V3 := dwFileVersionLS shr 16;
        V4 := dwFileVersionLS and $FFFF;
      end;
    finally
      FreeMem(VerInfo, VerInfoSize);
    end;
  except on e: Exception do
    begin
      //RaiseLastOSError;
    end;
  end;
end;

function GetBuildInfoAsString(sFullFilePath: string): string;
var
  V1, V2, V3, V4              : word;
begin
  GetBuildInfo(V1, V2, V3, V4, sFullFilePath);
  Result := IntToStr(V1) + '.' + IntToStr(V2) + '.' + IntToStr(V3) + '.' + IntToStr(V4);
end;

function CompareVersionNumbers(AVersion1, AVersion2: string): Integer;
var
  N1, N2                      : Integer;
  //Returns 1 if AVersion1 < AVersion2
  //Returns -1 if AVersion1 > AVersion2
  //Returns 0 if values are equal

  function GetNextNumber(var Version: string): Integer;
  var
    P                         : Integer;
    S                         : string;
  begin
    P := Pos('.', Version);
    if P > 0 then
    begin
      S := Copy(Version, 1, P - 1);
      Version := Copy(Version, P + 1, Length(Version) - P);
    end
    else
    begin
      S := Version;
      Version := '';
    end;
    if S = '' then
      Result := -1
    else
      try
        Result := StrToInt(S);
      except
        Result := -1;
      end;
  end;

begin
  Result := 0;
  repeat
    N1 := GetNextNumber(AVersion1);
    N2 := GetNextNumber(AVersion2);
    if N2 > N1 then
    begin
      Result := 1;
      Exit;
    end
    else if N2 < N1 then
    begin
      Result := -1;
      Exit;
    end
  until (AVersion1 = '') and (AVersion2 = '');
end;

function GetRegistryData(RootKey: HKEY; Key, Value, sMachine: string): string;
var
  Reg                         : TRegistry;
  RegDataType                 : TRegDataType;
  DataSize, Len               : integer;
  s                           : string;
begin
  Reg := TRegistry.Create(KEY_READ);
  try
    try
      Reg.RootKey := RootKey;

      sMachine := ExcludeTrailingPathDelimiter(sMachine);
      if not mgStartsText('\\', sMachine) then
      begin
        sMachine := '\\' + sMachine;
      end;

      if Reg.RegistryConnect(sMachine) then
      begin
        //if Reg.KeyExists(Key) then
        begin
          if Reg.OpenKey(Key, False) then
          begin
            try
              RegDataType := Reg.GetDataType(Value);
              if (RegDataType = rdString) or
                (RegDataType = rdExpandString) then
              begin
                Result := Reg.ReadString(Value)
              end
              else if RegDataType = rdInteger then
              begin
                Result := IntToStr(Reg.ReadInteger(Value));
              end
              else if RegDataType = rdBinary then
              begin
                DataSize := Reg.GetDataSize(Value);
                if DataSize = -1 then
                begin
                  Result := '';
                end;
                SetLength(s, DataSize);
                Len := Reg.ReadBinaryData(Value, PChar(s)^, DataSize);
                if Len <> DataSize then
                begin
                  Result := '';
                end;
                Result := s;
              end
              else if RegDataType = rdUnknown then
              begin
                Result := '';
              end;
            except
              s := ''; // Deallocates memory if allocated
              Reg.CloseKey;
              //raise; //todo: remove these when completed
            end;
            Reg.CloseKey;
          end
          else
          begin
            Result := SysErrorMessage(GetLastError); //'';
            //raise Exception.Create(SysErrorMessage(GetLastError));
          end;
        end;
      end;
    except
      FreeAndNil(Reg);
      Result := '';
      //raise; //todo: remove these when completed
    end;
  finally
    FreeAndNil(Reg);
  end;
end;

function RunProgram(sProgramName, sMachine, u, p: string): string;
var
  Process                     : TWin32_Process;
  PID                         : Cardinal;
begin
  //
  try
    //CoInitialize(nil);
    Process := TWin32_Process.Create(False);
    try

      Process.WmiConnection.WmiServer := sMachine;
      //Process.WmiUser := u;
      //Process.WmiPass := p;

      Process.Create(sProgramName, '', Unassigned, PID);
      Result := IntToStr(PID);
      //objWMIService := GetWMIObject(Format('winmgmts:\\%s\%s', ['.', 'root\CIMV2']));

    finally
      Process.Free;
      //CoUninitialize;
    end;
  except
    on E: Exception do
    begin
      Result := (E.Classname + ': ' + E.Message);
    end;
  end;

end;

function CopyFileToRemoteSystem(sLocalFileWithPath, sArguments, sRemoteHost: string): string;
var
  sFilename                   : string;
  sRemoteFolder               : string;
  sFullCommand                : string;
  sMsg                        : string;
  idx                         : integer;
begin
  ///
  Result := 'failed'; //default
  sFilename := ExtractFileName(sLocalFileWithPath);
  sRemoteFolder := '\\' + sRemoteHost + '\ADMIN$';

  idx := 0;
  while mgFileExists(sRemoteFolder + '\' + sFilename) do
  begin
    DeleteFile(PChar(sRemoteFolder + '\' + sFilename));
    Inc(idx);

    Sleep(100); // .1 seconds
    if (idx * 10) = 30 then
    begin
      Exit;
    end;
  end;

  if not CopyFile(PChar(sLocalFileWithPath), PChar(sRemoteFolder + '\' + sFilename), False) then
  begin
    begin //WriteLn('Copying [TO]: ' + sRemoteFolder + '\' + sFilename);
      if GetLastError <> ERROR_SUCCESS then
      begin
        Result := ('Error: ' + SysErrorMessage(GetLastError));
      end;
    end;
    Exit;
  end
  else
  begin
    Result := 'Success';
  end;
end;

end.

