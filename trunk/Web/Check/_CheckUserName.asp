<!-- #include file="../inc/WebSvcURL.asp" -->
<%
Dim UserName

UserName=Request("UserName")

'Response.Write(UserName)
'response.End()

if UserName="" then
	response.write"<SCRIPT language=JavaScript>javascript:history.go(-1)</SCRIPT>"
end if
 
if UserName<>"" and objSOAPClient.KsIsExistsByUserName(UserName) then
	Response.write"<SCRIPT language=JavaScript>alert('�û����ظ�!  ������ѡ��һ���û�����');"
	Response.write"javascript:history.go(-1)</SCRIPT>"
else
	response.write"<SCRIPT language=JavaScript>alert('- ��ϲ��,�û�������ʹ�ã� -');"
	response.write"javascript:history.go(-1)</SCRIPT>"
end if
%>