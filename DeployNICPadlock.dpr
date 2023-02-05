program DeployNICPadlock;

{$WEAKLINKRTTI ON}
{$RTTI EXPLICIT METHODS([]) PROPERTIES([]) FIELDS([])}
//{$DYNAMICBASE ON} //ASLR enabled
//{$SETPEOPTFLAGS $100} //NX enabled
{$SETPEOPTFLAGS $140} //ASLR and NX
{$I nldefine.inc}

uses
  Forms,
  main in 'main.pas' {Form1},
  uGlobal in 'uGlobal.pas',
  uHelpers in 'uHelpers.pas',
  uRemoteNicMgrUtils in 'uRemoteNicMgrUtils.pas',
  amSplitter in 'amSplitter.pas',
  WbemScripting_TLB in 'WbemScripting_TLB.pas',
  uWmiQueries in 'uWmiQueries.pas',
  SQLite3 in 'SQLite3.pas',
  SQLiteTable3 in 'SQLiteTable3.pas',
  frmModifyIpAddress in 'forms\frmModifyIpAddress.pas' {fModifyIPAddress},
  IPMask in 'IPMask.pas',
  ThreadUtilities in 'ThreadUtilities.pas',
  uThrdAbortThreads in 'uThrdAbortThreads.pas',
  uGlobalNetBios in 'uGlobalNetBios.pas',
  frmPass in 'forms\frmPass.pas' {frmEnterPassword},
  uBasicEncrypt in 'uBasicEncrypt.pas',
  frmChangePass in 'forms\frmChangePass.pas' {frmChangePassword},
  uCustomImageDrawHook in 'uCustomImageDrawHook.pas',
  uThrdDeploySvc in 'uThrdDeploySvc.pas',
  uThrdNbtStat in 'uThrdNbtStat.pas',
  frmAltCreds in 'forms\frmAltCreds.pas' {frmAlternateCredentials},
  frmUserMessage in 'forms\frmUserMessage.pas' {frmUserMsgOnDisable},
  frmAbout in 'forms\frmAbout.pas' {frmAboutProgram},
  frmDeployProgress in 'forms\frmDeployProgress.pas' {frmShowProgress},
  uPing in 'uPing.pas',
  uThrdRetrieveHostInfo in 'uThrdRetrieveHostInfo.pas',
  uWmiDelphiClass in 'uWmiDelphiClass.pas',
  uWin32_NetworkAdapter in 'uWin32_NetworkAdapter.pas',
  uWin32_NetworkAdapterConfiguration in 'uWin32_NetworkAdapterConfiguration.pas',
  uWin32_Process in 'uWin32_Process.pas',
  frmMassDeploy in 'forms\frmMassDeploy.pas' {frmMassDeploySvc},
  frmMassRetrieve in 'forms\frmMassRetrieve.pas' {frmMassRetrieveInfo},
  frmImportDeleteHosts in 'forms\frmImportDeleteHosts.pas' {frmImportDeleteProgress},
  frmForgotPass in 'forms\frmForgotPass.pas' {frmForgotPassword},
  uLic in 'uLic.pas',
  frmRegistration in 'forms\frmRegistration.pas' {frmReg},
  uWin32_StartupCommand in 'uWin32_StartupCommand.pas',
  frmGetFullVersion in 'forms\frmGetFullVersion.pas' {frmGetFull},
  frmProtection in 'forms\frmProtection.pas' {frmTrialProtector},
  AsyncCalls in 'AsyncCalls.pas',
  uThreadStringList in 'uThreadStringList.pas',
  uBuildInfo in 'uBuildInfo.pas';

{$R *.res}
//{$R 'DeployNICPadlock.res'}
{$R 'Win7UAC.res'}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  {$IFNDEF LITE_VERSION}
  //SaveGroupState();
{$ELSE}
  Application.CreateForm(TfrmTrialProtector, frmTrialProtector);
{$ENDIF}

  Application.Run;
end.

