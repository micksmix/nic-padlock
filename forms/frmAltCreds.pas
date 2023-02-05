unit frmAltCreds;

interface

uses

  SysUtils,
  Windows,
  Classes,

  Controls,
  Forms,
  Dialogs,
  StdCtrls,
  ExtCtrls,
  Graphics;

type
  TfrmAlternateCredentials = class(TForm)
    Panel1: TPanel;
    Image1: TImage;
    Label1: TLabel;
    lblCredPass: TLabeledEdit;
    lblCredUser: TLabeledEdit;
    btnSave: TButton;
    btnCancel: TButton;
    chkShowChars: TCheckBox;
    chkInheritCreds: TCheckBox;
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure chkShowCharsClick(Sender: TObject);
    procedure chkInheritCredsClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    procedure SetCheckedState(const checkBox: TCheckBox; const check: boolean);
    { Private declarations }
  public
    sModIpHost: string;
    sModIpGroup: string;
    bModifyExisting: Boolean; //= False;

    { Public declarations }
  end;

var
  frmAlternateCredentials     : TfrmAlternateCredentials;

implementation

uses
  main, uHelpers;
{$R *.dfm}

procedure TfrmAlternateCredentials.btnCancelClick(Sender: TObject);
begin
  //  if not bModifyExisting then
  //  begin
  //    uGlobal.StoreAlternateCredentials(False, '', '', sModIpHost, sModIpGroup);
  //  end;
  Close;
end;

procedure TfrmAlternateCredentials.btnSaveClick(Sender: TObject);
var
  sUser                       : string;
  sEncUser, sEncPass          : string;
begin

  if chkInheritCreds.Checked then
  begin
    main.Form1.StoreAlternateCredentials(False, '', '', sModIpHost, sModIpGroup);
    lblCredUser.Enabled := False;
    lblCredPass.Enabled := False;
    chkShowChars.Enabled := False;
  end
  else
  begin
    chkInheritCreds.Checked := False;
    lblCredUser.Enabled := True;
    lblCredPass.Enabled := True;
    chkShowChars.Enabled := True;

    sUser := Trim(lblCredUser.Text);

    if Length(sUser) < 1 then
    begin
      MessageDlg('You must provide a username if you are using alternate credentials.', mtError,
        [mbOK],
        0);
      //cbUseAltCreds.Checked := False;
      //uGlobal.SetCheckedState(rbUseAltCreds, False);
      //lblCredUser.Enabled := False;
      //lblCredPass.Enabled := False;

      //uGlobal.SetCheckedState(uGlobal.rbConnectAsCurrentUser, True);
      //uGlobal.SetCheckedState(uGlobal.rbUseAltCreds, False);
      Exit;
    end;

    sEncUser := uHelpers.EncryptDbString(Trim(lblCredUser.Text));
    sEncPass := uHelpers.EncryptDbString(Trim(lblCredPass.Text));
    //
    main.Form1.StoreAlternateCredentials(True, sEncUser, sEncPass, sModIpHost, sModIpGroup);
  end;
  //
  //uGlobal.SetCheckedState(uGlobal.chkInherit, False);
  //uGlobal.SetCheckedState(uGlobal.chkUseAltCredentials, True);

  //uGlobal.chkUseAltCredentials.Hint := 'User: ' + lblCredUser.Text;
  //uGlobal.lblConnectAs.Caption := 'User: ' + lblCredUser.Text;
  //uGlobal.btnConnectAs.Caption := 'User: ' + lblCredUser.Text;
  //uGlobal.btnConnectAs.Visible := True;
  //uGlobal.SetFieldsChanged(True);
  Close;
end;

procedure TfrmAlternateCredentials.chkInheritCredsClick(Sender: TObject);
var
  sUser, sPass                : string;
  bUseAltCreds                : boolean;
begin
  if chkInheritCreds.Checked then
  begin
    if Length(Trim(lblCredUser.Text)) < 1 then
    begin
      lblCredUser.Enabled := False;
      lblCredPass.Enabled := False;
      chkShowChars.Enabled := False;
      Exit;
    end;

    uHelpers.RetrieveDbUserPass(sModIpGroup, sModIpHost, sUser, sPass, bUseAltCreds);
    case MessageBox(Self.Handle,
      PChar('Selecting this will clear the following saved username and password:' + #13#10#13#10
      + '   USER:   ' + sUser + #13#10#13#10
      + 'Do you want to continue?'), '',
      MB_ICONQUESTION or MB_YESNO or
      MB_DEFBUTTON2 or MB_APPLMODAL) of
      IDYES:
        begin
          //uGlobal.StoreAlternateCredentials(False, '', '', sModIpHost, sModIpGroup);
          lblCredUser.Enabled := False;
          lblCredPass.Enabled := False;
          chkShowChars.Enabled := False;
          //SetCheckedState(chkInherit, True); //not able to uncheck
          //chkInherit.Hint := ''; //'User: ' + lblCredUser.Text;
          //lblConnectAs.Caption := '';
          //btnConnectAs.Caption := '';
          //btnConnectAs.Visible := False;

          //SetCheckedState(chkUseAltCredentials, not chkInherit.Checked); //not able to uncheck
        end;
      IDNO:
        begin
          chkInheritCreds.Checked := False;
          lblCredUser.Enabled := True;
          lblCredPass.Enabled := True;
          chkShowChars.Enabled := True;
          //SetCheckedState(chkInherit, False);
        end;
    end;

  end
  else
  begin
    lblCredUser.Enabled := True;
    lblCredPass.Enabled := True;
    chkShowChars.Enabled := True;
  end;
end;

procedure TfrmAlternateCredentials.chkShowCharsClick(Sender: TObject);
begin
  if chkShowChars.Checked then
    lblCredPass.PasswordChar := #0
  else
    lblCredPass.PasswordChar := '*';
end;

procedure TfrmAlternateCredentials.SetCheckedState(const checkBox: TCheckBox; const check: boolean);
var
  onClickHandler              : TNotifyEvent;
begin
  with checkBox do
  begin
    onClickHandler := OnClick;
    OnClick := nil;
    Checked := check;
    OnClick := onClickHandler;
  end;
end;

procedure TfrmAlternateCredentials.FormActivate(Sender: TObject);
var
  sUser, sPass                : string;
  bUseAltCreds                : boolean;
begin
  uHelpers.RetrieveDbUserPass(sModIpGroup, sModIpHost, sUser,
    sPass, bUseAltCreds);

  if bUseAltCreds then
  begin
    lblCredUser.Enabled := True;
    lblCredPass.Enabled := True;
    chkShowChars.Enabled := True;
    lblCredUser.Text := sUser;
    lblCredPass.Text := sPass;
    SetCheckedState(chkInheritCreds, False); //.Checked := True;
  end
  else
  begin
    lblCredUser.Enabled := False;
    lblCredPass.Enabled := False;
    chkShowChars.Enabled := False;
    SetCheckedState(chkInheritCreds, True); //.Checked := True;
  end;

end;

end.

