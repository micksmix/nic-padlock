unit frmAbout;

{$I nldefine.inc}

interface

uses
  Windows,
  Classes,
  Controls,
  Forms,
  ExtCtrls,
  StdCtrls,
  Dialogs,
  SysUtils,
  Graphics;

type
  TfrmAboutProgram = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    lblClickUrl: TLabel;
    btnOk: TButton;
    btn1: TButton;
    procedure lblClickUrlClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAboutProgram             : TfrmAboutProgram;

implementation

uses
  ShellAPI,
  uHelpers;

{$R *.dfm}

procedure TfrmAboutProgram.btn1Click(Sender: TObject);
var
  i                           : extended;
begin
{$IFDEF LITE_VERSION}
  i := 1 / 0;
  showmessage(Format('%s', [i]));
{$ENDIF}
end;

procedure TfrmAboutProgram.btnOkClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmAboutProgram.FormActivate(Sender: TObject);
begin
  //
{$IFDEF LITE_VERSION}
  frmAboutProgram.Caption := 'About Nic Padlock TRIAL version';
  Label1.Caption := 'NIC Padlock v' + GetBuildInfoAsString() + ' - TRIAL' + #13#10
    + 'Copyright © 2015 Wild Paw Software'
{$ELSE}

  Label1.Caption := 'NIC Padlock v' + GetBuildInfoAsString() + #13#10
    + 'Copyright © 2015 Wild Paw Software'
{$ENDIF}
end;

procedure TfrmAboutProgram.lblClickUrlClick(Sender: TObject);
begin
  if (Sender is TLabel) then
  begin
    with (Sender as TLabel) do
      ShellExecute(Application.Handle,
        PChar('open'),
        PChar(Hint),
        PChar(0),
        nil,
        SW_NORMAL);
  end;
end;

end.

