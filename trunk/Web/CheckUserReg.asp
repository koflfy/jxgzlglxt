<!-- #include file="inc/WebSvcURL.asp" -->
<%
Dim UserName,UserPwd,UserPwd2,Sfzh

UserName=Request.Form("UserName")
UserPwd=Request.Form("UserPwd")
UserPwd2=Request.Form("UserPwd2")
Sfzh=Request.Form("Sfzh")

If Len(UserName)<6 Then 
	Response.redirect "show_error.asp?eid=�û������Ȳ�������6λ!"
end if

If Len(UserPwd)<6 Then 
	Response.redirect "show_error.asp?eid=���볤�Ȳ�������6λ!"
end if

If  UserPwd<>UserPwd2 Then 
	Response.redirect "show_error.asp?eid=�������벻һ��!"
end if

If  Len(Sfzh)<>18 and Len(SfZh)<>15 Then 
	Response.redirect "show_error.asp?eid=���֤��λ������Ϊ18λ��15λ!"
end if

if objSOAPClient.KsIsExistsByUserName(UserName) then
	Response.redirect "show_error.asp?eid=��ע���û��Ѵ��ڣ��뻻һ����������!"
end if

if objSOAPClient.KsIsExistsBySfzh(Sfzh) then
	Response.redirect "show_error.asp?eid=�����֤�ŵ��û���ע�ᣬ��������ԣ�"
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
  	Response.redirect "show_error.asp?eid=ע��ʧ�ܣ���������ԣ�"
end if
%>