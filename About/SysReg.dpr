program SysReg;

uses
  Forms,
  uDM in '..\public\uDM.pas' {DM: TDataModule},
  GetGBKPY_imp in '..\public\GetGBKPY_imp.pas',
  uSysRegister in '..\public\uSysRegister.pas' {SysRegister},
  uJxgzlIntf in '..\Srv\uJxgzlIntf.pas',
  uAdminIntf in '..\Srv\uAdminIntf.pas',
  PwdFunUnit in '..\public\PwdFunUnit.pas',
  EncdDecdEx in '..\public\EncdDecdEx.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  dm := TDM.Create(Application);
  Application.CreateForm(TSysRegister, SysRegister);
  Application.Run;
end.
