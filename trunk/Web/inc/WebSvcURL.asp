<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>
<%
	OPTION  EXPLICIT  
	dim sUrl,gbBackUrl
	sUrl="http://" & Request.ServerVariables("HTTP_HOST") & Request.ServerVariables("HTTP_URL")
	sUrl=left(sUrl,instrRev(sUrl,"/"))		'�õ�����һ��������Ŀ¼��Urlֵ
	gbBackUrl=sUrl
	
	Const gbWebServiceUrl="http://localhost/jxgzl/Srv/jxgzlWebSrv.dll/wsdl/Ijxgzl"

	Dim  strWebSvcWSDLURL  
	Dim  objSOAPClient    
	strWebSvcWSDLURL = gbWebServiceUrl  
	Set  objSOAPClient  =  Server.CreateObject("MSSOAP.SoapClient30")  
	objSOAPClient.ClientProperty("ServerHTTPRequest") = True    
	objSOAPClient.MSSoapInit   strWebSvcWSDLURL,   "",   "",   ""  
%>
