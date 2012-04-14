<!-- #include file="../inc/WebSvcURL.asp" -->
<%
Dim Sfzh

Sfzh=Request("Sfzh")

'Response.Write(UserName)
'response.End()

if Sfzh="" then
	response.write"<SCRIPT language=JavaScript>javascript:history.go(-1)</SCRIPT>"
end if

if  Sfzh<>"" and objSOAPClient.KsIsExistsBySfzh(Sfzh) then
	Response.write"<SCRIPT language=JavaScript>alert('该身份证号用户已注册! 请重新检查后重试！');"
	Response.write"javascript:history.go(-1)</SCRIPT>"
else
	response.write"<SCRIPT language=JavaScript>alert('该身份证号没有注册,可以使用！');"
	Response.write"javascript:history.go(-1)</SCRIPT>"
end if
%>