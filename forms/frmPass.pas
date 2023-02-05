unit frmPass;

{$WEAKLINKRTTI ON}
{$RTTI EXPLICIT METHODS([]) PROPERTIES([]) FIELDS([])}

interface

uses
  Messages,
  Windows,
  SysUtils,
  Classes,
  Controls,
  Forms,
  Dialogs,
  StdCtrls,
  ExtCtrls,
  Graphics;

type
  TfrmEnterPassword = class(TForm)
    lblPasswordForm: TLabeledEdit;
    lblPasswordInstructions: TLabel;
    btnSavePasswordToFile: TButton;
    btnPassOk: TButton;
    btnGenPassword: TButton;
    cbShowPassCharacters: TCheckBox;
    btnQuit: TButton;
    lblEnterNewPassword: TLabeledEdit;
    lblDontLosePwd: TLabel;
    Panel1: TPanel;
    imgCreatePwd: TImage;
    imgEnterPassword: TImage;
    lblForgotPassword: TLabel;
    procedure btnSavePasswordToFileClick(Sender: TObject);
    procedure btnGenPasswordClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnPassOkClick(Sender: TObject);
    procedure cbShowPassCharactersClick(Sender: TObject);
    procedure btnQuitClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lblForgotPasswordClick(Sender: TObject);
  private
    procedure CheckAndSetPassword;
    procedure DoSavePassword;
    { Private declarations }
  public
    sLabelText: string;
    bCreatePass: boolean;
    sPrevHash: string;
    { Public declarations }
  end;

const
  s1                          = '4X+zru';
  s2                          = 'VHA';
  s3                          = 'TkpsY';
  s4                          = 'Rg';

var
  frmEnterPassword            : TfrmEnterPassword;
  bFocusSet                   : Boolean = False;
  bPassSaved                  : Boolean = False;
  bDataFileDeleted            : boolean = False;

implementation

uses
  LbCipher,
  LbString,
  LbUtils,
  main,
  frmForgotPass,
  uBasicEncrypt,
  uHelpers,
  uGlobal;

var
  Key128                      : TKey128;

{$R *.dfm}

procedure SleepWithProcMessages(iSleepSeconds: Integer);
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

function IsValidPassword(sPass: string): Boolean;
begin
  //
  Result := False; //default
  if Length(sPass) >= 8 then
    Result := True;
  //
end;

procedure TfrmEnterPassword.CheckAndSetPassword();
var
  sPass                       : string;
  sFormPass                   : string;
  sHash                       : string;
  SHA1Digest                  : TSHA1Digest;
begin
  //
  sFormPass := lblPasswordForm.Text;

  if bCreatePass then
  begin
    if not SameStr(lblEnterNewPassword.Text, sFormPass) then
    begin
      MessageDlg('Passwords do not match!', mtError, [mbOK], 0);
      Exit;
    end;
  end;

  if not IsValidPassword(lblPasswordForm.Text) then
  begin
    MessageDlg('This is not a valid password. It must be at least 8 characters.', mtError, [mbOK],
      0);
    Exit;
  end;

  if bCreatePass then
  begin
    sPass := EncodePWDEx(sFormPass, s3 + s1 + s4 + s2);
    StringHashSHA1(SHA1Digest, s3 + s1 + sFormPass + s4 + s2);
    sHash := BufferToHex(SHA1Digest, SizeOf(SHA1Digest));

    GenerateLMDKey(Key128, SizeOf(Key128), sPass);

    uGlobal.sEncryptedPassVal := StrToHex(sPass);
    uGlobal.sEncryptedPassVal2 := StrToHex(RDLEncryptStringCBCEx(
      uBasicEncrypt.GeneratePWDSecurityString,
      Key128,
      16,
      True
      ));

    uGlobal.sHashedPass := sHash;
    uGlobal.sUserSuppliedHashedPass := sHash;

    if not bPassSaved then
    begin
      if (MessageDlg('You have not saved a copy of this password. ' + #13 + #10 + '' + #13 + #10 +
        'If you lose this password you will not be able to access any saved data in the future.' + #13
        + #10 + '' + #13 + #10 + 'Would you like to save this password in a text file?', mtWarning,
        [mbYes, mbNo], 0) = mrYes) then
      begin
        DoSavePassword();
      end;
    end;
  end
  else
  begin
    StringHashSHA1(SHA1Digest, s3 + s1 + sFormPass + s4 + s2);
    sHash := BufferToHex(SHA1Digest, SizeOf(SHA1Digest));

    if not SameStr(sPrevHash, sHash) then
    begin
      btnPassOk.Enabled := False;
      SleepWithProcMessages(3);
      btnPassOk.Enabled := True;

      MessageDlg('The password you entered is incorrect. Please try again.', mtError, [mbOK], 0);
      Exit;
    end;

    uGlobal.sUserSuppliedHashedPass := sHash;
  end;
  //
  Close;
end;

procedure TfrmEnterPassword.btnPassOkClick(Sender: TObject);
begin
  //
  CheckAndSetPassword();
  //
end;

procedure TfrmEnterPassword.btnQuitClick(Sender: TObject);
begin
  Halt;
end;

procedure TfrmEnterPassword.DoSavePassword();
var
  saveDialog                  : TSaveDialog; // Save dialog variable
  slFileSave                  : TStringList;
  sToWrite                    : string;
begin
  //
  if not IsValidPassword(lblPasswordForm.Text) then
  begin
    MessageDlg('This is not a valid password. It must be at least 8 characters.', mtError, [mbOK],
      0);
    Exit;
  end;

  if bCreatePass then
  begin
    if not SameStr(lblEnterNewPassword.Text, lblPasswordForm.Text) then
    begin
      MessageDlg('Passwords do not match!', mtError, [mbOK], 0);
      Exit;
    end;
  end;

  MessageDlg('Please store this text file containing your password in a safe location!', mtWarning,
    [mbOK], 0);

  // Create the save dialog object - assign to our save dialog variable
  slFileSave := TStringList.Create;
  saveDialog := TSaveDialog.Create(self);
  try
    // Give the dialog a title
    saveDialog.Title := 'Save your password';
    saveDialog.InitialDir := GetCurrentDir;
    saveDialog.Filter := 'Text file|*.txt';
    saveDialog.DefaultExt := 'txt';
    saveDialog.FilterIndex := 1;
    saveDialog.OptionsEx := [ofExNoPlacesBar];

    // Display the open file dialog
    if saveDialog.Execute then
    begin
      sToWrite := 'Written by "' + ExtractFileName(ParamStr(0)) + '" on ' + DateTimeToStr(Now()) +
        #13#10#13#10;
      slFileSave.Text := sToWrite + lblPasswordForm.Text;
      slFileSave.SaveToFile(saveDialog.FileName);
      //
      bPassSaved := True;
    end
    else
    begin
      Exit;
    end;
  finally
    FreeAndNil(saveDialog);
    FreeAndNil(slFileSave);
  end;
end;

procedure TfrmEnterPassword.btnSavePasswordToFileClick(Sender: TObject);
begin
  //
  DoSavePassword();
end;

procedure TfrmEnterPassword.cbShowPassCharactersClick(Sender: TObject);
begin
  if cbShowPassCharacters.Checked then
  begin
    lblPasswordForm.PasswordChar := #0;
    lblEnterNewPassword.PasswordChar := #0;
  end
  else
  begin
    lblPasswordForm.PasswordChar := '*';
    lblEnterNewPassword.PasswordChar := '*';
  end;
end;

procedure TfrmEnterPassword.FormActivate(Sender: TObject);
begin
  lblPasswordInstructions.Caption := sLabelText;

  if ActiveControl <> nil then
    ActiveControl.SetFocus;

  if not bCreatePass then
  begin
    if lblPasswordForm.CanFocus then
    begin
      lblPasswordForm.SetFocus;
    end;
  end
  else
  begin
    if lblEnterNewPassword.CanFocus then
    begin
      lblEnterNewPassword.SetFocus;
    end;
  end;
end;

procedure TfrmEnterPassword.FormShow(Sender: TObject);
begin
  if bCreatePass then
  begin
    //
    lblForgotPassword.Visible := False;
    lblEnterNewPassword.Visible := True;
    lblPasswordForm.EditLabel.Caption := 'Re-Enter Password';

    lblEnterNewPassword.Top := 93;
    btnGenPassword.Top := 191;
    btnSavePasswordToFile.Top := 162;
    //
    btnQuit.Top := 162;
    btnPassOk.Top := 162;
    //
    lblPasswordForm.Top := 135;
    lblDontLosePwd.Top := 191;
    //
  end
  else
  begin
    lblEnterNewPassword.Visible := False;
    lblForgotPassword.Visible := True;
    lblPasswordForm.EditLabel.Caption := 'Enter Password';

    if btnGenPassword.Top = 191 then
    begin
      btnQuit.Top := btnQuit.Top - 25;
      btnPassOk.Top := btnPassOk.Top - 25;
    end;
  end;
end;

procedure TfrmEnterPassword.lblForgotPasswordClick(Sender: TObject);
var
  frmForgotPass               : TfrmForgotPassword;
begin
  if (Sender is TLabel) then
  begin
    frmForgotPass := TfrmForgotPassword.Create(nil);
    try
      bDataFileDeleted := False;
      frmForgotPass.Position := poMainFormCenter;
      frmForgotPass.ShowModal;

      if bDataFileDeleted then
        Halt;

    finally
      frmForgotPass.Release;
      Pointer(frmForgotPass) := nil;
    end;
  end;
end;

procedure TfrmEnterPassword.btnGenPasswordClick(Sender: TObject);
var
  sPass                       : string;
begin
  sPass := uBasicEncrypt.GeneratePWDSecurityString;
  lblPasswordForm.Text := sPass;
  lblEnterNewPassword.Text := sPass;
end;

end.

