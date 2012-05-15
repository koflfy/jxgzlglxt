program jxgzlglxt;

uses
  Forms,
  uMain in 'uMain.pas' {Main},
  uDM in '..\public\uDM.pas' {DM: TDataModule},
  uConnSet in 'uConnSet.pas' {ConnSet},
  uLogin in 'uLogin.pas' {Login},
  uCzyEdit in 'uCzyEdit.pas' {CzyEdit},
  uKsInfoBrowse in 'uKsInfoBrowse.pas' {KsInfoBrowse},
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
  uMzDmSet in 'uMzDmSet.pas' {MzDmSet},
  uCzyRightGroupSet in 'uCzyRightGroupSet.pas' {CzyRightGroupSet},
  uStatusDisplay in 'uStatusDisplay.pas' {StatusDisplay},
  uLockScreen in 'uLockScreen.pas' {LockScreen},
  PwdFunUnit in '..\public\PwdFunUnit.pas',
  uReportDesign in 'uReportDesign.pas' {ReportDesign},
  uPrintBHSet in 'uPrintBHSet.pas' {PrintBHSet},
  uNetBmTimeSet in 'uNetBmTimeSet.pas' {NetBmTimeSet},
  uZzMmSet in 'uZzMmSet.pas' {ZzMmSet},
  uBkZyLbSet in 'uBkZyLbSet.pas' {BkZyLbSet},
  uBkZySet in 'uBkZySet.pas' {BkZySet},
  uEnglishDjKsSet in 'uEnglishDjKsSet.pas' {EnglishDjKsSet},
  uJsjDjKsSet in 'uJsjDjKsSet.pas' {JsjDjKsSet},
  uSchoolSet in 'uSchoolSet.pas' {SchoolSet},
  uRoomSet in 'uRoomSet.pas' {RoomSet},
  uSfDmSet in 'uSfDmSet.pas' {SfDmSet},
  uKsBmEdit in 'uKsBmEdit.pas' {KsBmEdit},
  uKsBmInput in 'uKsBmInput.pas' {KsBmInput},
  uKsInfo in 'uKsInfo.pas' {KsInfo},
  uPhotoProcess in 'uPhotoProcess.pas' {PhotoProcess},
  uKsBmConfirm in 'uKsBmConfirm.pas' {KsBmConfirm},
  uKsKcSet in 'uKsKcSet.pas' {KsKcSet},
  uZkzEdit in 'uZkzEdit.pas' {ZkzEdit},
  uAutoPkInput in 'uAutoPkInput.pas' {AutoPkInput},
  uZkzInfoBrowse in 'uZkzInfoBrowse.pas' {ZkzInfoBrowse},
  EncdDecdEx in '..\public\EncdDecdEx.pas',
  uGzljsbfFileSet in 'uGzljsbfFileSet.pas' {GzljsbfFileSet},
  uCjInput in 'uCjInput.pas' {CjInput},
  uInitKsCjb in 'uInitKsCjb.pas' {InitKsCjb},
  uCjBrowse in 'uCjBrowse.pas' {CjBrowse},
  uZkzInput in 'uZkzInput.pas' {ZkzInput},
  uKsDfbPrint in 'uKsDfbPrint.pas' {KsDfbPrint},
  uCjTotal in 'uCjTotal.pas' {CjTotal},
  uCjImport in 'uCjImport.pas' {CjImport},
  uCjUpload in 'uCjUpload.pas' {CjUpload};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '教学工作量管理系统';
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
