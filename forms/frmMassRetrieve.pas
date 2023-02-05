unit frmMassRetrieve;

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
  main,
  ExtCtrls,
  ComCtrls,
  Graphics;

type
  TfrmMassRetrieveInfo = class(TForm)
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
    procedure RetrievalsDone();
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
  frmMassRetrieveInfo         : TfrmMassRetrieveInfo;
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
  uthrdRetrieveHostInfo,
  uThrdAbortThreads;

procedure TfrmMassRetrieveInfo.GetHostDetailsFromDb(var HostInfo: TCmdParams; const sHostname,
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
      Application.ProcessMessages;

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
              //SetCheckedListboxState(lbIpAddresses, i, False);
              Application.ProcessMessages;
            end
            else
            begin
              HostInfo.sHostAddr := slIpAddresses.Names[i];
              Application.ProcessMessages;
            end;
          end;
        finally
          FreeAndNil(slIpAddresses);
        end;

        HostInfo.bAltCreds := StrToBool(sltbInfo.FieldByName['fldUseAltUser']);
        //bShowUserMessage := False; //default
        HostInfo.bDisplayUserMessage := False; //default
        HostInfo.sUserMessage := ''; //default
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

        //
        Application.ProcessMessages;
        sltbInfo.Next;
      end;
    except on E: Exception do
      begin
        OutputDebugString(PChar('error: ' + e.Message));
      end;
    end;
  finally
    if sltbInfo <> nil then
      FreeAndNil(sltbInfo);
  end;
  Application.ProcessMessages;
end;

procedure TfrmMassRetrieveInfo.lvDeployProgressColumnClick(Sender: TObject;
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

procedure TfrmMassRetrieveInfo.lvDeployProgressCompare(Sender: TObject; Item1,
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

procedure TfrmMassRetrieveInfo.btnCloseClick(Sender: TObject);
var
  iCount                      : integer;
begin
  //crit_GetAutoStart.Enter;
  iCount := iRunningHostRetrievals;
  //crit_GetAutoStart.Leave;
  if iCount > 0 then
  begin
    if (MessageBox(0, 'This will kill all currently running and scheduled retrievals. ' + #13 + #10
      + '' + #13 + #10 + 'Do you want to cancel all retrievals and close this window?',
      'Confirm cancellation of all retrievals', MB_ICONWARNING or MB_YESNO or MB_TASKMODAL or
      MB_TOPMOST or MB_DEFBUTTON2) = IDYES) then
    begin
      //now close the form and cancel the deployments
      lvDeployProgress.Clear;
      bDone := True;
      if Assigned(thrdRetrieveHostInfo) then
      begin
        uThrdAbortThreads.TAbortThreads.Create(Addr(thrdRetrieveHostInfo)); //kill old threads
      end;
      //
      StatusBar1.Panels[0].Text := 'Retrievals cancelled.';
      ProgressBar1.Enabled := False;
      bCloseForm := True;
      Close;
    end;
  end
  else
  begin
    //close form
    lvDeployProgress.Clear;
    bDone := True;
    if Assigned(thrdRetrieveHostInfo) then
    begin
      uThrdAbortThreads.TAbortThreads.Create(Addr(thrdRetrieveHostInfo)); //kill old threads
    end;
    ProgressBar1.Enabled := False;
    bCloseForm := True;
    Close;
  end;
end;

procedure TfrmMassRetrieveInfo.RetrievalsDone;
begin
  //
  bDone := True;
  if Assigned(thrdRetrieveHostInfo) then
  begin
    uThrdAbortThreads.TAbortThreads.Create(Addr(thrdRetrieveHostInfo)); //kill old threads
  end;
  //
  StatusBar1.Panels[0].Text := 'Retrievals complete.';
  ProgressBar1.Enabled := False;
end;

procedure TfrmMassRetrieveInfo.btnExportToCSVClick(Sender: TObject);
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

procedure TfrmMassRetrieveInfo.ExecuteWork;
var
  sCurHost                    : string;
  sHostIp                     : string;
  HostParams                  : TCmdParams;
  myCurTask                   : PRemoteTask;
  msg_prm                     : PWMMgMessageLog; // PWMRetrieveInfoCmd;
  CurItem                     : TListItem;
  idx, iCount                 : Integer;
  bFoundHost                  : boolean;
begin
  //

//{$IFDEF LITE_VERSION}
//  bDone := True;
//  main.Form1.AvailableInProEdition();
//{$ENDIF}

//{$IFNDEF LITE_VERSION}
  if not Assigned(FslMachineList) then
  begin
    MessageDlg('Did not receive a list of hosts!', mtError, [mbOK], 0);
    Exit;
  end;

  for sCurHost in FslMachineList do
  begin
    Application.ProcessMessages;
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

  uGlobal.MAX_RETRIVE_HOST_INFO_THREADS := 4;
  if FslMachineList.Count < uGlobal.MAX_RETRIVE_HOST_INFO_THREADS then
  begin
    uGlobal.MAX_RETRIVE_HOST_INFO_THREADS := FslMachineList.Count;
  end;

  idx := 0;
  //crit_GetAutoStart.Enter;
  iRunningHostRetrievals := 0;
  //crit_GetAutoStart.Leave;

  for sCurHost in FslMachineList do
  begin
    Application.ProcessMessages;
    GetHostDetailsFromDb(HostParams, sCurHost, FsGroup); //get info for this host from DB

    if HostParams.bAutoUpdateIp then
    begin
      HostParams.sHostAddr := RetrieveIpForHostAndUpdateDB(sCurHost, FsGroup);
    end;

    Application.ProcessMessages;

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

      if not PostMessage(Self.Handle, WM_POSTED_MSG, WM_THRD_RETRIEVE_HOST_DONE,
        integer(msg_prm)) then
      begin
        Sleep(35);
        PostMessage(Self.Handle, WM_POSTED_MSG, WM_THRD_RETRIEVE_HOST_DONE, integer(msg_prm));
        if not PostMessage(Self.Handle, WM_POSTED_MSG, WM_THRD_RETRIEVE_HOST_DONE,
          integer(msg_prm)) then
        begin
          Sleep(35);
          if not PostMessage(Self.Handle, WM_POSTED_MSG, WM_THRD_RETRIEVE_HOST_DONE,
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

    New(myCurTask);
    myCurTask.Params := HostParams;

    if not Assigned(thrdRetrieveHostInfo) then
    begin
      thrdRetrieveHostInfo := TRetrieveHostInfo.Create(Self.Handle);
    end;

    thrdRetrieveHostInfo.BeginWork(myCurTask);
    InterlockedIncrement(iRunningHostRetrievals);

    StatusBar1.Panels[0].Text := 'Remaining retrievals: ' +
      IntToStr(iRunningHostRetrievals);

    Application.ProcessMessages;

  end;

  bAllScheduled := True;

  iCount := 1; //default
  //crit_GetAutoStart.Enter;
  iCount := iRunningHostRetrievals;
  //crit_GetAutoStart.Leave;

  StatusBar1.Panels[0].Text := 'Remaining retrievals: ' +
    IntToStr(iCount);

  while not bDone do
  begin
    //Sleep(500);
    Application.ProcessMessages();
  end;
  //{$ENDIF}
end;

procedure TfrmMassRetrieveInfo.FormActivate(Sender: TObject);
begin

  lvDeployProgress.Clear;

  //crit_GetAutoStart.Enter;
  iRunningHostRetrievals := 0; //default
  //crit_GetAutoStart.Leave;

  bDone := False;
  bAllScheduled := False;
  bCloseForm := False;

  ExecuteWork;

end;

procedure TfrmMassRetrieveInfo.ThreadMessage(var Msg: TMessage);
var
  msg_retriveinfo             : PWMMgMessageLog;
  idx                         : integer;
  CurItem                     : TListItem;
  sGroup, sHost, sMsg         : string;
  iCount                      : integer;
begin
  case Msg.WParam of
    WM_PROGRESS_FORM_CLOSE:
      begin
        bDone := True;
        bCloseForm := True;
        Application.ProcessMessages;
        Close;
      end;
    WM_PROGRESS_FORM_STOP:
      begin
        bDone := True;
        Application.ProcessMessages;
        //Timer1.Enabled := False;
      end;
    WM_THRD_RETRIEVE_HOST_DONE:
      begin
        // This is sent by the any thread when it is ready to show a status
        Application.ProcessMessages;
        try
          msg_retriveinfo := PWMMgMessageLog(Msg.LParam);
          try
            if not bCloseForm then
            begin
              if ((Length(msg_retriveinfo.group) > 0) and (Length(msg_retriveinfo.host) > 0)) then
              begin
                //
                sGroup := Trim(msg_retriveinfo.group);
                sHost := Trim(msg_retriveinfo.host);
                sMsg := Trim(msg_retriveinfo.msg);

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

                InterlockedDecrement(iRunningHostRetrievals);

                iCount := 1; //default
                //crit_GetAutoStart.Enter;
                iCount := iRunningHostRetrievals;
                //crit_GetAutoStart.Leave;

                StatusBar1.Panels[0].Text := 'Remaining retrievals: ' +
                  IntToStr(iCount);

                if iCount <= 0 then
                begin
                  if bAllScheduled then
                  begin
                    RetrievalsDone();
                  end;
                end;
              end;
            end;
          finally
            Dispose(msg_retriveinfo);
          end;
        except on E: Exception do
          begin
            //
            //ShowMessage('exception: ' + E.Message);
          end;
        end;
      end;
    WM_THRD_RETRIEVE_HOST_INFO:
      //
      // This is sent by the any thread when it is ready to show a status
      //
      begin
        Application.ProcessMessages;
        msg_retriveinfo := PWMMgMessageLog(Msg.LParam);
        try
          try
            if not bCloseForm then
            begin
              if ((Length(msg_retriveinfo.group) > 0) and (Length(msg_retriveinfo.host) > 0)) then
              begin
                //
                sGroup := Trim(msg_retriveinfo.group);
                sHost := Trim(msg_retriveinfo.host);
                sMsg := Trim(msg_retriveinfo.msg);

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
            end;
          except on E: Exception do
            begin
              //
            end;
          end;
        finally
          Dispose(msg_retriveinfo);
        end;
      end;
  end;
  inherited;
end;

procedure TfrmMassRetrieveInfo.Timer1Timer(Sender: TObject);
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

  //Application.ProcessMessages;

  if bCloseForm then
  begin
    Close;
  end;
end;

end.

