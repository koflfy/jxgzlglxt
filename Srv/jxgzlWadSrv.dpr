program jxgzlWadSrv;

{$APPTYPE GUI}

uses
  Forms,
  SockApp,
  uJxgzlWebModule in 'uJxgzlWebModule.pas' {ZsbBmWebModule: TWebModule},
  uWadSrvMain in 'uWadSrvMain.pas' {WadSrvMain},
  uJxgzlIntf in 'uJxgzlIntf.pas',
  uJxgzlSoapDM in 'uJxgzlSoapDM.pas' {JxgzlSoapDM: TSoapDataModule},
  uJxgzlImpl in 'uJxgzlImpl.pas',
  Net in '..\public\Net.pas',
  PwdFunUnit in '..\public\PwdFunUnit.pas',
  uAdminImpl in 'uAdminImpl.pas',
  uAdminIntf in 'uAdminIntf.pas',
  EncdDecdEx in '..\public\EncdDecdEx.pas';

//这个工程文件是好的
  
{$R *.res}

begin
  Application.Initialize;
  Application.Title := '教学工作量管理系统服务器';
  Application.CreateForm(TZsbBmWebModule, ZsbBmWebModule);
  Application.CreateForm(TWadSrvMain, WadSrvMain);
  Application.Run;
end.
