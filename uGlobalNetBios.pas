unit uGlobalNetBios;

{$WEAKLINKRTTI ON}
{$RTTI EXPLICIT METHODS([]) PROPERTIES([]) FIELDS([])}

interface

uses
  uThrdNbtStat,
  uThrdRetrieveHostInfo,
  uThrdDeploySvc;

var
  thrdRetrieveHostInfo : TRetrieveHostInfo;
  iRunningHostRetrievals : integer;
  //
  thrdNetBios       : TNbtstatCheck;
  iRunningTasks     : integer;
  //
  thrdDeploySvc     : TDeploySvc;
  iRunningSvcDeployments: integer;
  iRunningMassSvcDeployments : integer;

implementation

end.

