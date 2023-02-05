unit frmRegistration;

{$I nldefine.inc}

interface

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  StdCtrls,
  ExtCtrls;

type
  TfrmReg = class(TForm)
    lbledtName: TLabeledEdit;
    lbledtSerial: TLabeledEdit;
    btnRegister: TButton;
    pnl1: TPanel;
    img1: TImage;
    lbl1: TLabel;
    lblThankYou: TLabel;
    procedure btnRegisterClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    procedure ValidLicenseFound;
    procedure SleepWithProcMessages(iSleepSeconds: Integer);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmReg                      : TfrmReg;

implementation

{$R *.dfm}

uses
  main,

  uLic;

procedure TfrmReg.SleepWithProcMessages(iSleepSeconds: Integer);
var
  idx                         : integer;
begin
  //
  for idx := 1 to iSleepSeconds * 10 do
  begin
    Sleep(100); //= 0.1 seconds
    Application.ProcessMessages;
  end;
end;

function HexStringToBytes(const Value: string): TBytes;
var
  i, v                        : Integer;
  dg0, dg1                    : Byte;
  HexStr                      : string;
begin
  HexStr := '';
  for i := 1 to Length(Value) do
    if Value[i] <> #32 then
      HexStr := HexStr + Value[i];
  SetLength(Result, Length(HexStr) div 2);
  for i := 1 to Length(HexStr) div 2 do
  begin
    dg0 := 0;
    dg1 := 1;
    if TryStrToInt('$' + HexStr[i * 2 - 1], v) then
      dg0 := Byte(v) shl 4;
    if TryStrToInt('$' + HexStr[i * 2], v) then
      dg1 := Byte(v);
    Result[i - 1] := dg0 + dg1;
  end;
end;

procedure TfrmReg.btnRegisterClick(Sender: TObject);
var
  sUser, sSer                 : string;
  //stmp : string;
begin
  //
  sUser := Trim(lbledtName.Text);
  lbledtName.Text := sUser;
  sSer := lbledtSerial.Text;

  if (Length(Trim(sUser)) < 1) or (Length(Trim(sSer)) <> 16) then
  begin
    MessageDlg('This is not a valid license combination!' + #13 + #10 + '' + #13 + #10 +
      'Please use the exact registration name and serial number given to you.', mtError, [mbOK], 0);
    Exit;
  end;

  btnRegister.Enabled := False;
  SleepWithProcMessages(3);
  btnRegister.Enabled := True;


  if uLic.AuthenticateReleaseCode(sUser, sSer) then
  begin
    //this is a valid license!!
    if not main.Form1.SetLicenseStatus(sUser, sSer) then
    begin
      MessageDlg('Unable to register this product!' + #13 + #10 + '' + #13 + #10 +
        'Please contact support at www.wildpawsoftware.com.', mtError, [mbOK], 0);
    end
    else
    begin
      ValidLicenseFound();
    end;
  end
  else
  begin
    MessageDlg('This is not a valid license!' + #13 + #10 + '' + #13 + #10 +
      'Please contact support at www.wildpawsoftware.com.', mtError, [mbOK], 0);
  end;
end;

procedure TfrmReg.ValidLicenseFound();
var
  sUser, sSer                 : string;
begin
  lblThankYou.Visible := True;
  //
  lbledtName.EditLabel.Caption := 'Registered to:';
  main.Form1.GetLicInfo(sUser, sSer);
  lbledtName.ReadOnly := True;
  lbledtName.Text := sUser;
  //
  HideCaret(lbledtName.Handle);
  //
  lbledtSerial.EditLabel.Caption := 'Serial number is valid:';
  lbledtSerial.PasswordChar := '*';
  lbledtSerial.Text := '1234567890';
  lbledtSerial.ReadOnly := True;
  btnRegister.Enabled := False;
end;

procedure TfrmReg.FormActivate(Sender: TObject);
begin
  //
  if main.Form1.IsValidLicenseDb then
  begin
    //
    ValidLicenseFound();
  end
  else
  begin
    lblThankYou.Visible := False;
  end;
end;

end.

