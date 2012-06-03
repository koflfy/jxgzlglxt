program jxgzlglxt;

uses
  Forms,
  uMain in 'uMain.pas' {Main},
  uDM in '..\public\uDM.pas' {DM: TDataModule},
  uConnSet in 'uConnSet.pas' {ConnSet},
  uLogin in 'uLogin.pas' {Login},
  uCzyEdit in 'uCzyEdit.pas' {CzyEdit},
  Net in '..\public\Net.pas',
  uUserLoginLog in 'uUserLoginLog.pas' {UserLoginLog},
  uOnlineUpdateSet in 'uOnlineUpdateSet.pas' {OnlineUpdateSet},
  uDataImport in 'uDataImport.pas' {DataImport},
  uCzyRightSet in 'uCzyRightSet.pas' {CzyRightSet},
  uUserInfoSet in 'uUserInfoSet.pas' {UserInfoSet},
  uSysLog in 'uSysLog.pas' {SysLog},
  uIpSet in 'uIpSet.pas' {IpSet},
  uWebMessagePublish in 'uWebMessagePublish.pas' {WebMessagePublish},
  uJxgzlIntf in '..\Srv\uJxgzlIntf.pas',
  uAdminIntf in '..\Srv\uAdminIntf.pas',
  uCzyRightGroupSet in 'uCzyRightGroupSet.pas' {CzyRightGroupSet},
  uStatusDisplay in 'uStatusDisplay.pas' {StatusDisplay},
  uLockScreen in 'uLockScreen.pas' {LockScreen},
  PwdFunUnit in '..\public\PwdFunUnit.pas',
  uReportDesign in 'uReportDesign.pas' {ReportDesign},
  uPrintBHSet in 'uPrintBHSet.pas' {PrintBHSet},
  uNetBmTimeSet in 'uNetBmTimeSet.pas' {NetBmTimeSet},
  EncdDecdEx in '..\public\EncdDecdEx.pas',
  uGzljsbfFileSet in 'uGzljsbfFileSet.pas' {GzljsbfFileSet},
  ujxGzlBrowse in 'ujxGzlBrowse.pas' {jxGzlBrowse},
  uExecSqlSet in 'uExecSqlSet.pas' {ExecSqlSet},
  uJxmsDmSet in 'uJxmsDmSet.pas' {JxmsDmSet},
  uXnXqSet in 'uXnXqSet.pas' {XnXqSet},
  ujxDataEdit in 'ujxDataEdit.pas' {jxDataEdit},
  uKcLbDmSet in 'uKcLbDmSet.pas' {KcLbDmSet},
  uRoomTypeSet in 'uRoomTypeSet.pas' {RoomTypeSet},
  uKcxzDmSet in 'uKcxzDmSet.pas' {KcxzDmSet},
  uHsgzLxDmSet in 'uHsgzLxDmSet.pas' {HsgzLxDmSet},
  uHsgzLxWhereSet in 'uHsgzLxWhereSet.pas' {HsgzLxWhereSet},
  uHsgzLxInput in 'uHsgzLxInput.pas' {HsgzLxInput},
  ujxGzlInitialize in 'ujxGzlInitialize.pas' {jxGzlInitialize};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '“教学工作量”核算系统';
  dm := TDM.Create(Application);
  gbIsOK := False;
  Login := TLogin.Create(Application);
  Login.ShowModal;
  if gbIsOK then
  begin
    Application.CreateForm(TMain, Main);
  end;
  Application.Run;
end.
