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
	Response.write"<SCRIPT language=JavaScript>alert('�����֤���û���ע��! �����¼������ԣ�');"
	Response.write"javascript:history.go(-1)</SCRIPT>"
else
	response.write"<SCRIPT language=JavaScript>alert('�����֤��û��ע��,����ʹ�ã�');"
	Response.write"javascript:history.go(-1)</SCRIPT>"
end if
%>