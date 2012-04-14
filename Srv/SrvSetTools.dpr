program SrvSetTools;

uses
  Forms,
  uDbInfoSet in 'uDbInfoSet.pas' {DbInfoSet},
  uToolsMain in 'uToolsMain.pas' {ToolsMain},
  Net in '..\public\Net.pas',
  PwdFunUnit in '..\public\PwdFunUnit.pas',
  uIIS in '..\public\uIIS.pas',
  uServiceSet in 'uServiceSet.pas' {ServiceSet},
  uDbConnect in 'uDbConnect.pas',
  GetGBKPY_imp in '..\public\GetGBKPY_imp.pas',
  uDM in '..\public\uDM.pas' {DM: TDataModule},
  uSQLBackupRestore in '..\public\uSQLBackupRestore.pas',
  uDbBackupRestore in 'uDbBackupRestore.pas' {DbBackupRestore},
  uInputSaPwd in 'uInputSaPwd.pas' {InputSaPwd},
  uJxgzlIntf in 'uJxgzlIntf.pas',
  uAdminIntf in 'uAdminIntf.pas',
  EncdDecdEx in '..\public\EncdDecdEx.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := False;
  dm := TDM.Create(Application);
  Application.Title := '工作量管理系统服务配置工具';
  Application.CreateForm(TToolsMain, ToolsMain);
  Application.Run;
end.
