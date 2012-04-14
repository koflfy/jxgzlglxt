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
	Response.write"<SCRIPT language=JavaScript>alert('用户名重复!  请重新选择一个用户名！');"
	Response.write"javascript:history.go(-1)</SCRIPT>"
else
	response.write"<SCRIPT language=JavaScript>alert('- 恭喜您,用户名可以使用！ -');"
	response.write"javascript:history.go(-1)</SCRIPT>"
end if
%>