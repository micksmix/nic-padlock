unit frmProtection;

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
  frmGetFullVersion,
  mxProtector;

type
  TfrmTrialProtector = class(TForm)
    mxprtctr1: TmxProtector;
    procedure mxprtctr1Expiration(Sender: TObject);
    procedure mxprtctr1DayTrial(Sender: TObject; DaysRemained: Integer);
    procedure mxprtctr1InvalidSystemTime(Sender: TObject);
    procedure mxprtctr1GetRegistryPath(Sender: TObject; var APath: string);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmTrialProtector           : TfrmTrialProtector;

implementation

{$R *.dfm}

procedure TfrmTrialProtector.mxprtctr1DayTrial(Sender: TObject; DaysRemained: Integer);
begin

  MessageBox(Application.Handle, PChar(Format('This TRIAL version will expire after %d days.',
    [DaysRemained])), '', MB_ICONINFORMATION or MB_OK
    or MB_TASKMODAL or MB_TOPMOST);

  {
       If DaysRemained = 1 Then
            lbl_Message.Caption := 'Only one licenced day left'  Else
            lbl_Message.Caption := Format( 'This software licence will expire after %d days.', [ DaysRemained ] );

       lbl_Remaining.Caption := Format( '%d days remaining', [ DaysRemained ] );
       btn_Reset.Enabled := FALSE;
       btn_Go.Enabled := TRUE;
       ProgressBar.Max := mxProtector.MaxDayNumber;
       ProgressBar.Position := DaysRemained;}
end;

procedure TfrmTrialProtector.mxprtctr1Expiration(Sender: TObject);
var
  frmGetFull                  : TfrmGetFull;
begin
  //
  MessageBox(Application.Handle,
    PChar('TRIAL version has expired. Please consider upgrading to the full version.'), '',
    MB_ICONINFORMATION or MB_OK
    or MB_TASKMODAL or MB_TOPMOST);

  frmGetFull := TfrmGetFull.Create(nil);
  try
    frmGetFull.ShowModal;
  finally
    frmGetFull.Release;
    Pointer(frmGetFull) := nil;
  end;

  Halt;
  Close;
end;

procedure TfrmTrialProtector.mxprtctr1GetRegistryPath(Sender: TObject;
  var APath: string);
var
  v3_0_22                     : string;
  v3_5_0                      : string;
  vTesting                    : string;
begin
  //this is where we can change where trial registry info is stored
  // good to change this with every NEW
  v3_0_22 := '{581493B1-6161-44F4-B1A2-223DFB1F1684}';
  v3_5_0 := '{322F51D1-1C03-44D9-AA49-B5B0D2A1F067}';
  vTesting := '{9FB048D4-CEFF-46C5-B80A-9ED5C9D16905}';
  APath := '\SOFTWARE\Classes\CLSID\' + vTesting + '\Info';
end;

procedure TfrmTrialProtector.mxprtctr1InvalidSystemTime(Sender: TObject);
begin
  MessageBox(Application.Handle,
    PChar('Your system time is invalid.' + #13 + #10 +
    'Please set the correct date and time to continue.'), '',
    MB_ICONINFORMATION or MB_OK
    or MB_TASKMODAL or MB_TOPMOST);

  Close;
end;

end.

