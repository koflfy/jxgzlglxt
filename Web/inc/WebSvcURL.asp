<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>
<%
	OPTION  EXPLICIT  
	dim sUrl,gbBackUrl
	sUrl="http://" & Request.ServerVariables("HTTP_HOST") & Request.ServerVariables("HTTP_URL")
	sUrl=left(sUrl,instrRev(sUrl,"/"))		'得到的是一个带虚拟目录的Url值
	gbBackUrl=sUrl
	
	Const gbDebugDate="20100228"		'工商银行测试服务器的时间
'	Const gbWebServiceUrl="http://sf.szrtvu.com.cn/NetPay/NetPayWebSrv.dll/wsdl/INetPay"
	Const gbWebServiceUrl="http://localhost/NetPay/Srv/NetPayWebSrv.dll/wsdl/INetPay"

	Dim  strWebSvcWSDLURL  
	Dim  objSOAPClient    
	strWebSvcWSDLURL = gbWebServiceUrl  
'	strWebSvcWSDLURL = "http://localhost:1024/NetPayWadSrv.NetPay/wsdl/INetPay"
	Set  objSOAPClient  =  Server.CreateObject("MSSOAP.SoapClient30")  
	objSOAPClient.ClientProperty("ServerHTTPRequest") = True    
	objSOAPClient.MSSoapInit   strWebSvcWSDLURL,   "",   "",   ""  
%>
