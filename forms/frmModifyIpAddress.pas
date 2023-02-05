unit frmModifyIpAddress;

{$I nldefine.inc}

{$WEAKLINKRTTI ON}
{$RTTI EXPLICIT METHODS([]) PROPERTIES([]) FIELDS([])}

interface

uses
  Classes,
  Windows,
  Controls,
  Forms,
  Dialogs,
  StdCtrls,
  SysUtils,
  ComCtrls,
  IPMask,
  ExtCtrls,
  Graphics,
  CheckLst;

type
  TfModifyIPAddress = class(TForm)
    Panel1: TPanel;
    Image1: TImage;
    Label1: TLabel;
    lblIpAddress: TLabel;
    btnLookupIpDns: TButton;
    lbIpAddresses: TCheckListBox;
    btnAddIpAddr: TButton;
    btnDeleteChecked: TButton;
    animateFindComputer: TAnimate;
    pnllModifyIpAddress: TPanel;
    pnlAddIpAddress: TPanel;
    IPMask1: TIPMask;
    btnAddIp: TButton;
    pgc1: TPageControl;
    ts_ModifyIp: TTabSheet;
    ts_AddIp: TTabSheet;
    procedure btnLookupIpDnsClick(Sender: TObject);
    procedure btnDeleteCheckedClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btnAddIpClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnAddIpAddrClick(Sender: TObject);
  private
    procedure RetrieveIpForHost(sTheHost, sTheGroup: string; bSilent: Boolean = False);
    procedure SetCheckedListboxState(const checkBox: TCheckListBox; idx: integer; const check:
      boolean);
    procedure AdjustCheckListBox(listbox: TCheckListBox);
    procedure PrivateAddIpAddress(sIpText: string);
    { Private declarations }
  public
    sModIpHost: string;
    sModIpGroup: string;

    procedure StoreIpAddresses(const sGroup, sHost: string);
    { Public declarations }
  end;

var
  fModifyIPAddress            : TfModifyIPAddress;

implementation

uses
  AsyncCalls,

  SQLiteTable3,
  uHelpers,
  uGlobal;

{$R *.dfm}

//
//procedure TfModifyIPAddress.AddRetrieveIpForHost(sTheHost, sTheGroup: string; bSilent: Boolean =
//  False);
//var
//  slIpAddresses               : TStringList;
//  asHostQuery                 : IAsyncCall;
//  sSQL                        : string;
//  i                           : integer;
//begin
//  slIpAddresses := TStringList.Create;
//  try
//    slIpAddresses.Sorted := True;
//    slIpAddresses.Duplicates := dupIgnore;
//
//    //means the user is looking at this host's information
//    if not bSilent then
//    begin
//      try
//        sSQL := 'SELECT * From "' + INFO_TABLE + '" WHERE fldGroup = "' + sTheGroup +
//          '" AND fldHostname = "' + sTheHost + '";';
//
//        GetSqlTableByQuery(sltbInfo, sSQL);
//
//        if sltbInfo.Count <= 0 then
//        begin
//          Exit;
//        end;
//
//        while not sltbInfo.eof do
//        begin
//          slIpAddresses.Clear;
//          slIpAddresses.CommaText := sltbInfo.FieldByName['fldIpAddr'];
//          lbIpAddresses.Clear;
//          for i := 0 to slIpAddresses.Count - 1 do
//          begin
//            lbIpAddresses.Items.Add(slIpAddresses.Names[i]);
//          end;
//
//          for i := 0 to slIpAddresses.Count - 1 do
//          begin
//            if slIpAddresses.ValueFromIndex[i] = '0' then
//            begin
//              SetCheckedListboxState(lbIpAddresses, i, False);
//            end
//            else
//            begin
//              SetCheckedListboxState(lbIpAddresses, i, True);
//            end;
//          end;
//
//
//          sltbInfo.Next;
//        end;
//      finally
//        if sltbInfo <> nil then
//          FreeAndNil(sltbInfo);
//      end;
//    end;
//  finally
//    FreeAndNil(slIpAddresses);
//  end;
//end;

procedure TfModifyIPAddress.PrivateAddIpAddress(sIpText: string);
var
  idx, iPos                   : integer;
  bItemChecked                : Boolean;
  sItem, sCur                 : string;
begin
  if sIpText = '0.0.0.0' then
  begin
    MessageDlg('Please enter a valid IP address!', mtError, [mbOK], 0);
    Exit;
  end;

  for idx := 0 to lbIpAddresses.Items.Count - 1 do
  begin
    if lbIpAddresses.Checked[idx] then
    begin
      bItemChecked := True;
      break;
    end;
  end;

  if lbIpAddresses.Count > 0 then
  begin
    for idx := 0 to lbIpAddresses.Count - 1 do
    begin
      sCur := lbIpAddresses.Items.Strings[idx];
      if SameText(sCur, sIpText) then
      begin
        MessageDlg('IP "' + sIpText + '" already exists in list!',
          mtInformation, [mbOK], 0);

        Exit;
      end;
      //Inc(idx);
    end;

    for idx := 0 to lbIpAddresses.Count - 1 do
    begin
      if lbIpAddresses.Checked[idx] then
      begin
        bItemChecked := True;
        break;
      end;
    end;
  end;

  if not bItemChecked then
  begin
    lbIpAddresses.CheckAll(cbUnchecked, True, False);
    iPos := lbIpAddresses.Items.Add(sIpText);
    lbIpAddresses.Checked[iPos] := True;
  end
  else
    lbIpAddresses.Items.Add(sIpText);

  StoreIpAddresses(sModIpGroup, sModIpHost);
end;

procedure TfModifyIPAddress.SetCheckedListboxState(const checkBox: TCheckListBox; idx: integer; const
  check: boolean);
var
  onClickHandler              : TNotifyEvent;
begin
  with checkBox do
  begin
    onClickHandler := OnClick;
    OnClick := nil;
    Checked[idx] := check;
    OnClick := onClickHandler;
  end;
end;

procedure TfModifyIPAddress.RetrieveIpForHost(sTheHost, sTheGroup: string; bSilent: Boolean =
  False);
var
  slIpAddresses               : TStringList;
  asHostQuery                 : IAsyncCall;
  sSQL                        : string;
  i                           : integer;
begin
  slIpAddresses := TStringList.Create;
  try
    slIpAddresses.Sorted := True;
    slIpAddresses.Duplicates := dupIgnore;
    //
    asHostQuery := AsyncCall(@HostToIP, [sTheHost, slIpAddresses]);

    while AsyncMultiSync([asHostQuery], True, 10) = WAIT_TIMEOUT do
    begin
      Application.ProcessMessages;
    end;

    if slIpAddresses.Count < 1 then
    begin
      if not bSilent then
        MessageDlg('Could not retrieve the IP address. ' + ''#13'' + ''#10'' +
          'Check that the host is online and available.', mtError, [mbOK], 0);
    end;

    uHelpers.AddNewResolvedIPs(slIpAddresses, sTheHost, sTheGroup);

    //means the user is looking at this host's information
    if not bSilent then
    begin
      try
        sSQL := 'SELECT * From "' + INFO_TABLE + '" WHERE fldGroup = "' + sTheGroup +
          '" AND fldHostname = "' + sTheHost + '";';

        GetSqlTableByQuery(sltbInfo, sSQL);

        if sltbInfo.Count <= 0 then
        begin
          Exit;
        end;

        while not sltbInfo.eof do
        begin
          slIpAddresses.Clear;
          slIpAddresses.CommaText := sltbInfo.FieldByName['fldIpAddr'];
          lbIpAddresses.Clear;
          for i := 0 to slIpAddresses.Count - 1 do
          begin
            lbIpAddresses.Items.Add(slIpAddresses.Names[i]);
          end;

          for i := 0 to slIpAddresses.Count - 1 do
          begin
            if slIpAddresses.ValueFromIndex[i] = '0' then
            begin
              SetCheckedListboxState(lbIpAddresses, i, False);
            end
            else
            begin
              SetCheckedListboxState(lbIpAddresses, i, True);
            end;
          end;

          sltbInfo.Next;
        end;
      finally
        if sltbInfo <> nil then
          FreeAndNil(sltbInfo);
      end;
    end;
  finally
    FreeAndNil(slIpAddresses);
  end;
end;

procedure TfModifyIPAddress.StoreIpAddresses(const sGroup, sHost: string);
var
  sQuery                      : string;
  sCommaText                  : string;
  sCurIp                      : string;
  idx                         : Integer;
  bItemChecked                : boolean;
  a                           : TListItem;
begin
  bItemChecked := False; //default
  try
    for idx := 0 to lbIpAddresses.Items.Count - 1 do
    begin
      if lbIpAddresses.Checked[idx] then
      begin
        bItemChecked := True;
        break;
      end;
    end;

    if lbIpAddresses.Items.Count < 1 then
      bItemChecked := True; //this is a lie, but oh well

    if not bItemChecked then
    begin
      lbIpAddresses.Checked[0] := True;
    end;

    if lbIpAddresses.Items.Count > 0 then
    begin
      for idx := 0 to lbIpAddresses.Items.Count - 1 do
      begin
        sCurIp := lbIpAddresses.Items.Strings[idx];
        if lbIpAddresses.Checked[idx] then
        begin
          sCommaText := sCommaText + sCurIp + '=1';
        end
        else
        begin
          sCommaText := sCommaText + sCurIp + '=0';
        end;
        if idx <> lbIpAddresses.Items.Count - 1 then
        begin
          sCommaText := sCommaText + ',';
        end;
      end;
      sQuery := 'UPDATE  ' + INFO_TABLE + ' SET fldIpAddr = "' + sCommaText +
        '" WHERE fldHostname = "' +
        sHost + '" AND fldGroup = "' + sGroup + '";';
      ModifySqlTableByQuery(sQuery);
    end
    else
    begin
      //
      sQuery := 'UPDATE  ' + INFO_TABLE + ' SET fldIpAddr = "" WHERE fldHostname = "' +
        sHost + '" AND fldGroup = "' + sGroup + '";';
      //
      ModifySqlTableByQuery(sQuery);
    end;
  finally
    //sldb.Free;
  end;
end;

procedure TfModifyIPAddress.btnAddIpAddrClick(Sender: TObject);
begin
  pgc1.ActivePage := ts_AddIp;
end;

procedure TfModifyIPAddress.btnAddIpClick(Sender: TObject);
begin
  PrivateAddIpAddress(IPMask1.Text);
  pgc1.ActivePage := ts_ModifyIp;
end;

procedure TfModifyIPAddress.AdjustCheckListBox(listbox: TCheckListBox);
var
  i, nMaxWidth, nItemWidth    : integer;
begin
  nMaxWidth := listbox.ClientWidth;
  for i := 0 to listbox.Items.Count - 1 do
  begin
    nItemWidth := listbox.Canvas.TextWidth(listbox.Items[i]) + 20;
    if (nItemWidth > nMaxWidth) then
      nMaxWidth := nItemWidth;
  end;
  if (nMaxWidth > listbox.ClientWidth) then
    listbox.ScrollWidth := nMaxWidth;

end;

procedure TfModifyIPAddress.btnDeleteCheckedClick(Sender: TObject);
var
  i                           : integer;
begin
  case MessageBox(Self.Handle,
    PChar('Are you sure you want to delete this IP address?'), '', MB_ICONQUESTION or MB_YESNO or
    MB_DEFBUTTON2 or MB_APPLMODAL) of
    idYes:
      begin
        i := 0;
        while i < lbIpAddresses.Items.Count do
        begin
          if lbIpAddresses.Checked[i] then
          begin
            lbIpAddresses.Items.Delete(i);
            dec(i);
          end;
          Inc(i);
        end;
        AdjustCheckListBox(lbIpAddresses);
        StoreIpAddresses(sModIpGroup, sModIpHost);

        //SetFieldsChanged(True);
      end;
  end;
end;

procedure TfModifyIPAddress.btnLookupIpDnsClick(Sender: TObject);
begin
  //
  animateFindComputer.Visible := True;
  animateFindComputer.Active := True;
  btnLookupIpDns.Enabled := False;
  RetrieveIpForHost(sModIpHost, sModIpGroup, False);

  animateFindComputer.Visible := False;
  animateFindComputer.Active := False;
  btnLookupIpDns.Enabled := True;
end;

procedure TfModifyIPAddress.FormActivate(Sender: TObject);
begin
  pgc1.ActivePage := ts_ModifyIp;
end;

procedure TfModifyIPAddress.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
  begin
    Close;
  end;
end;

procedure TfModifyIPAddress.FormShow(Sender: TObject);
var
  sSQL                        : string;
  slIpAddresses               : TStringList;
  i                           : Integer;
begin
  try
    sSQL := 'SELECT * From "' + INFO_TABLE + '" WHERE fldGroup = "' + sModIpGroup +
      '" AND fldHostname = "' + sModIpHost + '";';

    GetSqlTableByQuery(sltbInfo, sSQL);

    if sltbInfo.Count <= 0 then
    begin
      Exit;
    end;

    while not sltbInfo.eof do
    begin
      slIpAddresses := TStringList.Create;
      try
        slIpAddresses.CommaText := sltbInfo.FieldByName['fldIpAddr'];
        //
        lbIpAddresses.Clear;
        for i := 0 to slIpAddresses.Count - 1 do
        begin
          lbIpAddresses.Items.Add(slIpAddresses.Names[i]);
        end;

        for i := 0 to slIpAddresses.Count - 1 do
        begin
          if slIpAddresses.ValueFromIndex[i] = '0' then
          begin
            SetCheckedListboxState(lbIpAddresses, i, False);
          end
          else
          begin
            //btnModifyIpAddress.Caption := slIpAddresses.Names[i];
            SetCheckedListboxState(lbIpAddresses, i, True);
          end;
        end;
      finally
        FreeAndNil(slIpAddresses);
      end;
      sltbInfo.Next;
    end;
  finally
    if sltbInfo <> nil then
      FreeAndNil(sltbInfo);
  end;

end;

end.

