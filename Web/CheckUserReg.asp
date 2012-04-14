<!-- #include file="inc/WebSvcURL.asp" -->
<%
Dim UserName,UserPwd,UserPwd2,Sfzh

UserName=Request.Form("UserName")
UserPwd=Request.Form("UserPwd")
UserPwd2=Request.Form("UserPwd2")
Sfzh=Request.Form("Sfzh")

If Len(UserName)<6 Then 
	Response.redirect "show_error.asp?eid=用户名长度不能少于6位!"
end if

If Len(UserPwd)<6 Then 
	Response.redirect "show_error.asp?eid=密码长度不能少于6位!"
end if

If  UserPwd<>UserPwd2 Then 
	Response.redirect "show_error.asp?eid=两次密码不一致!"
end if

If  Len(Sfzh)<>18 and Len(SfZh)<>15 Then 
	Response.redirect "show_error.asp?eid=身份证号位数必须为18位或15位!"
end if

if objSOAPClient.KsIsExistsByUserName(UserName) then
	Response.redirect "show_error.asp?eid=该注册用户已存在，请换一个名字试试!"
end if

if objSOAPClient.KsIsExistsBySfzh(Sfzh) then
	Response.redirect "show_error.asp?eid=该身份证号的用户已注册，请检查后重试！"
end if

If objSOAPClient.KsRegister(UserName,UserPwd,Sfzh) then
	Session("Logined")="OK"
	Session("UserName")=UserName	
	Session("Sfzh")=Sfzh
	Session("BmNo")=objSOAPClient.GetKsBmNoByUserName(UserName)
	Session("Photo_Url")=objSOAPClient.GetPhotoUrlByUserName(UserName)
	Response.redirect "UserBm.asp"
else
	Session("UserName")=""	
	Session("Logined")=""
  	Response.redirect "show_error.asp?eid=注册失败，请检查后重试！"
end if
%>