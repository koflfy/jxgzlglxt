program jxgzlWadSrv;

{$APPTYPE GUI}

uses
  Forms,
  SockApp,
  uJxgzlWebModule in 'uJxgzlWebModule.pas' {jxgzlWebModule: TWebModule},
  uWadSrvMain in 'uWadSrvMain.pas' {WadSrvMain},
  uJxgzlIntf in 'uJxgzlIntf.pas',
  uJxgzlSoapDM in 'uJxgzlSoapDM.pas' {JxgzlSoapDM: TSoapDataModule},
  uJxgzlImpl in 'uJxgzlImpl.pas',
  Net in '..\public\Net.pas',
  PwdFunUnit in '..\public\PwdFunUnit.pas',
  uAdminImpl in 'uAdminImpl.pas',
  uAdminIntf in 'uAdminIntf.pas',
  EncdDecdEx in '..\public\EncdDecdEx.pas';

//��������ļ��Ǻõ�
  
{$R *.res}

begin
  Application.Initialize;
  Application.Title := '��ѧ����������ϵͳ������';
  Application.CreateForm(TjxgzlWebModule, jxgzlWebModule);
  Application.CreateForm(TWadSrvMain, WadSrvMain);
  Application.Run;
end.
