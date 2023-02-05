unit frmGetFullVersion;

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
  TfrmGetFull = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    lblClickUrl: TLabel;
    btnOk: TButton;
    btn1: TButton;
    mmo1: TMemo;
    procedure lblClickUrlClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure mmo1Click(Sender: TObject);
    procedure mmo1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAboutProgram             : TfrmGetFull;

implementation

uses
  ShellAPI;

{$R *.dfm}

procedure TfrmGetFull.btn1Click(Sender: TObject);
//var
  //i                           : extended;
begin
  //i := 1 / 0;
  //showmessage(Format('%s', [i]));
end;

procedure TfrmGetFull.btnOkClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmGetFull.lblClickUrlClick(Sender: TObject);
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

procedure TfrmGetFull.mmo1Click(Sender: TObject);
begin
  HideCaret(mmo1.Handle)
end;

procedure TfrmGetFull.mmo1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = Ord('A')) and (ssCtrl in Shift) then
  begin
    TMemo(Sender).SelectAll;
    Key := 0;
  end;
end;

end.

