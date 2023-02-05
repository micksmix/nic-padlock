unit uBuildInfo;

interface

uses
  Windows,
  SysUtils;

function SmallGetBuildInfoAsString: string;
function SmallStringToHex(const S: string): string;

implementation

function SmallStringToHex(const S: string): string;
var
  Index                       : Integer;
begin
  Result := '';
  for Index := 1 to Length(S) do
    Result := Result + IntToHex(Byte(S[Index]), 2);
end;

procedure SmallGetBuildInfo(sFilename: string; var V1, V2, V3, V4: word);
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

function SmallGetBuildInfoAsString: string;
var
  V1, V2, V3, V4              : word;
begin
  SmallGetBuildInfo(ParamStr(0), V1, V2, V3, V4);
  Result := IntToStr(V1) + '.' + IntToStr(V2) + '.' +
    IntToStr(V3) + '.' + IntToStr(V4);
end;

end.

