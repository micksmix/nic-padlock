unit frmUserMessage;

interface

uses

  SysUtils,

  Classes,

  Controls,
  Forms,
  Dialogs,
  ExtCtrls,
  SQLiteTable3,
  main,
  StdCtrls,
  Graphics;

type
  TfrmUserMsgOnDisable = class(TForm)
    Panel1: TPanel;
    Image1: TImage;
    Label1: TLabel;
    Memo1: TMemo;
    lblInstructions: TLabel;
    btnAccept: TButton;
    btnCancel: TButton;
    Label2: TLabel;
    chkShowMessageToUser: TCheckBox;
    procedure btnAcceptClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure chkShowMessageToUserClick(Sender: TObject);
    procedure Memo1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    procedure SetCheckedState(const checkBox: TCheckBox; const check: boolean);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmUserMsgOnDisable         : TfrmUserMsgOnDisable;

implementation

uses

  uHelpers,
  uGlobal;

{$R *.dfm}

procedure TfrmUserMsgOnDisable.btnAcceptClick(Sender: TObject);
var
  sldb                        : TSQLiteDatabase;
  sQuery                      : string;
  sEncMsg                     : string;
begin
  if Length(Trim(Memo1.Lines.Text)) < 10 then //
  begin
    MessageDlg('You must enter a message of at least 10 characters!', mtError, [mbOK], 0);
  end
  else if Length(Trim(Memo1.Lines.Text)) > 1000 then //
  begin
    MessageDlg('The message must be less than 1,000 characters!'
      + #13#10 + 'You entered ' + IntToStr(Length(Trim(Memo1.Lines.Text))) + ' characters.',
      mtError, [mbOK], 0);
  end
  else
  begin
    //update DB

    sEncMsg := StrToHex(Trim(Memo1.Lines.Text));
    //uBasicEncrypt.VigenereExEncrypt(Trim(Memo1.Lines.Text), VIGENERE_KEY, False));
    //sldb := TSQLiteDatabase.Create(slDBPath);
    try
      sQuery := 'UPDATE  ' + INFO_TABLE + ' SET fldUserMessage = "' + sEncMsg
        //'" AND fldShowUserMessage = "' + BoolToStr(True, True)
      + '" WHERE fldHostname = "'
        + main.Form1.lblHost.Caption
        + '" AND fldGroup = "'
        + main.Form1.lblGroup.Caption + '";';

      ModifySqlTableByQuery(sQuery);

      sQuery := 'UPDATE  ' + INFO_TABLE + ' SET fldShowUserMessage = "'
        + BoolToStr(chkShowMessageToUser.Checked, True)
        + '" WHERE fldHostname = "'
        + main.Form1.lblHost.Caption
        + '" AND fldGroup = "'
        + main.Form1.lblGroup.Caption + '";';

      ModifySqlTableByQuery(sQuery);

    finally
      //sldb.Free;
    end;
  end;
  Close;
end;

procedure TfrmUserMsgOnDisable.btnCancelClick(Sender: TObject);
var
  sUserMsg                    : string;
  bShowMsg                    : boolean;
begin

  main.Form1.RetrieveDbUserMessage(
    main.Form1.lblGroup.Caption,
    main.Form1.lblHost.Caption, sUserMsg, bShowMsg);

  //  if Length(Trim(sUserMsg)) < 10 then
  //  begin
  //    main.Form1.SetCheckedState(main.Form1.chkDisplayMessageToUser, False);
  //    main.Form1.btnDisplayEditUserMessage.Enabled := False;
  //  end;

  Close;
end;

procedure TfrmUserMsgOnDisable.chkShowMessageToUserClick(Sender: TObject);
begin
  if chkShowMessageToUser.Checked then
  begin
    Memo1.Enabled := True;
  end
  else
  begin
    Memo1.Enabled := False;
  end;
end;

procedure TfrmUserMsgOnDisable.SetCheckedState(const checkBox: TCheckBox; const check: boolean);
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

procedure TfrmUserMsgOnDisable.FormActivate(Sender: TObject);
var
  sUserMsg, sDecMsg           : string;
  bShowMsg                    : boolean;
begin
  //
  main.Form1.RetrieveDbUserMessage(
    main.Form1.lblGroup.Caption,
    main.Form1.lblHost.Caption, sUserMsg, bShowMsg);

  chkShowMessageToUser.Checked := bShowMsg;
  //SetCheckedState(chkShowMessageToUser, bShowMsg);
  if chkShowMessageToUser.Checked then
  begin
    Memo1.Enabled := True;
  end
  else
  begin
    Memo1.Enabled := False;
  end;

  sDecMsg := HexToString(sUserMsg); //uBasicEncrypt.VigenereExEncrypt(sUserMsg, VIGENERE_KEY, True));

  if Length(Trim(sDecMsg)) < 10 then
  begin
    Memo1.Lines.Text := 'EXAMPLE TEXT' + #13#10#13#10 +
      'Your network card(s) have been disabled by technology support because ' + #13#10 +
      'of suspected malicious activity, likely performed by a virus on your system.' + #13#10 + '' +
      #13#10 +
      'Please contact your technology support team immediately for more ' + #13#10 +
      'information and remediation.' + #13#10 + '' + #13#10 + 'phone:  1-800-XXX-XXX' + #13#10 +
      '  email:  YOUR_SUPPORT_TEAM@your_company.com';
  end
  else
  begin
    Memo1.Lines.Text := sDecMsg;
  end;

end;

procedure TfrmUserMsgOnDisable.Memo1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = Ord('A')) and (ssCtrl in Shift) then
  begin
    TMemo(Sender).SelectAll;
    Key := 0;
  end;
end;

end.

