<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>
<%
	OPTION  EXPLICIT  
	dim sUrl,gbBackUrl
	sUrl="http://" & Request.ServerVariables("HTTP_HOST") & Request.ServerVariables("HTTP_URL")
	sUrl=left(sUrl,instrRev(sUrl,"/"))		'�õ�����һ��������Ŀ¼��Urlֵ
	gbBackUrl=sUrl
	
	Const gbDebugDate="20100228"		'�������в��Է�������ʱ��
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
