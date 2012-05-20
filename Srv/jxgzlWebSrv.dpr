library jxgzlWebSrv;

uses
  ActiveX,
  ComObj,
  WebBroker,
  ISAPIApp,
  ISAPIThreadPool,
  uJxgzlWebModule in 'uJxgzlWebModule.pas' {jxgzlWebModule: TWebModule},
  uJxgzlSoapDM in 'uJxgzlSoapDM.pas' {JxgzlSoapDM: TSoapDataModule},
  Net in '..\public\Net.pas',
  PwdFunUnit in '..\public\PwdFunUnit.pas',
  uJxgzlIntf in 'uJxgzlIntf.pas',
  uJxgzlImpl in 'uJxgzlImpl.pas',
  uAdminIntf in 'uAdminIntf.pas',
  uAdminImpl in 'uAdminImpl.pas',
  EncdDecdEx in '..\public\EncdDecdEx.pas';

{$R *.res}

exports
  GetExtensionVersion,
  HttpExtensionProc,
  TerminateExtension;

begin
  CoInitFlags := COINIT_MULTITHREADED;
  Application.Initialize;
  Application.CreateForm(TjxgzlWebModule, jxgzlWebModule);
  Application.Run;
end.
