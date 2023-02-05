unit uLic;

interface

uses
  OnGuard,
  SysUtils,
  OgUtil;

function AuthenticateReleaseCode(const sMod, inReleaseCodeHexString: string):
  Boolean;

implementation

procedure CodeGetKey(var Key: TKey);
const
  CKey: TKey = ($76, $A8, $4F, $B3, $31, $D2, $AA, $0C, $5D, $83, $5A, $A4,
    $1E, $B7, $62, $8B);
begin
  Key := CKey;
end;

//
//{ Used by you to generate the unlock code you send to your customer, do not include in the customer software }
//function GenerateReleaseCode(inExpiryDate: TDateTime; inRegCode: string):
//  string;
//(* inAppKey is the byte sequence key you already have
//   inRegCode can be anything, typically customers name
//   Returns the release code for the customer to type into the software *)
//var
//  releaseCode                 : TCode;
//  key                         : TKey;
//begin
//  //HexToBuffer(inAppKey, key, SizeOf(TKey));
//  CodeGetKey(key);
//  InitRegCode(key, inRegCode, inExpiryDate, releaseCode);
//  Result := BufferToHex(releaseCode, SizeOf(releaseCode));
//end;

{ Used in your program to authenticate if the release code is valid - does not check for expiry }

function AuthenticateReleaseCode(const sMod, inReleaseCodeHexString: string):
  Boolean;
var
  releaseCode: TCode;
  inAppKey: TKey;
  Modifier: LongInt;
  sUnicodeInput: string;
  idx: Integer;
begin

    CodeGetKey(inAppKey);
    HexToBuffer(inReleaseCodeHexString, releaseCode, SizeOf(releaseCode));
    //
    //
    sUnicodeInput := '';
    for idx := 1 to Length(sMod) do
    begin
      sUnicodeInput := sUnicodeInput + '&#' + IntToStr(Ord(sMod[idx]));
    end;
    //
    //
    Modifier := GenerateStringModifierPrimMg(sUnicodeInput);
    ApplyModifierToKeyPrimMg(Modifier, inAppKey, SizeOf(inAppKey));
    //
    Result := IsRegCodeValid(inAppKey, releaseCode);
end;

//{ Used in your program to test if the license has expired }
//
//function UnlockCodeExpiryDate(const inReleaseCodeHexString: string; const inAppKey: TKey):
//  TDateTime;
//var
//  releaseCode                 : TCode;
//begin
//  HexToBuffer(inReleaseCodeHexString, releaseCode, SizeOf(releaseCode));
//  Result := GetExpirationDate(inAppKey, releaseCode);
//end;

end.

