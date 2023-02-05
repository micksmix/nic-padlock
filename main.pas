unit main;
{$I nldefine.inc}

{$WEAKLINKRTTI ON}
{$RTTI EXPLICIT METHODS([]) PROPERTIES([]) FIELDS([])}

interface

uses
  Windows,
  SQLiteTable3,
  SysUtils,
  Classes,
  Controls,
  Forms,
  Dialogs,
  StdCtrls,
  Buttons,
  ExtCtrls,
  ComCtrls,
  CommCtrl,
  amSplitter,
  Menus,
  ActiveX,
  ActnMan,
  StdActns,
  ActnMenus,
  VirtualTrees,
  uGlobal,
  UxTheme,
  Messages,
  CheckLst,
  DB,
  Graphics,
  //IPMask,
  ActnList,
  ImgList,
  SyncObjs,
  ShellAnimations,
  Spin,
  frmDeployProgress,
  LbCipher,
  LbString,
  ToolWin,
  XPStyleActnCtrls,
  IPMask,
  JvExControls,
  JvButton,
  JvTransparentButton, System.Actions;

type
  TForm1 = class(TForm)
    chkDisableAllAdapters: TCheckBox;
    chkEnableAllAdapters: TCheckBox;
    panelStringTree: TPanel;
    Splitter1: TSplitter;
    Images: TImageList;
    vstPopupMenu: TPopupMenu;
    Addsinglecomputer1: TMenuItem;
    Addmultiplecomputers1: TMenuItem;
    panelHostDetail: TPanel;
    Removecomputer1: TMenuItem;
    ActionManager1: TActionManager;
    FileExit1: TFileExit;
    AddNewGroup1: TMenuItem;
    RemoveGroup1: TMenuItem;
    vst1: TVirtualStringTree;
    lblHost: TLabel;
    lblGroup: TLabel;
    pnlSysInfo: TPanel;
    lblSysInfoHostname: TLabel;
    lblSysInfoModel: TLabel;
    lblSysInfoUsername: TLabel;
    lblSysInfoDomain: TLabel;
    lblSysInfoManufacturer: TLabel;
    lblSysInfoPrimaryOwnerName: TLabel;
    lblSysInfoSystemType: TLabel;
    lblSysInfoTotalPhysMem: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    lvRemoteNics: TListView;
    panelGeneralInfo: TPanel;
    btnApplyConfigToGroup: TButton;
    lblLastRefreshed: TLabel;
    lblGroupHosts: TLabel;
    lvGroupHosts: TListView;
    panelNetworkInfo: TPanel;
    grpNetworkInfoHosts: TGroupBox;
    Label9: TLabel;
    Label10: TLabel;
    lvMultipleComputers: TListView;
    edtIpStart: TIPMask;
    btnScanSubnet: TButton;
    StatusBar1: TStatusBar;
    Animate1: TAnimate;
    btnCancelScan: TButton;
    edtIpEnd: TIPMask;
    btnAddChecked: TButton;
    cbGroups: TComboBox;
    Label11: TLabel;
    GroupBox2: TGroupBox;
    lblNumGroups: TLabel;
    lblNumHosts: TLabel;
    PopUpMultipleComputerScan: TPopupMenu;
    puCheckAll: TMenuItem;
    puCheckNone: TMenuItem;
    PopUpGroupHosts: TPopupMenu;
    CheckAll_GroupHosts: TMenuItem;
    CheckNone_GroupHosts: TMenuItem;
    PageControl1: TPageControl;
    Tab01_NetworkInfo: TTabSheet;
    Tab02_GeneralInfo: TTabSheet;
    Tab03_HostDetail: TTabSheet;
    cbReEnableAdapters: TCheckBox;
    seHoursMinutes: TSpinEdit;
    rbMinutes: TRadioButton;
    rbHours: TRadioButton;
    btnResetScan: TButton;
    actnRefreshHost: TAction;
    actnSaveHost: TAction;
    Action1: TAction;
    actnFileMenu: TAction;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Exit1: TMenuItem;
    SaveHostChanges1: TMenuItem;
    Tools1: TMenuItem;
    ChangePassword1: TMenuItem;
    actnChangePassword: TAction;
    Label12: TLabel;
    lblNoHostsInGroup: TLabel;
    lblNetworkScanHostsInfo: TLabel;
    panelNetworkScanHostsInfo: TPanel;
    AddMultipleComputers2: TMenuItem;
    Addnewgroup2: TMenuItem;
    panelNoHostsInGroup: TPanel;
    Label13: TLabel;
    lblSysInfoWindowsVersion: TLabel;
    Panel1: TPanel;
    Image1: TImage;
    Panel2: TPanel;
    Image2: TImage;
    Panel3: TPanel;
    Image3: TImage;
    Label14: TLabel;
    actnDeploySvc: TAction;
    actnUseAlternateCreds: TAction;
    Help1: TMenuItem;
    About1: TMenuItem;
    lblRemoteIpAddress: TLabel;
    mmoDeploymentResult: TMemo;
    actnModifyIpAddress: TAction;
    actnUserMessage: TAction;
    Label15: TLabel;
    lblUserMessageVisible: TLabel;
    Label16: TLabel;
    lblUserCredentialsType: TLabel;
    tlb1: TToolBar;
    btnChangePassword: TToolButton;
    btnAddNewGroup: TToolButton;
    actAddNewGroup: TAction;
    actAddOneComputer: TAction;
    btnAddOneComputer: TToolButton;
    actAddMultipleComputers: TAction;
    btnAddMultipleComputers: TToolButton;
    btnRemoveComputer: TToolButton;
    actnRemoveComputer: TAction;
    actnRemoveGroup: TAction;
    btnRemoveGroup: TToolButton;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    btnImportHosts: TButton;
    mmoImportInfo: TMemo;
    Addacomputer1: TMenuItem;
    Removecomputer2: TMenuItem;
    Removegroup2: TMenuItem;
    actnPingTheHost: TAction;
    actnAutoUpdateIp: TAction;
    btnGetSysInfoList: TButton;
    sbGeneralInfo: TStatusBar;
    btnDeployToCheckedHosts: TButton;
    pgcMultipleHosts: TPageControl;
    tsMassSettings: TTabSheet;
    tsMassActions: TTabSheet;
    actnRenameComputer: TAction;
    btnRenameComputer: TToolButton;
    Renamecomputer1: TMenuItem;
    pgcHostDiscovery: TPageControl;
    tsImportHosts: TTabSheet;
    tsNbtScanHosts: TTabSheet;
    HostSpecificActions1: TMenuItem;
    ModifyIPAddress1: TMenuItem;
    ShowUserMessage1: TMenuItem;
    SetCredentials1: TMenuItem;
    PingHost2: TMenuItem;
    AutoUpdatehostsIPaddress1: TMenuItem;
    DeployNicLocker1: TMenuItem;
    Retrievehostdetails1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    lblSysInfoSerial: TLabel;
    Label18: TLabel;
    actnLocateHostRecord: TAction;
    ToolButton3: TToolButton;
    btnLocateHost: TToolButton;
    Locateahostsrecord1: TMenuItem;
    Renamecomputer2: TMenuItem;
    N5: TMenuItem;
    grpConfigurationOptions: TGroupBox;
    pgcMultipleConfigOptions: TPageControl;
    tsPage1: TTabSheet;
    cbGroupHostsDisableAll: TCheckBox;
    cbGroupHostsEnableAll: TCheckBox;
    cbGroupHostsReEnableAfter: TCheckBox;
    rbGroupHostsHours: TRadioButton;
    rbGroupHostsMinutes: TRadioButton;
    seGroupHostsHoursMinutes: TSpinEdit;
    chkAutoUpdateIp: TCheckBox;
    grpLine: TGroupBox;
    tsCredentials: TTabSheet;
    lblGroupHostsCredUser: TLabeledEdit;
    chkShowPass: TCheckBox;
    cbGroupHostsUseAltCreds: TCheckBox;
    lblGroupHostsCredPass: TLabeledEdit;
    tsMessage: TTabSheet;
    cbGroupHostsDisplayMsg: TCheckBox;
    memoUserMessage: TMemo;
    Registration1: TMenuItem;
    tmr1: TTimer;
    pmHostActions: TPopupMenu;
    Savechanges1: TMenuItem;
    ModifyIPAddress2: TMenuItem;
    ShowUserMessage2: TMenuItem;
    SetCredentials2: TMenuItem;
    PingHost1: TMenuItem;
    AutoUpdatehostsIPaddress2: TMenuItem;
    pmClearHostHistory: TPopupMenu;
    Clearthisdeploymentlog1: TMenuItem;
    actnClearHostHistory: TAction;
    actHostActionsDropDown: TAction;
    ToolBar1: TToolBar;
    btnHostActions: TToolButton;
    btnnRefreshHost: TToolButton;
    btnnDeploySvc: TToolButton;
    pgc1: TPageControl;
    ts1: TTabSheet;
    tsAutoStart: TTabSheet;
    lvAutoStartApplications: TListView;
    grpModifyNicOptions: TGroupBox;
    chkModifyNicOptions: TCheckBox;
    grpModifyCredentials: TGroupBox;
    chkModifyCredentials: TCheckBox;
    grpModifyUserMessage: TGroupBox;
    chkModifyUserMessage: TCheckBox;
    OnlineHelp1: TMenuItem;
    N6: TMenuItem;
    CheckforUpdates1: TMenuItem;
    btnnDeploySvc1: TJvTransparentButton;
    btnnDeploySvc2: TJvTransparentButton;
    btnnDeploySvc3: TJvTransparentButton;
    btnnDeploySvc4: TJvTransparentButton;
    btnnDeploySvc5: TJvTransparentButton;
    btnnDeploySvc6: TJvTransparentButton;
    procedure vst1GetNodeDataSize(Sender: TBaseVirtualTree;
      var NodeDataSize: Integer);
    procedure vst1FreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure vst1GetImageIndex(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Kind: TVTImageKind; Column: TColumnIndex; var Ghosted: Boolean;
      var ImageIndex: Integer);
    procedure vst1DragOver(Sender: TBaseVirtualTree; Source: TObject;
      Shift: TShiftState; State: TDragState; Pt: TPoint; Mode: TDropMode;
      var Effect: Integer; var Accept: Boolean);
    procedure vst1DragDrop(Sender: TBaseVirtualTree; Source: TObject;
      DataObject: IDataObject; Formats: TFormatArray; Shift: TShiftState;
      Pt: TPoint; var Effect: Integer; Mode: TDropMode);
    procedure vst1DragAllowed(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; var Allowed: Boolean);
    procedure vst1ContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure vst1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure vst1GetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    //    procedure btnAddIpAddrClick(Sender: TObject);
    procedure grpAlternateCredsCheckBoxClick(Sender: TObject);
    procedure lvRemoteNicsCompare(Sender: TObject; Item1, Item2: TListItem;
      Data: Integer; var Compare: Integer);
    procedure lvRemoteNicsColumnClick(Sender: TObject; Column: TListColumn);
    procedure chkEnableAllAdaptersClick(Sender: TObject);
    procedure chkDisableAllAdaptersClick(Sender: TObject);
    procedure lvRemoteNicsItemChecked(Sender: TObject; Item: TListItem);
    procedure lblCredUser2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lblCredPass2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lvRemoteNicsDrawItem(Sender: TCustomListView; Item: TListItem;
      Rect: TRect; State: TOwnerDrawState);
    procedure ListView1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure vst1Change(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure btnApplyConfigToGroupClick(Sender: TObject);
    procedure lvGroupHostsColumnClick(Sender: TObject; Column: TListColumn);
    procedure lvGroupHostsCompare(Sender: TObject; Item1, Item2: TListItem;
      Data: Integer; var Compare: Integer);
    procedure cbGroupHostsUseAltCredsClick(Sender: TObject);
    procedure cbGroupHostsEnableAllClick(Sender: TObject);
    procedure cbGroupHostsDisableAllClick(Sender: TObject);
    procedure btnAddCheckedClick(Sender: TObject);
    procedure btnScanSubnetClick(Sender: TObject);
    procedure btnCancelScanClick(Sender: TObject);
    procedure btnCustomizeAdaptersClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure puCheckAllClick(Sender: TObject);
    procedure puCheckNoneClick(Sender: TObject);
    procedure lvMultipleComputersColumnClick(Sender: TObject;
      Column: TListColumn);
    procedure lvMultipleComputersCompare(Sender: TObject; Item1,
      Item2: TListItem; Data: Integer; var Compare: Integer);
    procedure CheckAll_GroupHostsClick(Sender: TObject);
    procedure CheckNone_GroupHostsClick(Sender: TObject);
    procedure Splitter1Moved(Sender: TObject);
    procedure cbReEnableAdaptersClick(Sender: TObject);
    procedure rbMinutesClick(Sender: TObject);
    procedure rbHoursClick(Sender: TObject);
    procedure cbGroupHostsReEnableAfterClick(Sender: TObject);
    procedure edtIpEndEnter(Sender: TObject);
    procedure btnResetScanClick(Sender: TObject);
    procedure File1Click(Sender: TObject);
    procedure actnRefreshHostExecute(Sender: TObject);
    procedure actnChangePasswordExecute(Sender: TObject);
    procedure actnSaveHostExecute(Sender: TObject);
    procedure actnDeploySvcExecute(Sender: TObject);
    procedure btnDisplayEditUserMessageClick(Sender: TObject);
    procedure cbGroupHostsDisplayMsgClick(Sender: TObject);
    procedure cbGroupHostsNoUserMsgChangeClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure vst1FocusChanged(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex);
    procedure actnModifyIpAddressExecute(Sender: TObject);
    procedure actnUserMessageExecute(Sender: TObject);
    procedure actnUseAlternateCredsExecute(Sender: TObject);
    procedure actAddNewGroupExecute(Sender: TObject);
    procedure actAddOneComputerExecute(Sender: TObject);
    procedure actAddMultipleComputersExecute(Sender: TObject);
    procedure actnRemoveComputerExecute(Sender: TObject);
    procedure actnRemoveGroupExecute(Sender: TObject);
    procedure tlb1CustomDraw(Sender: TToolBar; const ARect: TRect;
      var DefaultDraw: Boolean);
    procedure btnImportHostsClick(Sender: TObject);
    procedure seHoursMinutesChange(Sender: TObject);
    procedure actnPingTheHostExecute(Sender: TObject);
    procedure memoUserMessageKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure mmoDeploymentResultKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure actnAutoUpdateIpExecute(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure vst1Click(Sender: TObject);
    procedure vst1CompareNodes(Sender: TBaseVirtualTree; Node1,
      Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
    procedure btnGetSysInfoListClick(Sender: TObject);
    procedure btnCancelGroupHostsClick(Sender: TObject);
    procedure actnRenameComputerExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure chkShowPassClick(Sender: TObject);
    procedure panelNoHostsInGroupClick(Sender: TObject);
    procedure lblNoHostsInGroupClick(Sender: TObject);
    procedure btnDeployToCheckedHostsClick(Sender: TObject);
    procedure actnLocateHostRecordExecute(Sender: TObject);
    procedure vst1IncrementalSearch(Sender: TBaseVirtualTree;
      Node: PVirtualNode; const SearchText: string; var Result: Integer);
    procedure Registration1Click(Sender: TObject);
    procedure tmr1Timer(Sender: TObject);
    procedure mmoDeploymentResultClick(Sender: TObject);
    procedure actnClearHostHistoryExecute(Sender: TObject);
    procedure btnHostActionsClick(Sender: TObject);
    procedure lvAutoStartApplicationsColumnClick(Sender: TObject;
      Column: TListColumn);
    procedure lvAutoStartApplicationsCompare(Sender: TObject; Item1,
      Item2: TListItem; Data: Integer; var Compare: Integer);
    procedure chkModifyNicOptionsClick(Sender: TObject);
    procedure chkModifyCredentialsClick(Sender: TObject);
    procedure chkModifyUserMessageClick(Sender: TObject);
    procedure pgcHostDiscoveryDrawTab(Control: TCustomTabControl;
      TabIndex: Integer; const Rect: TRect; Active: Boolean);
    procedure OnlineHelp1Click(Sender: TObject);
    procedure CheckforUpdates1Click(Sender: TObject);
  private
    procedure CheckChildNodes(Sender: TBaseVirtualTree; Node: PVirtualNode;
      pText: Pointer; var Abort: Boolean);
    procedure SaveChangesToRecord(const sTheHost, sTheGroup: string);
    procedure ShowNodeDetails(iNodeLevel: Integer; Data: PHostRec);
    procedure SaveVisibleNicDetails(const sTheHost, sTheGroup: string);
    procedure SysDetailClear;
    function DetermineListViewColumn(ListView: TListview; ListItem: TListItem; x: integer): integer;
    procedure EnableAllAdaptersInListview;
    procedure DisableAllAdaptersInListview;
    procedure ReadNicDetailsFromDBAndUpdateGrid(sGroup, sHost: string);
    procedure ReadSysInfoFromDBAndUpdateGrid(sGroup, sHost: string);
    procedure ThreadMessage(var Msg: TMessage); message WM_POSTED_MSG;
    procedure ScanDone;
    procedure AddNewGroup(sValue: string);
    procedure UpdateNetworkSummary;
    procedure ChangeListViewCheckStateAll(ListView: TListView;
      bCheckAll: boolean);
    procedure RefreshHostDetails(sTheHost, sTheGroup: string; bSilent: boolean);
    procedure ShowPassForm(bCreatePass: boolean; sPrevPass: string = '');
    procedure DeploySvcToCurrentVisible;
    procedure ShowUserEditMessage;
    procedure PrepareLaunch;
    procedure DSiProcessThreadMessages;
    procedure ModifyTheHostIpAddress(const sHost, sGroup: string);
    procedure ShowCredentialsForm;
    procedure SetVisualActionStates(var Node: PVirtualNode; iNodeLevel: Integer; const sHost,
      sGroup: string);
    procedure PrepareHostPing;
    procedure DeploySvcToList(sMachineList: TStringList; sTheGroup: string);
    procedure SaveAutoUpdateIp(const sTheHost, sTheGroup: string);
    procedure DSiProcessMessages(hwnd: THandle; waitForWMQuit: boolean);
    procedure HostRetrievalsDone;
    procedure RenameComputer(const sTheHost, sTheGroup, sTheNewName: string);
    procedure SaveGroupState;
    procedure GetHostInfoFromList(sMachineList: TStringList; sTheGroup: string);
    procedure GetDatabaseFullName;
    procedure ShowRegistrationForm;
    procedure PopulateAutorunDisplayFromDb(const sTheGroup, sTheHost: string);
    procedure ToggleNicOptionsPage(bEnable: boolean);
    procedure ToggleCredentialsPage(bEnable: boolean);
    procedure ToggleUserMessagePage(bEnable: Boolean);
    procedure SetTrialState;
    { Private declarations }
  public
    { Public declarations }
    function GetLicInfo(var sUser, sSer: string): boolean;
    procedure GetEncryptedLicenseVal(var sLic: string);
    function IsValidLicenseDb: boolean;
    function SetLicenseStatus(const sUser, sKey: string): boolean;
    procedure AvailableInProEdition;
    function IsValidName(sValue: string): boolean;
    procedure PopulateLastQueriedDisplay(sCustomMsg: string = '');
    function ChangeUserPassDb(sNewPass: string): string;
    procedure CreateTreeViewOnStartup;
    procedure AddHostToVst(sGroup, sHost: string);
    procedure PopulateNicDetailListView(MgNicArray: TRemoteNicArray; bEnableAll: boolean = False;
      bDisableAll: boolean = False);
    procedure PopulateSysDetailMemo(MgSysInfo: TRemoteSysInfoArray);
    procedure StoreAlternateCredentials(bUseAltCreds: boolean; const sEncUser, sEncPass: string;
      sHost: string; sGroup: string);
    procedure SetCheckedState(const checkBox: TCheckBox; const check: boolean);
    procedure SetCheckedListboxState(const checkBox: TCheckListBox; idx: integer; const check:
      boolean);
    procedure SetCheckedRadioBtnState(const radioBtn: TRadioButton;
      const check: boolean);
    procedure SetFieldsChanged(bChanged: boolean);
    procedure RetrieveDbUserMessage(const sGroup, sHost: string;
      var sUserMessage: string; var bShowUserMessage: boolean);
  end;

var
  frmProgress                 : TfrmShowProgress;
  bHostScanAborted            : Boolean;
  bHostInfoRetrieveAborted    : Boolean;
  mHandle                     : THandle; // Mutexhandle
  Form1                       : TForm1;
  bAllChildrenChecked         : Boolean;
  bFieldsChanged              : Boolean = False;
  bFormActivated              : Boolean = False; //default
  sPrevSelNode                : string = '-';
  DescRemoteNics, DescGroupHosts, DescMultipleHosts: Boolean;
  SortedColRemoteNics, SortedColAutostart, SortedColGroupHosts, SortedColMultipleHosts: Integer;
  NetworkNode                 : PVirtualNode; //root node
  bOnMouseFired               : Boolean = False;

const
  SAVE_ICON                   = 7;
  NETWORK_ICON                = 21;
  FOLDER_ICON                 = 9;
  COMPUTER_ICON               = 10;
  COMPUTER_GRAY_ICON          = 11;
  MB_TIMEDOUT                 = 32000;
  NETWORK_LEVEL               = 0;
  FOLDER_LEVEL                = 1;
  HOST_LEVEL                  = 2;
  DETAIL_PANEL_WIDTH          = 590;

function MessageBoxTimeOut(hWnd: HWND; lpText: PChar; lpCaption: PChar; uType: UINT; wLanguageId:
  WORD; dwMilliseconds: DWORD): Integer; stdcall; external user32 name 'MessageBoxTimeoutW';

implementation

{$R *.dfm}

uses
  uHelpers,
  PerlRegex,
  StrUtils,
  uWmiQueries,
  uThrdNbtStat,
  uThrdDeploySvc,
  uThrdAbortThreads,
  uGlobalNetBios,
  uLic,
  LbUtils,
  frmPass,
  frmUserMessage,
  frmChangePass,
  frmAltCreds,
  frmAbout,
  frmRegistration,
  frmModifyIpAddress,
  frmMassRetrieve,
  frmMassDeploy,
  frmImportDeleteHosts,
  frmGetFullVersion,
  uBasicEncrypt,
  AsyncCalls,
  ShellAPI,

  Themes,
  WinSvc;

//var
//  frmProgress                 : TfrmShowProgress;
//  bHostScanAborted            : Boolean;

  //function UpdateRemoteImagePath(RootKey: HKEY; sMachine, sNewImagePathValue: string): boolean;
  //var
  //  Reg               : TRegistry;
  //  RegDataType       : TRegDataType;
  //  s                 : string;
  //  Key, Value        : string;
  //begin
  //  Result := False;                      //default
  //  Key := 'SYSTEM\CurrentControlSet\services\' + SERVICE_NAME;
  //  Value := 'ImagePath';
  //
  //  Reg := TRegistry.Create;
  //  try
  //    try
  //      Reg.RootKey := RootKey;
  //
  //      sMachine := ExcludeTrailingPathDelimiter(sMachine);
  //      if not mgStartsText('\\', sMachine) then
  //      begin
  //        sMachine := '\\' + sMachine;
  //      end;
  //
  //      if Reg.RegistryConnect(sMachine) then
  //      begin
  //        if Reg.KeyExists(Key) then
  //        begin
  //          if Reg.OpenKey(Key, False) then
  //          begin
  //            try
  //              Reg.WriteExpandString(Value, sNewImagePathValue);
  //
  //              RegDataType := Reg.GetDataType(Value);
  //              if (RegDataType = rdString) or (RegDataType = rdExpandString) then
  //              begin
  //                s := Reg.ReadString(Value);
  //                if CompareText(s, sNewImagePathValue) = 0 then
  //                begin
  //                  Result := True;
  //                end;
  //              end;
  //            except
  //              Reg.CloseKey;
  //              //raise; //todo: remove these when completed
  //            end;
  //            Reg.CloseKey;
  //          end
  //          else
  //          begin
  //            Result := False;
  //            //raise Exception.Create(SysErrorMessage(GetLastError));
  //          end;
  //        end;
  //      end;
  //    except
  //      FreeAndNil(Reg);
  //      Result := False;
  //      //raise; //todo: remove these when completed
  //    end;
  //  finally
  //    FreeAndNil(Reg);
  //  end;
  //end;

procedure UninstallService(const sServiceName, sMachine: string; const Silent: Boolean);
const
  cRemoveMsg                  = 'Your service was removed sucesfuly!';
var
  SCManager                   : SC_HANDLE;
  Service                     : SC_HANDLE;
  ServiceStatus               : TServiceStatus;
begin
  SCManager := OpenSCManager(PChar(sMachine), nil, SC_MANAGER_ALL_ACCESS);
  if SCManager = 0 then
    Exit;

  try
    Service := OpenService(SCManager, PChar(sServiceName), SERVICE_ALL_ACCESS);
    ControlService(Service, SERVICE_CONTROL_STOP, ServiceStatus);
    DeleteService(Service);
    CloseServiceHandle(Service);
    if not Silent then
      MessageBox(0, cRemoveMsg, PChar(sServiceName), MB_ICONINFORMATION or MB_OK or MB_TASKMODAL or
        MB_TOPMOST);
  finally
    CloseServiceHandle(SCManager);
  end;
end;

procedure TForm1.HostRetrievalsDone();
begin
  if not bHostInfoRetrieveAborted then
  begin
    //
    btnApplyConfigToGroup.Enabled := True;
    btnDeployToCheckedHosts.Enabled := True;
    btnGetSysInfoList.Enabled := True;
    lvGroupHosts.Enabled := True;
    //
    uThrdAbortThreads.TAbortThreads.Create(Addr(thrdRetrieveHostInfo)); //kill old threads
    //
    sbGeneralInfo.Panels[0].Text :=
      'Completed retrieving host information from the requested hosts.';
    //
    MessageDlg('Completed retrieving host information from the requested hosts.',
      mtInformation, [mbOK], 0);
  end;

  bHostInfoRetrieveAborted := True;

end;

procedure TForm1.ScanDone();
begin
  uThrdAbortThreads.TAbortThreads.Create(Addr(thrdNetBios)); //kill old threads
  uThrdAbortThreads.TAbortThreads.Create(Addr(thrdDeploySvc)); //kill old threads
  //
  StatusBar1.Panels[0].Text := '';
  Animate1.Active := False;
  Animate1.Visible := False;
  btnCancelScan.Enabled := False;
  btnScanSubnet.Enabled := True;
  btnAddChecked.Enabled := True;
  btnResetScan.Enabled := True;
end;

procedure TForm1.seHoursMinutesChange(Sender: TObject);
begin
  //
  SetFieldsChanged(True);
end;

procedure TForm1.ThreadMessage(var Msg: TMessage);
var
  msg_prm                     : PWMUCommand;
  msg_deploysvc               : PWMDeploySvcCommand;
  msg_deploysvc_log           : PWMMgMessageLog;
  msg_retrive_host            : PWMRetrieveInfoCmd;
  Item                        : TListItem;
  slMemo                      : TStringList;
  sDeployResult               : string;
begin
  //
  case Msg.WParam of
    WM_THRD_NBTSCAN_MSG:
      begin
        msg_prm := PWMUCommand(Msg.LParam);
        try
          if msg_prm.bOnline then
          begin
            Item := lvMultipleComputers.Items.Add;

            Item.Caption := ''; //checkbox
            Item.SubItems.Add(msg_prm.ip);
            Item.SubItems.Add(msg_prm.host);
          end;

          InterlockedDecrement(iRunningTasks);
          if not bHostScanAborted then
          begin
            StatusBar1.Panels[0].Text := 'Remaining tasks: ' + IntToStr(iRunningTasks);
          end
          else
          begin
            ScanDone();
          end;

          if iRunningTasks <= 0 then
          begin
            ScanDone();
          end;
        finally
          Dispose(msg_prm);
        end;
      end;
    WM_THRD_RETRIEVE_HOST_INFO:
      begin
        msg_retrive_host := PWMRetrieveInfoCmd(Msg.LParam);
        try
          InterlockedDecrement(iRunningHostRetrievals);

          if not bHostInfoRetrieveAborted then
          begin
            sbGeneralInfo.Panels[0].Text := 'Remaining tasks: ' + IntToStr(iRunningHostRetrievals);
          end
          else
          begin
            HostRetrievalsDone();
          end;

          if iRunningHostRetrievals <= 0 then
          begin
            HostRetrievalsDone();
          end;

        finally
          Dispose(msg_retrive_host);
        end;
      end;
    WM_THRD_DEPLOYSVC_DONE:
      //
      // This is sent by the Deployment thread when it is ready to update the DB with the deployment result
      //
      begin
        msg_deploysvc := PWMDeploySvcCommand(Msg.LParam);
        try
          if ((Length(msg_deploysvc.group) > 0) and (Length(msg_deploysvc.host) > 0)) then
          begin
            try
              try
                //
                sDeployResult := UpdateDeployResult(msg_deploysvc.host, msg_deploysvc.group,
                  msg_deploysvc.result);
                //
                //if the record for this host is currently visible, update the view
                if (SameText(lblHost.Caption, msg_deploysvc.host)
                  and SameText(lblGroup.Caption, msg_deploysvc.group)) then
                begin
                  mmoDeploymentResult.Text := sDeployResult;
                end;

                if Assigned(frmProgress) then
                begin
                  //
                  PostMessage(frmProgress.Handle, WM_PROGRESS_FORM_MSG, WM_PROGRESS_FORM_STOP, 0);
                end;

              finally
                //sldb.Free;
              end;

            finally
              if sltbInfo <> nil then
                FreeAndNil(sltbInfo);

            end;
          end;

          InterlockedDecrement(iRunningSvcDeployments);
          StatusBar1.Panels[0].Text := 'Remaining deployments: ' + IntToStr(iRunningSvcDeployments);

          if iRunningSvcDeployments <= 0 then
          begin
            ScanDone();
          end;
        finally
          Dispose(msg_deploysvc);
        end;

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
            MessageDlg(msg_deploysvc.result, mtWarning, [mbOK], 0);
          end;
        finally
          Dispose(msg_deploysvc);
        end;
      end;
    WM_THRD_DEPLOYSVC_PROCESS_LOG:
      //
      // This is a message to update current host deployment status
      //
      begin
        //
        msg_deploysvc_log := PWMMgMessageLog(Msg.LParam);
        slMemo := TStringList.Create;
        try
          if Assigned(frmProgress) then
          begin
            slMemo.Text := Trim(msg_deploysvc_log.msg);
            frmProgress.Memo1.Lines.Add(msg_deploysvc_log.msg);
            frmProgress.mmoMarquee.Clear;
            frmProgress.mmoMarquee.Lines[0] := slMemo[0];
            frmProgress.mmoMarquee.SelStart := 0;

            //end;
          end;
        finally
          Dispose(msg_deploysvc_log);
          FreeAndNil(slMemo);
        end;
      end;
    WM_THRD_CLOSE_PROCESS_FORM:
      begin
        //
        msg_deploysvc_log := PWMMgMessageLog(Msg.LParam);
        try
          if Assigned(frmProgress) then
          begin
            if msg_deploysvc_log.msg = 'CLOSE_MSG_FORM' then
            begin
              frmProgress.ProgressBar1.Visible := False;
              frmProgress.ProgressBar1.Enabled := False;
              frmProgress.bDone := True;
            end
            else
            begin
              frmProgress.Memo1.Lines.Add(msg_deploysvc_log.msg);
            end;
          end;
        finally
          Dispose(msg_deploysvc_log);
        end;
      end;
  end;
  inherited;
end;

// lets check if trial period is over

procedure TForm1.tlb1CustomDraw(Sender: TToolBar; const ARect: TRect;
  var DefaultDraw: Boolean);
var
  ElementDetails              : TThemedElementDetails;
begin
  if ThemeServices.ThemesEnabled then
  begin
    ElementDetails := ThemeServices.GetElementDetails(trRebarRoot);
    ThemeServices.DrawElement(Sender.Canvas.Handle, ElementDetails, Sender.ClientRect);
  end;
end;

procedure TForm1.tmr1Timer(Sender: TObject);
begin
{$IFNDEF LITE_VERSION}
  if not IsValidLicenseDb then
  begin
    tmr1.Enabled := False;
    MessageBox(Application.Handle, 'This software is not yet registered.' + #13 + #10 + '' + #13 +
      #10 +
      'Please enter the user name and serial number provided when you purchased this software.', '',
      MB_ICONINFORMATION or MB_OK or MB_TASKMODAL or MB_TOPMOST);

    ShowRegistrationForm();

    if not IsValidLicenseDb then
    begin
      Halt;
    end
    else
    begin
      tmr1.Enabled := True;
    end;
  end;
{$ELSE}
  //
 // TrialStatus(15); //
{$ENDIF}

end;

procedure TForm1.actnRemoveComputerExecute(Sender: TObject);
var
  sSQL                        : string;
  Node, ParentNode            : PVirtualNode;
  Data                        : PHostRec;
  frmImportDelProgress        : TfrmImportDeleteProgress;
begin
  Node := vst1.FocusedNode;
  if Assigned(Node) then
  begin
    ParentNode := Node.Parent;
    if Assigned(ParentNode) then
    begin
      if vst1.SelectedCount > 1 then
      begin

        if (MessageBox(0, PChar('Are you sure you want to remove these ' +
          IntToStr(vst1.SelectedCount) +
          ' hosts?'), '',
          MB_ICONQUESTION or MB_YESNO or MB_TASKMODAL or MB_TOPMOST or MB_DEFBUTTON1) <> idYes) then
        begin
          Exit;
        end;

        frmImportDelProgress := TfrmImportDeleteProgress.Create(self);
        try
          frmImportDelProgress.Position := poMainFormCenter;
          frmImportDelProgress.ShowModal;
        finally
          frmImportDelProgress.Release;
          Pointer(frmImportDelProgress) := nil;
        end;

        Exit;
      end;

      Data := vst1.GetNodeData(Node);
      if (MessageBox(0, PChar('Are you sure you want to delete this computer [' + Data.AHostname +
        ']?'), '',
        MB_ICONQUESTION or MB_YESNO or MB_TASKMODAL or MB_TOPMOST or MB_DEFBUTTON1) <> idYes) then
      begin
        Exit;
      end;

      try
        sSQL := 'DELETE FROM ' + INFO_TABLE + ' WHERE fldHostname = "' + Data.AHostname +
          '" AND fldGroup = "'
          + Data.AGroupname + '";';
        ModifySqlTableByQuery(sSQL);
      except on E: Exception do
        begin
          //ShowMessage('error: ' + e.Message);
        end;
      end;
    end;

    vst1.DeleteNode(Node, True);
    vst1.Invalidate();
    vst1.SortTree(0, sdAscending, true);

    UpdateNetworkSummary();
    vst1.FocusedNode := vst1.GetFirstLevel(0);
    vst1.Selected[vst1.GetFirstLevel(0)] := True;
  end;
end;

procedure TForm1.actnRemoveGroupExecute(Sender: TObject);
var
  Node                        : PVirtualNode;
  Data                        : PHostRec;
  sSQL                        : string;
begin

  Node := vst1.FocusedNode;

  if Assigned(Node) then
  begin
    Data := vst1.GetNodeData(Node);
    if (MessageBox(0, PChar('Are you sure you want to delete this group [' + Data.AGroupName +
      ']?'),
      '',
      MB_ICONQUESTION or MB_YESNO or MB_TASKMODAL or MB_TOPMOST or MB_DEFBUTTON1) <> idYes) then
    begin
      Exit;
    end;

    try

      sSQL := 'SELECT fldGroupName From "' + GROUP_TABLE + '"';
      GetSqlTableByQuery(sltbGroups, sSQL);

      sSQL := 'SELECT * From "' + INFO_TABLE + '" WHERE fldGroup = "' + Data.AGroupName + '";';
      GetSqlTableByQuery(sltbInfo, sSQL);

      if sltbInfo.Count > 0 then
      begin
        MessageBox(0, 'This group is not empty. You must remove computers in this group first.',
          'Group is not empty', MB_ICONSTOP or MB_OK or MB_TASKMODAL or MB_TOPMOST or
          MB_DEFBUTTON1);
        //MessageDlg('This group is not empty. You must remove computers in this group first.', mtError,
        //  [mbOK], 0);
        Exit;
      end;

      sSQL := 'DELETE FROM ' + GROUP_TABLE + ' WHERE fldGroupname = "' + Data.AGroupName + '";';

      vst1.DeleteNode(Node, True);
      ModifySqlTableByQuery(sSQL);

      vst1.Invalidate();
      vst1.SortTree(0, sdAscending, true);
    finally
      if sltbGroups <> nil then
        FreeAndNil(sltbGroups);

      if sltbInfo <> nil then
        FreeAndNil(sltbInfo);

    end;

    UpdateNetworkSummary();
  end;
end;

procedure TForm1.RenameComputer(const sTheHost, sTheGroup, sTheNewName: string);
var
  sQuery                      : string;
begin

  sQuery := 'UPDATE  ' + INFO_TABLE
    + ' SET fldHostname = "' + sTheNewName
    + '" WHERE fldHostname = "' + sTheHost + '" AND fldGroup = "' + sTheGroup + '";';

  ModifySqlTableByQuery(sQuery);
  lblHost.Caption := sTheNewName;
end;

procedure TForm1.actnRenameComputerExecute(Sender: TObject);
var
  sSQL                        : string;
  Node, ANode, ParentNode     : PVirtualNode;
  Data                        : PHostRec;
  i, ipc                      : integer;
  sValue                      : string;
begin

{$IFDEF LITE_VERSION}
  AvailableInProEdition();
{$ENDIF}

{$IFNDEF LITE_VERSION}

  Node := vst1.FocusedNode;
  if Assigned(Node) then
  begin
    ParentNode := Node.Parent;
    if Assigned(ParentNode) then
    begin
      if vst1.SelectedCount > 1 then
      begin
        MessageDlg('You can only rename 1 computer at a time.', mtError, [mbOK], 0);
        Exit;
      end;

      Data := vst1.GetNodeData(Node);

      if Data.ALevel = HOST_LEVEL then
      begin

        sValue := Data.AHostname;
        if not InputQuery('Rename [' + Data.AHostname + ']', 'Enter NEW computer name',
          sValue) then
        begin
          Exit;
        end;

        sValue := Trim(sValue);

        if Length(sValue) < 1 then
        begin
          MessageDlg('The computer name must contain at least 1 character!', mtError, [mbOK], 0);
          Exit;
        end;

        if Length(sValue) > 255 then
        begin
          MessageDlg('The computer name cannot be longer than 255 characters!', mtError, [mbOK], 0);
          Exit;
        end;

        if not IsValidName(sValue) then
          Exit;

        if SameText(sValue, Data.AHostname) then
        begin
          MessageDlg('The new name cannot be the same as the current name!', mtError, [mbOK],
            0);
          Exit;
        end;

        vst1.BeginUpdate;
        try

          sSQL := 'SELECT * From "' + INFO_TABLE + '" WHERE fldGroup = "' + Data.AGroupname +
            '" AND Upper(fldHostname) = "' + UpperCase(sValue) + '";';

          GetSqlTableByQuery(sltbInfo, sSQL);

          if sltbInfo.Count > 0 then
          begin
            MessageDlg('This host already exists in this group.', mtError, [mbOK], 0);
            Exit;
          end;

          RenameComputer(Data.AHostname, Data.AGroupname, sValue);

          Data.AHostname := UpperCase(sValue);
          //vst1.FullExpand();

          vst1.Invalidate();
          vst1.SortTree(0, sdAscending, True);
        finally
          vst1.EndUpdate;

          if sltbInfo <> nil then
            FreeAndNil(sltbInfo);

        end;

        UpdateNetworkSummary();
      end
    end;

  end;
{$ENDIF}
end;

procedure TForm1.CheckAll_GroupHostsClick(Sender: TObject);
begin
  ChangeListViewCheckStateAll(lvGroupHosts, True);
end;

procedure TForm1.CheckChildNodes(Sender: TBaseVirtualTree;
  Node: PVirtualNode; pText: Pointer; var Abort: Boolean);
begin
  //Node.CheckState := csCheckedNormal;
  // vst1.ValidateNode(Node, False);

end;

procedure TForm1.CheckforUpdates1Click(Sender: TObject);
begin

{$IFDEF LITE_VERSION}
  ShellExecute(Application.Handle,
    PChar('open'),
    PChar('http://www.wildpawsoftware.com/cgi-bin/updates.php?product=NIC_Padlock_TRIAL&version=' +
    GetBuildInfoAsString()),
    PChar(0),
    nil,
    SW_NORMAL);
{$ELSE}
  ShellExecute(Application.Handle,
    PChar('open'),
    PChar('http://www.wildpawsoftware.com/cgi-bin/updates.php?product=NIC_Padlock&version=' +
    GetBuildInfoAsString()),
    PChar(0),
    nil,
    SW_NORMAL);
{$ENDIF}
end;

procedure TForm1.CheckNone_GroupHostsClick(Sender: TObject);
begin
  ChangeListViewCheckStateAll(lvGroupHosts, False);
end;

procedure TForm1.chkDisableAllAdaptersClick(Sender: TObject);
var
  iVal                        : integer;
begin

{$IFDEF LITE_VERSION}
  if not chkDisableAllAdapters.Checked then
  begin
    chkDisableAllAdapters.Checked := True;
    Exit;
  end;

  MessageBox(0,
    PChar('In this Trial version, all disabled adapters are re-enabled within ' +
    IntToStr(TRIAL_REENABLE_MIN) + ' minutes.'), '',
    MB_ICONINFORMATION or MB_TASKMODAL or MB_TOPMOST);

  cbReEnableAdapters.Checked := True;
  iVal := seHoursMinutes.Value;
  seHoursMinutes.MaxValue := TRIAL_REENABLE_MIN;

  if (iVal < 1) or (iVal > TRIAL_REENABLE_MIN) then
  begin
    seHoursMinutes.Value := TRIAL_REENABLE_MIN;
  end;

  SetCheckedRadioBtnState(rbMinutes, True);
  SetCheckedRadioBtnState(rbHours, False);

  if chkDisableAllAdapters.Checked then
  begin
    rbMinutes.Enabled := True;
    rbHours.Enabled := False;
    seHoursMinutes.Enabled := True;
  end
  else
  begin
    cbReEnableAdapters.Checked := False;
    rbMinutes.Enabled := False;
    rbHours.Enabled := False;
    seHoursMinutes.Enabled := False;
  end;

{$IFDEF LITE_VERSION}
  chkEnableAllAdapters.Enabled := False;
  chkEnableAllAdapters.Checked := False;
  SetCheckedState(chkEnableAllAdapters, False);
  chkDisableAllAdapters.Enabled := True;
  chkDisableAllAdapters.Checked := True;
{$ENDIF}

  DisableAllAdaptersInListview();
  SaveChangesToRecord(lblHost.Caption, lblGroup.Caption);
{$ELSE}
  DisableAllAdaptersInListview();

{$ENDIF}

end;

procedure TForm1.DisableAllAdaptersInListview();
var
  idx                         : integer;
  NicItem                     : TListItem;
  onLVClickHandler            : TLVColumnClickEvent;
begin
  onLVClickHandler := lvRemoteNicsColumnClick;
  lvRemoteNics.OnColumnClick := nil;

  for idx := 0 to lvRemoteNics.Items.Count - 1 do
  begin
    NicItem := lvRemoteNics.Items[idx];
    NicItem.Caption := BoolToStr(False);
    NicItem.SubItems[0] := (BoolToStr(True));
  end;
  lvRemoteNics.OnColumnClick := onLVClickHandler;

  SetCheckedState(chkEnableAllAdapters, False);
  SetFieldsChanged(True);

  if chkDisableAllAdapters.Checked then
  begin
    lvRemoteNics.Enabled := False;
    lvRemoteNics.Color := cl3DLight;
    //lvRemoteNics.Font.Color := cl3DLight;
    //lvRemoteNics.Font.Style := [fsItalic];
  end
  else
  begin
    lvRemoteNics.Enabled := True;
    lvRemoteNics.Color := clWindow;
    //lvRemoteNics.Font.Color := clWindowText;
    //lvRemoteNics.Font.Style := [];
  end;

  lvRemoteNics.Refresh;
end;
//
//function TForm1.GetIpFirstThree(sIp: string): string;
//var
//  Regex             : TPerlRegEx;
//  ResultString      : string;
//begin
//  Regex := TPerlRegEx.Create();
//  try
//    Regex.RegEx := '(\b[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)[0-9]{1,3}\b';
//    Regex.Options := [preSingleLine, preCaseless, preMultiLine];
//    Regex.Subject := sIp;
//    if Regex.Match then
//    begin
//      Result := Regex.MatchedText;
//    end
//    else
//    begin
//      ResultString := '';
//    end;
//  finally
//    FreeAndNil(Regex);
//  end;
//end;

procedure TForm1.edtIpEndEnter(Sender: TObject);
var
  Regex                       : TPerlRegEx;
  sResult                     : string;
begin

  if ((edtIpEnd.Text = '0.0.0.1') and (edtIpStart.Text <> '0.0.0.1')) then
  begin
    //
    //edtIpEnd.Text := edtIpStart;
    Regex := TPerlRegEx.Create(nil);
    try
      Regex.RegEx := '(\b[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)([0-9]{1,3})\b';
      Regex.Options := [preSingleLine, preCaseless, preMultiLine];
      Regex.Subject := edtIpStart.Text;
      Regex.Replacement := '$1254';
      Regex.ReplaceAll;
      sResult := Regex.Subject;
    finally
      FreeAndNil(Regex);
    end;

    edtIpEnd.Text := sResult;
  end;

end;

procedure TForm1.EnableAllAdaptersInListview();
var
  idx                         : integer;
  NicItem                     : TListItem;
  onLVClickHandler            : TLVColumnClickEvent;
begin
  onLVClickHandler := lvRemoteNicsColumnClick;
  lvRemoteNics.OnColumnClick := nil;

  for idx := 0 to lvRemoteNics.Items.Count - 1 do
  begin
    NicItem := lvRemoteNics.Items[idx];
    NicItem.Caption := BoolToStr(True);
    NicItem.SubItems[0] := (BoolToStr(False));
  end;
  lvRemoteNics.OnColumnClick := onLVClickHandler;

  SetFieldsChanged(True);
  SetCheckedState(chkDisableAllAdapters, False);

  if chkEnableAllAdapters.Checked then
  begin
    lvRemoteNics.Enabled := False;
    lvRemoteNics.Color := cl3DLight;
    //lvRemoteNics.Font.Color := cl3DLight;
    //lvRemoteNics.Font.Style := [fsItalic];
  end
  else
  begin
    lvRemoteNics.Enabled := True;
    lvRemoteNics.Color := clWindow;
    //lvRemoteNics.Font.Color := clWindowText;
    //lvRemoteNics.Font.Style := [];
  end;

  lvRemoteNics.Refresh;
end;


procedure TForm1.chkEnableAllAdaptersClick(Sender: TObject);
begin

  //{$IFDEF LITE_VERSION}
  //  MessageBox(0, PChar('The Trial version only allows you to disable adapters.'), '',
  //    MB_ICONINFORMATION or MB_TASKMODAL or MB_TOPMOST);
  //  SetCheckedState(chkEnableAllAdapters, False);
  //{$ELSE}
  EnableAllAdaptersInListview();
  //{$ENDIF}

end;

procedure TForm1.ToggleNicOptionsPage(bEnable: boolean);
begin
  cbGroupHostsEnableAll.Enabled := bEnable;
  cbGroupHostsDisableAll.Enabled := bEnable;
  chkAutoUpdateIp.Enabled := bEnable;
  cbGroupHostsReEnableAfter.Enabled := bEnable;
  rbGroupHostsMinutes.Enabled := bEnable;
  rbGroupHostsHours.Enabled := bEnable;
  seGroupHostsHoursMinutes.Enabled := bEnable;

  if bEnable then
  begin
    if cbGroupHostsReEnableAfter.Checked then
    begin
      seGroupHostsHoursMinutes.Enabled := True;
      rbGroupHostsMinutes.Enabled := True;
      rbGroupHostsHours.Enabled := True;
    end
    else
    begin
      rbGroupHostsMinutes.Enabled := False;
      rbGroupHostsHours.Enabled := False;
      rbGroupHostsHours.Enabled := False;
    end;
  end;
end;

procedure TForm1.ToggleCredentialsPage(bEnable: boolean);
begin
  cbGroupHostsUseAltCreds.Enabled := bEnable;
  lblGroupHostsCredUser.Enabled := bEnable;
  lblGroupHostsCredPass.Enabled := bEnable;
  chkShowPass.Enabled := bEnable;

  if bEnable then
  begin
    if cbGroupHostsUseAltCreds.Checked then
    begin
      lblGroupHostsCredUser.Enabled := True;
      lblGroupHostsCredPass.Enabled := True;
      chkShowPass.Enabled := True;
    end
    else
    begin
      lblGroupHostsCredUser.Enabled := False;
      lblGroupHostsCredPass.Enabled := False;
      chkShowPass.Enabled := False;
    end;
  end;

end;

procedure TForm1.chkModifyCredentialsClick(Sender: TObject);
begin
  if chkModifyCredentials.Checked then
  begin
    grpModifyCredentials.Enabled := True;
    ToggleCredentialsPage(True);
  end
  else
  begin
    grpModifyCredentials.Enabled := False;
    ToggleCredentialsPage(False);
  end;
end;

procedure TForm1.ToggleUserMessagePage(bEnable: Boolean);
begin
  cbGroupHostsDisplayMsg.Enabled := bEnable;
  memoUserMessage.Enabled := bEnable;
  grpModifyUserMessage.Enabled := bEnable;
end;

procedure TForm1.chkModifyNicOptionsClick(Sender: TObject);
begin
  if chkModifyNicOptions.Checked then
  begin
    grpModifyNicOptions.Enabled := True;
    ToggleNicOptionsPage(True);
  end
  else
  begin
    grpModifyNicOptions.Enabled := False;
    ToggleNicOptionsPage(False);
  end;
end;

procedure TForm1.chkModifyUserMessageClick(Sender: TObject);
begin
  if chkModifyUserMessage.Checked then
  begin
    ToggleUserMessagePage(True);
  end
  else
  begin
    ToggleUserMessagePage(False);
  end;

  if cbGroupHostsDisplayMsg.Checked then
  begin
    memoUserMessage.Enabled := True;
  end
  else
  begin
    memoUserMessage.Enabled := False;
  end;
end;

procedure TForm1.chkShowPassClick(Sender: TObject);
begin
  if chkShowPass.Checked then
  begin
    lblGroupHostsCredPass.PasswordChar := #0;
  end
  else
  begin
    lblGroupHostsCredPass.PasswordChar := '*';
  end;
end;

procedure TForm1.ShowCredentialsForm();
var
  frmUseDifferentCreds        : TfrmAlternateCredentials;
  //sUser, sPass                : string;
  //bUseAltUser                 : Boolean;
begin

  frmUseDifferentCreds := TfrmAlternateCredentials.Create(nil);
  try
    frmUseDifferentCreds.sModIpHost := lblHost.Caption;
    frmUseDifferentCreds.sModIpGroup := lblGroup.Caption;
    frmUseDifferentCreds.Position := poMainFormCenter;
    frmUseDifferentCreds.ShowModal;

  finally
    frmUseDifferentCreds.Release;
    Pointer(frmUseDifferentCreds) := nil;

    //FreeAndNil(frmUseDifferentCreds);
  end;

end;

//procedure TForm1.AllChildrenAreChecked(Sender: TBaseVirtualTree;
//  Node: PVirtualNode; pText: Pointer; var Abort: Boolean);
//begin
//  //  if Node.CheckState = csUncheckedNormal then
//  //  begin
//  //    bAllChildrenChecked := False;
//  //  end;
//    // vst1.ValidateNode(Node, False);
//end;
//
//procedure TForm1.UnCheckChildNodes(Sender: TBaseVirtualTree;
//  Node: PVirtualNode; pText: Pointer; var Abort: Boolean);
//begin
//  //Node.CheckState := csUncheckedNormal;
//  // vst1.ValidateNode(Node, False);
//end;

procedure TForm1.vst1Change(Sender: TBaseVirtualTree; Node: PVirtualNode);
begin

  if vst1.Width < 236 then
  begin
    if vst1.Header.Columns[0].Width < 190 then
    begin
      vst1.Header.Columns[0].Width := 190;
    end;
  end;

  vst1.Header.Columns[0].Width := 200;
end;

{
procedure TForm1.vst1Checked(Sender: TBaseVirtualTree; Node: PVirtualNode);
var
  Data                        : PHostRec;
begin
  if Assigned(Node) then
  begin
    vst1.BeginUpdate;
    Data := Sender.GetNodeData(Node);
    if Data.ALevel = FOLDER_LEVEL then
    begin

      vst1.SortTree(0, sdAscending, true);
      //
      //      if Node.CheckState = csCheckedNormal then //1=checked, 0=unchecked
      //      begin
      //        //check child nodes
      //        Sender.IterateSubtree(Node, CheckChildNodes, Data, [], True, True);
      //        vst1.SortTree(0, sdAscending, true);
      //      end
      //      else
      //      begin
      //        //uncheck child nodes
      //        Sender.IterateSubtree(Node, UnCheckChildNodes, Data, [], True, True);
      //        vst1.SortTree(0, sdAscending, true);
      //      end;
    end
    else if Data^.ALevel = HOST_LEVEL then
    begin
      if Node.CheckState = csUncheckedNormal then
      begin
        //uncheck parent node
        //Node.Parent.CheckState := csUncheckedNormal;
      end
      else
      begin
        bAllChildrenChecked := True; //default
        Sender.IterateSubtree(Node.Parent, AllChildrenAreChecked, Data, [], True, True);

        //if bAllChildrenChecked then
//        begin
//          Node.Parent.CheckState := csCheckedNormal;
//        end;

        vst1.SortTree(0, sdAscending, true);
      end;
    end;
    vst1.EndUpdate;
  end;
end;
}

procedure TForm1.vst1Click(Sender: TObject);
begin
  vst1.SetFocus;
end;

procedure TForm1.vst1CompareNodes(Sender: TBaseVirtualTree; Node1,
  Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
var
  Data1, Data2                : PHostRec;
begin
  Data1 := Sender.GetNodeData(Node1);
  Data2 := Sender.GetNodeData(Node2);
  Result := CompareText(Data1^.AHostname, Data2^.AHostname);
end;

procedure TForm1.vst1ContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
var
  Data                        : PHostRec;
  Node                        : PVirtualNode;
begin
  try
    if vst1.SelectedCount <= 1 then
    begin
      Node := TBaseVirtualTree(Sender).GetNodeAt(MousePos.X, MousePos.Y);
    end
    else
      Node := vst1.FocusedNode;

    if (Node = nil) then
    begin
      vstPopupMenu.Items[0].Visible := False;
      vstPopupMenu.Items[1].Visible := False;
      vstPopupMenu.Items[2].Visible := False;
      vstPopupMenu.Items[3].Visible := True;
      vstPopupMenu.Items[4].Visible := False;
      //
    end
    else if TBaseVirtualTree(Sender).GetNodeLevel(Node) = HOST_LEVEL then
    begin
      // this is a child node

      vstPopupMenu.Items[0].Visible := False;
      vstPopupMenu.Items[1].Visible := False;
      vstPopupMenu.Items[2].Visible := True;
      vstPopupMenu.Items[3].Visible := False;
      vstPopupMenu.Items[4].Visible := False;
      //
    end
    else if TBaseVirtualTree(Sender).GetNodeLevel(Node) = FOLDER_LEVEL then
    begin
      //
      Data := TBaseVirtualTree(Sender).GetNodeData(Node);
      vstPopupMenu.Items[0].Visible := True;
      vstPopupMenu.Items[1].Visible := True;
      vstPopupMenu.Items[2].Visible := False;
      vstPopupMenu.Items[3].Visible := True;
      vstPopupMenu.Items[4].Visible := True;
      vstPopupMenu.Items[4].Caption := 'Remove "' + Data^.AGroupname + '" group';
      //
    end;
  except
    //ShowMessage('*** exception');
  end;
end;

procedure TForm1.vst1DragAllowed(Sender: TBaseVirtualTree; Node: PVirtualNode;
  Column: TColumnIndex; var Allowed: Boolean);
begin
  if Sender.GetNodeLevel(Node) > FOLDER_LEVEL then
  begin
    Allowed := True;
  end
  else
  begin
    Allowed := False;
  end;
end;

procedure TForm1.vst1DragDrop(Sender: TBaseVirtualTree; Source: TObject;
  DataObject: IDataObject; Formats: TFormatArray; Shift: TShiftState;
  Pt: TPoint; var Effect: Integer; Mode: TDropMode);
var
  SentData                    : PHostRec;
  TargetData                  : PHostRec;
  AttachMode                  : TVTNodeAttachMode;
  Nodes                       : TNodeArray;
  I                           : Integer;
  sSQL                        : string;
  spNode                      : PVirtualNode;
  HostData                    : PHostRec;
begin
  Nodes := nil;

  if Sender.GetNodeLevel(Sender.DropTargetNode) <> FOLDER_LEVEL then
  begin
    //only can drop this on root node
    Exit;
  end;

  if DataObject <> nil then
  begin
    // VCL drag'n drop. Handling this requires detailed knowledge about the sender and its data. This is one reason
    // why it was a bad decision by Borland to implement something own instead using the system's way.
    // In this demo we have two known sources of VCL dd data: Tree2 and LogListBox.
    if Source = vst1 then
    begin
      TargetData := Sender.GetNodeData(Sender.DropTargetNode);

      if not Assigned(TargetData) then
        Exit;

      if (MessageDlg('Are you sure that you would like to ' + #13 + #10 +
        'move this computer to this group?', mtConfirmation, [mbYes, mbNo], 0) <> mrYes) then
      begin
        //selected NO or didnt select anything
        Exit;
      end;

      vst1.BeginUpdate;
      try
        // Since we know this is a Virtual Treeview we can ignore the drop event entirely and use VT mechanisms.
        Effect := DROPEFFECT_MOVE;
        Nodes := vst1.GetSortedSelection(True);

        if Assigned(Nodes[0]) then
          spNode := Nodes[0].Parent;

        for I := 0 to High(Nodes) do
        begin
          SentData := Sender.GetNodeData(Nodes[I]);
          AttachMode := amAddChildLast;

          sSQL := 'SELECT * From "' + INFO_TABLE + '" WHERE fldGroup = "' + TargetData.AGroupname +
            '" AND fldHostname = "' + SentData.AHostname + '";';

          GetSqlTableByQuery(sltbInfo, sSQL);

          if sltbInfo.Count > 0 then
          begin
            MessageDlg('This computer already exists in this group.', mtError, [mbOK], 0);
            Exit;
          end;

          if Effect = DROPEFFECT_COPY then
          begin
            vst1.CopyTo(Nodes[I], Sender.DropTargetNode, AttachMode, False);
          end
          else
          begin
            vst1.MoveTo(Nodes[I], Sender.DropTargetNode, AttachMode, False);
          end;

          sSQL := 'UPDATE ' + INFO_TABLE + ' SET fldGroup = "' + TargetData.AGroupname +
            '" WHERE fldHostname = "' + SentData.AHostname + '" AND fldGroup = "' +
            SentData.AGroupname + '";';

          lblGroup.Caption := TargetData.AGroupname;
          ModifySqlTableByQuery(sSQL);

          HostData := vst1.GetNodeData(Nodes[I]);
          vst1.ValidateNode(Nodes[I], False);

          HostData^.AGroupname := TargetData.AGroupname;
        end;
        vst1.SortTree(0, sdAscending, true);
      finally
        vst1.EndUpdate;

        if sltbInfo <> nil then
          FreeAndNil(sltbInfo);

      end;
    end;
  end;
end;

procedure TForm1.vst1DragOver(Sender: TBaseVirtualTree; Source: TObject;
  Shift: TShiftState; State: TDragState; Pt: TPoint; Mode: TDropMode;
  var Effect: Integer; var Accept: Boolean);
var
  Node                        : PVirtualNode;
  iLevel                      : Integer;
begin
  //
  Node := Sender.GetNodeAt(pt.X, pt.Y);
  iLevel := Sender.GetNodeLevel(Node);
  if iLevel <> FOLDER_LEVEL then
  begin
    Accept := False;
    //vst1.DragCursor := crNoDrop;
  end
  else
  begin
    Accept := True;
    //vst1.DragCursor := crDrag;
  end;
end;

procedure TForm1.vst1FocusChanged(Sender: TBaseVirtualTree; Node: PVirtualNode;
  Column: TColumnIndex);
var
  Data                        : PHostRec;
  iNodeLevel                  : integer;
  bNewNode                    : boolean;
  sHost, sGroup               : string;
begin
  if not bOnMouseFired then
  begin
    if Assigned(Node) then
    begin
      Data := Sender.GetNodeData(Node);
      iNodeLevel := Sender.GetNodeLevel(Node);
      sHost := Data.AHostname;
      sGroup := Data.AGroupname;
      SetVisualActionStates(Node, iNodeLevel, sHost, sGroup);

      bNewNode := False; //default

      if (sPrevSelNode = Data.AGroupname + ' > ' + Data.AHostname) then
      begin
        bNewNode := False; //default
      end
      else
      begin
        bNewNode := True;
      end;

      if iNodeLevel = HOST_LEVEL then //> FOLDER_LEVEL then
      begin
        if sPrevSelNode = '-' then
          bFieldsChanged := False;

        if bNewNode and bFieldsChanged then
        begin
          //
          if (MessageDlg('Do you want to save the changes to this host?:' + #13#10 + sPrevSelNode,
            mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
          begin
            SaveChangesToRecord(sHost, sGroup);
          end;
        end;
      end;

      sPrevSelNode := Data.AGroupname + ' > ' + Data.AHostname;
      lblHost.Caption := Data.AHostname;
      lblGroup.Caption := Data.AGroupname;

      if bNewNode then
      begin
        SetFieldsChanged(False);

        if iNodeLevel = HOST_LEVEL then
        begin
          lvRemoteNics.DoubleBuffered := False;
          //AnimateWindow(lvRemoteNics.Handle, 10, AW_VER_NEGATIVE or AW_SLIDE or AW_HIDE);
          lvRemoteNics.DoubleBuffered := True;
          lvRemoteNics.Repaint;
        end;
        ShowNodeDetails(iNodeLevel, Data);
      end;
    end;
  end;

  bOnMouseFired := False;
  //end;
end;

procedure TForm1.vst1FreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
var
  Data                        : PHostRec;
begin
  //
  Data := vst1.GetNodeData(Node);
  if Assigned(Data) then
  begin
    Data^.AGroupname := '';
    Data^.AHostname := '';
    Data^.ALevel := -1;
    Data^.AbOnline := 0;
    Finalize(Data^);
  end;
end;

procedure TForm1.vst1GetImageIndex(Sender: TBaseVirtualTree; Node: PVirtualNode; Kind: TVTImageKind;
  Column: TColumnIndex; var Ghosted: Boolean; var ImageIndex: Integer);
var
  Data                        : PHostRec;
begin
  if Kind <> ikOverlay then
  begin
    Data := Sender.GetNodeData(Node);
    if Data^.ALevel = FOLDER_LEVEL then
    begin
      ImageIndex := FOLDER_ICON; //9;                  //default
      if vsExpanded in Node.States then
      begin
        //
        ImageIndex := FOLDER_ICON; //9;
      end
      else
      begin
        ImageIndex := FOLDER_ICON; //8;
      end;
    end
    else if Data^.ALevel = HOST_LEVEL then
    begin
      ImageIndex := COMPUTER_ICON; //10;                 //default

      //if Data^.AbOnline = 0 then
      //  ImageIndex := COMPUTER_GRAY_ICON;

    end
    else if Data^.ALevel = NETWORK_LEVEL then
    begin
      ImageIndex := NETWORK_ICON;
    end;
  end;
end;

procedure TForm1.vst1GetNodeDataSize(Sender: TBaseVirtualTree; var NodeDataSize: Integer);
begin
  NodeDataSize := SizeOf(THostRec);
end;

procedure TForm1.vst1GetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
  Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
var
  Data                        : PHostRec;
begin
  Data := Sender.GetNodeData(Node);
  CellText := '??';

  if Data^.ALevel = FOLDER_LEVEL then
  begin
    CellText := Data^.AGroupname;
  end
  else if Data^.ALevel = HOST_LEVEL then
  begin
    CellText := Data^.AHostname;
  end
  else if Data^.ALevel = NETWORK_LEVEL then
  begin
    CellText := 'Network';
  end;
end;

procedure TForm1.vst1IncrementalSearch(Sender: TBaseVirtualTree;
  Node: PVirtualNode; const SearchText: string; var Result: Integer);
var
  Data                        : PHostRec;
begin
  Data := vst1.GetNodeData(Node);

  if AnsiLowerCase(Copy(Data.AHostname, 1, Length(SearchText))) < AnsiLowerCase(SearchText) then
    Result := -1
  else if AnsiLowerCase(Copy(Data.AHostname, 1, Length(SearchText))) > AnsiLowerCase(SearchText)
    then
    Result := 1
  else
    Result := 0;
end;

procedure TForm1.vst1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  Node                        : PVirtualNode;
  Data                        : PHostRec;
  iNodeLevel                  : integer;
  sHint                       : string;
  bNewNode                    : boolean;
  sHost, sGroup               : string;
begin
  //
  bOnMouseFired := True;

  if Button = mbRight then
  begin
    Node := TBaseVirtualTree(Sender).GetNodeAt(X, Y); // HotNode; //Node under mouse

    if Assigned(Node) then
    begin
      Data := TBaseVirtualTree(Sender).GetNodeData(Node);
      Node := TBaseVirtualTree(Sender).GetNodeAt(X, Y); // HotNode; //Node under mouse
      iNodeLevel := TBaseVirtualTree(Sender).GetNodeLevel(Node);
      sHost := Data.AHostname;
      sGroup := Data.AGroupname;
      SetVisualActionStates(Node, iNodeLevel, sHost, sGroup);
    end;
  end
  else if Button = mbLeft then
  begin
    Node := TBaseVirtualTree(Sender).GetNodeAt(X, Y); // HotNode; //Node under mouse
    if Assigned(Node) then
    begin
      Data := TBaseVirtualTree(Sender).GetNodeData(Node);
      iNodeLevel := TBaseVirtualTree(Sender).GetNodeLevel(Node);

      //      if (vst1.SelectedCount <= 1) then // and (iNodeLevel <> HOST_LEVEL) then
      //      begin
      //        vst1.BeginUpdate;
      //        vst1.ClearSelection;
      //        vst1.FocusedNode := Node;
      //        vst1.Selected[Node] := True;    //vst1.FocusedNode] := True;
      //        vst1.InvalidateNode(Node);
      //        vst1.EndUpdate;
      //      end;

      case iNodeLevel of
        NETWORK_LEVEL:
          begin
            PageControl1.ActivePage := Tab01_NetworkInfo;

            actnRemoveGroup.Hint := '';
            actnRemoveGroup.Caption := 'Remove group';
            actnRemoveComputer.Hint := '';
            actnRemoveComputer.Caption := 'Remove computer';

            actAddOneComputer.Enabled := False;
            actAddMultipleComputers.Enabled := True;
            actnRemoveComputer.Enabled := False;
            actnRenameComputer.Enabled := False;
            actAddNewGroup.Enabled := True;
            actnRemoveGroup.Enabled := False;

            HostSpecificActions1.Enabled := False;
          end;
        FOLDER_LEVEL:
          begin
            PageControl1.ActivePage := Tab02_GeneralInfo;
            sHint := 'Remove "' + Data.AGroupname + '" group';

            actnRemoveGroup.Hint := sHint;
            actnRemoveGroup.Caption := sHint;
            actnRemoveComputer.Hint := '';
            actnRemoveComputer.Caption := 'Remove computer';

            actAddOneComputer.Enabled := True;
            actAddMultipleComputers.Enabled := True;
            actnRemoveComputer.Enabled := False;
            actnRenameComputer.Enabled := False;
            actAddNewGroup.Enabled := True;
            actnRemoveGroup.Enabled := True;

            HostSpecificActions1.Enabled := False;
          end;
        HOST_LEVEL:
          begin
            PageControl1.ActivePage := Tab03_HostDetail;
            sHint := 'Remove "' + Data.AHostname + '" computer';

            actnRemoveGroup.Hint := '';
            actnRemoveGroup.Caption := 'Remove group';
            actnRemoveComputer.Hint := sHint;
            actnRemoveComputer.Caption := sHint;

            actAddOneComputer.Enabled := False;
            actAddMultipleComputers.Enabled := True;
            actnRemoveComputer.Enabled := True;
            actnRenameComputer.Enabled := True;
            actAddNewGroup.Enabled := False;
            actnRemoveGroup.Enabled := False;

            HostSpecificActions1.Enabled := True;

          end;
      end;

      bNewNode := False; //default

      if (sPrevSelNode = Data.AGroupname + ' > ' + Data.AHostname) then
      begin
        bNewNode := False; //default
      end
      else
      begin
        bNewNode := True;
      end;

      if iNodeLevel = HOST_LEVEL then //> FOLDER_LEVEL then
      begin
        if sPrevSelNode = '-' then
          bFieldsChanged := False;

        if bNewNode and bFieldsChanged then
        begin
          //
          if (MessageDlg('Do you want to save the changes to this host?:' + #13#10 + sPrevSelNode,
            mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
          begin
            SaveChangesToRecord(lblHost.Caption, lblGroup.Caption);
          end;
        end;
      end;

      sPrevSelNode := Data.AGroupname + ' > ' + Data.AHostname;
      lblHost.Caption := Data.AHostname;
      lblGroup.Caption := Data.AGroupname;

      if bNewNode then
      begin
        SetFieldsChanged(False);

        if iNodeLevel = HOST_LEVEL then
        begin
          lvRemoteNics.DoubleBuffered := False;
          //AnimateWindow(lvRemoteNics.Handle, 10, AW_VER_NEGATIVE or AW_SLIDE or AW_HIDE);
          lvRemoteNics.DoubleBuffered := True;
          lvRemoteNics.Repaint;
        end;

        ShowNodeDetails(iNodeLevel, Data);
      end;
    end;
  end;
end;

procedure TForm1.About1Click(Sender: TObject);
var
  frmAbout                    : TfrmAboutProgram;
begin
  //
  frmAbout := TfrmAboutProgram.Create(nil);
  try
    frmAbout.ShowModal;
  finally
    frmAbout.Release;
    Pointer(frmAbout) := nil;

    //FreeAndNil(frmAbout);
  end;
end;

procedure TForm1.actnModifyIpAddressExecute(Sender: TObject);
begin
  //
  ModifyTheHostIpAddress(lblHost.Caption, lblGroup.Caption);
  lblRemoteIpAddress.Caption := RetrieveIpFromDB(lblHost.Caption, lblGroup.Caption);
end;

procedure TForm1.actnPingTheHostExecute(Sender: TObject);
begin
  if PageControl1.ActivePage = Tab03_HostDetail then
    PrepareHostPing();

end;

procedure TForm1.PrepareHostPing();
var
  sHostToUse                  : string;
  asHostPing                  : IAsyncCall;
  slResults                   : TStringList;
begin

  if actnAutoUpdateIp.Checked then
  begin
    lblRemoteIpAddress.Caption := RetrieveIpForHostAndUpdateDB(Trim(lblHost.Caption),
      Trim(lblGroup.Caption));
  end;

  if Length(Trim(lblRemoteIpAddress.Caption)) < 1 then
  begin

    //if not bSilent then
    ShowMessage('You must provide an IP address');

    Exit;
  end;
  sHostToUse := Trim(lblRemoteIpAddress.Caption);
  //

  sbGeneralInfo.Panels[0].Text := 'Pinging ' + sHostToUse;

  slResults := TStringList.Create;
  try
    asHostPing := AsyncCall(@ContactHost, [sHostToUse, slResults, Trim(lblHost.Caption),
      Trim(lblGroup.Caption)]);
    while AsyncMultiSync([asHostPing], True, 10) = WAIT_TIMEOUT do
    begin
      Application.ProcessMessages;
    end;

    MessageDlg(PChar(slResults.Text), mtInformation, [mbOK], 0);
    sbGeneralInfo.Panels[0].Text := '';

  finally
    FreeAndNil(slResults);
  end;
end;

procedure TForm1.actAddMultipleComputersExecute(Sender: TObject);
begin
  PageControl1.ActivePage := Tab01_NetworkInfo;

  vst1.FocusedNode := vst1.GetFirstLevel(0);
  vst1.Selected[vst1.GetFirstLevel(0)] := True;

  lvMultipleComputers.Refresh;
end;

procedure TForm1.actAddNewGroupExecute(Sender: TObject);
var
  sValue                      : string;
begin
  //
  if not InputQuery('Add New Group', 'Enter group name', sValue) then
  begin
    Exit;
    //ShowMessage('User cancelled the dialog');
  end;

  if Length(Trim(sValue)) < 1 then
    Exit;

  if Length(sValue) > 255 then
  begin
    MessageDlg('The group name cannot be longer than 255 characters!', mtError, [mbOK], 0);
    Exit;
  end;
  AddNewGroup(sValue);
end;

procedure TForm1.actAddOneComputerExecute(Sender: TObject);
var
  sValue                      : string;
  Node, ChildNode             : PVirtualNode;
  Data, ChildData             : PHostRec;
  sSQL                        : string;
begin

  Node := vst1.FocusedNode;

  if Assigned(Node) then
  begin
    Data := vst1.GetNodeData(Node);

    if Data.ALevel = FOLDER_LEVEL then
    begin

      if not InputQuery('Add Computer', 'Enter computer name', sValue) then
      begin
        Exit;
      end;

      sValue := Trim(sValue);

      if Length(sValue) < 1 then
      begin
        MessageDlg('The computer name must contain at least 1 character!', mtError, [mbOK], 0);
        Exit;
      end;

      if Length(sValue) > 255 then
      begin
        MessageDlg('The computer name cannot be longer than 255 characters!', mtError, [mbOK], 0);
        Exit;
      end;

      if not IsValidName(sValue) then
        Exit;

      vst1.BeginUpdate;
      try

        sSQL := 'SELECT * From "' + INFO_TABLE + '" WHERE fldGroup = "' + Data.AGroupname +
          '" AND Upper(fldHostname) = "' + UpperCase(sValue) + '";';

        GetSqlTableByQuery(sltbInfo, sSQL);

        if sltbInfo.Count > 0 then
        begin
          MessageDlg('This host already exists in this group.', mtError, [mbOK], 0);
          Exit;
        end;

        sSQL := 'INSERT INTO ' + INFO_TABLE + ' (fldHostname, fldGroup, fldAutoUpdateIp) VALUES ("'
          + sValue
          + '", "'
          + Data.AGroupname
          + '", "'
          + '1'
          + '")';

        ModifySqlTableByQuery(sSQL);

        ChildNode := vst1.AddChild(Node); //child node
        vst1.ValidateNode(ChildNode, False);
        //ChildNode.CheckType := ctNone; // ctCheckBox;
        //ChildNode.CheckState := csUncheckedNormal;
        //
        ChildData := vst1.GetNodeData(ChildNode);

        //
        ChildData^.AGroupname := Data.AGroupname;
        ChildData^.AHostname := sValue;
        ChildData^.ALevel := HOST_LEVEL;
        ChildData^.AbOnline := 1; //we dont know yet

        //vst1.FullExpand();

        vst1.Invalidate();
        vst1.SortTree(0, sdAscending, True);
      finally
        vst1.EndUpdate;

        if sltbInfo <> nil then
          FreeAndNil(sltbInfo);
      end;

      UpdateNetworkSummary();
      if Assigned(ChildNode) and Assigned(ChildNode) then
      begin
        //
        vst1.Expanded[Node] := True;
        vst1.FocusedNode := ChildNode;
        //vst1.FullExpand(ChildNode) ;
      end;
    end
    else
    begin
      MessageDlg('You must first select (or create) a group before attempting to add a new computer.',
        mtError, [mbOK], 0);
    end;
  end
  else
  begin
    //MessageDlg('This is not a valid group.', mtError, [mbOK], 0);
    MessageDlg('You must first select (or create) a group before attempting to add a new computer.',
      mtError, [mbOK], 0);
  end;
end;

procedure TForm1.actnAutoUpdateIpExecute(Sender: TObject);
begin
  //
  SaveAutoUpdateIp(lblHost.Caption, lblGroup.Caption)
end;

procedure TForm1.actnChangePasswordExecute(Sender: TObject);
var
  frmPassChange               : TfrmChangePassword;
begin
{$IFNDEF LITE_VERSION}
  frmPassChange := TfrmChangePassword.Create(nil);
  try
    frmPassChange.sPrevHash := sHashedPass;
    frmPassChange.Position := poMainFormCenter;
    frmPassChange.ShowModal;

  finally
    frmPassChange.Release;
    Pointer(frmPassChange) := nil;
    //FreeAndNil(frmPassChange);
  end;
  SetFieldsChanged(True);
{$ELSE}
  MessageBox(0, PChar('There is no password protection in the Trial version.'), '',
    MB_ICONINFORMATION or
    MB_TASKMODAL or MB_TOPMOST);

{$ENDIF}
end;

procedure TForm1.actnClearHostHistoryExecute(Sender: TObject);
var
  sSQL                        : string;
  sDeployResult               : string;
begin
  //
  sDeployResult := '';
  //
  sSQL := 'UPDATE  ' + INFO_TABLE + ' SET fldDeploymentResult = "' + sDeployResult +
    '" WHERE fldHostname = "' + lblHost.Caption +
    '" and fldGroup = "' + lblGroup.Caption + '";';

  ModifySqlTableByQuery(sSQL);
  mmoDeploymentResult.Text := 'Deployment Result: -';
end;

procedure TForm1.actnDeploySvcExecute(Sender: TObject);
var
  sHost                       : string;
begin
  //
  sHost := Trim(lblHost.Caption);

  case MessageBox(0, PChar('Are you sure you want to deploy to ' + sHost + '?'),
    PChar('Deploy to ' + sHost + ' now?'),
    MB_ICONINFORMATION or MB_TASKMODAL or MB_TOPMOST
    or MB_YESNO) of
    id_Yes:
      begin
        //
        DeploySvcToCurrentVisible();
      end;
  end;
end;

procedure TForm1.actnLocateHostRecordExecute(Sender: TObject);
var
  sSQL                        : string;
  sValue                      : string;
  sCurGroup                   : string;
  slGroups                    : TStringList;
begin
  //

  sValue := '';
  if not InputQuery('Locate host', 'Enter host to locate',
    sValue) then
  begin
    Exit;
  end;

  sSQL := 'SELECT fldGroup From "' + INFO_TABLE + '" WHERE Upper(fldHostname) = "' +
    UpperCase(sValue) +
    '";';
  GetSqlTableByQuery(sltbInfo, sSQL);

  if sltbInfo.Count < 1 then
  begin
    //    MessageDlg('This host does not exist in any group, but I''ll look for similarly named hosts...',
    //      mtError, [mbOK], 0);
    sSQL := 'SELECT fldGroup From "' + INFO_TABLE + '" WHERE Upper(fldHostname) = "' +
      UpperCase(sValue) + '";';

    GetSqlTableByQuery(sltbInfo, sSQL);

    if sltbInfo.Count < 1 then
    begin
      MessageDlg('This host does not exist in any group, and I was unable to find any similarly named hosts...',
        mtError, [mbOK], 0);
    end;

    //Exit;
  end;

  slGroups := TStringList.Create;
  try
    while not sltbInfo.EOF do
    begin
      sCurGroup := sltbInfo.FieldAsString(sltbInfo.FieldIndex['fldGroup']);
      slGroups.Add('  -> ' + sCurGroup);

      sltbInfo.Next;
    end;

    if slGroups.Count > 1 then
    begin
      MessageDlg('The host [' + sValue + '] was found in the following groups:' + #13 + #10 + '' +
        #13 + #10 +
        slGroups.Text, mtInformation, [mbOK], 0);
    end
    else
    begin
      if slGroups.Count = 1 then
      begin
        MessageDlg('The host [' + sValue + '] was found in the following group:' + #13 + #10 + '' +
          #13 + #10 +
          slGroups.Text, mtInformation, [mbOK], 0);
      end;
    end;

  finally
    FreeAndNil(slGroups);
  end;

end;

procedure TForm1.actnRefreshHostExecute(Sender: TObject);
var
  sHost                       : string;
begin

  sHost := Trim(lblHost.Caption);

  case MessageBox(0, PChar('Are you sure you want to retrieve host details from ' + sHost + '?'),
    PChar('Retrieve host details from ' + sHost + ' now?'),
    MB_ICONINFORMATION or MB_TASKMODAL or MB_TOPMOST
    or MB_YESNO) of
    id_Yes:
      begin
        //
        RefreshHostDetails(lblHost.Caption, lblGroup.Caption, False);
      end;
  end;

end;

procedure TForm1.actnSaveHostExecute(Sender: TObject);
begin
  //
  SaveChangesToRecord(lblHost.Caption, lblGroup.Caption);
  SaveGroupState();
  SetFieldsChanged(False);
end;

procedure TForm1.actnUseAlternateCredsExecute(Sender: TObject);
var
  sUser, sPass                : string;
  bUseAltCreds                : boolean;
begin
  //
  ShowCredentialsForm();
  RetrieveDbUserPass(lblGroup.Caption, lblHost.Caption, sUser, sPass, bUseAltCreds);

  if bUseAltCreds then
  begin
    lblUserCredentialsType.Caption := '[' + sUser + ']';
  end
  else
  begin
    lblUserCredentialsType.Caption := 'Inherited';
  end;
end;

procedure TForm1.actnUserMessageExecute(Sender: TObject);
var
  sUserMsg                    : string;
  bShowMsg                    : boolean;
begin
  ShowUserEditMessage();

  RetrieveDbUserMessage(
    lblGroup.Caption,
    lblHost.Caption, sUserMsg, bShowMsg);

  if bShowMsg then
  begin
    lblUserMessageVisible.Caption := 'Yes, a message will be shown';
  end
  else
  begin
    lblUserMessageVisible.Caption := 'No message will be shown';
  end;
end;

procedure TForm1.AddHostToVst(sGroup, sHost: string);
var
  ParentNode, ChildNode, HostNode: PVirtualNode;
  HostData, ChildData         : PHostRec;
  iLoop                       : Integer;
  ipc                         : Integer;
begin

  vst1.BeginUpdate;
  try
    try
      ParentNode := vst1.GetFirstLevel(0);
      ipc := ParentNode.ChildCount - 1;
      for iLoop := 0 to ipc do
      begin

        if iLoop = 0 then
          HostNode := ParentNode.FirstChild //.NextSibling
        else
        begin
          HostNode := HostNode.NextSibling;

          if not Assigned(HostNode) then
          begin
            HostNode := HostNode.NextSibling;
          end;

          if not Assigned(HostNode) then
          begin
            HostNode := HostNode.NextSibling;
          end;
        end;

        if not Assigned(HostNode) then
          Exit;

        vst1.ValidateNode(HostNode, False);

        HostData := vst1.GetNodeData(HostNode);
        if HostData^.ALevel = FOLDER_LEVEL then
        begin
          //
          if SameText(HostData^.AGroupname, sGroup) then
          begin
            //let's add the nodes

            ChildNode := vst1.AddChild(HostNode); //child node
            vst1.ValidateNode(ChildNode, False);
            //
            ChildData := vst1.GetNodeData(ChildNode);

            //
            ChildData^.AGroupname := sGroup;
            ChildData^.AHostname := sHost;
            ChildData^.ALevel := HOST_LEVEL;
            ChildData^.AbOnline := 1; //we dont know yet

            vst1.ValidateNode(ChildNode, False);
          end;
        end;
      end;
    except on E: Exception do
      begin
        //suppress
      end;
    end;
  finally
    vst1.EndUpdate;
  end;
end;

procedure TForm1.btn1Click(Sender: TObject);
begin
  //ShowMessage('loop');
end;

procedure TForm1.btnAddCheckedClick(Sender: TObject);
var
  iChecked                    : integer;
  iLoop                       : integer;
  sIp, sComputer              : string;
  sQuery                      : string;
  sGroup                      : string;
  bNewGroup                   : boolean;
  sDbGroup                    : string;
  iAlreadyExist, iAdded       : integer;
  slMachines                  : TStringList;
  frmImportDelProgress        : TfrmImportDeleteProgress;
begin

  btnAddChecked.Enabled := False;
  slMachines := TStringList.Create;
  try
    sGroup := Trim(cbGroups.Text);
    slMachines.NameValueSeparator := '^';

    if Length(sGroup) <= 0 then
    begin
      MessageDlg('Select, or enter, a group name in the group box.', mtError, [mbOK], 0);
      Exit;
    end;

    if not IsValidName(sGroup) then
      Exit;

    if lvMultipleComputers.Items.Count < 1 then
    begin
      MessageDlg('There are no computers to add.' + #13#10
        + 'Please scan for hosts first.', mtError, [mbOK], 0);
      Exit;
    end;

    iChecked := 0; //default
    for iLoop := 0 to lvMultipleComputers.Items.Count - 1 do
    begin
      if lvMultipleComputers.Items[iLoop].Checked then
      begin
        sIp := '';
        sComputer := '';
        sIp := lvMultipleComputers.Items[iLoop].SubItems[0];
        sComputer := UpperCase(lvMultipleComputers.Items[iLoop].SubItems[1]);

        if sComputer = '' then
          sComputer := '-';

        slMachines.Add(sComputer + '^' + sIp);
        Inc(iChecked);
      end;
    end;

    if iChecked < 1 then
    begin
      MessageDlg('There are no selected computers from the list.' + #13#10
        + 'Please check the box next to the computer(s) you would like to add.', mtError, [mbOK],
        0);
      Exit;
    end;

    bNewGroup := True; //default

{$IFDEF LITE_VERSION}
    sQuery := 'SELECT fldHostname From "' + INFO_TABLE + '";';
    GetSqlTableByQuery(sltbInfo, sQuery);

    if sltbInfo.Count + iChecked > 4 then
    begin
      MessageBox(0,
        'Only 5 hosts can be stored in the free version! Please upgrade for unlimited hosts.' + #13#10
        + '' + #13#10 + 'Visit www.WildPawSoftware.com to upgrade.',
        'Please upgrade to use this feature',
        MB_TASKMODAL or MB_TOPMOST or MB_ICONSTOP or MB_OK);
      //AvailableInProEdition();
      Exit;
    end;
{$ENDIF}

    sQuery := 'SELECT fldGroupName From "' + GROUP_TABLE + '"';
    GetSqlTableByQuery(sltbGroups, sQuery);

    while not sltbGroups.EOF do
    begin
      sDbGroup := sltbGroups.FieldAsString(sltbGroups.FieldIndex['fldGroupName']);

      if UpperCase(sDbGroup) = UpperCase(sGroup) then
      begin
        bNewGroup := False;
        Break;
      end;

      sltbGroups.Next;
    end;

    if bNewGroup then
    begin
      //
      AddNewGroup(sGroup);
    end;

    iChecked := 0; //default
    iAlreadyExist := 0; //default
    iAdded := 0;

    frmImportDelProgress := TfrmImportDeleteProgress.Create(self);
    try
      frmImportDelProgress.t_slMachineList := slMachines;
      frmImportDelProgress.t_sGroup := sGroup;
      frmImportDelProgress.t_bAddHosts := True;

      frmImportDelProgress.Position := poMainFormCenter;
      frmImportDelProgress.ShowModal;
    finally
      frmImportDelProgress.Release;
      Pointer(frmImportDelProgress) := nil;
    end;
  finally
    btnAddChecked.Enabled := True;
    FreeAndNil(slMachines);
  end;
end;

{
procedure TForm1.AdjustCheckListBox(listbox: TCheckListBox);
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
}

procedure TForm1.StoreAlternateCredentials(bUseAltCreds: boolean; const sEncUser, sEncPass:
  string; sHost: string; sGroup: string);
var
  sQuery                      : string;
begin

  sQuery := 'UPDATE  ' + INFO_TABLE + ' SET fldUseAltUser = "' + BoolToStr(bUseAltCreds, True) +
    '" WHERE fldHostname = "'
    + sHost + '" AND fldGroup = "' + sGroup + '";';

  ModifySqlTableByQuery(sQuery);

  sQuery := 'UPDATE  ' + INFO_TABLE
    + ' SET fldAltUser = "'
    + sEncUser + '", fldAltPass = "'
    + sEncPass +
    '" WHERE fldHostname = "'
    + sHost
    + '" AND fldGroup = "'
    + sGroup + '";';

  ModifySqlTableByQuery(sQuery);

end;
//
//procedure TForm1.StoreIpAddresses(const sGroup, sHost: string);
//var
//  sQuery                      : string;
//  sCommaText                  : string;
//  sCurIp                      : string;
//  idx                         : Integer;
//  sldb                        : TSQLiteDatabase;
//  bItemChecked                : boolean;
//  a                           : TListItem;
//begin
//  bItemChecked := False; //default
//  sldb := TSQLiteDatabase.Create(slDBPath);
//  try
//    for idx := 0 to lbIpAddresses.Items.Count - 1 do
//    begin
//      if lbIpAddresses.Checked[idx] then
//      begin
//        bItemChecked := True;
//        break;
//      end;
//    end;
//
//    if lbIpAddresses.Items.Count < 1 then
//      bItemChecked := True; //this is a lie, but oh well
//
//    if not bItemChecked then
//    begin
//      lbIpAddresses.Checked[0] := True;
//    end;
//
//    if lbIpAddresses.Items.Count > 0 then
//    begin
//      for idx := 0 to lbIpAddresses.Items.Count - 1 do
//      begin
//        sCurIp := lbIpAddresses.Items.Strings[idx];
//        if lbIpAddresses.Checked[idx] then
//        begin
//          sCommaText := sCommaText + sCurIp + '=1';
//        end
//        else
//        begin
//          sCommaText := sCommaText + sCurIp + '=0';
//        end;
//        if idx <> lbIpAddresses.Items.Count - 1 then
//        begin
//          sCommaText := sCommaText + ',';
//        end;
//      end;
//      sQuery := 'UPDATE  ' + INFO_TABLE + ' SET fldIpAddr = "' + sCommaText +
//        '" WHERE fldHostname = "' +
//        sHost + '" AND fldGroup = "' + sGroup + '";';
//      ModifySqlTableByQuery(sldb, sQuery);
//    end
//    else
//    begin
//      //
//      sQuery := 'UPDATE  ' + INFO_TABLE + ' SET fldIpAddr = "" WHERE fldHostname = "' +
//        sHost + '" AND fldGroup = "' + sGroup + '";';
//      ModifySqlTableByQuery(sldb, sQuery);
//    end;
//  finally
//    sldb.Free;
//  end;
//end;

//PopulateSysDetailMemo

procedure TForm1.SysDetailClear();
//var
  //NicItem                     : TListItem;
  //idx                         : Integer;
begin
  lblSysInfoHostname.Caption := '-';
  lblSysInfoHostname.Font.Color := clWhite;
  lblSysInfoHostname.Font.Size := 8;
  lblSysInfoHostname.Font.Style := [];
  lblSysInfoHostname.Top := 17;
  //
  lblSysInfoDomain.Caption := '-';
  lblSysInfoUsername.Caption := '-';
  lblSysInfoManufacturer.Caption := '-';
  lblSysInfoModel.Caption := '-';
  lblSysInfoSerial.Caption := '-';
  lblSysInfoPrimaryOwnerName.Caption := '-';
  lblSysInfoSystemType.Caption := '-';
  lblSysInfoTotalPhysMem.Caption := '-';
  lblSysInfoWindowsVersion.Caption := '-';
  lblUserMessageVisible.Caption := '-';
  lblUserCredentialsType.Caption := '-';
end;

procedure TForm1.ChangeListViewCheckStateAll(ListView: TListView; bCheckAll: boolean);
var
  idx                         : integer;
begin
  if not Assigned(ListView) then
    Exit;

  for idx := 0 to ListView.Items.Count - 1 do
  begin
    //
    ListView.Items[idx].Checked := bCheckAll;
  end;
end;

procedure TForm1.PopulateSysDetailMemo(MgSysInfo: TRemoteSysInfoArray);
const
  clOrange                    = TColor($0080FF); //TColor($0000A5FF);
var
  idx                         : Integer;
  bMsgShown                   : boolean;
begin
  bMsgShown := False;
  {
  for idx := 0 to Length(MgSysInfo) - 1 do
  begin
    lblSysInfoHostname.Caption := lblHost.Caption;

    //    if not SameText(lblSysInfoHostname.Caption, lblHost.Caption) then
    //    begin
    //      MessageBox(0,
    //        PChar('The hostname retrieved from the system does not match the host you requested!'+#13#10#13#10+'You have entered the host as [' +
    //        lblHost.Caption + '] but the query returned [' + lblSysInfoHostname.Caption + ']'
    //        + #13 + #10 + '' + #13 + #10 +
    //        'This could be an issue with DNS, but please ensure this is the correct system before deploying NIC Padlock.'),
    //        '', MB_ICONWARNING or MB_OK or MB_TOPMOST or MB_TASKMODAL);
    //      lblSysInfoHostname.Font.Color := clOrange;
    //      lblSysInfoHostname.Font.Size := 10;
    //      lblSysInfoHostname.Font.Style := [fsBold]; //, fsItalic];
    //      lblSysInfoHostname.Top := 16;
    //    end
    //    else
    begin
      lblSysInfoHostname.Font.Color := clWhite;
      lblSysInfoHostname.Font.Size := 8;
      lblSysInfoHostname.Font.Style := [];
      lblSysInfoHostname.Top := 17;
    end;

    lblSysInfoDomain.Caption := 'wildpaw.corp.com'; //(MgSysInfo[idx].sDomain);
    lblSysInfoUsername.Caption := 'ALincoln'; //(MgSysInfo[idx].sUsername);
    lblSysInfoManufacturer.Caption := MgSysInfo[idx].sManufacturer;
    lblSysInfoModel.Caption := '2910'; //MgSysInfo[idx].sModel;
    lblSysInfoSerial.Caption := '8923AQW'; //MgSysInfo[idx].sSerialNumber;
    lblSysInfoPrimaryOwnerName.Caption := 'alincoln'; //MgSysInfo[idx].sPrimaryOwnerName;
    lblSysInfoSystemType.Caption := MgSysInfo[idx].sSystemType;
    lblSysInfoTotalPhysMem.Caption := MgSysInfo[idx].sTotalPhysicalMemory;
    lblSysInfoWindowsVersion.Caption := MgSysInfo[idx].sOsVersion;
  end;
  }
  for idx := 0 to Length(MgSysInfo) - 1 do
  begin
    lblSysInfoHostname.Caption := (MgSysInfo[idx].sName);

    if not SameText(lblSysInfoHostname.Caption, lblHost.Caption) then
    begin
      if not bMsgShown then
      begin
        bMsgShown := True;
        MessageBox(0,
          PChar('The hostname retrieved from the system does not match the host you requested!' +
          #13#10#13#10 + 'You have entered the host as [' +
          lblHost.Caption + '] but the query returned [' + lblSysInfoHostname.Caption + ']'
          + #13 + #10 + '' + #13 + #10 +
          'This could be an issue with DNS, but please ensure this is the correct system before deploying NIC Padlock.'),
          '', MB_ICONWARNING or MB_OK or MB_TOPMOST or MB_TASKMODAL);
        lblSysInfoHostname.Font.Color := clOrange;
        lblSysInfoHostname.Font.Size := 10;
        lblSysInfoHostname.Font.Style := [fsBold]; //, fsItalic];
        lblSysInfoHostname.Top := 16;
      end;
    end
    else
    begin
      lblSysInfoHostname.Font.Color := clWhite;
      lblSysInfoHostname.Font.Size := 8;
      lblSysInfoHostname.Font.Style := [];
      lblSysInfoHostname.Top := 17;
    end;

    lblSysInfoDomain.Caption := (MgSysInfo[idx].sDomain);
    lblSysInfoUsername.Caption := (MgSysInfo[idx].sUsername);
    lblSysInfoManufacturer.Caption := (MgSysInfo[idx].sManufacturer);
    lblSysInfoModel.Caption := (MgSysInfo[idx].sModel);
    lblSysInfoSerial.Caption := MgSysInfo[idx].sSerialNumber;
    lblSysInfoPrimaryOwnerName.Caption := (MgSysInfo[idx].sPrimaryOwnerName);
    lblSysInfoSystemType.Caption := (MgSysInfo[idx].sSystemType);
    lblSysInfoTotalPhysMem.Caption := (MgSysInfo[idx].sTotalPhysicalMemory);
    lblSysInfoWindowsVersion.Caption := (MgSysInfo[idx].sOsVersion);
  end;

  PopulateLastQueriedDisplay();

end;

//procedure TForm1.RetrieveIpForHost(sTheHost, sTheGroup: string; bSilent: Boolean = False);
//var
//  slIpAddresses               : TStringList;
//  sHost                       : string;
//  asHostQuery                 : IAsyncCall;
//  sldb                        : TSQLiteDatabase;
//  sSQL                        : string;
//  i                           : integer;
//  //bCheckedAnItem    : boolean;
//begin
//  sHost := lblHost.Caption;
//  slIpAddresses := TStringList.Create;
//  try
//    slIpAddresses.Sorted := True;
//    slIpAddresses.Duplicates := dupIgnore;
//    //
//    asHostQuery := AsyncCall(@HostToIP, [sHost, slIpAddresses]);
//
//    while AsyncMultiSync([asHostQuery], True, 10) = WAIT_TIMEOUT do
//    begin
//      Application.ProcessMessages;
//    end;
//
//    if slIpAddresses.Count < 1 then
//    begin
//      if not bSilent then
//        MessageDlg('Could not retrieve the IP address. ' + ''#13'' + ''#10'' +
//          'Check that the host is online and available.', mtError, [mbOK], 0);
//    end;
//
//    AddNewResolvedIPs(slIpAddresses, sTheHost, sTheGroup);
//
//    //means the user is looking at this host's information
//    if not bSilent then
//    begin
//      //
//      sldb := TSQLiteDatabase.Create(slDBPath);
//      try
//        sSQL := 'SELECT * From "' + INFO_TABLE + '" WHERE fldGroup = "' + sTheGroup +
//          '" AND fldHostname = "' + sTheHost + '";';
//
//        GetSqlTableByQuery(sldb, sltbInfo, sSQL);
//
//        if sltbInfo.Count <= 0 then
//        begin
//          Exit;
//        end;
//
//        SetCheckedState(chkDisableAllAdapters, False);
//        SetCheckedState(chkEnableAllAdapters, False);
//
//        while not sltbInfo.eof do
//        begin
//          //slIpAddresses := TStringList.Create;
//          slIpAddresses.Clear;
//          //          try
//          slIpAddresses.CommaText := sltbInfo.FieldByName['fldIpAddr'];
//          lbIpAddresses.Clear;
//          for i := 0 to slIpAddresses.Count - 1 do
//          begin
//            lbIpAddresses.Items.Add(slIpAddresses.Names[i]);
//          end;
//
//          //bCheckedAnItem := False;      //default
//          for i := 0 to slIpAddresses.Count - 1 do
//          begin
//            if slIpAddresses.ValueFromIndex[i] = '0' then
//            begin
//              SetCheckedListboxState(lbIpAddresses, i, False);
//            end
//            else
//            begin
//              //if bCheckedAnItem then
//              //  SetCheckedListboxState(lbIpAddresses, i, False)
//              //else
//              SetCheckedListboxState(lbIpAddresses, i, True);
//
//              //bCheckedAnItem := True;
//            end;
//          end;
//          //          finally
//          //            FreeAndNil(slIpAddresses);
//          //          end;
//
//          sltbInfo.Next;
//        end;
//      finally
//        if sltbInfo <> nil then
//          FreeAndNil(sltbInfo);
//
//        sldb.Free;
//      end;
//    end;
//
//  finally
//    FreeAndNil(slIpAddresses);
//  end;
//  SetFieldsChanged(True);
//end;

procedure TForm1.puCheckAllClick(Sender: TObject);
begin
  ChangeListViewCheckStateAll(lvMultipleComputers, True);
end;

procedure TForm1.puCheckNoneClick(Sender: TObject);
begin
  ChangeListViewCheckStateAll(lvMultipleComputers, False);
end;

//procedure TForm1.rbInheritCredsClick(Sender: TObject);
//begin
//  main.Form1.StoreAlternateCredentials(False, '', '');
//  main.Form1.rbUseAltCreds.Hint := '';  //'User: ' + lblCredUser.Text;
//end;

procedure TForm1.rbHoursClick(Sender: TObject);
begin
  SetFieldsChanged(True);
end;

procedure TForm1.rbMinutesClick(Sender: TObject);
begin
  SetFieldsChanged(True);
end;

//procedure TForm1.Image1DblClick(Sender: TObject);
//begin
//  //
//  if PageControl1.ActivePage = Tab03_HostDetail then
//  begin
//    PrepareHostPing();
//  end;
//end;

function TForm1.IsValidName(sValue: string): boolean;
var
  FoundMatch                  : Boolean;
  Regex                       : TPerlRegEx;
begin
  FoundMatch := False;
  //default
  Regex := TPerlRegEx.Create(nil);
  try
    Regex.RegEx := '[\\/"*:<>%`{}?;]';
    Regex.Options := [preCaseless, preMultiLine];
    Regex.Subject := sValue;
    FoundMatch := Regex.Match;
  finally
    FreeAndNil(Regex);
  end;

  if FoundMatch then
  begin
    MessageDlg('This name contains invalid characters. The following characters are not allowed in the name: '
      + ''#13'' + ''#10'' + '' + ''#13'' + ''#10'' + '\ / " * : < > % ` { } ? ;', mtError, [mbOK],
      0);
  end;

  if sValue = '-' then
    FoundMatch := True;

  Result := not FoundMatch;
end;

procedure TForm1.SaveGroupState();
var
  sSQL                        : string;
  bExpanded                   : boolean;
  //
  RootNode, GroupNode         : PVirtualNode;
  GroupData                   : PHostRec;
  iLoop                       : Integer;
  ipc                         : Integer;
begin
  bExpanded := False; //default
  vst1.BeginUpdate;
  try
    //vst1.Clear;
    try
      RootNode := vst1.GetFirstLevel(0);
      ipc := RootNode.ChildCount - 1;
      for iLoop := 0 to ipc do
      begin
        if iLoop = 0 then
          GroupNode := RootNode.FirstChild //.NextSibling
        else
        begin
          GroupNode := GroupNode.NextSibling;

          if not Assigned(GroupNode) then
          begin
            GroupNode := GroupNode.NextSibling;
          end;

          if not Assigned(GroupNode) then
          begin
            GroupNode := GroupNode.NextSibling;
          end;
        end;

        if not Assigned(GroupNode) then
          Exit;

        vst1.ValidateNode(GroupNode, False);

        GroupData := vst1.GetNodeData(GroupNode);
        if GroupData^.ALevel = FOLDER_LEVEL then
        begin
          bExpanded := vsExpanded in GroupNode.States;

          sSQL := 'UPDATE ' + GROUP_TABLE
            + ' SET fldNodeExpanded = "' + BoolToStr(bExpanded)
            + '" WHERE fldGroupName = "' + GroupData^.AGroupname + '";';

          ModifySqlTableByQuery(sSQL);
          //
        end;
      end;
    except on E: Exception do
      begin
        //suppress
      end;
    end;
  finally
    vst1.EndUpdate;

    if sltbGroups <> nil then
      FreeAndNil(sltbGroups);
  end;
end;

procedure TForm1.AddNewGroup(sValue: string);
var
  sSQL                        : string;
  Node                        : PVirtualNode;
  Data                        : PHostRec;
  //sldb                        : TSQLiteDatabase;
begin

  if not IsValidName(sValue) then
    Exit;

  sSQL := 'SELECT * From "' + GROUP_TABLE + '" WHERE Upper(fldGroupName) = "' + UpperCase(sValue)
    + '";';

  //sldb := TSQLiteDatabase.Create(slDBPath);
  vst1.BeginUpdate;
  try
    GetSqlTableByQuery(sltbGroups, sSQL);
    if sltbGroups.Count > 0 then
    begin
      MessageDlg('This group already exists.', mtError, [mbOK], 0);
      Exit;
    end;

    sSQL := 'INSERT INTO "' + GROUP_TABLE + '" (fldGroupName) VALUES ("' + sValue + '");';

    ModifySqlTableByQuery(sSQL);
    Node := vst1.AddChild(NetworkNode);
    vst1.ValidateNode(Node, False);
    //Node.CheckType := ctNone; // ctCheckBox
    //Node.CheckState := csUncheckedNormal;
    //
    Data := vst1.GetNodeData(Node);

    //
    Data^.AGroupname := sValue;
    Data^.AHostname := '-';
    Data^.ALevel := FOLDER_LEVEL;
  finally
    vst1.EndUpdate;
    if sltbGroups <> nil then
      FreeAndNil(sltbGroups);
    //sldb.Free;
  end;

  UpdateNetworkSummary();
end;

procedure TForm1.PopulateLastQueriedDisplay(sCustomMsg: string = '');
var
  sLastRefreshed              : string;
  sQuery                      : string;
begin
  sQuery := 'SELECT fldLastQueried From "' + INFO_TABLE + '" WHERE fldGroup = "' +
    lblGroup.Caption + '" AND fldHostname = "' + lblHost.Caption + '";';
  GetSqlTableByQuery(sltbInfo, sQuery);
  if sltbInfo.Count <= 0 then
  begin
  end;

  while not sltbInfo.eof do
  begin
    sLastRefreshed := sltbInfo.FieldByName['fldLastQueried'];
    if Length(sLastRefreshed) < 1 then
    begin
      sLastRefreshed := ' -';
    end;
    sltbInfo.Next;
  end;

  if Length(Trim(sCustomMsg)) > 0 then
    lblLastRefreshed.Caption := 'Last Retrieved: ' + sCustomMsg
  else
    lblLastRefreshed.Caption := 'Last Retrieved: ' + sLastRefreshed;
end;

procedure TForm1.PopulateAutorunDisplayFromDb(const sTheGroup, sTheHost: string);
var
  sLastRefreshed              : string;
  sQuery                      : string;
  ms                          : TMemoryStream;
  sltbU                       : TSQLiteUniTable;
  i                           : integer;
  mgAutorunInfo               : TRemoteStartupInfoArray;
  sSQL                        : string;
  liStartupItem               : TListItem;
  iNumBytes, iFldIndex        : Integer;
  BlobPtr                     : Pointer;
begin

  ms := TMemoryStream.Create;
  sSQL := 'SELECT fldStartupInfo From "' + INFO_TABLE + '" WHERE fldGroup = "' +
    sTheGroup + '" AND fldHostname = "' + sTheHost + '";';

  GetSqlUnicodeTableByQuery(sltbU, sSQL);
  //ms := sltbU.FieldAsBlob(sltbU.FieldIndex['fldStartupInfo']);

  try
    iFldIndex := sltbU.FieldIndex['fldStartupInfo'];
    BlobPtr := sltbU.FieldAsBlobPtr(iFldIndex, iNumBytes);
    if Assigned(ms) then
    begin
      ms.WriteBuffer(BlobPtr^, iNumBytes);
      ms.Position := 0;
      //default
      try
        ms.ReadBuffer(i, 4);
        //get # of elements
        SetLength(mgAutorunInfo, i);
        try
          ms.ReadBuffer(Pointer(mgAutorunInfo)^, (Length(mgAutorunInfo) *
            SizeOf(TRemoteStartupInfo)) + 4);
        except on e: Exception do
          begin
            //
          end;
        end;

        lvAutoStartApplications.Clear;
        for i := 0 to Length(mgAutorunInfo) - 1 do
        begin
          if Length(Trim(mgAutorunInfo[i].sCommand)) < 1 then
            continue;

          liStartupItem := lvAutoStartApplications.Items.Add;
          liStartupItem.Caption := mgAutorunInfo[i].sCaption;
          liStartupItem.SubItems.Add(mgAutorunInfo[i].sCommand);
          liStartupItem.SubItems.Add(mgAutorunInfo[i].sUser);
          liStartupItem.SubItems.Add(mgAutorunInfo[i].sLocation);
        end;
        SetLength(mgAutorunInfo, 0);
        //PopulateNicDetailListView(MgNicArray, bEnableAll, bDisableAll);
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
end;

procedure TForm1.SetFieldsChanged(bChanged: boolean);
begin
  bFieldsChanged := bChanged;

  actnSaveHost.Enabled := bChanged;
end;

procedure TForm1.PopulateNicDetailListView(MgNicArray: TRemoteNicArray; bEnableAll: boolean =
  False; bDisableAll: boolean = False);
var
  idx, iEnable, iDisable      : Integer;
  onLVItemCheckHandler        : TLVCheckedItemEvent;
  NicItem                     : TListItem;
  onLVClickHandler            : TLVColumnClickEvent;
begin
  onLVClickHandler := lvRemoteNicsColumnClick;
  onLVItemCheckHandler := lvRemoteNicsItemChecked;
  lvRemoteNics.OnColumnClick := nil;
  lvRemoteNics.OnItemChecked := nil;

  lvRemoteNics.Clear;

  iEnable := 0;
  iDisable := 0;
  for idx := 0 to Length(MgNicArray) - 1 do
  begin
    NicItem := lvRemoteNics.Items.Add;

    if MgNicArray[idx].bEnableAdapter then
      Inc(iEnable);

    if MgNicArray[idx].bDisableAdapter then
      Inc(iDisable);

    try
      NicItem.Caption := BoolToStr(MgNicArray[idx].bEnableAdapter);
      NicItem.SubItems.Add(BoolToStr(MgNicArray[idx].bDisableAdapter));
    except on E: Exception do
      begin
        //
      end;
    end;

    NicItem.SubItems.Add(MgNicArray[idx].sIpAddress);
    NicItem.SubItems.Add(MgNicArray[idx].sMac);
    NicItem.SubItems.Add(MgNicArray[idx].sManufacturer);
    NicItem.SubItems.Add(MgNicArray[idx].sName);
    NicItem.SubItems.Add(MgNicArray[idx].sGuid);
  end;
  lvRemoteNics.OnColumnClick := onLVClickHandler;
  lvRemoteNics.OnItemChecked := onLVItemCheckHandler;

  if (not bEnableAll) and (not bDisableAll) then
  begin
    if iEnable = Length(MgNicArray) then
    begin
      SetCheckedState(chkEnableAllAdapters, True);
      SetCheckedState(chkDisableAllAdapters, False);
      Exit;
    end
    else if iDisable = Length(MgNicArray) then
    begin
      SetCheckedState(chkEnableAllAdapters, False);
      SetCheckedState(chkDisableAllAdapters, True);
      Exit;
    end;
  end;

  if ((iEnable > 0) or (iDisable > 0)) then
  begin
    //show advanced view
    if (not chkDisableAllAdapters.Checked) and (not chkEnableAllAdapters.Checked) then
    begin
      lvRemoteNics.DoubleBuffered := False;
      //if not AnimateWindow(lvRemoteNics.Handle, 200, AW_VER_NEGATIVE or AW_SLIDE or AW_HIDE) then
      //begin
      //  AnimateWindow(lvRemoteNics.Handle, 200, AW_VER_POSITIVE or AW_SLIDE);
      //end;

      lvRemoteNics.DoubleBuffered := True;
      lvRemoteNics.Repaint;
    end;

    lvRemoteNics.Refresh;
  end;

  if (chkDisableAllAdapters.Checked) or (chkEnableAllAdapters.Checked) then
  begin
    lvRemoteNics.Enabled := False;
    lvRemoteNics.Color := cl3DLight;
    //lvRemoteNics.Font.Color := cl3DLight;
    //lvRemoteNics.Font.Style := [fsItalic];
  end
  else
  begin
    lvRemoteNics.Enabled := True;
    lvRemoteNics.Color := clWindow;
    //lvRemoteNics.Font.Color := clWindowText;
    //lvRemoteNics.Font.Style := [];
  end;

  if bEnableAll and bDisableAll then
  begin
    //hmmm, both are set to TRUE...not possible...leave them both unchecked...no soup for you!
    bEnableAll := False;
    bDisableAll := False;
  end;

  if bEnableAll then
  begin
    chkEnableAllAdapters.Checked := True;
    EnableAllAdaptersInListview();
    SetCheckedState(chkDisableAllAdapters, False);
    SetFieldsChanged(False);
  end
  else if bDisableAll then
  begin
    SetCheckedState(chkEnableAllAdapters, False);
    chkDisableAllAdapters.Checked := True;
    DisableAllAdaptersInListview();
    SetFieldsChanged(False);
  end;

end;

procedure TForm1.RetrieveDbUserMessage(const sGroup, sHost: string; var sUserMessage: string;
  var bShowUserMessage: boolean);
var
  //sldb                        : TSQLiteDatabase;
  sSQL                        : string;
begin

  //sldb := TSQLiteDatabase.Create(slDBPath);
  try
    sSQL := 'SELECT * From "' + INFO_TABLE + '" WHERE fldGroup = "' + sGroup +
      '" AND fldHostname = "' + sHost + '";';

    GetSqlTableByQuery(sltbInfo, sSQL);

    if sltbInfo.Count <= 0 then
    begin
      Exit;
    end;

    while not sltbInfo.eof do
    begin
      bShowUserMessage := StrToBool(sltbInfo.FieldByName['fldShowUserMessage']);
      if bShowUserMessage then
      begin
        sUserMessage := sltbInfo.FieldByName['fldUserMessage'];
      end
      else
      begin
        sUserMessage := '';
      end;
      sltbInfo.Next;
    end;
  finally
    if sltbInfo <> nil then
      FreeAndNil(sltbInfo);

    //sldb.Free;
  end;
end;

procedure TForm1.GetDatabaseFullName;
var
  sAppName                    : string;
  sPath                       : string;
  sCurPath                    : string;
begin
  //true
  //  if IsDirectoryWriteable(ExtractFilePath(Application.ExeName)) then
  //  begin
  //    if not DirectoryExists(IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName)) + 'nldata')
  //      then
  //    begin
  //      CreateDir(IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName)) + 'nldata');
  //    end;
  //
  //    sPath := ExtractFilePath(Application.ExeName); // + 'nldata\niclocker.sqlite ';
  //  end
  //  else
  //begin
  sAppName := ExtractFileName(Application.ExeName);
  sAppName := ReplaceText(sAppName, ExtractFileExt('.' + sAppName), '');

  sCurPath := IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName));

  if IsDirectoryWriteable(sCurPath) then
  begin
    if FileExists(sCurPath + SQLITE_DATA_FILE) then
    begin
      slDBPath := IncludeTrailingPathDelimiter(sPath) + 'nldata\' + SQLITE_DATA_FILE;
      Exit;
    end;
  end;

  sPath := IncludeTrailingPathDelimiter(GetRoamingUserAppDataPath) + sAppName;

  if not DirectoryExists(sPath) then
  begin
    CreateDir(sPath);
  end;
  sPath := IncludeTrailingPathDelimiter(sPath);

  if not DirectoryExists(sPath + 'nldata') then
  begin
    CreateDir(sPath + 'nldata');
  end;
  //end;
  slDBPath := IncludeTrailingPathDelimiter(sPath) + 'nldata\' + SQLITE_DATA_FILE;
end;

procedure TForm1.SetVisualActionStates(var Node: PVirtualNode; iNodeLevel: Integer; const sHost,
  sGroup: string);
var
  //Data                        : PHostRec;
  sHint                       : string;
  //iNodeLevel                  : Integer;
begin
  //Node := vst1.FocusedNode;
  if Assigned(Node) then
  begin
    //
    if vst1.SelectedCount <= 1 then
    begin
      vst1.BeginUpdate;
      vst1.ClearSelection;
      vst1.FocusedNode := Node;
      vst1.Selected[Node] := True;
      vst1.InvalidateNode(Node);
      vst1.EndUpdate;
    end
    else
    begin
      //iNodeLevel := TBaseVirtualTree(Sender).GetNodeLevel(Node);
      if iNodeLevel > FOLDER_LEVEL then
      begin
        sHint := 'Remove selected hosts';
        // + Data.AHostname + '" computer';
        actnRemoveGroup.Hint := '';
        actnRemoveGroup.Caption := 'Remove group';
        actnRemoveComputer.Hint := sHint;
        actnRemoveComputer.Caption := sHint;
        actAddOneComputer.Enabled := False;
        actAddMultipleComputers.Enabled := True;
        actnRemoveComputer.Enabled := True;
        actnRenameComputer.Enabled := False;

        actAddNewGroup.Enabled := False;
        actnRemoveGroup.Enabled := False;

        HostSpecificActions1.Enabled := False;
        Exit;
      end;
      //vstPopupMenu.Items[4].Visible := False;
    end;

    if iNodeLevel = HOST_LEVEL then
    begin
      sHint := 'Remove "' + sHost + '" computer';
      actnRemoveGroup.Hint := '';
      actnRemoveGroup.Caption := 'Remove group';
      actnRemoveComputer.Hint := sHint;
      actnRemoveComputer.Caption := sHint;
      actAddOneComputer.Enabled := False;
      actAddMultipleComputers.Enabled := True;
      actnRemoveComputer.Enabled := True;
      actnRenameComputer.Enabled := True;
      actAddNewGroup.Enabled := False;
      actnRemoveGroup.Enabled := False;
      HostSpecificActions1.Enabled := True;
    end
    else if iNodeLevel = FOLDER_LEVEL then
    begin
      sHint := 'Remove "' + sGroup + '" group';
      actnRemoveGroup.Hint := sHint;
      actnRemoveGroup.Caption := sHint;
      actnRemoveComputer.Hint := '';
      actnRemoveComputer.Caption := 'Remove computer';
      actAddOneComputer.Enabled := True;
      actAddMultipleComputers.Enabled := True;
      actnRemoveComputer.Enabled := False;
      actnRenameComputer.Enabled := False;
      actAddNewGroup.Enabled := True;
      actnRemoveGroup.Enabled := True;

      HostSpecificActions1.Enabled := False;
    end
    else {//vstPopupMenu.Items[4].Visible} if iNodeLevel = NETWORK_LEVEL then
    begin
      //
      actnRemoveGroup.Hint := '';
      actnRemoveGroup.Caption := 'Remove group';
      actnRemoveComputer.Hint := '';
      actnRemoveComputer.Caption := 'Remove computer';
      actAddOneComputer.Enabled := False;
      actAddMultipleComputers.Enabled := True;
      actnRemoveComputer.Enabled := False;
      actnRenameComputer.Enabled := False;
      actAddNewGroup.Enabled := True;
      actnRemoveGroup.Enabled := False;

      HostSpecificActions1.Enabled := False;
    end;
  end
  else
  begin
    //
    actnRemoveGroup.Hint := '';
    actnRemoveGroup.Caption := 'Remove group';
    actnRemoveComputer.Hint := '';
    actnRemoveComputer.Caption := 'Remove computer';
    actAddOneComputer.Enabled := False;
    actAddMultipleComputers.Enabled := True;
    actnRemoveComputer.Enabled := False;
    actnRenameComputer.Enabled := False;
    actAddNewGroup.Enabled := True;
    actnRemoveGroup.Enabled := False;

    HostSpecificActions1.Enabled := False;
  end;
end;
//

procedure TForm1.ShowNodeDetails(iNodeLevel: Integer; Data: PHostRec);
var
  ms                          : TMemoryStream;
  sltbU                       : TSQLiteUniTable;
  sSQL                        : string;
  sLastRefreshed              : string;
  sLastDeployed               : string;
  MgNicArray                  : TRemoteNicArray;
  MgSysInfo                   : TRemoteSysInfoArray;
  slIpAddresses               : TStringList;
  i                           : Integer;
  ComputerItem                : TListItem;
  bEnableAll, bDisableAll     : boolean;
  bReEnableNics               : boolean;
  sReEnableTime               : string;
  extReEnableTime             : Extended;
  bUseAltUser                 : boolean;
  bAutoUpdateIp               : boolean;
  sUsername                   : string;
  bShowUserMessage            : boolean;
  iHostOnline                 : integer;
  iNumBytes, iFldIndex        : integer;
  BlobPtr                     : Pointer;
begin

  if not SameText(uGlobal.sUserSuppliedHashedPass, uGlobal.sHashedPass) then
    Exit;

  if iNodeLevel = HOST_LEVEL then
  begin

    PageControl1.ActivePage := Tab03_HostDetail;
    actnRefreshHost.Enabled := True;
    try
      try
        sSQL := 'SELECT * From "' + INFO_TABLE + '" WHERE fldGroup = "' + Data.AGroupname +
          '" AND fldHostname = "' + Data.AHostname + '";';

        GetSqlTableByQuery(sltbInfo, sSQL);

        if sltbInfo.Count <= 0 then
        begin
          SysDetailClear();
          Exit;
        end;

        mmoDeploymentResult.Text := '';
        lvRemoteNics.Clear;
        lblRemoteIpAddress.Caption := '';

        SysDetailClear();
        SetCheckedState(chkDisableAllAdapters, False);
        SetCheckedState(chkEnableAllAdapters, False);

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
              end
              else
              begin
                lblRemoteIpAddress.Caption := slIpAddresses.Names[i];
                //SetCheckedListboxState(lbIpAddresses, i, True);
              end;
            end;
          finally
            FreeAndNil(slIpAddresses);
          end;

          sLastRefreshed := sltbInfo.FieldByName['fldLastQueried'];
          if Length(sLastRefreshed) < 1 then
          begin
            sLastRefreshed := ' -';
          end;

          sLastDeployed := sltbInfo.FieldByName['fldDeploymentResult'];
          if Length(sLastDeployed) < 1 then
          begin
            sLastDeployed := ' -';
          end;

          lblLastRefreshed.Caption := 'Last Retrieved: ' + sLastRefreshed;
          mmoDeploymentResult.Text := 'Deployment Info: ' + sLastDeployed;
          //
          bUseAltUser := StrToBool(sltbInfo.FieldByName['fldUseAltUser']);

          bShowUserMessage := False; //default
          bShowUserMessage := StrToBool(sltbInfo.FieldByName['fldShowUserMessage']);

          if bShowUserMessage then
          begin
            lblUserMessageVisible.Caption := 'Yes, a message will be shown';
          end
          else
          begin
            lblUserMessageVisible.Caption := 'No message will be shown';
          end;

          if bUseAltUser then
          begin
            sUsername := DecryptDbString(sltbInfo.FieldByName['fldAltUser']);
            lblUserCredentialsType.Caption := '[' + sUsername + ']';
          end
          else
          begin
            lblUserCredentialsType.Caption := 'Inherited';
          end;

          bAutoUpdateIp := True;
          bAutoUpdateIp := StrToBool(sltbInfo.FieldByName['fldAutoUpdateIp']);

          actnAutoUpdateIp.Checked := bAutoUpdateIp;

          bEnableAll := StrToBool(sltbInfo.FieldByName['fldEnableAllNics']);
          bDisableAll := StrToBool(sltbInfo.FieldByName['fldDisableAllNics']);

          bReEnableNics := StrToBool(sltbInfo.FieldByName['fldReEnableNics']);
          sReEnableTime := sltbInfo.FieldByName['fldReEnableTime'];

          if sReEnableTime <> '0' then
          begin
            if IsStrFloatNum(sReEnableTime) then
            begin
              extReEnableTime := StrToFloat(sReEnableTime);
              extReEnableTime := extReEnableTime * 60; //convert to minutes
              seHoursMinutes.Value := Round(extReEnableTime);

              SetCheckedRadioBtnState(rbMinutes, True);
              SetCheckedRadioBtnState(rbHours, False);

            end
            else
            begin
              extReEnableTime := StrToInt(sReEnableTime);
              seHoursMinutes.Value := Trunc(extReEnableTime);
              SetCheckedRadioBtnState(rbMinutes, False);
              SetCheckedRadioBtnState(rbHours, True);
            end;
          end
          else
          begin
            //
            SetCheckedRadioBtnState(rbMinutes, False);
            SetCheckedRadioBtnState(rbHours, True);
          end;

          if bReEnableNics then
          begin
            SetCheckedState(cbReEnableAdapters, True);
            rbHours.Enabled := True;
            rbMinutes.Enabled := True;
            seHoursMinutes.Enabled := True;
          end
          else
          begin
            SetCheckedState(cbReEnableAdapters, False);
            rbHours.Enabled := False;
            rbMinutes.Enabled := False;
            seHoursMinutes.Value := 1;
            seHoursMinutes.Enabled := False;
          end;

          if bEnableAll and bDisableAll then
          begin
            //hmmm, both are set to TRUE...not possible...leave them both unchecked...no soup for you!
            bEnableAll := False;
            bDisableAll := False;
          end;

          if bEnableAll then
          begin
            SetCheckedState(chkEnableAllAdapters, True);
            SetCheckedState(chkDisableAllAdapters, False);
          end
          else if bDisableAll then
          begin
            SetCheckedState(chkEnableAllAdapters, False);
            SetCheckedState(chkDisableAllAdapters, True);
          end;

          if Length(sltbInfo.FieldByName['fldHostOnline']) < 1 then
          begin
            iHostOnline := 0; //
          end
          else
          begin
            iHostOnline := StrToInt(sltbInfo.FieldByName['fldHostOnline']);

            if (iHostOnline <> 0) and (iHostOnline <> 1) then
              iHostOnline := 0;
          end;

          Data^.AbOnline := iHostOnline;

          ms := TMemoryStream.Create;
          sSQL := 'SELECT fldNicDetails From "' + INFO_TABLE + '" WHERE fldGroup = "' +
            Data.AGroupname + '" AND fldHostname = "' + Data.AHostname + '";';

          GetSqlUnicodeTableByQuery(sltbU, sSQL);

          try
            //ms := sltbU.FieldAsBlob(sltbU.FieldIndex['fldNicDetails']);
            iFldIndex := sltbU.FieldIndex['fldNicDetails'];
            BlobPtr := sltbU.FieldAsBlobPtr(iFldIndex, iNumBytes);
            if Assigned(ms) then
            begin
              ms.WriteBuffer(BlobPtr^, iNumBytes);
              ms.Position := 0;
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
                PopulateNicDetailListView(MgNicArray, bEnableAll, bDisableAll);
                SetLength(MgNicArray, 0); //free it
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

          lvAutoStartApplications.Clear;
          PopulateAutorunDisplayFromDb(Data.AGroupname, Data.AHostname);

          ms := TMemoryStream.Create;

          sSQL := 'SELECT fldSystemDetails From "' + INFO_TABLE + '" WHERE fldGroup = "' +
            Data.AGroupname + '" AND fldHostname = "' + Data.AHostname + '";';

          GetSqlUnicodeTableByQuery(sltbU, sSQL);
          //ms := sltbU.FieldAsBlob(sltbU.FieldIndex['fldSystemDetails']);
          try
            //ms := sltbU.FieldAsBlob(sltbU.FieldIndex['fldSystemDetails']);
            iFldIndex := sltbU.FieldIndex['fldSystemDetails'];
            BlobPtr := sltbU.FieldAsBlobPtr(iFldIndex, iNumBytes);
            if Assigned(ms) then
            begin
              ms.WriteBuffer(BlobPtr^, iNumBytes);
              ms.Position := 0;
              i := 0;
              try
                ms.ReadBuffer(i, 4);
                //get # of elements
                SetLength(MgSysInfo, i);
                try
                  ms.ReadBuffer(Pointer(MgSysInfo)^, (Length(MgSysInfo) * SizeOf(TRemoteSysInfo)) +
                    4);
                except on e: Exception do
                  begin
                    //
                  end;
                end;
                PopulateSysDetailMemo(MgSysInfo);
                SetLength(MgSysInfo, 0);
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

      HideCaret(mmoDeploymentResult.Handle);

    finally
      if sltbInfo <> nil then
        FreeAndNil(sltbInfo);

    end;

{$IFDEF LITE_VERSION}
    chkEnableAllAdapters.Enabled := False;
    chkEnableAllAdapters.Checked := False;
    SetCheckedState(chkEnableAllAdapters, False);
    chkDisableAllAdapters.Enabled := True;
    chkDisableAllAdapters.Checked := True;
{$ENDIF}

  end
  else if iNodeLevel = FOLDER_LEVEL then
  begin
    //nodelevel = 0 = this is folder group

    lvGroupHosts.Clear;
    lblGroupHosts.Caption := Data.AGroupname;
    SetCheckedState(cbGroupHostsEnableAll, False);
    SetCheckedState(cbGroupHostsDisableAll, False);
    SetCheckedState(cbGroupHostsUseAltCreds, False);
    SetCheckedState(cbGroupHostsReEnableAfter, False);
    seGroupHostsHoursMinutes.Value := 1;
    rbGroupHostsHours.Enabled := False;
    rbGroupHostsMinutes.Enabled := False;
    lblGroupHostsCredUser.Text := '';
    lblGroupHostsCredPass.Text := '';

    PageControl1.ActivePage := Tab02_GeneralInfo;

    try
      sSQL := 'SELECT * From "' + INFO_TABLE + '" WHERE fldGroup = "' + Data.AGroupname + '";';

      GetSqlTableByQuery(sltbInfo, sSQL);

      while not sltbInfo.eof do
      begin
        //
        ComputerItem := lvGroupHosts.Items.Add;
        ComputerItem.Caption := ''; //checkbox
        ComputerItem.SubItems.Add(sltbInfo.FieldByName['fldHostname']);

        sltbInfo.Next;
      end;
    finally
      if sltbInfo <> nil then
        FreeAndNil(sltbInfo);

      //sldb.Free;
    end;

    if lvGroupHosts.Items.Count < 1 then
    begin
      //todo: add guide
      lvGroupHosts.Enabled := False;
      panelNoHostsInGroup.Visible := True;
    end
    else
    begin
      lvGroupHosts.Enabled := True;
      panelNoHostsInGroup.Visible := False;
    end;

    ToggleNicOptionsPage(False);
    ToggleCredentialsPage(False);
    ToggleUserMessagePage(False);
    SetCheckedState(chkModifyCredentials, False);
    SetCheckedState(chkModifyNicOptions, False);
    SetCheckedState(chkModifyUserMessage, False);
  end
  else if iNodeLevel = NETWORK_LEVEL then
  begin
    PageControl1.ActivePage := Tab01_NetworkInfo;

    sSQL := 'SELECT fldGroupName From "' + GROUP_TABLE + '"';
    GetSqlTableByQuery(sltbGroups, sSQL);

    while not sltbGroups.EOF do
    begin
      cbGroups.Items.Add(sltbGroups.FieldAsString(sltbGroups.FieldIndex['fldGroupName']));
      sltbGroups.Next;
    end;

    UpdateNetworkSummary();

    if cbGroups.Items.Count >= 1 then
      cbGroups.ItemIndex := 0;

  end;
end;

{
procedure TForm1.SetGuiWidth();
var
  iWidth                      : integer;
begin
  iWidth := PageControl1.Width
    + panelStringTree.Padding.Left
    + panelStringTree.Padding.Right
    + panelStringTree.Margins.Left
    + panelStringTree.Margins.Right
    + PageControl1.Padding.Left
    + PageControl1.Padding.Right
    + PageControl1.Margins.Left
    + PageControl1.Margins.Right
    + Splitter1.Margins.Left
    + Splitter1.Margins.Right
    + Splitter1.Width
    - 2; //I dont know why -2

  if DETAIL_PANEL_WIDTH > iWidth then
  begin
    iWidth := DETAIL_PANEL_WIDTH;
  end;

  Form1.Width := panelStringTree.Width + iWidth;
end;
}

procedure TForm1.Splitter1Moved(Sender: TObject);
begin
  //SetGuiWidth();
end;

procedure TForm1.UpdateNetworkSummary();
var
  sSQL                        : string;
begin

  sSQL := 'SELECT fldGroupName From "' + GROUP_TABLE + '"';
  GetSqlTableByQuery(sltbGroups, sSQL);

  lblNumGroups.Caption := 'Number of Groups: ' + IntToStr(sltbGroups.Count);

  sSQL := 'SELECT fldHostname, fldGroup From "' + INFO_TABLE + '" WHERE fldHostname' +
    ' NOT NULL AND fldHostname <> "" AND fldGroup NOT NULL AND fldGroup <> ""';
  GetSqlTableByQuery(sltbInfo, sSQL);

  lblNumHosts.Caption := 'Number of Hosts: ' + IntToStr(sltbInfo.Count);

  sSQL := 'SELECT fldGroupName From "' + GROUP_TABLE + '"';
  GetSqlTableByQuery(sltbGroups, sSQL);

  cbGroups.Clear;

  while not sltbGroups.EOF do
  begin
    cbGroups.Items.Add(sltbGroups.FieldAsString(sltbGroups.FieldIndex['fldGroupName']));
    sltbGroups.Next;
  end;

  vst1.BeginUpdate;
  try
    vst1.Invalidate;
    vst1.SortTree(0, sdAscending, true);
  finally
    vst1.EndUpdate;
  end;

end;

procedure TForm1.btnDeployToCheckedHostsClick(Sender: TObject);
var
  iChecked, iLoop             : integer;
  slMachines                  : TStringList;
begin
  //

  iChecked := 0; //default

  slMachines := TStringList.Create;
  try
    slMachines.Sorted := True;
    slMachines.Duplicates := dupIgnore;
    //
    for iLoop := 0 to lvGroupHosts.Items.Count - 1 do
    begin
      if lvGroupHosts.Items[iLoop].Checked then
      begin
        Inc(iChecked);
        slMachines.Add(lvGroupHosts.Items[iLoop].SubItems[0]);
      end;
    end;

    if iChecked < 1 then
    begin
      MessageDlg('You must check at least 1 host.', mtError, [mbOK], 0);
      Exit;
    end;

    if (MessageDlg('Are you sure you want to deploy to these ' + IntToStr(iChecked)
      + ' hosts?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then

      DeploySvcToList(slMachines, lblGroupHosts.Caption);
  finally
    FreeAndNil(slMachines);
  end;

end;

procedure TForm1.btnDisplayEditUserMessageClick(Sender: TObject);
begin
  ShowUserEditMessage();
end;

procedure TForm1.btnGetSysInfoListClick(Sender: TObject);
var
  iChecked, iLoop             : integer;
  slMachines                  : TStringList;
begin

  iChecked := 0; //default

  slMachines := TStringList.Create;
  try
    slMachines.Sorted := True;
    slMachines.Duplicates := dupIgnore;
    //
    for iLoop := 0 to lvGroupHosts.Items.Count - 1 do
    begin
      if lvGroupHosts.Items[iLoop].Checked then
      begin
        Inc(iChecked);
        slMachines.Add(lvGroupHosts.Items[iLoop].SubItems[0]);
      end;
    end;

    if iChecked < 1 then
    begin
      MessageDlg('You must check at least 1 host.', mtError, [mbOK], 0);
      Exit;
    end;

    if (MessageDlg('Are you sure you want to retrieve information from these ' + IntToStr(iChecked)
      + ' hosts?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then

      GetHostInfoFromList(slMachines, lblGroupHosts.Caption);
  finally
    FreeAndNil(slMachines);
  end;
end;

procedure TForm1.btnHostActionsClick(Sender: TObject);
begin
  btnHostActions.CheckMenuDropdown;
end;

//procedure TForm1.btnGetSysInfoListClick(Sender: TObject);

procedure TForm1.GetHostInfoFromList(sMachineList: TStringList; sTheGroup: string);
var
  frmMassRetrieve             : TfrmMassRetrieveInfo;
begin

  //{$IFNDEF LITE_VERSION}
  frmMassRetrieve := TfrmMassRetrieveInfo.Create(self);
  try
    frmMassRetrieve.t_sGroup := sTheGroup;
    frmMassRetrieve.t_slMachineList := sMachineList;

    frmMassRetrieve.Position := poMainFormCenter;
    frmMassRetrieve.ShowModal;

  finally
    frmMassRetrieve.Release;
    Pointer(frmMassRetrieve) := nil;
  end;

  vst1.BeginUpdate;
  try
    vst1.Invalidate;
    vst1.SortTree(0, sdAscending, true);
  finally
    vst1.EndUpdate;
  end;

  //{$ENDIF}
end;

procedure TForm1.ShowUserEditMessage();
var
  frmMsg                      : TfrmUserMsgOnDisable;
begin
  frmMsg := TfrmUserMsgOnDisable.Create(nil);
  try
    frmMsg.Position := poMainFormCenter;
    frmMsg.ShowModal;

  finally
    frmMsg.Release;
    Pointer(frmMsg) := nil;

    //FreeAndNil(frmMsg);
  end;
end;

procedure TForm1.btnImportHostsClick(Sender: TObject);
var
  od1                         : TOpenDialog; // Open dialog variable
  slImported, slRow           : TStringList;
  sLine                       : string;
  iCurDelim                   : integer;
  Item                        : TListItem;
  sIp, sHost                  : string;
  bIsIpV6                     : boolean;
begin

  od1 := TOpenDialog.Create(self);
  try
    //openDialog.InitialDir := GetCurrentDir;
    od1.Options := [ofFileMustExist];
    od1.Filter :=
      'Comma separated values|*.csv|Text files|*.txt';
    od1.FilterIndex := 1;

    // Display the open file dialog
    if od1.Execute then
    begin
      //ShowMessage('File : ' + od1.FileName)
      slImported := TStringList.Create;
      slRow := TStringList.Create;
      try
        slRow.StrictDelimiter := True;
        slRow.Delimiter := ',';
        slImported.LoadFromFile(od1.FileName);
        for sLine in slImported do
        begin
          //
          sIp := '';
          sHost := '';
          //
 //         Item := lvMultipleComputers.Items.Add;
//          Item.Caption := ''; //checkbox
          //
          slRow.DelimitedText := sLine;
          for iCurDelim := 0 to slRow.Count - 1 do
          begin
            case iCurDelim of
              0: sHost := Trim(slRow[iCurDelim]); //Host
              1: sIp := Trim(slRow[iCurDelim]); //IP Address
            end;
          end;

          if uHelpers.IsAnIpAddress(sHost, bIsIpV6) then
          begin
            sIp := sHost;
            sHost := '';
          end;

          if (Length(sHost) <= 255)
            and (Length(sHost) >= 1)
            and (Length(sIp) >= 1)
            and (Length(sIp) <= 25)
            and (IsValidName(sHost)) then
          begin
            Item := lvMultipleComputers.Items.Add;
            Item.Caption := ''; //checkbox
            Item.SubItems.Add(sIp);
            Item.SubItems.Add(sHost);
          end
          else
          begin
            if (Length(sHost) >= 1)
              or (Length(sIp) >= 1) then
            begin

              if Length(sIp) < 1 then
              begin
                //no IP entered, just a hostname
                if (Length(sHost) <= 255) and (IsValidName(sHost)) then
                begin
                  Item := lvMultipleComputers.Items.Add;
                  Item.Caption := ''; //checkbox
                  Item.SubItems.Add(sIp);
                  Item.SubItems.Add(sHost);
                end;
              end
              else
              begin
                if Length(sIp) <= 25 then
                begin
                  Item := lvMultipleComputers.Items.Add;
                  Item.Caption := ''; //checkbox
                  Item.SubItems.Add(sIp);
                  Item.SubItems.Add(sHost);
                end;
              end;
            end;
          end;
        end;
      finally
        FreeAndNil(slRow);
        FreeAndNil(slImported);
      end;
    end
    else
    begin
      Exit;
      //ShowMessage('Open file was cancelled');
    end;

  finally
    FreeAndNil(od1);
  end;
end;

procedure TForm1.DeploySvcToList(sMachineList: TStringList; sTheGroup: string);
var
  frmMassDeploy               : TfrmMassDeploySvc;
begin

  //{$IFNDEF LITE_VERSION}
  frmMassDeploy := TfrmMassDeploySvc.Create(self);
  try
    frmMassDeploy.t_sGroup := sTheGroup;
    frmMassDeploy.t_slMachineList := sMachineList;

    frmMassDeploy.Position := poMainFormCenter;
    frmMassDeploy.ShowModal;

  finally
    frmMassDeploy.Release;
    Pointer(frmMassDeploy) := nil;
  end;

  vst1.BeginUpdate;
  try
    vst1.Invalidate;
    vst1.SortTree(0, sdAscending, true);
  finally
    vst1.EndUpdate;
  end;

  //{$ENDIF}
end;

procedure TForm1.DeploySvcToCurrentVisible();
var
  HostParams                  : TCmdParams;
  extReEnableTime             : Cardinal;
  sHostIp                     : string;
  sCurGuid                    : string;
  idx                         : integer;
  bEn, bDis                   : boolean;
  slGuids                     : TStringList;
  bUseAltCreds                : boolean;
  sUser, sPass                : string;
  sUserMessage                : string;
  bShowMessage                : Boolean;
  myCurDeployTask             : PRemoteTask;
  bAdapterChecked             : boolean;
begin
  mmoDeploymentResult.Text := '';
  if actnAutoUpdateIp.Checked then
  begin
    lblRemoteIpAddress.Caption := RetrieveIpForHostAndUpdateDB(lblHost.Caption,
      lblGroup.Caption);
  end;

  slGuids := TStringList.Create;
  try
    RetrieveDbUserPass(lblGroup.Caption, lblHost.Caption, sUser, sPass, bUseAltCreds);
    //
    bShowMessage := False;
    RetrieveDbUserMessage(lblGroup.Caption, lblHost.Caption, sUserMessage, bShowMessage);

    HostParams.bDisplayUserMessage := bShowMessage;

    if bShowMessage then
    begin
      HostParams.sUserMessage := sUserMessage;
    end
    else
    begin
      HostParams.sUserMessage := '';
    end;

    HostParams.bAltCreds := bUseAltCreds; // cbUseAltCreds.Checked;
    if HostParams.bAltCreds then
    begin
      HostParams.sUser := sUser; //lblCredUser.Text;
      HostParams.sPass := sPass; //lblCredPass.Text;
    end
    else
    begin
      HostParams.sUser := '';
      HostParams.sPass := '';
    end;

    if Length(Trim(lblRemoteIpAddress.Caption)) < 1 then
    begin
      ModifyTheHostIpAddress(lblHost.Caption, lblGroup.Caption);
      Exit;
    end;

    if Length(Trim(lblRemoteIpAddress.Caption)) < 1 then
    begin
      if actnAutoUpdateIp.Checked then
      begin
        lblRemoteIpAddress.Caption := RetrieveIpForHostAndUpdateDB(lblHost.Caption,
          lblGroup.Caption);
      end;

      if Length(Trim(lblRemoteIpAddress.Caption)) < 1 then
      begin
        Exit;
      end;
    end;

    if Length(Trim(lblRemoteIpAddress.Caption)) < 1 then
    begin
      sHostIp := lblHost.Caption; //just set it to the host name since no IP specified
    end
    else
    begin
      sHostIp := Trim(lblRemoteIpAddress.Caption);
    end;

    HostParams.sHostAddr := sHostIp;
    HostParams.sHostName := lblHost.Caption;
    HostParams.sGroup := lblGroup.Caption;
    //

    if not IsSystemOnlineNbtPing(HostParams.sHostAddr) then
    begin
      HostParams.sHostAddr := Trim(lblRemoteIpAddress.Caption);
    end;

    HostParams.bDisableAllAdapters := chkDisableAllAdapters.Checked;
    HostParams.bEnableAllAdapters := chkEnableAllAdapters.Checked;
    HostParams.bModifySomeAdapterState := False; //default
    SetLength(HostParams.arrAdapterGuids, 0); //clear

    HostParams.bReEnableAdapters := cbReEnableAdapters.Checked;

    bAdapterChecked := chkDisableAllAdapters.Checked or chkEnableAllAdapters.Checked;

    if ((not chkDisableAllAdapters.Checked) and (not chkEnableAllAdapters.Checked)) then
    begin
      try
        for idx := 0 to lvRemoteNics.Items.Count - 1 do
        begin
          //if at least 1 is enabled or disabled
          if ((StrToBool(lvRemoteNics.Items[idx].Caption)) or
            (StrToBool(lvRemoteNics.Items[idx].SubItems[0]))) then
          begin
            sCurGuid := Trim(lvRemoteNics.Items[idx].SubItems[5]);
            if Length(sCurGuid) > 0 then
            begin
              bEn := False; //dfeault
              bDis := False; //default

              bEn := StrToBool(lvRemoteNics.Items[idx].Caption); //enabled column
              bDis := StrToBool(lvRemoteNics.Items[idx].SubItems[0]); // disabled column

              if ((not bEn) and (not bDis)) then
              begin
                continue;
              end;

              if bEn then
                bAdapterChecked := True;

              HostParams.bModifySomeAdapterState := True;
              slGuids.Add(sCurGuid + '=' + BoolToStr(bEn));
              //if true the adapter is enabled, if false it is disabled
            end;
          end;
        end;

        SetLength(HostParams.arrAdapterGuids, slGuids.Count);
        for idx := 0 to slGuids.Count - 1 do
        begin
          HostParams.arrAdapterGuids[idx] := slGuids[idx];
        end;

      except on E: Exception do
        begin
          //ShowMessage(e.Message);
          //bException := True;
        end;
      end;
    end;

    if not bAdapterChecked then
    begin
      MessageBox(0, 'You have not chosen to enable or disable any adapters!',
        'Choose to enable or disable adapters first', MB_TASKMODAL or MB_TOPMOST or MB_ICONSTOP or
        MB_OK);
      Exit;
    end;

    if HostParams.bReEnableAdapters then
    begin
      extReEnableTime := seHoursMinutes.Value;

      if extReEnableTime > 0 then
      begin
        if rbHours.Checked then
        begin
          extReEnableTime := extReEnableTime * 60; //convert to minutes
          extReEnableTime := Round(extReEnableTime);
        end;
      end;

      HostParams.iReEnableAfterMins := extReEnableTime;
    end
    else
    begin
      HostParams.iReEnableAfterMins := 0;
    end;

    if StartsText('6.', lblSysInfoWindowsVersion.Caption) then
    begin
      HostParams.bUseCimv2 := True; //if version >= 6.0
    end
    else
    begin
      HostParams.bUseCimv2 := False; //windows 2000/xp/server 2003
    end;

    uGlobal.MAX_DEPLOYSVC_THREADS := 1; //we only need 1

    New(myCurDeployTask);
    myCurDeployTask.Params := HostParams;

    frmProgress := TfrmShowProgress.Create(nil);
    PageControl1.Enabled := False;
    vst1.Enabled := False;
    try
      frmProgress.Memo1.Lines.Clear;
      frmProgress.Memo1.Lines.Add('Please wait...');
      frmProgress.Memo1.Lines.Add('Host is online.');

      frmProgress.Position := poMainFormCenter;
      frmProgress.Show;

      frmProgress.ProgressBar1.Enabled := True;
      frmProgress.ProgressBar1.Visible := True;

      if not Assigned(thrdDeploySvc) then
      begin
        thrdDeploySvc := TDeploySvc.Create(Self.Handle);
      end;

      thrdDeploySvc.BeginWork(myCurDeployTask);
      InterlockedIncrement(iRunningSvcDeployments);

      try
        if Assigned(frmProgress) then
        begin
          while not frmProgress.bCloseForm do
          begin
            Application.ProcessMessages();
          end;
        end;
      except
        //
      end;

      //lets kill old threads
      uThrdAbortThreads.TAbortThreads.Create(Addr(thrdDeploySvc)); //kill old threads
    finally
      frmProgress.Release;
      Pointer(frmProgress) := nil;

      //FreeAndNil(frmProgress);
      PageControl1.Enabled := True;
      vst1.Enabled := True;
    end;
  finally
    FreeAndNil(slGuids);
  end;
end;

procedure TForm1.ReadNicDetailsFromDBAndUpdateGrid(sGroup, sHost: string);
var
  ms                          : TMemoryStream;
  sltbU                       : TSQLiteUniTable;
  //sldb                        : TSQLiteDatabase;
  i                           : Integer;
  MgNicArray                  : TRemoteNicArray;
  sSQL                        : string;
  iNumBytes, iFldIndex        : Integer;
  BlobPtr                     : Pointer;
begin
  ms := TMemoryStream.Create;
  //sldb := TSQLiteDatabase.Create(slDBPath);
  try
    sSQL := 'SELECT fldNicDetails From "' + INFO_TABLE + '" WHERE fldGroup = "'
      + sGroup + '" AND fldHostname = "' + sHost + '";';

    GetSqlUnicodeTableByQuery(sltbU, sSQL);

    iFldIndex := sltbU.FieldIndex['fldNicDetails'];
    BlobPtr := sltbU.FieldAsBlobPtr(iFldIndex, iNumBytes);
    if Assigned(ms) then
    begin
      ms.WriteBuffer(BlobPtr^, iNumBytes);
      ms.Position := 0;
      i := 0;
      //default
      try
        ms.ReadBuffer(i, 4);
        //get # of elements
        SetLength(MgNicArray, i);
        try
          ms.ReadBuffer(Pointer(MgNicArray)^, (Length(MgNicArray) * SizeOf(TRemoteNic)) + 4);
        except on e: Exception do
          begin
            //
          end;
        end;

        PopulateNicDetailListView(MgNicArray, chkEnableAllAdapters.Checked,
          chkDisableAllAdapters.Checked);
      except on E: Exception do
        begin
          //suppress
        end;
      end;
    end;
  finally
    FreeAndNil(ms);
    sltbU.Free;
    //sldb.Free;
  end;
end;

procedure TForm1.ReadSysInfoFromDBAndUpdateGrid(sGroup, sHost: string);
var
  ms                          : TMemoryStream;
  sltbU                       : TSQLiteUniTable;
  //sldb                        : TSQLiteDatabase;
  i                           : Integer;
  MgSysInfo                   : TRemoteSysInfoArray;
  sSQL                        : string;
  iNumBytes, iFldIndex        : Integer;
  BlobPtr                     : Pointer;
begin
  ms := TMemoryStream.Create;
  //sldb := TSQLiteDatabase.Create(slDBPath);
  try
    sSQL := 'SELECT fldSystemDetails From "' + INFO_TABLE +
      '" WHERE fldGroup = "' + sGroup + '" AND fldHostname = "' + sHost + '";';
    GetSqlUnicodeTableByQuery(sltbU, sSQL);
    //sltbU := sldb.GetUniTable();

    ms := sltbU.FieldAsBlob(sltbU.FieldIndex['fldSystemDetails']);
    BlobPtr := sltbU.FieldAsBlobPtr(iFldIndex, iNumBytes);
    if Assigned(ms) then
    begin
      ms.WriteBuffer(BlobPtr^, iNumBytes);
      ms.Position := 0;
      i := 0;
      //default
      try
        ms.ReadBuffer(i, 4);
        //get # of elements
        SetLength(MgSysInfo, i);
        try
          ms.ReadBuffer(Pointer(MgSysInfo)^, (Length(MgSysInfo) * SizeOf(TRemoteSysInfo)) + 4);
        except on e: Exception do
          begin
            //
          end;
        end;
        //
        PopulateSysDetailMemo(MgSysInfo);
      except on E: Exception do
        begin
          //suppress
        end;
      end;
    end;
  finally
    FreeAndNil(ms);
    sltbU.Free;
    //sldb.Free;
  end;
end;

//procedure TForm1.AddNewResolvedIPs(var slRetrievedAddesses: TStringList; sTheHost,
//  sTheGroup: string);
//var
//  slIpAddresses               : TStringList;
//  j                           : Integer;
//  sChecked                    : string;
//  bFoundChecked               : boolean;
//  sCurCommaText               : string;
//  sldb                        : TSQLiteDatabase;
//  sQuery, sSQL                : string;
//begin
//  //
//  bFoundChecked := False;
//  slIpAddresses := TStringList.Create;
//  sldb := TSQLiteDatabase.Create(slDBPath);
//  try
//    slIpAddresses.Sorted := True;
//    slIpAddresses.Duplicates := dupIgnore;
//
//    sSQL := 'SELECT * From "' + INFO_TABLE + '" WHERE fldGroup = "' + sTheGroup +
//      '" AND fldHostname = "' + sTheHost + '";';
//
//    GetSqlTableByQuery(sldb, sltbInfo, sSQL);
//
//    if sltbInfo.Count <= 0 then
//    begin
//      Exit;
//    end;
//
//    //
//    slIpAddresses.CommaText := sltbInfo.FieldByName['fldIpAddr'];
//
//    //    for i := 0 to slIpAddresses.Count - 1 do
//    //    begin
//    //      if slIpAddresses.ValueFromIndex[i] <> '0' then
//    //      begin
//    //        sChecked := slIpAddresses.Names[i]; //lbIpAddresses.Items[i];
//    //        bFoundChecked := True;
//    //        break;
//    //      end;
//    //    end;
//
//    sCurCommaText := ReplaceText(slIpAddresses.CommaText, '=1', '=0');
//    //sCurCommaText := slIpAddresses.CommaText;
//
//    if ((Length(Trim(sCurCommaText)) > 0) and (slRetrievedAddesses.Count > 0)) then
//    begin
//      //
//      sCurCommaText := sCurCommaText + ',';
//    end;
//
//    for j := 0 to slRetrievedAddesses.Count - 1 do
//    begin
//      if j = 0 then
//      begin
//        //none are checked. lets just take the 1st one then
//        sCurCommaText := sCurCommaText + slRetrievedAddesses[j] + '=0';
//        //we will check this one later
//        sChecked := slRetrievedAddesses[j];
//      end
//      else
//        //       if SameText(slRetrievedAddesses[j], sChecked) then
//        //      begin
//        //        //this was previously checked
//        //        sCurCommaText := sCurCommaText + slRetrievedAddesses[j] + '=1';
//        //        //Break;
//        //      end
//        //      else
//      begin
//        sCurCommaText := sCurCommaText + slRetrievedAddesses[j] + '=0';
//      end;
//
//      if j <> slRetrievedAddesses.Count - 1 then
//      begin
//        sCurCommaText := sCurCommaText + ',';
//      end;
//
//    end;
//
//    slIpAddresses.CommaText := sCurCommaText; //this needs to go into the DB
//    slIpAddresses.CommaText := ReplaceText(slIpAddresses.CommaText, sChecked + '=0', sChecked +
//      '=1');
//
//    sQuery := 'UPDATE  ' + INFO_TABLE + ' SET fldIpAddr = "' + slIpAddresses.CommaText +
//      '" WHERE fldHostname = "' +
//      sTheHost + '" AND fldGroup = "' + sTheGroup + '";';
//    ModifySqlTableByQuery(sldb, sQuery);
//
//  finally
//    FreeAndNil(slIpAddresses);
//
//    if sltbInfo <> nil then
//      FreeAndNil(sltbInfo);
//
//    sldb.Free;
//  end;
//  ///
//end;

//function TForm1.RetrieveIpFromDB(sTheHost, sTheGroup: string): string;
//var
//  slIpAddresses               : TStringList;
//  sHost                       : string;
//  sldb                        : TSQLiteDatabase;
//  sSQL                        : string;
//  i                           : integer;
//begin
//  Result := ''; //default
//
//  sHost := sTheHost;
//  slIpAddresses := TStringList.Create;
//  try
//    slIpAddresses.Sorted := True;
//    slIpAddresses.Duplicates := dupIgnore;
//    //
//    sldb := TSQLiteDatabase.Create(slDBPath);
//    try
//      sSQL := 'SELECT * From "' + INFO_TABLE + '" WHERE fldGroup = "' + sTheGroup +
//        '" AND fldHostname = "' + sTheHost + '";';
//
//      GetSqlTableByQuery(sldb, sltbInfo, sSQL);
//
//      if sltbInfo.Count <= 0 then
//      begin
//        Exit;
//      end;
//
//      while not sltbInfo.eof do
//      begin
//        slIpAddresses.Clear;
//        slIpAddresses.CommaText := sltbInfo.FieldByName['fldIpAddr'];
//
//        //lblRemoteIpAddress.Caption := ''; //default
//        for i := 0 to slIpAddresses.Count - 1 do
//        begin
//          if slIpAddresses.ValueFromIndex[i] = '0' then
//          begin
//            //SetCheckedListboxState(lbIpAddresses, i, False);
//          end
//          else
//          begin
//            Result := Trim(slIpAddresses.Names[i]);
//            //lblRemoteIpAddress.Caption := slIpAddresses.Names[i];
//            break;
//          end;
//        end;
//
//        sltbInfo.Next;
//      end;
//    finally
//      if sltbInfo <> nil then
//        FreeAndNil(sltbInfo);
//
//      sldb.Free;
//    end;
//  finally
//    FreeAndNil(slIpAddresses);
//  end;
//end;

//function TForm1.RetrieveIpForHostAndUpdateDB(sTheHost, sTheGroup: string): string;
//var
//  slIpAddresses               : TStringList;
//  sHost                       : string;
//  asHostQuery                 : IAsyncCall;
//  sldb                        : TSQLiteDatabase;
//  sSQL                        : string;
//  i                           : integer;
//begin
//  Result := ''; //default
//  sHost := sTheHost;
//  slIpAddresses := TStringList.Create;
//  try
//    slIpAddresses.Sorted := True;
//    slIpAddresses.Duplicates := dupIgnore;
//    //
//    asHostQuery := AsyncCall(@HostToIP, [sHost, slIpAddresses]);
//
//    while AsyncMultiSync([asHostQuery], True, 10) = WAIT_TIMEOUT do
//    begin
//      Application.ProcessMessages;
//    end;
//
//    AddNewResolvedIPs(slIpAddresses, sTheHost, sTheGroup);
//    sldb := TSQLiteDatabase.Create(slDBPath);
//    try
//      sSQL := 'SELECT * From "' + INFO_TABLE + '" WHERE fldGroup = "' + sTheGroup +
//        '" AND fldHostname = "' + sTheHost + '";';
//
//      GetSqlTableByQuery(sldb, sltbInfo, sSQL);
//
//      if sltbInfo.Count <= 0 then
//      begin
//        Exit;
//      end;
//
//      while not sltbInfo.eof do
//      begin
//        slIpAddresses.Clear;
//        slIpAddresses.CommaText := sltbInfo.FieldByName['fldIpAddr'];
//
//        for i := 0 to slIpAddresses.Count - 1 do
//        begin
//          if slIpAddresses.ValueFromIndex[i] = '0' then
//          begin
//            //SetCheckedListboxState(lbIpAddresses, i, False);
//          end
//          else
//          begin
//            Result := Trim(slIpAddresses.Names[i]);
//            break;
//          end;
//        end;
//
//        sltbInfo.Next;
//      end;
//    finally
//      if sltbInfo <> nil then
//        FreeAndNil(sltbInfo);
//
//      sldb.Free;
//    end;
//  finally
//    FreeAndNil(slIpAddresses);
//  end;
//end;

procedure TForm1.RefreshHostDetails(sTheHost, sTheGroup: string; bSilent: boolean);
var
  sQuery                      : string;
  asNicInfo                   : IAsyncCall;
  asSysInfo                   : IAsyncCall;
  //asWinVersion                : IAsyncCall;
  asAutostartInfo             : IAsyncCall;
  sFormattedUser              : string;
  sPass, sUser                : string;
  bUseAltCreds                : boolean;
  sHostToUse                  : string;
  Data                        : PHostRec;
  Node                        : PVirtualNode;
  bAutoUpdateIp               : boolean;
  hMsgForm                    : THandle;
  slWinVersion                : TStringList;
  //sWinVersion                 : string;
  bUsePassthruCreds           : boolean;
  Success                     : HRESULT;
begin
  bAutoUpdateIp := False; //default
  hMsgForm := 0; //default

  if not bSilent then
  begin
    frmProgress := TfrmShowProgress.Create(Self);
    panelHostDetail.Enabled := False;
    PageControl1.Enabled := False;
    vst1.Enabled := False;
  end;

  try
    if Assigned(frmProgress) and not bSilent then
    begin
      frmProgress.Memo1.Lines.Clear;
      frmProgress.bDone := False;

    end;

    sHostToUse := RetrieveIpFromDB(sTheHost, sTheGroup);
    //
    RetrieveDbAutoUpdateIp(sTheHost, sTheGroup, bAutoUpdateIp);
    if bAutoUpdateIp then
    begin
      sHostToUse := RetrieveIpForHostAndUpdateDB(sTheHost, sTheGroup);
    end;

    if Length(sHostToUse) < 1 then
    begin
      if not bSilent then
        ShowMessage('You must provide an IP address');

      Exit;
    end;

    if not bSilent then
    begin
      frmProgress.Position := poMainFormCenter;
      //frmProgress.ShowModal;
      frmProgress.Show;
    end;

    Application.ProcessMessages;
    //then refresh the IP from DNS
    if not IsSystemOnlineNbtPing(sHostToUse) then
    begin
      UpdateDbHostOnline(sTheHost, sTheGroup, False);
      //
      Application.ProcessMessages;
      if Assigned(frmProgress) and not bSilent then
      begin
        frmProgress.Memo1.Lines.Add('*** This host cannot be reached!');
        frmProgress.mmoMarquee.Clear;
        frmProgress.mmoMarquee.Lines[0] := '*** This host cannot be reached!';
        frmProgress.mmoMarquee.SelStart := 0;
      end;

      if not bSilent then
      begin
        MessageDlg('This host cannot be reached!', mtError, [mbOK], 0);

        if Assigned(frmProgress) then
        begin
          PostMessage(frmProgress.Handle, WM_PROGRESS_FORM_MSG, WM_PROGRESS_FORM_STOP, 0);
        end;

        if Assigned(frmProgress) then
        begin
          while not frmProgress.bCloseForm do
          begin
            Application.ProcessMessages();
          end;
        end;
        Exit;
      end
      else
      begin
        Exit;
      end;
    end
    else
    begin
      UpdateDbHostOnline(sTheHost, sTheGroup, True);
    end;

    if Assigned(frmProgress) and not bSilent then
    begin
      frmProgress.Memo1.Lines.Add('System is online.');
      frmProgress.mmoMarquee.Clear;
      frmProgress.mmoMarquee.Lines[0] := 'System is online.';
      frmProgress.mmoMarquee.SelStart := 0;
    end;

    bUseAltCreds := False; //default
    RetrieveDbUserPass(sTheGroup, sTheHost, sUser, sPass, bUseAltCreds);

    bUsePassthruCreds := not bUseAltCreds;

    sFormattedUser := Trim(sUser);
    if Length(sFormattedUser) > 0 then
    begin
      if not ContainsText(sFormattedUser, '\') then
      begin
        sFormattedUser := sHostToUse + '\' + sUser;
      end;
    end;
    //

    if Assigned(frmProgress) and not bSilent then
    begin
      frmProgress.ProgressBar1.Enabled := True;
      frmProgress.ProgressBar1.Visible := True;
      //
      frmProgress.Memo1.Lines.Append('Beginning remote query.');
      frmProgress.mmoMarquee.Clear;
      frmProgress.mmoMarquee.Lines[0] := 'Beginning remote query.';
      frmProgress.mmoMarquee.SelStart := 0;
      //
      frmProgress.Memo1.Lines.Append('This could take up to 2-3 minutes over slow network links.');
      //
      hMsgForm := frmProgress.Handle;
    end;
    {
    sWinVersion := '';
    slWinVersion := TStringList.Create;
    try
      //RetrieveRemoteWinVersion(sPass, sTheHost, bUseAltCreds, sHostToUse, sUser);

      asWinVersion := AsyncCall(@RetrieveRemoteWinVersion, [
        sPass, sTheHost, sTheGroup, bUseAltCreds, sHostToUse, sUser, hMsgForm, slWinVersion]);

      while AsyncMultiSync([asWinVersion], True, 10) = WAIT_TIMEOUT do
      begin
        Application.ProcessMessages;
      end;

      for sWinVersion in slWinVersion do
      begin
        //
        if StartsText('Error: ', sWinVersion) then
        begin
          //this failed
          try
            if Assigned(frmProgress) and not bSilent then
            begin
              PostMessage(frmProgress.Handle, WM_PROGRESS_FORM_MSG, WM_PROGRESS_FORM_STOP, 0);
            end;

            if Assigned(frmProgress) and not bSilent then
            begin
              while not frmProgress.bCloseForm do
              begin
                Application.ProcessMessages();
              end;
            end;
          except
            //
          end;

          Exit;
        end;

      end;
    finally
      FreeAndNil(slWinVersion);
    end;

    asWinVersion.ForceDifferentThread;
    }

    Success := CoInitialize(nil); //Ex(nil, COINIT_MULTITHREADED);
    try
      asNicInfo := AsyncCall(@GetNicInfo, [
        sTheHost,
          sHostToUse,
          sFormattedUser,
          sPass,
          sTheGroup,
          bUsePassthruCreds,
          hMsgForm,
          WM_PROGRESS_FORM_MSG]);

      //asNicInfo.ForceDifferentThread;
      //Application.ProcessMessages;

      asSysInfo := AsyncCall(@GetSysInfo, [
        sTheHost,
          sHostToUse,
          sFormattedUser,
          sPass,
          sTheGroup,
          bUsePassthruCreds,
          hMsgForm, //frmProgress.Handle,
          WM_PROGRESS_FORM_MSG]);

      //asSysInfo.ForceDifferentThread;
      //Application.ProcessMessages;

      asAutostartInfo := AsyncCall(@GetAutoStartInfo, [
        sTheHost,
          sHostToUse,
          sFormattedUser,
          sPass,
          sTheGroup,
          bUsePassthruCreds,
          hMsgForm, //frmProgress.Handle,
          WM_PROGRESS_FORM_MSG]);

      //asAutostartInfo.ForceDifferentThread;
      //Application.ProcessMessages;

      while AsyncMultiSync([asNicInfo, asSysInfo, asAutostartInfo], True, 10) = WAIT_TIMEOUT do
      begin
        Application.ProcessMessages;

        //below will check if user clicked the CLOSE button on form and end this query
        if Assigned(frmProgress) and not bSilent then
        begin
          if frmProgress.bCloseForm then
          begin
            PageControl1.Enabled := True;
            vst1.Enabled := True;
            Application.ProcessMessages;
            Exit;
          end;
        end;
      end;
    finally
      CoUninit(Success);
    end;

    if not bSilent then
    begin
      SysDetailClear();
      ReadNicDetailsFromDBAndUpdateGrid(sTheGroup, sTheHost);
      ReadSysInfoFromDBAndUpdateGrid(sTheGroup, sTheHost);
      PopulateAutorunDisplayFromDb(sTheGroup, sTheHost);
    end;

    //sldb := TSQLiteDatabase.Create(slDBPath);
    try
      sQuery := 'UPDATE  ' + INFO_TABLE + ' SET fldLastQueried = "' + DateTimeToStr(Now()) +
        '" WHERE fldHostname = "' + sTheHost + '" AND fldGroup = "' + sTheGroup + '";';
      ModifySqlTableByQuery(sQuery);

      if not bSilent then
      begin
        PopulateLastQueriedDisplay();
      end;
    finally
      //sldb.Free;
    end;

    if not bSilent then
    begin
      Node := vst1.FocusedNode;
      Data := vst1.GetNodeData(Node);

      //
      //
      if Assigned(Data) then
      begin
        ShowNodeDetails(HOST_LEVEL, Data);
      end;
    end;

    if Assigned(frmProgress) and not bSilent then
    begin
      frmProgress.Memo1.Lines.Append(#13#10 + 'Done');
      frmProgress.mmoMarquee.Clear;
      frmProgress.mmoMarquee.Lines[0] := 'Done';
      frmProgress.mmoMarquee.SelStart := 0;
      frmProgress.bDone := True;

      PostMessage(frmProgress.Handle, WM_PROGRESS_FORM_MSG, WM_PROGRESS_FORM_STOP, 0);
    end;

    try
      if Assigned(frmProgress) and not bSilent then
      begin
        while not frmProgress.bCloseForm do
        begin
          Application.ProcessMessages();
        end;
      end;
    except
      //
    end;

  finally
    //
    if Assigned(frmProgress) and not bSilent then
    begin
      frmProgress.Release;
      Pointer(frmProgress) := nil;
    end;

    if not bSilent then
    begin
      panelHostDetail.Enabled := True;
      PageControl1.Enabled := True;
      vst1.Enabled := True;
    end;
  end;
end;

procedure TForm1.ShowRegistrationForm();
var
  frmReg                      : TfrmReg;
begin
  //
  frmReg := TfrmReg.Create(nil);
  try
    frmReg.ShowModal;
  finally
    frmReg.Release;
    Pointer(frmReg) := nil;
    //FreeAndNil(frmAbout);
  end;
end;

procedure TForm1.Registration1Click(Sender: TObject);
var
  frmGetFull                  : TfrmGetFull;
begin
  //
{$IFNDEF LITE_VERSION}
  ShowRegistrationForm();
{$ELSE}
  frmGetFull := TfrmGetFull.Create(nil);
  try
    frmGetFull.ShowModal;
  finally
    frmGetFull.Release;
    Pointer(frmGetFull) := nil;
    //FreeAndNil(frmAbout);
  end;
{$ENDIF}
end;

procedure TForm1.btnResetScanClick(Sender: TObject);
begin
  edtIpStart.Text := '0.0.0.0';
  edtIpEnd.Text := '0.0.0.0';
  lvMultipleComputers.Items.Clear;
end;

procedure TForm1.cbGroupHostsDisableAllClick(Sender: TObject);
begin
  SetCheckedState(cbGroupHostsEnableAll, False);
end;

procedure TForm1.cbGroupHostsDisplayMsgClick(Sender: TObject);
begin
  if cbGroupHostsDisplayMsg.Checked then
  begin
    memoUserMessage.Enabled := True;
  end
  else
  begin
    memoUserMessage.Enabled := False;
  end;
end;

procedure TForm1.cbGroupHostsEnableAllClick(Sender: TObject);
begin
  SetCheckedState(cbGroupHostsDisableAll, False);
end;

procedure TForm1.cbGroupHostsNoUserMsgChangeClick(Sender: TObject);
begin
  //  if cbGroupHostsNoUserMsgChange.Checked then
  //  begin
  //    //
  //    SetCheckedState(cbGroupHostsDisplayMsg, False);
  //    memoUserMessage.Enabled := False;
  //  end
  //  else
  //  begin
  //    //
  //    SetCheckedState(cbGroupHostsDisplayMsg, True);
  //    memoUserMessage.Enabled := True;
  //  end;
end;

procedure TForm1.cbGroupHostsReEnableAfterClick(Sender: TObject);
begin
  //SetFieldsChanged(True);
  if cbGroupHostsReEnableAfter.Checked then
  begin
    seGroupHostsHoursMinutes.Enabled := True;
    rbGroupHostsMinutes.Enabled := True;
    rbGroupHostsHours.Enabled := True;
  end
  else
  begin
    rbGroupHostsMinutes.Enabled := False;
    rbGroupHostsHours.Enabled := False;
    rbGroupHostsHours.Enabled := False;
  end;
end;

procedure TForm1.cbGroupHostsUseAltCredsClick(Sender: TObject);
begin
  if cbGroupHostsUseAltCreds.Checked then
  begin
    lblGroupHostsCredUser.Enabled := True;
    lblGroupHostsCredPass.Enabled := True;
    chkShowPass.Enabled := True;
  end
  else
  begin
    lblGroupHostsCredUser.Enabled := False;
    lblGroupHostsCredPass.Enabled := False;
    chkShowPass.Enabled := False;
  end;
end;

procedure TForm1.cbReEnableAdaptersClick(Sender: TObject);
var
  iVal                        : integer;
begin
  //
  SetFieldsChanged(True);

{$IFDEF LITE_VERSION}
  if not chkDisableAllAdapters.Checked then
  begin
    chkDisableAllAdapters.Checked := True;
    Exit;
  end;


  cbReEnableAdapters.Checked := True;
  iVal := seHoursMinutes.Value;
  seHoursMinutes.MaxValue := TRIAL_REENABLE_MIN;

  if (iVal < 1) or (iVal > TRIAL_REENABLE_MIN) then
  begin
    seHoursMinutes.Value := TRIAL_REENABLE_MIN;
  end;

  SetCheckedRadioBtnState(rbMinutes, True);
  SetCheckedRadioBtnState(rbHours, False);

  if chkDisableAllAdapters.Checked then
  begin
    rbMinutes.Enabled := True;
    rbHours.Enabled := False;
    seHoursMinutes.Enabled := True;
  end
  else
  begin
    cbReEnableAdapters.Checked := False;
    rbMinutes.Enabled := False;
    rbHours.Enabled := False;
    seHoursMinutes.Enabled := False;
  end;

{$ELSE}

  if cbReEnableAdapters.Checked then
  begin
    seHoursMinutes.Enabled := True;
    rbMinutes.Enabled := True;
    rbHours.Enabled := True;
  end
  else
  begin
    seHoursMinutes.Enabled := False;
    rbMinutes.Enabled := False;
    rbHours.Enabled := False;
  end;
{$ENDIF}
end;

procedure TForm1.ModifyTheHostIpAddress(const sHost, sGroup: string);
var
  frmModifyIp                 : TfModifyIPAddress;
begin
  //
  frmModifyIp := TfModifyIPAddress.Create(nil);
  try
    frmModifyIp.sModIpHost := sHost; //lblHost.Caption;
    frmModifyIp.sModIpGroup := sGroup; //lblGroup.Caption;
    frmModifyIp.Position := poMainFormCenter;

    frmModifyIp.ShowModal;

  finally
    frmModifyIp.Release;
    Pointer(frmModifyIp) := nil;

    //FreeAndNil(frmModifyIp);
  end;
end;

procedure TForm1.OnlineHelp1Click(Sender: TObject);
begin
  //
  ShellExecute(Application.Handle,
    PChar('open'),
    PChar('http://www.wildpawsoftware.com/help'),
    PChar(0),
    nil,
    SW_NORMAL);
end;

procedure TForm1.panelNoHostsInGroupClick(Sender: TObject);
begin
  panelNoHostsInGroup.Visible := False;
end;

procedure TForm1.pgcHostDiscoveryDrawTab(Control: TCustomTabControl;
  TabIndex: Integer; const Rect: TRect; Active: Boolean);
begin
  //
  Control.Canvas.TextOut(Rect.left + 5, Rect.top + 3, PageControl1.Pages[tabindex].Caption);
  PageControl1.Pages[TabIndex].Brush.Color := clWhite;

end;

procedure TForm1.SaveAutoUpdateIp(const sTheHost, sTheGroup: string);
var
  //sldb                        : TSQLiteDatabase;
  sQuery                      : string;
begin
  //sldb := TSQLiteDatabase.Create(slDBPath);
  try
    sQuery := 'UPDATE  ' + INFO_TABLE
      + ' SET fldAutoUpdateIp = "' + BoolToStr(actnAutoUpdateIp.Checked, True)
      + '" WHERE fldHostname = "' + sTheHost + '" AND fldGroup = "' + sTheGroup + '";';

    ModifySqlTableByQuery(sQuery);

  finally
    //sldb.Free;
  end;
end;

procedure TForm1.SaveVisibleNicDetails(const sTheHost, sTheGroup: string);
var
  //
  strm, ms                    : TMemoryStream;
  //sldb                        : TSQLiteDatabase;
  MgNicArray                  : TRemoteNicArray;
  i, idx                      : Integer;
  sQuery                      : string;
  sltbU                       : TSQLiteUniTable;
  bException                  : boolean;
  extTime                     : Extended; //possibly floating point
  sSQL                        : string;
  iNumBytes, iFldIndex        : Integer;
  BlobPtr                     : Pointer;
begin

  //sldb := TSQLiteDatabase.Create(slDBPath);
  try
    if rbHours.Checked then
      extTime := StrToInt(seHoursMinutes.Text)
    else if rbMinutes.Checked then
    begin
      extTime := StrToInt(seHoursMinutes.Text) / 60;
    end;

    sQuery := 'UPDATE  ' + INFO_TABLE
      + ' SET fldEnableAllNics = "' + BoolToStr(chkEnableAllAdapters.Checked, True)
      + '", fldDisableAllNics = "' + BoolToStr(chkDisableAllAdapters.Checked, True)
      + '", fldAutoUpdateIp = "' + BoolToStr(actnAutoUpdateIp.Checked, True)
      + '", fldReEnableNics = "' + BoolToStr(cbReEnableAdapters.Checked, True)
      + '", fldReEnableTime = "' + FloatToStr(extTime)
      + '" WHERE fldHostname = "'
      + sTheHost + '" AND fldGroup = "' + sTheGroup + '";';

    ModifySqlTableByQuery(sQuery);

    ms := TMemoryStream.Create;
    sSQL := 'SELECT fldNicDetails From "' + INFO_TABLE + '" WHERE fldGroup = "'
      + sTheGroup + '" AND fldHostname = "' + sTheHost + '";';

    GetSqlUnicodeTableByQuery(sltbU, sSQL);
    try
      //ms := sltbU.FieldAsBlob(sltbU.FieldIndex['fldNicDetails']);
      iFldIndex := sltbU.FieldIndex['fldNicDetails'];
      BlobPtr := sltbU.FieldAsBlobPtr(iFldIndex, iNumBytes);
      if Assigned(ms) then
      begin
        ms.WriteBuffer(BlobPtr^, iNumBytes);
        ms.Position := 0;
        i := 0;
        //default
        try
          ms.ReadBuffer(i, 4);
          //get # of elements
          SetLength(MgNicArray, i);
          ms.ReadBuffer(Pointer(MgNicArray)^, (Length(MgNicArray) * SizeOf(TRemoteNic)) + 4);
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

    i := Length(MgNicArray);
    if i < 1 then
      Exit;

    bException := False;
    try
      if lvRemoteNics.Items.Count >= 1 then
      begin
        for idx := 0 to lvRemoteNics.Items.Count - 1 do
        begin
          MgNicArray[idx].bEnableAdapter := StrToBool(lvRemoteNics.Items[idx].Caption);
          MgNicArray[idx].bDisableAdapter := StrToBool(lvRemoteNics.Items[idx].SubItems[0]);
          MgNicArray[idx].sIpAddress := lvRemoteNics.Items[idx].SubItems[1];
          MgNicArray[idx].sMac := lvRemoteNics.Items[idx].SubItems[2];
          MgNicArray[idx].sManufacturer := lvRemoteNics.Items[idx].SubItems[3];
          MgNicArray[idx].sName := lvRemoteNics.Items[idx].SubItems[4];
          MgNicArray[idx].sGuid := lvRemoteNics.Items[idx].SubItems[5];
          //Inc(idx);
        end;
      end;
    except on E: Exception do
      begin
        //ShowMessage(e.Message);
        bException := True;
      end;
    end;

    if bException then
      Exit;

    strm := TMemoryStream.Create();
    //sldb := TSQLiteDatabase.Create(slDBPath);
    try
      i := Length(MgNicArray);
      if i < 1 then
        Exit;

      strm.WriteBuffer(i, 4);
      strm.WriteBuffer(Pointer(MgNicArray)^, (Length(MgNicArray) * SizeOf(TRemoteNic)) + 4);
      //this is working
      strm.Position := 0;
      sQuery := 'UPDATE ' + INFO_TABLE + ' SET fldNicDetails = ? WHERE fldHostname = "' +
        lblHost.Caption +
        '" AND fldGroup = "' + lblGroup.Caption + '";';

      //sldb.UpdateBlob(sQuery, strm);
      ModifySqlTableBlobByQuery(sQuery, strm);

      sQuery := 'UPDATE  ' + INFO_TABLE
        + ' SET fldEnableAllNics = "' + BoolToStr(chkEnableAllAdapters.Checked, True)
        + '", fldDisableAllNics = "' + BoolToStr(chkDisableAllAdapters.Checked, True)
        + '", fldReEnableNics = "' + BoolToStr(cbReEnableAdapters.Checked, True)
        + '", fldReEnableTime = "' + FloatToStr(extTime) +
        '" WHERE fldHostname = "' +
        lblHost.Caption + '" AND fldGroup = "' + lblGroup.Caption + '";';

      ModifySqlTableByQuery(sQuery);
    finally
      FreeAndNil(strm);
      //sldb.Free;
    end;
  finally
    //sldb.Free;
  end;

end;

procedure TForm1.SaveChangesToRecord(const sTheHost, sTheGroup: string);
begin
  SaveVisibleNicDetails(sTheHost, sTheGroup);
  SaveAutoUpdateIp(sTheHost, sTheGroup);
end;

//procedure TForm1.btnSaveUpdatesClick(Sender: TObject);
//begin
//  SaveChangesToRecord();
//  SetFieldsChanged(False);
//end;

procedure TForm1.btnScanSubnetClick(Sender: TObject);
var
  myCurTask                   : PNetbiosTask;
  //  sIp                         : string;
  startIp, endIp, i           : Cardinal;
  iThreadNumber               : integer;
  sNewStartIp                 : string;
  Regex                       : TPerlRegEx;
begin
  if ((edtIpStart.Text = '0.0.0.1') or (edtIpEnd.Text = '0.0.0.1')) then
  begin
    MessageDlg('You must provide a valid subnet!', mtError, [mbOK], 0);
    Exit;
  end;

  startIp := IPToNumber(edtIpStart.Text);
  endIp := IPToNumber(edtIpEnd.Text);

  if endIp < startIp then
  begin
    //
    MessageDlg('Invalid IP address range!', mtError, [mbOK], 0);
    Exit;
  end;

  if EndsText('.0', NumberToIp(startIp)) then
  begin
    //
    MessageDlg('Invalid IP address range! Cannot scan "x.x.x.0". ' + #13#10
      + 'The starting IP address will be updated to a valid range.', mtError, [mbOK], 0);
    Regex := TPerlRegEx.Create(nil);
    try
      Regex.RegEx := '^(.*)\.0$';
      Regex.Options := [preCaseless, preMultiLine, preExtended];
      Regex.Subject := edtIpStart.Text;
      Regex.Replacement := '$1.1';
      Regex.ReplaceAll;
      sNewStartIp := Regex.Subject;
    finally
      FreeAndNil(Regex);
    end;

    edtIpStart.Text := sNewStartIp;
    Exit;
  end;

  bHostScanAborted := False;
  iRunningTasks := 0;

  lvMultipleComputers.Clear;
  StatusBar1.Panels[0].Text := 'Remaining tasks: <calculating>';
  btnScanSubnet.Enabled := False;
  btnAddChecked.Enabled := False;
  btnResetScan.Enabled := False;

  Animate1.Active := True;
  Animate1.Visible := True;
  btnCancelScan.Enabled := True;
  Application.ProcessMessages;

  iThreadNumber := endIp - startIp;
  if (iThreadNumber > 15) or (iThreadNumber < 1) then
    iThreadNumber := 15;

  uGlobal.MAX_NBT_THREADS := iThreadNumber;

  for i := startIp to endIp do
  begin
    if i mod 3 = 0 then
    begin
      StatusBar1.Panels[0].Text := 'Queuing tasks... <' + IntToStr(iRunningTasks) + '>';
      Application.ProcessMessages;
    end;

    New(myCurTask);
    myCurTask.sAddress := NumberToIp(i); //Concat(sIp, IntToStr(i));
    myCurTask.iTimeout := 4000;

    if not Assigned(thrdNetBios) then
    begin
      thrdNetBios := TNbtstatCheck.Create(Self.Handle);
    end;

    thrdNetBios.BeginWork(myCurTask);
    InterlockedIncrement(iRunningTasks);
  end;

  StatusBar1.Panels[0].Text := 'Remaining tasks: ' + IntToStr(iRunningTasks);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  ShowPassForm(False);
end;

function TForm1.ChangeUserPassDb(sNewPass: string): string;
var
  sPass                       : string;
  SHA1Digest                  : TSHA1Digest;
  sSQL                        : string;
  sRepairText                 : string;
  origRandPwd                 : string;
begin

  //this is correct
  sPass := EncodePWDEx(sNewPass, s3 + s1 + s4 + s2);
  StringHashSHA1(SHA1Digest, s3 + s1 + sNewPass + s4 + s2);
  uGlobal.sHashedPass := BufferToHex(SHA1Digest, SizeOf(SHA1Digest));
  uGlobal.sUserSuppliedHashedPass := uGlobal.sHashedPass;
  //this is correct

  ///
  ///
  ///
  GenerateLMDKey(Key128, SizeOf(Key128), HexToString(sEncryptedPassVal));
  //decrypt using original value

  origRandPwd := RDLEncryptStringCBCEx(//this is the original RAND pwd that should not change
    HexToString(uGlobal.sEncryptedPassVal2),
    Key128,
    16,
    False
    );

  GenerateLMDKey(Key128, SizeOf(Key128), sPass);

  uGlobal.sEncryptedPassVal := StrToHex(sPass);
  uGlobal.sEncryptedPassVal2 := StrToHex(RDLEncryptStringCBCEx(
    origRandPwd,
    Key128,
    16,
    True
    ));

  ///
  ///
  ///

  GetEncryptedLicenseVal(sRepairText); //get license before we drop this table
  //mgSplitString(sRepairText, sUser, sKey, ','); //sUser is hex encoded
  try

    sSQL := ('DROP TABLE ' + DB_INFO_TABLE + ';');
    ModifySqlTableByQuery(sSQL);

    sSQL := (
      'CREATE TABLE ' + DB_INFO_TABLE + '('
      + 'fldAccessVal1 VARCHAR(512),'
      + 'fldAccessVal2 VARCHAR(512),'
      + 'fldAccessHash VARCHAR(256),'
      + 'fldRepairText VARCHAR(1024),' //holds license key
      + '"PK" INTEGER NOT NULL DEFAULT "1"  PRIMARY KEY AUTOINCREMENT)');

    ModifySqlTableByQuery(sSQL);

    sSQL := 'INSERT INTO ' + DB_INFO_TABLE +
      ' ("fldAccessVal1","fldAccessVal2","fldRepairText","fldAccessHash") VALUES("'
      + sEncryptedPassVal + '","'
      + sEncryptedPassVal2 + '","'
      + '' + '","'
      + sHashedPass + '");';

    ModifySqlTableByQuery(sSQL);

    if Length(sRepairText) > 0 then
    begin
      //SetLicenseStatus(sRepairText);

      sSQL := 'UPDATE  ' + DB_INFO_TABLE + ' SET fldRepairText = "'
        + sRepairText + '";';

      ModifySqlTableByQuery(sSQL);
    end;
  finally
    //sldb.Free;
  end;

end;

procedure TForm1.AvailableInProEdition();
begin
  MessageDlg('This feature is only available in the full version!' + #13 + #10 + '' + #13 +
    #10 + 'Visit www.WildPawSoftware.com to upgrade.', mtError, [mbOK], 0);
  {
    MessageBox(0, 'This feature is only available in the professional version!' + #13 + #10 + '' + #13
      + #10 + 'Visit www.WildPawSoftware.com to upgrade.', 'Please upgrade to use this feature',
      MB_ICONSTOP or MB_OK);
  }
end;

procedure TForm1.btnApplyConfigToGroupClick(Sender: TObject);
var
  iLoop, iChecked             : Integer;
  sQuery                      : string;
  bUseAltCreds                : boolean;
  sUser, sPass                : string;
  extTime                     : Extended;
  sEncUser, sEncPass          : string;
  bShowMsg                    : boolean;
  sUserMsg                    : string;
begin
  //

{$IFDEF LITE_VERSION}
  AvailableInProEdition();
{$ENDIF}

{$IFNDEF LITE_VERSION}
  iChecked := 0; //default

  for iLoop := 0 to lvGroupHosts.Items.Count - 1 do
  begin
    if lvGroupHosts.Items[iLoop].Checked then
    begin
      Inc(iChecked);
    end;
  end;

  if iChecked < 1 then
  begin
    MessageDlg('You must check at least 1 host to apply settings upon.', mtError, [mbOK], 0);
    Exit;
  end;

  if (not chkModifyNicOptions.Checked) and
    (not chkModifyCredentials.Checked) and
    (not chkModifyUserMessage.Checked) then
  begin
    MessageDlg('You have not selected any configuration options to set.', mtError, [mbOK], 0);
    Exit;
  end;

  if (MessageDlg('Are you sure you want to apply the settings below to these ' + IntToStr(iChecked)
    + ' hosts?', mtConfirmation, [mbYes, mbNo], 0) = mrNo) then
  begin
    Exit; //they said no
  end;

  bUseAltCreds := cbGroupHostsUseAltCreds.Checked;
  sPass := Trim(lblGroupHostsCredPass.Text);

  if bUseAltCreds then
  begin
    sUser := Trim(lblGroupHostsCredUser.Text);

    if Length(sUser) < 1 then
    begin
      MessageDlg('You must provide a username if you are using alternate credentials.', mtError,
        [mbOK], 0);
      cbGroupHostsUseAltCreds.Checked := False;
      lblGroupHostsCredUser.Enabled := False;
      lblGroupHostsCredPass.Enabled := False;
      chkShowPass.Enabled := False;
      Exit;
    end;

    sEncUser := EncryptDbString(sUser);
    sEncPass := EncryptDbString(sPass);
  end
  else
  begin
    sEncUser := '';
    sEncPass := '';
  end;

  bShowMsg := cbGroupHostsDisplayMsg.Checked;

  if bShowMsg then
  begin
    sUserMsg := StrToHex(memoUserMessage.Lines.Text);
  end
  else
  begin
    sUserMsg := '';
  end;

  if rbGroupHostsHours.Checked then
    extTime := StrToInt(seGroupHostsHoursMinutes.Text)
  else if rbGroupHostsMinutes.Checked then
  begin
    extTime := StrToInt(seGroupHostsHoursMinutes.Text) / 60;
  end;

  try
    for iLoop := 0 to lvGroupHosts.Items.Count - 1 do
    begin
      if lvGroupHosts.Items[iLoop].Checked then
      begin

        sQuery := 'UPDATE  ' + INFO_TABLE + ' SET';

        if chkModifyNicOptions.Checked then
        begin
          sQuery := sQuery + ' fldEnableAllNics = "' + BoolToStr(cbGroupHostsEnableAll.Checked, True)
            + '", fldDisableAllNics = "' + BoolToStr(cbGroupHostsDisableAll.Checked, True)
            + '", fldAutoUpdateIp = "' + BoolToStr(chkAutoUpdateIp.Checked, True)
            + '", fldReEnableNics = "' + BoolToStr(cbGroupHostsReEnableAfter.Checked, True)
            + '", fldReEnableTime = "' + FloatToStr(extTime) + '",';
        end;

        if chkModifyCredentials.Checked then
        begin
          sQuery := sQuery + ' fldUseAltUser = "' + BoolToStr(cbGroupHostsUseAltCreds.Checked, True)
            + '", fldAltUser = "' + sEncUser
            + '", fldAltPass = "' + sEncPass + '",';
        end;

        if chkModifyUserMessage.Checked then
        begin
          sQuery := sQuery + ' fldShowUserMessage = "' + BoolToStr(bShowMsg, True)
            + '", fldUserMessage = "' + sUserMsg + '",';
        end;

        if StrUtils.EndsStr(',', sQuery) then
        begin
          Delete(sQuery, Length(sQuery), 1);
        end;

        sQuery := sQuery + ' WHERE fldGroup = "' + lblgroupHosts.Caption + '" AND fldHostname = "' +
          lvGroupHosts.Items[iLoop].SubItems[0] + '";';

        ModifySqlTableByQuery(sQuery);
      end;
    end;

    MessageBoxTimeout(Application.Handle, PChar('All hosts have been updated.'), PChar('Updated'),
      MB_OK or MB_SETFOREGROUND or MB_SYSTEMMODAL or MB_ICONINFORMATION,
      0, 5000);
  finally
    //sldb.Free;
  end;
{$ENDIF}
end;

procedure TForm1.btnCancelGroupHostsClick(Sender: TObject);
begin
  //
  HostRetrievalsDone();
  //
end;

procedure TForm1.btnCancelScanClick(Sender: TObject);
begin
  bHostScanAborted := True;
  ScanDone();
end;

procedure TForm1.btnCustomizeAdaptersClick(Sender: TObject);
begin
  lvRemoteNics.DoubleBuffered := False;
  //if not AnimateWindow(lvRemoteNics.Handle, 200, AW_VER_NEGATIVE or AW_SLIDE or AW_HIDE) then
  //begin
  //  AnimateWindow(lvRemoteNics.Handle, 200, AW_VER_POSITIVE or AW_SLIDE);
  //end;

  lvRemoteNics.DoubleBuffered := True;
  lvRemoteNics.Repaint;
  lvRemoteNics.Refresh;
end;

procedure TForm1.File1Click(Sender: TObject);
begin
  //
  if PageControl1.ActivePage = Tab03_HostDetail then
  begin
    actnRefreshHost.Enabled := True;

    if bFieldsChanged then
    begin
      actnSaveHost.Enabled := True;
      //actnSaveHost.ImageIndex := SAVE_ICON;
    end
    else
    begin
      actnSaveHost.Enabled := False;
      //actnSaveHost.ImageIndex := SAVE_GRAY_ICON;
    end;

  end
  else
  begin
    actnRefreshHost.Enabled := False;
    actnSaveHost.Enabled := False;
  end;
end;

procedure TForm1.ShowPassForm(bCreatePass: boolean; sPrevPass: string = '');
var
  frmPass                     : TfrmEnterPassword;
begin
  //     lblPasswordInstructions
  frmPass := TfrmEnterPassword.Create(nil);
  try
    frmPass.bCreatePass := bCreatePass;
    if bCreatePass then
    begin
      frmPass.imgCreatePwd.Visible := True;
      frmPass.imgEnterPassword.Visible := False;

      frmPass.Height := frmPass.Height; // + 60;
      frmPass.lblPasswordForm.Top := frmPass.lblPasswordForm.Top; // + 40;

      frmPass.sPrevHash := '';
      frmPass.sLabelText := 'Create a password to secure the data file';
      frmPass.btnGenPassword.Visible := True;
      frmPass.btnSavePasswordToFile.Visible := True;
      frmPass.lblDontLosePwd.Visible := True;

      frmPass.lblEnterNewPassword.TabOrder := 2;
      frmPass.lblPasswordForm.TabOrder := 3;
    end
    else
    begin
      frmPass.imgCreatePwd.Visible := False;
      frmPass.imgEnterPassword.Visible := True;

      frmPass.Height := frmPass.Height - 60;
      frmPass.lblPasswordForm.Top := frmPass.lblPasswordForm.Top - 40;

      frmPass.sPrevHash := sPrevPass;
      frmPass.sLabelText := 'Enter the password to access the data file';
      frmPass.btnGenPassword.Visible := False;
      frmPass.btnSavePasswordToFile.Visible := False;
      frmPass.lblDontLosePwd.Visible := False;

      frmPass.lblEnterNewPassword.TabOrder := 3;
      frmPass.lblPasswordForm.TabOrder := 2;
    end;

    frmPass.Position := poMainFormCenter;
    frmPass.ShowModal;
  finally
    frmPass.Release;
    Pointer(frmPass) := nil;
    //FreeAndNil(frmPass);
  end;
  SetFieldsChanged(True);
end;

procedure TForm1.DSiProcessMessages(hwnd: THandle; waitForWMQuit: boolean);
var
  bGet                        : longint;
  msg                         : TMsg;
begin
  if hwnd = 0 then
    Exit;
  repeat
    if not waitForWMQuit then
    begin
      if not PeekMessage(msg, hwnd, 0, 0, PM_REMOVE) then
        break; //repeat
    end
    else
    begin
      bGet := longint(GetMessage(msg, hwnd, 0, 0));
      if (bGet = 0) or (bGet = -1) then
        break; //repeat
    end;
    TranslateMessage(Msg);
    DispatchMessage(Msg);
  until msg.Message = WM_QUIT;
end; { DSiProcessMessages }

procedure TForm1.FormActivate(Sender: TObject);
begin
  if not bFormActivated then
  begin
    PageControl1.Visible := False;
    DSiProcessThreadMessages();
    PrepareLaunch();
    bFormActivated := True;
    Form1.ActiveControl := vst1;
  end;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin

{$IFNDEF LITE_VERSION}
  SaveGroupState();
  if Assigned(sqlitedb) then
    FreeAndNil(sqlitedb);
{$ELSE}
  if Assigned(sqlitedb) then
    FreeAndNil(sqlitedb);
  DeleteFile(slDBPath);
{$ENDIF}

end;

procedure TForm1.DSiProcessThreadMessages;
var
  msg                         : TMsg;
begin
  while PeekMessage(Msg, 0, 0, 0, PM_REMOVE) and (Msg.Message <> WM_QUIT) do
  begin
    TranslateMessage(Msg);
    DispatchMessage(Msg);
  end;

  //Application.ProcessMessages;
end; { DSiProcessThreadMessages }

function TForm1.SetLicenseStatus(const sUser, sKey: string): boolean;
var
  sSQL                        : string;
  sEncRepairText              : string;
  sHexUser                    : string;
begin
{$IFNDEF LITE_VERSION}
  try
    if uLic.AuthenticateReleaseCode(sUser, sKey) then
    begin
      sHexUser := uHelpers.StringToHex16(sUser);
      sEncRepairText := sHexUser + ',' + uHelpers.StringToHex(EncodePWDEx(sKey, s2 + s4 + s1 + s3));
    end
    else
    begin
      ShowMessage('invalid license code');
      Result := False;
      Exit;
    end;

    sSQL := 'UPDATE  ' + DB_INFO_TABLE + ' SET fldRepairText = "'
      + sEncRepairText + '";';

    Result := ModifySqlTableByQuery(sSQL);

  finally
    if sltbDbInfo <> nil then
      FreeAndNil(sltbDbInfo);
  end;
{$ENDIF}
end;

procedure TForm1.GetEncryptedLicenseVal(var sLic: string);
var
  sSQL                        : string;
  sRepairText                 : string;
begin
{$IFNDEF LITE_VERSION}
  try
    sSQL := 'SELECT fldRepairText from "' + DB_INFO_TABLE + '"';
    GetSqlTableByQuery(sltbDbInfo, sSQL);

    while not sltbDbInfo.EOF do
    begin
      sRepairText := sltbDbInfo.FieldAsString(sltbDbInfo.FieldIndex['fldRepairText']);
      sltbDbInfo.Next;
    end;

    sLic := sRepairText;
  finally
    if sltbDbInfo <> nil then
      FreeAndNil(sltbDbInfo);
  end;
{$ELSE}
  sLic := 'TRIAL VERSION';
{$ENDIF}
end;

function TForm1.GetLicInfo(var sUser, sSer: string): boolean;
var
  sSQL                        : string;
  sRepairText                 : string;
  sDecRepairText              : string;
  sHexUser, sEncKey           : string;
begin

{$IFNDEF LITE_VERSION}
  try
    sSQL := 'SELECT fldRepairText from "' + DB_INFO_TABLE + '"';
    GetSqlTableByQuery(sltbDbInfo, sSQL);

    while not sltbDbInfo.EOF do
    begin
      sRepairText := sltbDbInfo.FieldAsString(sltbDbInfo.FieldIndex['fldRepairText']);
      sltbDbInfo.Next;
    end;

    mgSplitString(sRepairText, sHexUser, sEncKey, ',');

    Result := False; //default

    sDecRepairText := DecodePWDEx(uHelpers.HexToString(sEncKey), s2 + s4 + s1 + s3);
    if uLic.AuthenticateReleaseCode(uHelpers.HexToString16(sHexUser), sDecRepairText) then
    begin
      sUser := uHelpers.HexToString16(sHexUser);
      sSer := sDecRepairText;
      Result := True;
    end;

  finally
    if sltbDbInfo <> nil then
      FreeAndNil(sltbDbInfo);
  end;

{$ELSE}
  sUser := 'TRIAL VERSION';
  sSer := 'TRIAL';
{$ENDIF}
end;

function TForm1.IsValidLicenseDb(): boolean;
var
  sSQL                        : string;
  sRepairText                 : string;
  sDecRepairText              : string;
  sHexUser, sEncKey           : string;
begin
  try
    sSQL := 'SELECT fldRepairText from "' + DB_INFO_TABLE + '"';
    GetSqlTableByQuery(sltbDbInfo, sSQL);

    while not sltbDbInfo.EOF do
    begin
      sRepairText := sltbDbInfo.FieldAsString(sltbDbInfo.FieldIndex['fldRepairText']);
      sltbDbInfo.Next;
    end;

    mgSplitString(sRepairText, sHexUser, sEncKey, ',');

    sDecRepairText := DecodePWDEx(uHelpers.HexToString(sEncKey), s2 + s4 + s1 + s3);
    Result := uLic.AuthenticateReleaseCode(uHelpers.HexToString16(sHexUser), sDecRepairText);
  finally
    if sltbDbInfo <> nil then
      FreeAndNil(sltbDbInfo);
  end;
end;

procedure TForm1.SetTrialState();
var
  sPass                       : string;
  sFormPass                   : string;
  sHash                       : string;
  SHA1Digest                  : TSHA1Digest;
begin
  //
  sFormPass := 'TRIAL_VERSION_PASSWORD';

  sPass := EncodePWDEx(sFormPass, s3 + s1 + s4 + s2);
  StringHashSHA1(SHA1Digest, s3 + s1 + sFormPass + s4 + s2);
  sHash := BufferToHex(SHA1Digest, SizeOf(SHA1Digest));

  GenerateLMDKey(Key128, SizeOf(Key128), sPass);

  uGlobal.sEncryptedPassVal := StrToHex(sPass);
  uGlobal.sEncryptedPassVal2 := StrToHex(RDLEncryptStringCBCEx(
    uBasicEncrypt.GeneratePWDSecurityString,
    Key128,
    16,
    True
    ));

  uGlobal.sHashedPass := sHash;
  uGlobal.sUserSuppliedHashedPass := sHash;
end;

procedure TForm1.PrepareLaunch();
var
  frmGetFull                  : TfrmGetFull;
  sSQL                        : string;
  sTempEncryptedVal1, sTempEncryptedVal2: string;
  sUser, sTmp                 : string;
begin
  //
  PageControl1.Visible := False;

  Form1.Width := 856;
  Form1.Height := 577; //491;

  sltbGroups := nil;
  sltbInfo := nil;
  //vst1.Header.Columns[0].Width := vst1.Width - 10;

  SetLength(TrueBoolStrs, 1);
  SetLength(FalseBoolStrs, 1);
  TrueBoolStrs[0] := '1'; //true
  FalseBoolStrs[0] := '0';

  GetDatabaseFullName();

{$IFDEF LITE_VERSION}
  if FileExists(slDBPath) then
    CopyFile(PChar(slDBPath), PChar(slDBPath + '.backup'), False);

  DeleteFile(slDBPath);
{$ENDIF}

  if not FileExists(slDBPath) then
  begin
{$IFNDEF LITE_VERSION}
    ShowPassForm(True);
{$ELSE}
    SetTrialState();

    frmGetFull := TfrmGetFull.Create(nil);
    try
      frmGetFull.ShowModal;
    finally
      frmGetFull.Release;
      Pointer(frmGetFull) := nil;
    end;
{$ENDIF}

    if Length(sEncryptedPassVal) < 1 then
    begin
      MessageDlg('You did not provide a password. Exiting.', mtError, [mbOK], 0);
      Halt;
    end;

    sSQL := (
      'CREATE TABLE ' + INFO_TABLE + '('
      + 'fldHostname VARCHAR(300),'
      + 'fldIpAddr VARCHAR(1024),' // NOT NULL DEFAULT "127.0.0.1=1" ,'
      + 'fldHostEntry VARCHAR(300),'
      + 'fldLastDeployed DATETIME,'
      + 'fldNicDetails BLOB,'
      + 'fldAltUser VARCHAR(512),'
      + 'fldAltPass VARCHAR(512),'
      + 'fldUseAltUser INTEGER,'
      + 'fldEnableAllNics INTEGER,'
      + 'fldDisableAllNics INTEGER,'
      + 'fldReEnableNics INTEGER,'
      + 'fldReEnableTime REAL,'
      + 'fldSystemDetails BLOB,'
      + 'fldStartupInfo BLOB,'
      + 'fldLastLoggedOnUser VARCHAR(100),'
      + 'fldUserMessage VARCHAR(1280),'
      + 'fldShowUserMessage INTEGER,'
      + 'fldAutoUpdateIp INTEGER,'
      + 'fldHostOnline INTEGER,'
      + 'fldExtra01 VARCHAR(255),'
      + 'fldExtra02 VARCHAR(255),'
      + 'fldExtra03 INTEGER,'
      + 'fldExtra04 INTEGER,'
      + 'fldLastQueried DATETIME,'
      + 'fldDeploymentResult VARCHAR(255),'
      + 'fldGroup VARCHAR(100) NOT NULL DEFAULT "default" ,'
      + 'fldIndexKey INTEGER NOT NULL DEFAULT "1"  PRIMARY KEY AUTOINCREMENT)');

    //DB object created here

    ///
    ///
    ///
    ///
    sqlitedb := TSQLiteDatabase.Create(slDBPath);
    ///
    ///
    ///
    ///
    ///
    ///
    ModifySqlTableByQuery(sSQL);

    sSQL := (
      'CREATE TABLE ' + GROUP_TABLE + '('
      + 'fldGroupName VARCHAR(100) UNIQUE NOT NULL DEFAULT "default",' +
      '"PK" INTEGER NOT NULL DEFAULT "1"  PRIMARY KEY AUTOINCREMENT, "fldNodeExpanded" INTEGER DEFAULT 0)');

    ModifySqlTableByQuery(sSQL);

    sSQL := 'INSERT INTO "' + GROUP_TABLE + '" VALUES ("default", 1, 0);';
    ModifySqlTableByQuery(sSQL);

    sSQL := (
      'CREATE TABLE ' + DB_INFO_TABLE + '('
      + 'fldAccessVal1 VARCHAR(512),'
      + 'fldAccessVal2 VARCHAR(512),'
      + 'fldAccessHash VARCHAR(256),'
      + 'fldRepairText VARCHAR(1024),' //holds license key
      + '"PK" INTEGER NOT NULL DEFAULT "1"  PRIMARY KEY AUTOINCREMENT)');

    ModifySqlTableByQuery(sSQL);

    sSQL := 'INSERT INTO ' + DB_INFO_TABLE +
      ' ("fldAccessVal1","fldAccessVal2","fldAccessHash") VALUES("'
      + (sEncryptedPassVal) + '","'
      + (sEncryptedPassVal2) + '","'
      + sHashedPass + '");';

    ModifySqlTableByQuery(sSQL);
  end
  else
  begin

    //DB object created here

    ///
    ///
    ///
    ///
    sqlitedb := TSQLiteDatabase.Create(slDBPath);
    ///
    ///
    ///
    ///
    ///

    try
      sSQL := 'SELECT fldAccessHash, fldAccessVal1, fldAccessVal2 From "' + DB_INFO_TABLE + '"';
      GetSqlTableByQuery(sltbDbInfo, sSQL);

      while not sltbDbInfo.EOF do
      begin
        sHashedPass := sltbDbInfo.FieldAsString(sltbDbInfo.FieldIndex['fldAccessHash']);
        sTempEncryptedVal1 := sltbDbInfo.FieldAsString(sltbDbInfo.FieldIndex['fldAccessVal1']);
        sTempEncryptedVal2 := sltbDbInfo.FieldAsString(sltbDbInfo.FieldIndex['fldAccessVal2']);
        sltbDbInfo.Next;
      end;

{$IFNDEF LITE_VERSION}
      ShowPassForm(False, sHashedPass);
{$ELSE}
      SetTrialState();
{$ENDIF}

    finally
      if sltbDbInfo <> nil then
        FreeAndNil(sltbDbInfo);
    end;

    if Length(sUserSuppliedHashedPass) < 1 then
    begin
      MessageDlg('You did not provide a password. Exiting.', mtError, [mbOK], 0);
      Halt;
    end;

    if not SameText(sUserSuppliedHashedPass, sHashedPass) then
    begin
      MessageDlg('Incorrect password. Exiting.', mtError, [mbOK], 0);
      Halt;
    end;

    sEncryptedPassVal := sTempEncryptedVal1; //these are in hex
    sEncryptedPassVal2 := sTempEncryptedVal2; //these are in hex

  end;

  PageControl1.Visible := True;
  CreateTreeViewOnStartup();
{$IFNDEF LITE_VERSION}
  if not IsValidLicenseDb then
  begin
    MessageBox(0, 'This software is not yet registered.' + #13 + #10 + '' + #13 + #10 +
      'Please enter the user name and serial number provided when you purchased this software.', '',
      MB_ICONINFORMATION or MB_OK or MB_TASKMODAL or MB_TOPMOST);

    //MessageDlg('This software is not yet registered. ' + #13 + #10 + '' + #13 + #10 +
    //  'Please enter the user name and serial number provided when you purchased this software.',
    //  mtError, [mbOK], 0);

    ShowRegistrationForm();

    if not IsValidLicenseDb then
      Halt;
  end
  else
  begin
    GetLicInfo(sUser, sTmp);
    Form1.Caption := Form1.Caption + ' - Registered to: ' + sUser;
  end;

  tmr1.Enabled := True;
{$ELSE}
  //seHoursMinutes.MaxValue := TRIAL_REENABLE_MIN;
  //seHoursMinutes.MinValue := 1;

  Form1.Caption := Form1.Caption + ' - TRIAL VERSION';
  tmr1.Enabled := True;
{$ENDIF}

  //

  vst1.FocusedNode := vst1.GetFirstLevel(0);
  vst1.Selected[vst1.GetFirstLevel(0)] := True;
  //
  DSiProcessMessages(vst1.Handle, False);

end;

procedure TForm1.SetCheckedListboxState(const checkBox: TCheckListBox; idx: integer; const check:
  boolean);
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

procedure TForm1.SetCheckedState(const checkBox: TCheckBox; const check: boolean);
var
  onClickHandler              : TNotifyEvent;
begin
  with checkBox do
  begin
    onClickHandler := OnClick;
    OnClick := nil;
    Checked := check;
    OnClick := onClickHandler;
  end;
end;

procedure TForm1.SetCheckedRadioBtnState(const radioBtn: TRadioButton; const check: boolean);
var
  onClickHandler              : TNotifyEvent;
begin

  onClickHandler := radioBtn.OnClick;
  radioBtn.OnClick := nil;
  radioBtn.Checked := check;
  radioBtn.OnClick := onClickHandler;
end;

procedure TForm1.grpAlternateCredsCheckBoxClick(Sender: TObject);
begin
  SetFieldsChanged(True);
end;

procedure TForm1.lblCredPass2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  SetFieldsChanged(True);
end;

procedure TForm1.lblCredUser2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  //
  SetFieldsChanged(True);
end;

procedure TForm1.lblNoHostsInGroupClick(Sender: TObject);
begin
  panelNoHostsInGroup.Visible := False;
end;

procedure TForm1.lvRemoteNicsDrawItem(Sender: TCustomListView; Item: TListItem;
  Rect: TRect; State: TOwnerDrawState);

  function ShrinkRect(const r: TRect; const X0, X1, Y0, Y1: integer): TRect; inline;
  begin
    result := r;
    inc(result.Left, X0);
    inc(result.Top, Y0);
    dec(result.Right, X1);
    dec(result.Bottom, Y1);
  end;

const
  btnCheckedNormal            = DFCS_BUTTONCHECK or DFCS_CHECKED or DFCS_FLAT;
  btnUncheckedNormal          = DFCS_BUTTONCHECK or DFCS_FLAT;
  btnUncheckedDisabled        = DFCS_BUTTONCHECK or DFCS_INACTIVE;
  btnCheckedDisabled          = DFCS_BUTTONCHECK or DFCS_CHECKED or DFCS_INACTIVE;
  IsChecked                   : array[Boolean] of Integer =
    (DFCS_BUTTONCHECK, DFCS_BUTTONCHECK or DFCS_CHECKED);
  CHECK_COL_EN                = 0;
  CHECK_COL_DIS               = 1;
  PADDING                     = 4;
var
  r                           : TRect;
  i                           : Integer;
  s                           : string;
  size                        : TSize;
  h                           : HTHEME;
  checkstate                  : Integer;
  ACol                        : integer;
  DrawState                   : integer;
  bDrawFrameSuccess           : boolean;
  // non themes:
  btnState                    : integer;
begin

  if chkEnableAllAdapters.Checked or chkDisableAllAdapters.Checked then
    FillRect(Sender.Canvas.Handle, Rect, GetStockObject(cl3DLight))
  else
    FillRect(Sender.Canvas.Handle, Rect, GetStockObject(WHITE_BRUSH));

  r := Rect;
  inc(r.Left, PADDING);

  for i := 0 to TListView(Sender).Columns.Count - 1 do
  begin
    r.Right := r.Left + Sender.Column[i].Width;
    if ((i <> CHECK_COL_EN) and (i <> CHECK_COL_DIS)) then
      //this means if this is not the Enable or Disable columns (first 2)
    begin
      if i = 0 then
      begin
        s := Item.Caption;
        if not IsWindowVisible(ListView_GetEditControl(Sender.Handle)) then
        begin
          if UseThemes and ([odSelected, odHotLight] * State <> []) then
          begin
            h := OpenThemeData(Sender.Handle, 'LISTVIEW');
            if h <> 0 then
              try
                DrawThemeBackground(h, Sender.Canvas.Handle, LVP_GROUPHEADER, IfThen(odSelected in
                  State, LVGH_CLOSESELECTED, LVGH_OPENHOT), ShrinkRect(r, -2, 6, 1, 1), nil);
              finally
                CloseThemeData(h);
              end;
          end;
          if (odSelected in State) and not UseThemes then
            DrawFocusRect(Sender.Canvas.Handle, ShrinkRect(r, -2, 6, 1, 1));
        end;
      end
      else
      begin
        s := Item.SubItems[i - 1];
      end;

      Sender.Canvas.Brush.Style := bsClear;
      DrawText(Sender.Canvas.Handle,
        PChar(s),
        length(s),
        r,
        DT_SINGLELINE or DT_VCENTER or DT_LEFT or DT_END_ELLIPSIS);
    end
    else
    begin
      ACol := DetermineListViewColumn(lvRemoteNics, Item, r.Left);

      if ACol <> i then
        Exit;

      size.cx := GetSystemMetrics(SM_CXMENUCHECK);
      size.cy := GetSystemMetrics(SM_CYMENUCHECK);
      if UseThemes then
      begin
        h := OpenThemeData(Sender.Handle, 'BUTTON');
        if h <> 0 then
          try

            if chkEnableAllAdapters.Checked or chkDisableAllAdapters.Checked then
              GetThemePartSize(h, Sender.Canvas.Handle, BP_CHECKBOX, CBS_CHECKEDDISABLED, nil,
                TS_DRAW, size)
            else
              GetThemePartSize(h, Sender.Canvas.Handle, BP_CHECKBOX, CBS_CHECKEDNORMAL, nil,
                TS_DRAW, size);

            r.Top := Rect.Top + (Rect.Bottom - Rect.Top - size.cy) div 2;
            r.Bottom := r.Top + size.cy;
            r.Left := r.Left + PADDING;
            r.Right := r.Left + size.cx;

            //if (CompareText(Item.SubItems[i], 'True') = 0) then
            if ACol = 0 then
            begin
              if (CompareText(Item.Caption, '0') = 0) then
              begin
                if chkEnableAllAdapters.Checked or chkDisableAllAdapters.Checked then
                  checkstate := CBS_UNCHECKEDNORMAL
                else
                  checkstate := CBS_UNCHECKEDDISABLED;
              end
              else
              begin
                if chkEnableAllAdapters.Checked or chkDisableAllAdapters.Checked then
                  checkstate := CBS_CHECKEDDISABLED
                else
                  checkstate := CBS_CHECKEDNORMAL;
              end;
            end
            else
            begin
              if (CompareText(Item.SubItems[0], '0') = 0) then
                //subitems[0] is actually "disable" column
              begin
                if chkEnableAllAdapters.Checked or chkDisableAllAdapters.Checked then
                  checkstate := CBS_UNCHECKEDNORMAL
                else
                  checkstate := CBS_UNCHECKEDDISABLED;
              end
              else
              begin
                if chkEnableAllAdapters.Checked or chkDisableAllAdapters.Checked then
                  checkstate := CBS_CHECKEDDISABLED
                else
                  checkstate := CBS_CHECKEDNORMAL;
              end;
            end;

            DrawThemeBackground(h, Sender.Canvas.Handle, BP_CHECKBOX, checkstate, r, nil);
          finally
            CloseThemeData(h);
          end;
      end
      else
      begin

        r.Top := Rect.Top + (Rect.Bottom - Rect.Top - size.cy) div 2;
        r.Bottom := r.Top + size.cy;
        r.Left := r.Left + PADDING;
        r.Right := r.Left + size.cx;

        //DrawState := CompareText(Item.SubItems[i], 'True');

        // DrawFrameControl(Sender.Canvas.Handle, r, DFC_BUTTON, btnGrayChecked);

         /// need to determine adapters to check
         ///
         ///
         ///

        if chkEnableAllAdapters.Checked or chkDisableAllAdapters.Checked then
        begin
          //GetThemePartSize(h, Sender.Canvas.Handle, BP_CHECKBOX, CBS_CHECKEDDISABLED, nil,
          //  TS_DRAW, size);
          DrawFrameControl(Sender.Canvas.Handle, r, DFC_BUTTON, btnCheckedDisabled);
        end
        else
        begin
          //GetThemePartSize(h, Sender.Canvas.Handle, BP_CHECKBOX, CBS_CHECKEDNORMAL, nil,
          //  TS_DRAW, size);

          DrawFrameControl(Sender.Canvas.Handle, r, DFC_BUTTON, btnCheckedNormal);
        end;

        //if (CompareText(Item.SubItems[i], 'True') = 0) then
        if ACol = 0 then
        begin
          if (CompareText(Item.Caption, '0') = 0) then
          begin
            if chkEnableAllAdapters.Checked or chkDisableAllAdapters.Checked then
              checkstate := btnUncheckedDisabled //CBS_UNCHECKEDNORMAL
            else
              checkstate := btnUncheckedNormal; // CBS_UNCHECKEDDISABLED;
          end
          else
          begin
            if chkEnableAllAdapters.Checked or chkDisableAllAdapters.Checked then
              checkstate := btnCheckedDisabled // CBS_CHECKEDDISABLED
            else
              checkstate := btnCheckedNormal; // CBS_CHECKEDNORMAL;
          end;
        end
        else
        begin
          if (CompareText(Item.SubItems[0], '0') = 0) then
            //subitems[0] is actually "disable" column
          begin
            if chkEnableAllAdapters.Checked or chkDisableAllAdapters.Checked then
              checkstate := btnUncheckedDisabled //CBS_UNCHECKEDNORMAL
            else
              checkstate := btnUncheckedNormal; //CBS_UNCHECKEDDISABLED;
          end
          else
          begin
            if chkEnableAllAdapters.Checked or chkDisableAllAdapters.Checked then
              checkstate := btnCheckedDisabled //CBS_CHECKEDDISABLED
            else
              checkstate := btnCheckedNormal; //CBS_CHECKEDNORMAL;
          end;
        end;

        //DrawThemeBackground(h, Sender.Canvas.Handle, BP_CHECKBOX, checkstate, r, nil);
        DrawFrameControl(Sender.Canvas.Handle, r, DFC_BUTTON, checkstate);

      end;

    end;
    inc(r.Left, Sender.Column[i].Width);
  end;
end;

procedure TForm1.ListView1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  Item, Item2                 : TListItem;
  ACol                        : Integer;
  sNewCaption                 : string;
  ColStartX                   : integer;
begin
  //
{$IFDEF LITE_VERSION}
  Exit;
{$ENDIF}
  // Which item belongs to the checkbox
  Item := lvRemoteNics.GetItemAt(x, y);

  // What kind of thing was hit on the item
  //HitTest := lvRemoteNics.GetHitTestInfoAt(x, y);

  // If an Item was hit and exactly his checkbox
  if (Item <> nil) then
  begin
    ACol := DetermineListViewColumn(lvRemoteNics, Item, X);

    if ACol = 0 then
    begin
      //0=false, -1 = true

      ColStartX := X + lvRemoteNics.Columns[0].Width;
      Item2 := lvRemoteNics.GetItemAt(ColStartX, y);

      sNewCaption := IfThen(CompareText(Item.Caption, '0') = 0, '-1', '0'); //swap them
      Item.Caption := sNewCaption;

      if ((sNewCaption <> '0') and (Item2.SubItems[0] <> '0')) then
      begin

        sNewCaption := IfThen(CompareText(sNewCaption, '0') = 0, '-1', '0'); //swap them
        Item2.SubItems[0] := sNewCaption;

      end;

      if sNewCaption = '0' then
      begin
        SetCheckedState(chkEnableAllAdapters, False);
        SetCheckedState(chkDisableAllAdapters, False);
      end
      else if sNewCaption = '-1' then
      begin
        SetCheckedState(chkDisableAllAdapters, False);
      end;

    end
    else if ACol = 1 then
    begin

      ColStartX := X - lvRemoteNics.Columns[1].Width;
      Item2 := lvRemoteNics.GetItemAt(ColStartX, y);

      sNewCaption := IfThen(CompareText(Item.SubItems[0], '0') = 0, '-1', '0'); //swap them
      Item.SubItems[0] := sNewCaption;

      if ((sNewCaption <> '0') and (Item2.Caption <> '0')) then
      begin
        sNewCaption := IfThen(CompareText(sNewCaption, '0') = 0, '-1', '0'); //swap them
        Item2.Caption := sNewCaption;
      end;

      if sNewCaption = '0' then
      begin
        SetCheckedState(chkEnableAllAdapters, False);
        SetCheckedState(chkDisableAllAdapters, False);
      end
      else if sNewCaption = '-1' then
      begin
        SetCheckedState(chkEnableAllAdapters, False);
      end;
    end;

    SetFieldsChanged(True);
  end;
end;

function TForm1.DetermineListViewColumn(ListView: TListview; ListItem: TListItem; x: integer):
  integer;
var
  n, i, RelativeX, ColStartX  : Integer;
  Col                         : Integer;
begin

  if ListItem <> nil then
  begin
    // Now let's try to find the Column
    RelativeX := X - {ListItem.Position.X} -BorderWidth;
    ColStartX := ListView.Columns[0].Width;
    n := ListView.Columns.Count - 1;
    for i := 0 to n do
    begin
      if RelativeX < ColStartX then
      begin
        Col := i;
        Result := Col;
        break;
      end;
      Inc(ColStartX, ListView.Columns[i].Width);
    end;
  end;
end;

{
function TForm1.DetermineListViewRow(ListView: TListview; CurItem: TListItem): integer;
var
  //  pos_              : integer;
  idx                         : Integer;
begin
  Result := -1; //default
  for idx := 0 to ListView.Items.Count do
  begin
    if ListView.Items[idx] = CurItem then
    begin
      Result := idx;
      break;
    end;
  end;
end;
}

procedure TForm1.lvAutoStartApplicationsColumnClick(Sender: TObject;
  Column: TListColumn);
begin
  TListView(Sender).SortType := ComCtrls.stNone;
  if Column.Index <> SortedColAutostart then
  begin
    SortedColAutostart := Column.Index;
    DescGroupHosts := False;
  end
  else
    DescGroupHosts := not DescGroupHosts;
  TListView(Sender).SortType := ComCtrls.stText;
end;

procedure TForm1.lvAutoStartApplicationsCompare(Sender: TObject; Item1,
  Item2: TListItem; Data: Integer; var Compare: Integer);
var
  idx                         : integer;
  sItem1, sItem2              : string;
begin
  if Assigned(Item1) and Assigned(Item2) then
  begin
    try
      if SortedColAutostart = 0 then
        Compare := CompareText(Item1.Caption, Item2.Caption)
      else if SortedColAutostart <> 0 then
      begin
        idx := SortedColAutostart - 1;

        if idx < 0 then
          exit;

        if idx>(Item1.SubItems.Count - 1) then
          exit;

        if idx>(Item2.SubItems.Count - 1) then
          exit;

        sItem1 := Item1.SubItems[idx];
        sItem2 := Item2.SubItems[idx];
        Compare := CompareText(Item1.SubItems[idx], Item2.SubItems[idx]);
      end;

      if DescGroupHosts then
        Compare := -Compare;
    except on E: Exception do
      begin
        //
        //ShowMessage(E.Message);
      end;
    end;
  end;
end;

procedure TForm1.lvGroupHostsColumnClick(Sender: TObject; Column: TListColumn);
begin
  TListView(Sender).SortType := ComCtrls.stNone;
  if Column.Index <> SortedColGroupHosts then
  begin
    SortedColGroupHosts := Column.Index;
    DescGroupHosts := False;
  end
  else
    DescGroupHosts := not DescGroupHosts;
  TListView(Sender).SortType := ComCtrls.stText;
end;

procedure TForm1.lvGroupHostsCompare(Sender: TObject; Item1, Item2: TListItem;
  Data: Integer; var Compare: Integer);
var
  idx                         : integer;
  sItem1, sItem2              : string;
begin
  if Assigned(Item1) and Assigned(Item2) then
  begin
    try
      if SortedColGroupHosts = 0 then
        Compare := CompareText(Item1.Caption, Item2.Caption)
      else if SortedColGroupHosts <> 0 then
      begin
        idx := SortedColGroupHosts - 1;

        if idx < 0 then
          exit;

        if idx>(Item1.SubItems.Count - 1) then
          exit;

        if idx>(Item2.SubItems.Count - 1) then
          exit;

        sItem1 := Item1.SubItems[idx];
        sItem2 := Item2.SubItems[idx];
        Compare := CompareText(Item1.SubItems[idx], Item2.SubItems[idx]);
      end;

      if DescGroupHosts then
        Compare := -Compare;
    except on E: Exception do
      begin
        //
        //ShowMessage(E.Message);
      end;
    end;
  end;
end;

procedure TForm1.lvMultipleComputersColumnClick(Sender: TObject;
  Column: TListColumn);
begin
  TListView(Sender).SortType := ComCtrls.stNone;
  if Column.Index <> SortedColMultipleHosts then
  begin
    SortedColMultipleHosts := Column.Index;
    DescMultipleHosts := False;
  end
  else
    DescMultipleHosts := not DescMultipleHosts;

  TListView(Sender).SortType := ComCtrls.stText; //
end;

procedure TForm1.lvMultipleComputersCompare(Sender: TObject; Item1,
  Item2: TListItem; Data: Integer; var Compare: Integer);
var
  idx                         : integer;
  sItem1, sItem2              : string;
begin
  if Assigned(Item1) and Assigned(Item2) then
  begin
    try
      if SortedColMultipleHosts = 0 then
        Compare := CompareText(Item1.Caption, Item2.Caption)
      else if SortedColMultipleHosts <> 0 then
      begin
        idx := SortedColMultipleHosts - 1;

        if idx < 0 then
          exit;

        if idx>(Item1.SubItems.Count - 1) then
          exit;

        if idx>(Item2.SubItems.Count - 1) then
          exit;

        sItem1 := Item1.SubItems[idx];
        sItem2 := Item2.SubItems[idx];
        Compare := CompareText(Item1.SubItems[idx], Item2.SubItems[idx]);
      end;

      if DescGroupHosts then
        Compare := -Compare;
    except on E: Exception do
      begin
        //
        //ShowMessage(E.Message);
      end;
    end;
  end;
end;

procedure TForm1.lvRemoteNicsColumnClick(Sender: TObject; Column: TListColumn);
begin
  TListView(Sender).SortType := ComCtrls.stNone;
  if Column.Index <> SortedColRemoteNics then
  begin
    SortedColRemoteNics := Column.Index;
    DescRemoteNics := False;
  end
  else
    DescRemoteNics := not DescRemoteNics;
  TListView(Sender).SortType := ComCtrls.stText;
end;

procedure TForm1.lvRemoteNicsCompare(Sender: TObject; Item1, Item2: TListItem;
  Data: Integer; var Compare: Integer);
var
  idx                         : integer;
  sItem1, sItem2              : string;
begin
  if Assigned(Item1) and Assigned(Item2) then
  begin
    try
      if SortedColRemoteNics = 0 then
        Compare := CompareText(Item1.Caption, Item2.Caption)
      else if SortedColRemoteNics <> 0 then
      begin
        idx := SortedColRemoteNics - 1;

        if idx < 0 then
          exit;

        if idx>(Item1.SubItems.Count - 1) then
          exit;

        if idx>(Item2.SubItems.Count - 1) then
          exit;

        sItem1 := Item1.SubItems[idx];
        sItem2 := Item2.SubItems[idx];
        Compare := CompareText(Item1.SubItems[idx], Item2.SubItems[idx]);
      end;

      if DescGroupHosts then
        Compare := -Compare;
    except on E: Exception do
      begin
        //
        //ShowMessage(E.Message);
      end;
    end;
  end;
end;

procedure TForm1.lvRemoteNicsItemChecked(Sender: TObject; Item: TListItem);
begin
  SetFieldsChanged(True);

  if Item.Checked then
  begin
    SetCheckedState(chkEnableAllAdapters, False);
  end
  else
  begin
    SetCheckedState(chkDisableAllAdapters, False);
  end;

end;

procedure TForm1.memoUserMessageKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = Ord('A')) and (ssCtrl in Shift) then
  begin
    TMemo(Sender).SelectAll;
    Key := 0;
  end;
end;

procedure TForm1.mmoDeploymentResultClick(Sender: TObject);
begin
  HideCaret(mmoDeploymentResult.Handle);
end;

procedure TForm1.mmoDeploymentResultKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = Ord('A')) and (ssCtrl in Shift) then
  begin
    TMemo(Sender).SelectAll;
    Key := 0;
  end;
end;

procedure TForm1.CreateTreeViewOnStartup;
var
  HostNode, ChildNode         : PVirtualNode;
  NetworkData, HostData, ChildData: PHostRec;
  sCurGroup                   : string;
  sSQL                        : string;
  bExpandedNode               : boolean;
  iHostOnline                 : integer;
  idx                         : Integer;
begin
  bExpandedNode := False; //default
  vst1.BeginUpdate;
  try
    sSQL := 'SELECT fldGroupName, fldNodeExpanded From "' + GROUP_TABLE + '"';
    GetSqlTableByQuery(sltbGroups, sSQL);

    vst1.Clear;
    vst1.NodeDataSize := Sizeof(THostRec);

    idx := 0;
    while not sltbGroups.EOF do
    begin
      if not Assigned(NetworkNode) then
      begin
        NetworkNode := vst1.AddChild(nil);
        vst1.ValidateNode(NetworkNode, False);
        //NetworkNode.CheckType := ctNone;

        NetworkData := vst1.GetNodeData(NetworkNode);
        NetworkData^.AGroupname := '-';
        NetworkData^.AHostname := '-';
        NetworkData^.ALevel := NETWORK_LEVEL;
        NetworkData^.AbOnline := 1; //online - not really used
      end;

      HostNode := vst1.AddChild(NetworkNode);
      vst1.ValidateNode(HostNode, False);
      //HostNode.CheckType := ctNone;
      //HostNode.CheckState := csUncheckedNormal;
      //
      sCurGroup := sltbGroups.FieldAsString(sltbGroups.FieldIndex['fldGroupName']);
      bExpandedNode :=
        StrToBool(sltbGroups.FieldAsString(sltbGroups.FieldIndex['fldNodeExpanded']));

      HostData := vst1.GetNodeData(HostNode);
      //
      HostData^.AGroupname := sCurGroup;
      HostData^.AHostname := '-';
      HostData^.ALevel := FOLDER_LEVEL;
      HostData^.AbOnline := 1; //online - not really used

      sSQL := 'SELECT * From ' + INFO_TABLE + ' WHERE fldGroup = "' + sCurGroup + '"';

      GetSqlTableByQuery(sltbInfo, sSQL);
      vst1.Invalidate();

      while not sltbInfo.EOF do
      begin

{$IFDEF LITE_VERSION}
        if idx < TRIAL_HOSTS_ALLOWED then
          Inc(idx)
        else
        begin
          sltbInfo.Next;
          continue;
        end;
{$ENDIF}

        if Length(sltbInfo.FieldByName['fldHostOnline']) < 1 then
        begin
          iHostOnline := 0; //
        end
        else
        begin
          iHostOnline := StrToInt(sltbInfo.FieldByName['fldHostOnline']);

          if (iHostOnline <> 0) and (iHostOnline <> 1) then
            iHostOnline := 0;
        end;

        ChildNode := vst1.AddChild(HostNode); //child node
        vst1.ValidateNode(ChildNode, False);
        //
        ChildData := vst1.GetNodeData(ChildNode);

        //
        ChildData^.AGroupname := sCurGroup;
        ChildData^.AHostname := sltbInfo.FieldAsString(sltbInfo.FieldIndex['fldHostname']);
        ChildData^.ALevel := HOST_LEVEL;
        ChildData^.AbOnline := iHostOnline;

        sltbInfo.Next;
      end;

      if bExpandedNode then
      begin
        if not (vsExpanded in HostNode.States) then
          vst1.ToggleNode(HostNode);
      end;

      sltbGroups.Next;
    end;

    if Assigned(NetworkNode) then
    begin
      if not (vsExpanded in NetworkNode.States) then
      begin
        vst1.ToggleNode(NetworkNode);
      end;
    end;

    //vst1.SortTree(0, sdAscending, true);
    vst1.BeginUpdate;
    try
      vst1.Invalidate;
      vst1.SortTree(0, sdAscending, true);
    finally
      vst1.EndUpdate;
    end;
    { The above "SortTree" is done to FORCE VirtualTree to INIT all
      of our data records and load them from the database. Even though this is contrary
      to the whole idea of the VitualTree, If we dont do this, then data does not get
      loaded from the database into the tree as you would expect.
      Note that it seems you only need to do this IF you are going to be doing some other
      work with the database data BEFORE the individual nodes get scrolled into view.
    }

    if Assigned(HostNode) then
    begin
      //vst1.Selected[Node] := True;
      ShowNodeDetails(0, vst1.GetNodeData(HostNode));
    end;
  finally
    vst1.EndUpdate;

    if sltbGroups <> nil then
      FreeAndNil(sltbGroups);

    //sldb.Free;
  end;

  //vst1.FullExpand();
end;

initialization
  mHandle := CreateMutex(nil, True, '{9E4BDFAA-1B85-410C-976E-C729BDCBB624}');
  if GetLastError = ERROR_ALREADY_EXISTS then
  begin
    MessageBox(0, 'This program is already running!', 'Already Running', MB_ICONINFORMATION or
      MB_OK or MB_TASKMODAL or MB_TOPMOST);
    halt;
  end;

  Crit_UpdateDb := TCriticalSection.Create;
  //crit_WmiQuery_NicInfo := TCriticalSection.Create;
  //crit_WmiQuery_AutoStart := TCriticalSection.Create;
  //crit_WmiQuery_SysInfo := TCriticalSection.Create;

finalization
  if mHandle <> 0 then
    CloseHandle(mHandle);

  FreeAndNil(Crit_UpdateDb);
  //FreeAndNil(crit_WmiQuery_NicInfo);
  //FreeAndNil(crit_WmiQuery_AutoStart);
  //FreeAndNil(crit_WmiQuery_SysInfo);
end.

