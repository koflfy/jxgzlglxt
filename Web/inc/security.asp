<% 
'Response.Cookies("TeacherSfzh")="441282800503781"
If  (Request.Cookies("TeacherSfzh")="" and Request.Cookies("TeacherNo")="")  OR	(request.Cookies("LoginIp")<>Request.ServerVariables("REMOTE_ADDR")) Then
	Response.Redirect("logout.asp")
End If
%>
