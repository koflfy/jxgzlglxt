program ClientTest;

uses
  Forms,
  uClientTestMain in 'uClientTestMain.pas' {ClinetTestMain},
  PwdFunUnit in '..\public\PwdFunUnit.pas',
  uAdminIntf in '..\Srv\uAdminIntf.pas',
  uJxgzlIntf in '..\Srv\uJxgzlIntf.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TClinetTestMain, ClinetTestMain);
  Application.Run;
end.
