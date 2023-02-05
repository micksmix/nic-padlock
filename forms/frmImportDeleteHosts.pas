unit frmImportDeleteHosts;

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
  ComCtrls,
  StdCtrls,
  uGlobal,
  uHelpers,
  main,
  VirtualTrees,
  ExtCtrls;

type
  TfrmImportDeleteProgress = class(TForm)
    pnl1: TPanel;
    img1: TImage;
    lblCurrentProgress: TLabel;
    pb1: TProgressBar;
    stat1: TStatusBar;
    btnCancel: TButton;
    tmrClose: TTimer;
    procedure FormActivate(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure tmrCloseTimer(Sender: TObject);
  private
    { Private declarations }
    FslMachineList: TStringList;
    FsGroup: string;
    FbAddHosts: boolean;
    procedure DoClose;
  public
    { Public declarations }
    procedure ExecuteAddComputers();
    procedure ExecuteDeleteComputers();
    property t_slMachineList: TStringList read FslMachineList write FslMachineList;
    property t_sGroup: string read FsGroup write FsGroup;
    property t_bAddHosts: boolean read FbAddHosts write FbAddHosts;
  end;

var
  frmImportDeleteProgress     : TfrmImportDeleteProgress;
  bStop                       : boolean = False;

implementation

{$R *.dfm}

{ TfrmImportDeleteProgress }

procedure TfrmImportDeleteProgress.btnCancelClick(Sender: TObject);
begin
  DoClose();
end;

procedure TfrmImportDeleteProgress.DoClose();
begin
  if not bStop then
  begin
    if (MessageBox(0, 'This will cancel all current actions. Do you want to continue?',
      'Confirm cancellation.', MB_ICONWARNING or MB_YESNO or MB_DEFBUTTON2) =
      IDYES) then
    begin
      //now close the form and cancel the deployments
      bStop := True;
      stat1.Panels[0].Text := 'Cancelled';
      pb1.Enabled := False;
      pb1.Position := 0;
      Application.ProcessMessages;
      tmrClose.Enabled := True;

      Close;
    end;
  end;

  stat1.Panels[0].Text := 'Cancelled';
  pb1.Enabled := False;
  pb1.Position := 0;

  Application.ProcessMessages;

  Close;
end;

procedure TfrmImportDeleteProgress.ExecuteAddComputers;
var
  iLoop                       : integer;
  sQuery                      : string;
  sIp, sComputer              : string;
  iAlreadyExist, iAdded       : integer;
  iPos                        : Integer;
begin

  lblCurrentProgress.Caption := 'Current Host Import Progress';

  iPos := (FslMachineList.Count) * 10;
  if iPos < 10 then
    iPos := 10;

  pb1.Max := iPos;
  pb1.Position := 0;
  pb1.Enabled := True;
  bStop := False; //default

  try
    for iLoop := 0 to FslMachineList.Count - 1 do
    begin
      if bStop then
      begin
        DoClose();
        Exit;
      end;

      pb1.StepIt;
      Application.ProcessMessages();

      sIp := FslMachineList.ValueFromIndex[iLoop]; //lvMultipleComputers.Items[iLoop].SubItems[0];
      sComputer := UpperCase(FslMachineList.Names[iLoop]);

      if sComputer = '-' then
        sComputer := '';

      if (Length(sComputer) <= 255)
        and (Length(sComputer) >= 1)
        and (Length(sIp) >= 1)
        and (Length(sIp) <= 25)
        and (main.Form1.IsValidName(sComputer)) then
      begin
        //valid IP and host entered
      end
      else
      begin
        if (Length(sComputer) >= 1)
          or (Length(sIp) >= 1) then
        begin

          if Length(sIp) < 1 then
          begin
            //no IP entered, just a hostname
            if (Length(sComputer) <= 255) and (main.Form1.IsValidName(sComputer)) then
            begin
              //
            end;
          end
          else
          begin
            if Length(sIp) <= 25 then
            begin
              //Only an IP and no computer entered
              sComputer := sIp;
            end;
          end;
        end;
      end;

      sQuery := 'SELECT fldHostname From "' + INFO_TABLE + '" WHERE fldGroup = "'
        + FsGroup + '" AND Upper(fldHostname) = "' + sComputer + '";';

      GetSqlTableByQuery(sltbInfo, sQuery);

      if sltbInfo.Count >= 1 then
      begin
        Inc(iAlreadyExist);
        Continue;
      end;

      Inc(iAdded);
      sQuery := 'INSERT INTO ' + INFO_TABLE +
        ' (fldHostname, fldGroup, fldIpAddr, fldAutoUpdateIp) VALUES ("'
        + sComputer
        + '", "'
        + FsGroup
        + '", "'
        + sIp + '=1'
        + '", "'
        + '1'
        + '")';

      ModifySqlTableByQuery(sQuery);
      stat1.Panels[0].Text := 'Loading host ' + IntToStr(iLoop + 1) + ' of ' +
        IntToStr(FslMachineList.Count);
      Application.ProcessMessages;

      main.Form1.AddHostToVst(FsGroup, sComputer);
    end;
    main.Form1.vst1.SortTree(0, sdAscending, True);

    stat1.Panels[0].Text := 'Done!';
    pb1.Enabled := False;
    pb1.Position := 0;

    if not bStop then
    begin
      if iAlreadyExist > 0 then
      begin
        MessageBox(0, PChar(IntToStr(iAlreadyExist) +
          ' hosts requested already exist in the group ['
          + FsGroup + ']' + #13 + #10 + IntToStr(iAdded) + ' new hosts were added to [' + FsGroup +
          '].'), 'Hosts added', MB_ICONINFORMATION or MB_OK);
      end
      else
      begin
        MessageBox(0, PChar(IntToStr(iAdded) + ' new hosts were added to [' + FsGroup +
          '].'), 'Hosts added', MB_ICONINFORMATION or MB_OK);
      end;
    end
    else
    begin
      DoClose();
      Exit;
    end;

    bStop := True;
  finally
    if sltbInfo <> nil then
      FreeAndNil(sltbInfo);

    pb1.Enabled := False;
  end;
end;

procedure TfrmImportDeleteProgress.ExecuteDeleteComputers;
var
  Node, ANode, ParentNode     : PVirtualNode;
  Data                        : PHostRec;
  i, ipc , idx                     : integer;
  sSQL                        : string;
  iPos                        : integer;
begin

  Node := main.Form1.vst1.FocusedNode;
  if Assigned(Node) then
  begin
    ParentNode := Node.Parent;
    if not Assigned(ParentNode) then
    begin
      Exit;
    end;
  end
  else
  begin
    Exit;
  end;

  iPos := (ParentNode.ChildCount) * 10;
  if iPos < 10 then
    iPos := 10;

  pb1.Max := iPos;
  pb1.Position := 0;
  pb1.Enabled := True;
  bStop := False; //default
  lblCurrentProgress.Caption := 'Current Host Removal Progress';

  idx := 0;
  main.Form1.vst1.BeginUpdate;
  try
    ipc := ParentNode.ChildCount - 1;
    for i := 0 to ipc do
    begin
      if bStop then
      begin
        DoClose();
        Exit;
      end;

      pb1.StepIt;

      Application.ProcessMessages;
      if i = 0 then
        ANode := ParentNode.FirstChild //Node
      else
      begin
        ANode := ANode.NextSibling;

        if not Assigned(ANode) then
        begin
          ANode := ANode.NextSibling;
        end;

        if not Assigned(ANode) then
        begin
          ANode := ANode.NextSibling;
        end;
      end;

      if Assigned(ANode) then
      begin
        if not main.Form1.vst1.Selected[ANode] then
          continue;

        Data := main.Form1.vst1.GetNodeData(ANode);
        try
          sSQL := 'DELETE FROM ' + INFO_TABLE + ' WHERE fldHostname = "' + Data.AHostname +
            '" AND fldGroup = "' + Data.AGroupname + '";';
          ModifySqlTableByQuery(sSQL);
          Application.ProcessMessages;

          Inc(idx);
          stat1.Panels[0].Text := 'Removing ' + IntToStr(idx) + ' of ' +
            IntToStr(main.Form1.vst1.SelectedCount);
        except on E: Exception do
          begin
            //OutputDebugString(PChar('error: ' + e.Message));
          end;
        end;
        //OutputDebugString(PChar('deleted ' + IntToStr(i)));
        main.Form1.vst1.DeleteNode(ANode, True);
      end;
    end;

    stat1.Panels[0].Text := 'Done!';
    pb1.Enabled := False;
    pb1.Position := 0;

    main.Form1.vst1.Invalidate();
    main.Form1.vst1.SortTree(0, sdAscending, true);

    bStop := True;
  finally
    main.Form1.vst1.EndUpdate;
    pb1.Enabled := False;
  end;

  main.Form1.vst1.FocusedNode := main.Form1.vst1.GetFirstLevel(0);
  main.Form1.vst1.Selected[main.Form1.vst1.GetFirstLevel(0)] := True;
end;

procedure TfrmImportDeleteProgress.FormActivate(Sender: TObject);
begin
  //
  bStop := False;
  tmrClose.Enabled := False;

  if FbAddHosts then
  begin
    ExecuteAddComputers();
  end
  else
  begin
    ExecuteDeleteComputers();
  end;
end;

procedure TfrmImportDeleteProgress.tmrCloseTimer(Sender: TObject);
begin
  if bStop then
  begin
    DoClose();
  end;
end;

end.

