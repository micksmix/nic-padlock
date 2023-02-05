unit frmDeployProgress;

interface

uses
  Classes,
  Controls,
  Forms,
  ComCtrls,
  uGlobal,
  Messages,
  SysUtils,
  ShellAnimations,
  Windows,
  Graphics,
  StrUtils,
  StdCtrls,
  ExtCtrls;

const
  WM_MYMEMO_ENTER             = WM_USER + 510;

type
  TfrmShowProgress = class(TForm)
    Memo1: TMemo;
    ProgressBar1: TProgressBar;
    Timer1: TTimer;
    btnClose: TButton;
    Panel1: TPanel;
    Image1: TImage;
    lblCurrentProgress: TLabel;
    mmoMarquee: TMemo;
    procedure FormActivate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure Memo1Enter(Sender: TObject);
    procedure Memo1Exit(Sender: TObject);
    procedure Memo1Change(Sender: TObject);
  private
    { Private declarations }
    procedure ThreadMessage(var Msg: TMessage); message WM_PROGRESS_FORM_MSG;
  public
    { Public declarations }
    bDone: boolean;
    bCloseForm: boolean;
    procedure WMMYMEMOENTER(var Message: TMessage); message WM_MYMEMO_ENTER;
  end;

var
  frmShowProgress             : TfrmShowProgress;

implementation

{$R *.dfm}

procedure TfrmShowProgress.btnCloseClick(Sender: TObject);
begin
  bDone := True;
  bCloseForm := True;
  Close;
end;

procedure TfrmShowProgress.FormActivate(Sender: TObject);
begin
  bDone := False;
  bCloseForm := False;
end;

procedure TfrmShowProgress.WMMYMEMOENTER(var Message: TMessage);
begin
  CreateCaret(Memo1.Handle, 0, 0, 0);
end;

procedure TfrmShowProgress.Memo1Change(Sender: TObject);
begin
  CreateCaret(Memo1.handle, 0, 0, 0);
end;

procedure TfrmShowProgress.Memo1Enter(Sender: TObject);
begin
  PostMessage(Handle, WM_MYMEMO_ENTER, 0, 0);
end;

procedure TfrmShowProgress.Memo1Exit(Sender: TObject);
begin
  CreateCaret(Memo1.handle, 1, 1, 1);
end;

procedure TfrmShowProgress.ThreadMessage(var Msg: TMessage);
var
  msg_deploysvc               : PWMDeploySvcCommand;
  slMemo                      : TStringList;
begin
  case Msg.WParam of
    WM_PROGRESS_FORM_CLOSE:
      begin
        bDone := True;
        bCloseForm := True;
        Close;
      end;
    WM_PROGRESS_FORM_STOP:
      begin
        bDone := True;
        ProgressBar1.Visible := False;
        Timer1.Enabled := False;
      end;
    WM_THRD_PROGRESS_MSG:
      //
      // This is sent by the any thread when it is ready to show a status
      //
      begin
        msg_deploysvc := PWMDeploySvcCommand(Msg.LParam);
        try
          if ((Length(msg_deploysvc.group) > 0) and (Length(msg_deploysvc.host) > 0)) then
          begin
            //
            slMemo := TStringList.Create;
            try
              slMemo.Text := Trim(msg_deploysvc.result);

              if Length(Trim(msg_deploysvc.result)) > 20 then
              begin

                if not ContainsText(Memo1.Lines.Text, Trim(msg_deploysvc.result)) then
                begin
                  Memo1.Lines.Add(#13#10 + msg_deploysvc.result);
                  mmoMarquee.Clear;
                  mmoMarquee.Lines[0] := slMemo[0];
                  mmoMarquee.SelStart := 0;
                end;
              end
              else
              begin
                Memo1.Lines.Add(#13#10 + msg_deploysvc.result);
                mmoMarquee.Clear;
                mmoMarquee.Lines[0] := slMemo[0];
                mmoMarquee.SelStart := 0;
              end;
            finally
              FreeAndNil(slMemo);
            end;
          end;
        finally
          Dispose(msg_deploysvc);
        end;
      end;

  end;
  inherited;
end;

procedure TfrmShowProgress.Timer1Timer(Sender: TObject);
begin
  if not bDone then
  begin
    if ProgressBar1.Position = ProgressBar1.Min then
      ProgressBar1.Visible := True;

    if ProgressBar1.Position > ProgressBar1.Max then
      ProgressBar1.Position := ProgressBar1.Min;

    ProgressBar1.StepIt;
  end
  else
  begin
    ProgressBar1.Visible := False;
  end;

  Application.ProcessMessages;

  if bCloseForm then
  begin
    Close;
  end;

end;

end.

