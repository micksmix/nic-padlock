unit frmForgotPass;

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
  TfrmForgotPassword = class(TForm)
    pnl1: TPanel;
    lblPasswordInstructions: TLabel;
    imgEnterPassword: TImage;
    mmoPasswordInfo: TMemo;
    btnDeleteDatafile: TButton;
    btnShowFile: TButton;
    procedure btnShowFileClick(Sender: TObject);
    procedure btnDeleteDatafileClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmForgotPassword           : TfrmForgotPassword;

implementation

uses
  ShellApi,
  uGlobal,
  frmPass,
  main;
{$R *.dfm}

procedure TfrmForgotPassword.btnDeleteDatafileClick(Sender: TObject);
begin
  //

  if (MessageBox(0,
    'Are you certain you want to DELETE the data file? All previously stored information will be lost! This cannot be undone.' + #13
    + #10 + '' + #13 + #10 + 'Do you want to delete the data file?', 'Confirm delete request',
    MB_ICONWARNING or MB_YESNO or MB_DEFBUTTON2) = IDYES) then
  begin
    //
    if Assigned(sqlitedb) then
      FreeAndNil(sqlitedb);

    if DeleteFile(slDBPath) then
    begin
      MessageDlg('Data file has been succesfully deleted. Please restart this program to create a new data file.', mtInformation, [mbOK], 0);
      frmPass.bDataFileDeleted := True;
      Close;
    end
    else
    begin
      if Assigned(sqlitedb) then
        FreeAndNil(sqlitedb);
      if DeleteFile(slDBPath) then
      begin
        MessageDlg('The data file has been succesfully deleted. Please restart this program to create a new data file.', mtInformation, [mbOK], 0);
        frmPass.bDataFileDeleted := True;
        Close;
      end
      else
      begin
        MessageDlg('Could not delete the data file! Please delete it manually at:' + #13 + #10 + ''
          + #13 + #10 + slDBPath, mtError, [mbOK], 0);
      end;
    end;
  end;
end;

procedure TfrmForgotPassword.btnShowFileClick(Sender: TObject);
var
  selectedFileName            : TFileName;
begin

  if FileExists(slDBPath) then
  begin
    ShellExecute(Handle,
      'OPEN',
      PChar('explorer.exe'),
      PChar('/select, "' + slDBPath + '"'),
      nil,
      SW_NORMAL);
  end
  else
  begin
    MessageDlg('Data file not found at expected location: ' + #13 + #10 + slDBPath, mtError, [mbOK],
      0);
  end;
end;

procedure TfrmForgotPassword.FormActivate(Sender: TObject);
begin
  HideCaret(mmoPasswordInfo.Handle);
end;

end.

