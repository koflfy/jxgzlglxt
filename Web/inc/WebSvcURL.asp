<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>
<%
	OPTION  EXPLICIT  
	dim sUrl,gbBackUrl
	sUrl="http://" & Request.ServerVariables("HTTP_HOST") & Request.ServerVariables("HTTP_URL")
	sUrl=left(sUrl,instrRev(sUrl,"/"))		'得到的是一个带虚拟目录的Url值
	gbBackUrl=sUrl
	
	Const gbWebServiceUrl="http://localhost/jxgzl/Srv/jxgzlWebSrv.dll/wsdl/Ijxgzl"

	Dim  strWebSvcWSDLURL  
	Dim  objSOAPClient    
	strWebSvcWSDLURL = gbWebServiceUrl  
	Set  objSOAPClient  =  Server.CreateObject("MSSOAP.SoapClient30")  
	objSOAPClient.ClientProperty("ServerHTTPRequest") = True    
	objSOAPClient.MSSoapInit   strWebSvcWSDLURL,   "",   "",   ""  
%>
