unit frmAddIp;

{$WEAKLINKRTTI ON}
{$RTTI EXPLICIT METHODS([]) PROPERTIES([]) FIELDS([])}

interface

uses
  Classes,
  Controls,
  Forms,
  Dialogs,
  StdCtrls,
  SysUtils,
  IPMask,
  ExtCtrls,
  Graphics;

type
  TfrmAddIPAddress = class(TForm)
    btnAddIp: TButton;
    IPMask1: TIPMask;
    Panel1: TPanel;
    Image1: TImage;
    Label1: TLabel;
    procedure btnAddIpClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAddIPAddress             : TfrmAddIPAddress;

implementation

uses
  frmModifyIpAddress;

{$R *.dfm}

procedure TfrmAddIPAddress.btnAddIpClick(Sender: TObject);
var
  iPos, idx                   : integer;
  bItemChecked                : boolean;
  sText                       : string;
begin

  if IPMask1.Text = '0.0.0.0' then
  begin
    MessageDlg('Please enter a valid IP address!', mtError, [mbOK], 0);
    Exit;
  end;

  sText := IPMask1.Text;
  frmModifyIpAddress.fModifyIpAddress.AddIpAddress(sText);
  //
  //  for idx := 0 to frmModifyIpAddress.lbIpAddresses.Items.Count - 1 do
  //  begin
  //    if SameText(fModifyIpAddress.lbIpAddresses.Items.Strings[idx], IPMask1.Text) then
  //    begin
  //      MessageDlg('IP "' + IPMask1.Text + '" already exists in list!',
  //        mtInformation, [mbOK], 0);
  //
  //      Exit;
  //    end;
  //  end;
  //
  //  for idx := 0 to fModifyIpAddress.lbIpAddresses.Items.Count - 1 do
  //  begin
  //    if fModifyIpAddress.lbIpAddresses.Checked[idx] then
  //    begin
  //      bItemChecked := True;
  //      break;
  //    end;
  //  end;
  //
  //  if not bItemChecked then
  //  begin
  //    fModifyIpAddress.lbIpAddresses.CheckAll(cbUnchecked, True, False);
  //    iPos := fModifyIpAddress.lbIpAddresses.Items.Add(IPMask1.Text);
  //    fModifyIpAddress.lbIpAddresses.Checked[iPos] := True;
  //  end
  //  else
  //    fModifyIpAddress.lbIpAddresses.Items.Add(IPMask1.Text);
  //
  //  fModifyIpAddress.StoreIpAddresses(sIpGroup, sIpHost);

  Close;
end;

procedure TfrmAddIPAddress.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
    Close;

end;

end.

