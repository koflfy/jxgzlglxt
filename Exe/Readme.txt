教务系统接口服务安装要点：

1、把JwxtWebSrv.dll拷贝到IIS的根目录或者任意一个虚拟目录中。
2、设置JwxtWebSrv.dll所在的Web目录的应用程序权限为"脚本和可执行文件"，如果是Windows Server 2003 还必须在Web扩展配置中把JwxtWebSrv.dll文件设置为允许访问。
3、Copy JwxtDbConnSet.ini文件到X:\Windows目录下，并配置JwxtDbConnSet.ini文件中的相关信息。
4、运行测试程序文件测试结果。

接口原型：
    function SrvIsOK(var sError:WideString):Boolean; stdcall;
    function  GetStuInfoByXH(const sXH: WideString; var sData: WideString; const sLoginUser: WideString; const sLoginPwd: WideString): Boolean; stdcall;
    function  GetStuInfoBySfzh(const sSfzh: WideString; var sData: WideString; const sLoginUser: WideString; const sLoginPwd: WideString): Boolean; stdcall;

如有疑问请咨询：
	QQ ：47612630
	Tel：13970889105

				----小宇飞刀(谢祥选)
					2009-1-8

