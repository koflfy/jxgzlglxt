<% 
'Response.Cookies("StuSfzh")="441282800503781"
If  (Request.Cookies("StuSfzh")="" and Request.Cookies("StudentNo")="")  OR	(request.Cookies("LoginIp")<>Request.ServerVariables("REMOTE_ADDR")) Then
	Response.Redirect("logout.asp")
End If
%>
