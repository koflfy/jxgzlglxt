<!-- #include file="inc/WebSvcURL.asp" -->
<%
Dim UserName,UserPwd
Dim LoginSuccess

UserName=Request.Form("UserName")
UserPwd=Request.Form("UserPwd")

'Response.Write(UserName)
'Response.Write(UserPwd)
'response.End()

If Len(UserName)=0 or Len(UserPwd)=0 Then 
	Response.redirect "show_error.asp?eid=�û��������벻��Ϊ��!"
end if

LoginSuccess  = objSOAPClient.KsLoginByUserName(UserName,UserPwd)

If LoginSuccess  then
	Session("Logined")="OK"
	Session("UserName")=UserName	
	Session("BmNo")=objSOapClient.GetKsBmNoByUserName(UserName)
	'Session("Sfzh")=objSOapClient.GetKsSfzhByUserName(UserName)
	Session("Photo_Url")=objSOapClient.GetPhotoUrlByUserName(UserName)
	Session("LoginIp")=Request.ServerVariables("REMOTE_ADDR")
	Response.redirect "index.asp"
else
	Session("Logined")=""
	Session("UserName")=""	
	Session("BmNo")=""	
	Session("Sfzh")=""	
	Session("Photo_Url")=""
	Session("LoginIp")=""
	Response.redirect "show_error.asp?eid=�û��������벻��ȷ!"
end if
%>