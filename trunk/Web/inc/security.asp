<!-- #include file="WebSvcURL.asp" -->
<% 
'Response.Cookies("StuSfzh")="441282800503781"
If (Session("Logined")="") or (Session("UserName")="") or (Session("LoginIp")<>Request.ServerVariables("REMOTE_ADDR")) Then
	Response.Redirect("logout.asp")
End If
%>
