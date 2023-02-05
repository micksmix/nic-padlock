unit frmChangePass;

{$WEAKLINKRTTI ON}
{$RTTI EXPLICIT METHODS([]) PROPERTIES([]) FIELDS([])}

interface

uses
  SysUtils,
  Classes,
  Controls,
  Forms,
  Dialogs,
  StdCtrls,
  Windows,
  LbCipher,
  LbUtils,
  ExtCtrls,
  Graphics;

type
  TfrmChangePassword = class(TForm)
    lblPasswordInstructions: TLabel;
    lblPasswordForm: TLabeledEdit;
    btnSavePasswordToFile: TButton;
    btnPassOk: TButton;
    btnGenPassword: TButton;
    cbShowPassCharacters: TCheckBox;
    btnQuit: TButton;
    lblOldPasswordFirst: TLabeledEdit;
    lblEnterNewPassword: TLabeledEdit;
    Label1: TLabel;
    Panel1: TPanel;
    Image1: TImage;
    grpLine: TGroupBox;
    procedure btnSavePasswordToFileClick(Sender: TObject);
    procedure btnGenPasswordClick(Sender: TObject);
    procedure btnQuitClick(Sender: TObject);
    procedure cbShowPassCharactersClick(Sender: TObject);
    procedure btnPassOkClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    procedure CheckAndSetPassword;
    { Private declarations }
  public
    { Public declarations }
    sPrevHash: string;
  end;

const
  s1                          = '4X+zru';
  s2                          = 'VHA';
  s3                          = 'TkpsY';
  s4                          = 'Rg';

var
  frmChangePassword           : TfrmChangePassword;
  Key128                      : TKey128;

implementation

uses
  uBasicEncrypt,
  main;

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
  if (Length(sPass) >= 8) and (Length(sPass) <= 100) then
    Result := True;
  //
end;

procedure TfrmChangePassword.btnGenPasswordClick(Sender: TObject);
var
  sPass                       : string;
begin
  cbShowPassCharacters.Checked := True;
  sPass := uBasicEncrypt.GeneratePWDSecurityString;
  lblPasswordForm.Text := sPass;
  lblEnterNewPassword.Text := sPass;
end;

procedure TfrmChangePassword.CheckAndSetPassword();
var
  sPass                       : string;
  sFormPass                   : string;
  sHash                       : string;
  SHA1Digest                  : TSHA1Digest;
begin
  //

  StringHashSHA1(SHA1Digest, s3 + s1 + lblOldPasswordFirst.Text + s4 + s2);
  sHash := BufferToHex(SHA1Digest, SizeOf(SHA1Digest));

  if not SameStr(sPrevHash, sHash) then
  begin
    btnPassOk.Enabled := False;
    SleepWithProcMessages(3);
    btnPassOk.Enabled := True;
    //
    MessageDlg('The current password you entered is incorrect. Please try again.', mtError, [mbOK],
      0);
    Exit;
  end;

  sFormPass := lblPasswordForm.Text;

  if not SameStr(lblEnterNewPassword.Text, sFormPass) then
  begin
    //
    MessageDlg('Passwords do not match!', mtError, [mbOK], 0);
    Exit;
  end;

  if not IsValidPassword(lblPasswordForm.Text) then
  begin
    MessageDlg('This is not a valid password. It must be at least 8 characters and no more than 100 characters.', mtError, [mbOK],
      0);
    Exit;
  end;

  main.Form1.ChangeUserPassDb(sFormPass);
  MessageBox(0, 'The data file password has been changed!', 'Success', MB_ICONINFORMATION or MB_OK
    or MB_TASKMODAL);
  Close;
end;

procedure TfrmChangePassword.FormKeyPress(Sender: TObject; var Key: Char);
begin
  //
  if Key = #27 then
    Close;
end;

procedure TfrmChangePassword.btnPassOkClick(Sender: TObject);
begin
  //
  CheckAndSetPassword();
end;

procedure TfrmChangePassword.btnQuitClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmChangePassword.btnSavePasswordToFileClick(Sender: TObject);
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

  MessageDlg('Please store this text file containing your password in a safe location!', mtWarning,
    [mbOK],
    0);

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

procedure TfrmChangePassword.cbShowPassCharactersClick(Sender: TObject);
begin
  if cbShowPassCharacters.Checked then
  begin
    lblPasswordForm.PasswordChar := #0;
    lblEnterNewPassword.PasswordChar := #0;
    lblOldPasswordFirst.PasswordChar := #0;
  end
  else
  begin
    lblPasswordForm.PasswordChar := '*';
    lblEnterNewPassword.PasswordChar := '*';
    lblOldPasswordFirst.PasswordChar := '*';
  end;
end;

end.

