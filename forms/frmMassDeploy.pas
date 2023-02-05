unit frmMassDeploy;

{$I nldefine.inc}

{$WEAKLINKRTTI ON}
{$RTTI EXPLICIT METHODS([]) PROPERTIES([]) FIELDS([])}

interface

uses
  Windows,
  Messages,
  SysUtils,
  Classes,
  Controls,
  Forms,
  uGlobal,
  Dialogs,
  StdCtrls,
  ExtCtrls,
  main,
  ComCtrls,
  Graphics;

type
  TfrmMassDeploySvc = class(TForm)
    pnl1: TPanel;
    img1: TImage;
    lblCurrentProgress: TLabel;
    lvDeployProgress: TListView;
    btnClose: TButton;
    Timer1: TTimer;
    ProgressBar1: TProgressBar;
    StatusBar1: TStatusBar;
    btnExportToCSV: TButton;
    procedure btnCloseClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure lvDeployProgressCompare(Sender: TObject; Item1, Item2: TListItem;
      Data: Integer; var Compare: Integer);
    procedure lvDeployProgressColumnClick(Sender: TObject; Column: TListColumn);
    procedure btnExportToCSVClick(Sender: TObject);
  private
    { Private declarations }
    FslMachineList: TStringList;
    FsGroup: string;
    procedure ThreadMessage(var Msg: TMessage); message WM_POSTED_MSG;
    procedure DeploymentsDone();
    procedure GetHostDetailsFromDb(var HostInfo: TCmdParams; const sHostname,
      sGroupname: string);
  public
    { Public declarations }
    //constructor Create(AOwner: TComponent);
    procedure ExecuteWork();
    property t_slMachineList: TStringList read FslMachineList write FslMachineList;
    property t_sGroup: string read FsGroup write FsGroup;
  end;

var
  frmMassDeploySvc            : TfrmMassDeploySvc;
  bDone                       : boolean = False;
  bAllScheduled               : boolean = False;
  bCloseForm                  : boolean = False;
  SortedColMassDeploy         : Integer;
  DescMassDeploy              : Boolean;

implementation

{$R *.dfm}

uses
  uGlobalNetBios,
  uHelpers,
  SQLiteTable3,
  uThrdDeploySvc,
  uThrdAbortThreads;

procedure TfrmMassDeploySvc.GetHostDetailsFromDb(var HostInfo: TCmdParams; const sHostname,
  sGroupname: string);
var
  ms                          : TMemoryStream;
  sltbU                       : TSQLiteUniTable;
  sSQL                        : string;
  MgNicArray                  : TRemoteNicArray;
  slIpAddresses               : TStringList;
  i, idx                      : Integer;
  bEn, bDis                   : Boolean;
  slGuids                     : TStringList;
begin
  //default
  if not SameText(sUserSuppliedHashedPass, uGlobal.sHashedPass) then
    Exit;

  try
    try
      sSQL := 'SELECT * From "' + INFO_TABLE + '" WHERE fldGroup = "' + sGroupname +
        '" AND fldHostname = "' + sHostname + '";';

      GetSqlTableByQuery(sltbInfo, sSQL);

      if sltbInfo.Count <= 0 then
      begin
        Exit;
      end;

      HostInfo.sHostAddr := '';

      while not sltbInfo.eof do
      begin
        slIpAddresses := TStringList.Create;
        try
          slIpAddresses.CommaText := sltbInfo.FieldByName['fldIpAddr'];

          for i := 0 to slIpAddresses.Count - 1 do
          begin
            if slIpAddresses.ValueFromIndex[i] = '0' then
            begin
              Application.ProcessMessages;
            end
            else
            begin
              HostInfo.sHostAddr := slIpAddresses.Names[i];
            end;
          end;
        finally
          FreeAndNil(slIpAddresses);
        end;

        //
//bUseAltUser := StrToBool(sltbInfo.FieldByName['fldUseAltUser']);
        HostInfo.bAltCreds := StrToBool(sltbInfo.FieldByName['fldUseAltUser']);

        //bShowUserMessage := False; //default
        HostInfo.bDisplayUserMessage := False; //default
        HostInfo.sUserMessage := ''; //default
        //bShowUserMessage := StrToBool(sltbInfo.FieldByName['fldShowUserMessage']);
        HostInfo.bDisplayUserMessage := StrToBool(sltbInfo.FieldByName['fldShowUserMessage']);
        HostInfo.bAutoUpdateIp := StrToBool(sltbInfo.FieldByName['fldAutoUpdateIp']);

        if HostInfo.bDisplayUserMessage then
        begin
          HostInfo.sUserMessage := sltbInfo.FieldByName['fldUserMessage'];
        end;
        //

        if HostInfo.bAltCreds then
        begin
          HostInfo.sUser := DecryptDbString(sltbInfo.FieldByName['fldAltUser']);
          HostInfo.sPass := DecryptDbString(sltbInfo.FieldByName['fldAltPass']);
        end
        else
        begin
          HostInfo.sUser := '';
          HostInfo.sPass := '';
        end;

        HostInfo.bEnableAllAdapters := StrToBool(sltbInfo.FieldByName['fldEnableAllNics']);
        HostInfo.bDisableAllAdapters := StrToBool(sltbInfo.FieldByName['fldDisableAllNics']);

        HostInfo.bReEnableAdapters := StrToBool(sltbInfo.FieldByName['fldEnableAllNics']);
        HostInfo.iReEnableAfterMins := 0; //default
        HostInfo.sReEnableTime := sltbInfo.FieldByName['fldReEnableTime'];

        if HostInfo.bReEnableAdapters then
        begin
          if HostInfo.sReEnableTime <> '0' then
          begin
            if IsStrFloatNum(HostInfo.sReEnableTime) then
            begin
              HostInfo.iReEnableAfterMins := Round(StrToFloat(HostInfo.sReEnableTime) * 60);
            end
            else
            begin
              HostInfo.iReEnableAfterMins := StrToInt(HostInfo.sReEnableTime);
            end;
          end
          else
          begin
            HostInfo.iReEnableAfterMins := 0;
          end;
        end;

        if HostInfo.bEnableAllAdapters and HostInfo.bDisableAllAdapters then
        begin
          //hmmm, both are set to TRUE...not possible...leave them both unchecked...no soup for you!
          HostInfo.bEnableAllAdapters := False;
          HostInfo.bDisableAllAdapters := False;
        end;

        SetLength(HostInfo.arrAdapterGuids, 0); //erase
        ms := TMemoryStream.Create;

        sSQL := 'SELECT fldNicDetails From "' + INFO_TABLE +
          '" WHERE fldGroup = "' + sGroupname + '" AND fldHostname = "' + sHostname + '";';

        GetSqlUnicodeTableByQuery(sltbU, sSQL);

        try
          ms := sltbU.FieldAsBlob(sltbU.FieldIndex['fldNicDetails']);
          if Assigned(ms) then
          begin
            i := 0;
            //default
            try
              ms.ReadBuffer(i, 4);
              //get # of elements
              SetLength(MgNicArray, i);
              try
                ms.ReadBuffer(Pointer(MgNicArray)^, (Length(MgNicArray) * SizeOf(TRemoteNic)) +
                  4);
              except on e: Exception do
                begin
                  //
                end;
              end;

              slGuids := TStringList.Create;
              try
                //PopulateNicDetailListView(MgNicArray, bEnableAll, bDisableAll);
                for idx := 0 to Length(MgNicArray) - 1 do
                begin
                  if Length(Trim(MgNicArray[idx].sGuid)) > 0 then
                    //MgNicArray[idx].bEnableAdapter or MgNicArray[idx].bDisableAdapter then
                  begin
                    //
                    bEn := False; //dfeault
                    bDis := False; //default

                    bEn := MgNicArray[idx].bEnableAdapter;
                    bDis := MgNicArray[idx].bDisableAdapter;

                    if ((not bEn) and (not bDis)) then
                    begin
                      continue;
                    end;

                    HostInfo.bModifySomeAdapterState := True;
                    slGuids.Add(MgNicArray[idx].sGuid + '=' + BoolToStr(bEn));
                    //if true the adapter is enabled, if false it is disabled
                  end;
                end;

                SetLength(HostInfo.arrAdapterGuids, slGuids.Count);

                for idx := 0 to slGuids.Count - 1 do
                begin
                  HostInfo.arrAdapterGuids[idx] := slGuids[idx];
                end;
              finally
                FreeAndNil(slGuids);
              end;
              //        end;
            except on E: Exception do
              begin
                //suppress
              end;
            end;
          end;
        finally
          FreeAndNil(ms);
          sltbU.Free;
        end;
        //
        sltbInfo.Next;
      end;
    except on E: Exception do
      begin
        //MessageBox(0, PChar(e.Message), '', MB_ICONSTOP or MB_OK);
        OutputDebugString(PChar('error: ' + e.Message));
      end;
    end;
  finally
    if sltbInfo <> nil then
      FreeAndNil(sltbInfo);

    //sldb.Free;
  end;
end;

procedure TfrmMassDeploySvc.lvDeployProgressColumnClick(Sender: TObject;
  Column: TListColumn);
begin
  TListView(Sender).SortType := ComCtrls.stNone;
  if Column.Index <> SortedColMassDeploy then
  begin
    SortedColMassDeploy := Column.Index;
    DescMassDeploy := False;
  end
  else
    DescMassDeploy := not DescMassDeploy;

  TListView(Sender).SortType := ComCtrls.stText; //
end;

procedure TfrmMassDeploySvc.lvDeployProgressCompare(Sender: TObject; Item1,
  Item2: TListItem; Data: Integer; var Compare: Integer);
begin
  if SortedColMassDeploy = 0 then
    Compare := CompareText(Item1.Caption, Item2.Caption)
  else if SortedColMassDeploy <> 0 then
    Compare := CompareText(Item1.SubItems[SortedColMassDeploy - 1],
      Item2.SubItems[SortedColMassDeploy
      - 1]);

  if DescMassDeploy then
    Compare := -Compare;
end;

procedure TfrmMassDeploySvc.btnCloseClick(Sender: TObject);
begin
  if iRunningMassSvcDeployments > 0 then
  begin
    if (MessageBox(0, 'This will kill all currently running and scheduled deployments. ' + #13 + #10
      + '' + #13 + #10 + 'Do you want to cancel all deployments and close this window?',
      'Confirm cancellation of all deployments', MB_ICONWARNING or MB_YESNO or MB_TASKMODAL or
      MB_TOPMOST or MB_DEFBUTTON2) = IDYES) then
    begin
      //now close the form and cancel the deployments
      lvDeployProgress.Clear;
      bDone := True;
      if Assigned(thrdDeploySvc) then
      begin
        uThrdAbortThreads.TAbortThreads.Create(Addr(thrdDeploySvc)); //kill old threads
      end;
      //
      StatusBar1.Panels[0].Text := 'Deployments cancelled.';
      ProgressBar1.Enabled := False;
      Close;
    end;
  end
  else
  begin
    //close form
    lvDeployProgress.Clear;
    bDone := True;
    if Assigned(thrdDeploySvc) then
    begin
      uThrdAbortThreads.TAbortThreads.Create(Addr(thrdDeploySvc)); //kill old threads
    end;
    ProgressBar1.Enabled := False;
    Close;
  end;
end;

procedure TfrmMassDeploySvc.btnExportToCSVClick(Sender: TObject);
var
  saveDialog                  : TSaveDialog; // Save dialog variable
  sToWrite                    : string;
begin
  // Create the save dialog object - assign to our save dialog variable
  saveDialog := TSaveDialog.Create(self);
  try
    // Give the dialog a title
    saveDialog.Title := 'Save your password';
    saveDialog.InitialDir := GetCurrentDir;
    saveDialog.Filter := 'Comma Separated Values|*.csv';
    saveDialog.DefaultExt := 'csv';
    saveDialog.FilterIndex := 1;
    saveDialog.OptionsEx := [ofExNoPlacesBar];

    // Display the open file dialog
    if saveDialog.Execute then
    begin
      uHelpers.ListViewToCSV(lvDeployProgress, saveDialog.FileName);
    end
    else
    begin
      Exit;
    end;
  finally
    FreeAndNil(saveDialog);
  end;
end;

procedure TfrmMassDeploySvc.DeploymentsDone;
begin
  //
  bDone := True;
  if Assigned(thrdDeploySvc) then
  begin
    uThrdAbortThreads.TAbortThreads.Create(Addr(thrdDeploySvc)); //kill old threads
  end;
  //
  StatusBar1.Panels[0].Text := 'Deployments complete.';
  ProgressBar1.Enabled := False;
end;

procedure TfrmMassDeploySvc.ExecuteWork;
var
  sCurHost                    : string;
  HostParams                  : TCmdParams;
  extReEnableTime             : Cardinal;
  sHostIp                     : string;
  sCurGuid                    : string;
  myCurDeployTask             : PRemoteTask;
  msg_prm                     : PWMMgMessageLog;
  CurItem                     : TListItem;
  idx                         : Integer;
  bFoundHost                  : boolean;
begin
  //

{$IFDEF LITE_VERSION}
  bDone := True;
  main.Form1.AvailableInProEdition();
{$ENDIF}

{$IFNDEF LITE_VERSION}
  if not Assigned(FslMachineList) then
  begin
    MessageDlg('Did not receive a list of hosts!', mtError, [mbOK], 0);
    Exit;
  end;

  for sCurHost in FslMachineList do
  begin
    Application.ProcessMessages;
    //GetHostDetailsFromDb(HostParams, sCurHost, FsGroup);
    //this gets password and user message and everything else
    bFoundHost := False; //default

    if lvDeployProgress.Items.Count >= 1 then
    begin
      for idx := 0 to lvDeployProgress.Items.Count - 1 do
      begin
        if SameText(lvDeployProgress.Items[idx].Caption, FsGroup) then
        begin
          if SameText(lvDeployProgress.Items[idx].SubItems[0], sCurHost) then
          begin
            //nothing --- its already here
            bFoundHost := True;
            break;
          end;
        end;
      end;
    end;

    if not bFoundHost then
    begin
      CurItem := lvDeployProgress.Items.Add;
      CurItem.Caption := FsGroup;
      CurItem.SubItems.Add(sCurHost);
      CurItem.SubItems.Add('');
    end;
  end;

  uGlobal.MAX_DEPLOYSVC_THREADS := 4;
  if FslMachineList.Count <= uGlobal.MAX_DEPLOYSVC_THREADS then
  begin
    uGlobal.MAX_DEPLOYSVC_THREADS := FslMachineList.Count;
  end;

  idx := 0;
  iRunningMassSvcDeployments := 0;
  for sCurHost in FslMachineList do
  begin

    GetHostDetailsFromDb(HostParams, sCurHost, FsGroup);
    Application.ProcessMessages;

    if HostParams.bAutoUpdateIp then
    begin
      HostParams.sHostAddr := RetrieveIpForHostAndUpdateDB(sCurHost, FsGroup);
    end;

    if Length(HostParams.sHostAddr) < 1 then
    begin
      sHostIp := sCurHost; //just set it to the host name since no IP specified
    end
    else
    begin
      sHostIp := Trim(HostParams.sHostAddr);
    end;

    if Length(sHostIp) < 1 then
    begin

      New(msg_prm);
      msg_prm.host := sCurHost;
      msg_prm.group := FsGroup;
      msg_prm.msg := 'error: could not retrieve hostname or IP address';

      if not PostMessage(Self.Handle, WM_POSTED_MSG, WM_THRD_DEPLOYSVC_PROCESS_LOG,
        integer(msg_prm)) then
      begin
        Sleep(35);
        PostMessage(Self.Handle, WM_POSTED_MSG, WM_THRD_DEPLOYSVC_PROCESS_LOG, integer(msg_prm));
        if not PostMessage(Self.Handle, WM_POSTED_MSG, WM_THRD_DEPLOYSVC_PROCESS_LOG,
          integer(msg_prm)) then
        begin
          Sleep(35);
          if not PostMessage(Self.Handle, WM_POSTED_MSG, WM_THRD_DEPLOYSVC_PROCESS_LOG,
            integer(msg_prm)) then
          begin
            Dispose(msg_prm);
          end;
        end;
      end;

      continue;
    end;

    HostParams.sHostAddr := sHostIp;
    HostParams.sHostName := sCurHost;
    HostParams.sGroup := FsGroup;
    HostParams.bPingTheHost := True;
    //
    HostParams.bUseCimv2 := False; //works on all OS
    //uGlobal.MAX_DEPLOYSVC_THREADS := 4; //we only need 1

    New(myCurDeployTask);
    myCurDeployTask.Params := HostParams;

    if not Assigned(thrdDeploySvc) then
    begin
      thrdDeploySvc := TDeploySvc.Create(Self.Handle);
    end;

    thrdDeploySvc.BeginWork(myCurDeployTask);
    InterlockedIncrement(iRunningMassSvcDeployments);
  end;

  bAllScheduled := True;

  StatusBar1.Panels[0].Text := 'Remaining deployments: ' +
    IntToStr(iRunningMassSvcDeployments);

  while not bDone do
  begin
    Application.ProcessMessages();
  end;
{$ENDIF}
end;

procedure TfrmMassDeploySvc.FormActivate(Sender: TObject);
begin

  //{$IFNDEF LITE_VERSION}
  lvDeployProgress.Clear;
  iRunningMassSvcDeployments := 0; //default
  bDone := False;
  bAllScheduled := False;
  bCloseForm := False;

  ExecuteWork;
  //{$ENDIF}
end;

procedure TfrmMassDeploySvc.ThreadMessage(var Msg: TMessage);
var
  msg_deploysvc               : PWMDeploySvcCommand;
  idx                         : integer;
  CurItem                     : TListItem;
  sGroup, sHost, sMsg         : string;
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
        //Timer1.Enabled := False;
      end;
    WM_THRD_DEPLOYSVC_DONE:
      begin
        begin
          msg_deploysvc := PWMDeploySvcCommand(Msg.LParam);
          try
            if ((Length(msg_deploysvc.group) > 0) and (Length(msg_deploysvc.host) > 0)) then
            begin
              //
              sGroup := Trim(msg_deploysvc.group);
              sHost := Trim(msg_deploysvc.host);
              sMsg := Trim(msg_deploysvc.result);

              if lvDeployProgress.Items.Count >= 1 then
              begin
                for idx := 0 to lvDeployProgress.Items.Count - 1 do
                begin
                  if SameText(lvDeployProgress.Items[idx].Caption, sGroup) then
                  begin
                    if SameText(lvDeployProgress.Items[idx].SubItems[0], sHost) then
                    begin
                      lvDeployProgress.Items[idx].SubItems[1] := sMsg;
                      break;
                    end;
                  end;
                end;
              end
              else
              begin
                CurItem := lvDeployProgress.Items.Add;
                CurItem.Caption := sGroup;
                CurItem.SubItems.Add(sHost);
                CurItem.SubItems.Add(sMsg);
              end;

              //updates the DB for this host's deployment history
              uHelpers.UpdateDeployResult(sHost, sGroup, sMsg);

              //
              InterlockedDecrement(iRunningMassSvcDeployments);

              StatusBar1.Panels[0].Text := 'Remaining deployments: ' +
                IntToStr(iRunningMassSvcDeployments);

              if iRunningMassSvcDeployments <= 0 then
              begin
                if bAllScheduled then
                begin
                  DeploymentsDone();
                end;
              end;
            end;
          finally
            Dispose(msg_deploysvc);
          end;
        end;
      end;
    WM_THRD_DEPLOYSVC_PROCESS_LOG:
      //
      // This is sent by the any thread when it is ready to show a status
      //
      begin
        msg_deploysvc := PWMDeploySvcCommand(Msg.LParam);
        try
          if ((Length(msg_deploysvc.group) > 0) and (Length(msg_deploysvc.host) > 0)) then
          begin
            //
            sGroup := Trim(msg_deploysvc.group);
            sHost := Trim(msg_deploysvc.host);
            sMsg := Trim(msg_deploysvc.result);

            if lvDeployProgress.Items.Count >= 1 then
            begin
              for idx := 0 to lvDeployProgress.Items.Count - 1 do
              begin
                if SameText(lvDeployProgress.Items[idx].Caption, sGroup) then
                begin
                  if SameText(lvDeployProgress.Items[idx].SubItems[0], sHost) then
                  begin
                    lvDeployProgress.Items[idx].SubItems[1] := sMsg;
                    break;
                  end;
                end;
              end;
            end
            else
            begin
              CurItem := lvDeployProgress.Items.Add;
              CurItem.Caption := sGroup;
              CurItem.SubItems.Add(sHost);
              CurItem.SubItems.Add(sMsg);
            end;
          end;

        finally
          Dispose(msg_deploysvc);
        end;
      end;
  end;
  inherited;
end;

procedure TfrmMassDeploySvc.Timer1Timer(Sender: TObject);
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

