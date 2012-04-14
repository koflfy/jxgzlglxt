program WebInstall;

uses
  Forms,
  uWebMain in 'uWebMain.pas' {WebMain},
  uIIS in '..\public\uIIS.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TWebMain, WebMain);
  Application.Run;
end.
