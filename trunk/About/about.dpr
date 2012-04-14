program about;

uses
  Forms,
  uABOUT in '..\public\uABOUT.pas' {AboutBox},
  Net in '..\public\Net.pas',
  uDM in '..\public\uDM.pas' {DM: TDataModule},
  GetGBKPY_imp in '..\public\GetGBKPY_imp.pas',
  uJxgzlIntf in '..\Srv\uJxgzlIntf.pas',
  uAdminIntf in '..\Srv\uAdminIntf.pas',
  PwdFunUnit in '..\public\PwdFunUnit.pas',
  EncdDecdEx in '..\public\EncdDecdEx.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  dm := Tdm.Create(Application);
  Application.CreateForm(TAboutBox, AboutBox);
  Application.Run;
end.
