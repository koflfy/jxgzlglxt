<!-- #include file="inc/WebSvcURL.asp" -->
<%
Dim LoginType,TeacherNo,TeacherName,verifycode,TeacherSfzh
Dim LoginSuccess
LoginType=Trim(request("LoginType"))
TeacherNo=Trim(Request("TeacherNo"))
TeacherName=Trim(request("TeacherName"))
verifycode=Trim(request("verifycode"))

If TeacherNo="" or TeacherName="" Then Response.redirect "show_error.asp?eid=֤���������������Ϊ��!"
If verifycode="" Then response.redirect "show_error.asp?eid=��֤�벻��Ϊ��!"
If cstr(session("getcode"))<>cstr(verifycode) then response.redirect "show_error.asp?eid=��֤����ִ���!"

If LoginType="�ον�ʦ" Then
	TeacherNo=Trim(Request("TeacherNo"))
    response.cookies("LoginIp")=Request.servervariables("REMOTE_ADDR")
	LoginSuccess  = objSOAPClient.TeacherLoginByNo(TeacherNo,TeacherName)
 	Response.Cookies("TeacherNo")=TeacherNo	
 	Response.Cookies("TeacherName")=TeacherName	
End If
  
If LoginSuccess  then
	response.redirect "index.asp"
else
  	Response.redirect "show_error.asp?eid=֤���Ż���������ȷ!"
end if
%>