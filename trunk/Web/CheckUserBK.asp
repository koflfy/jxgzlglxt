<!-- #include file="inc/WebSvcURL.asp" -->
<%
if Session("Logined")="" then
	Response.redirect "Index.asp"
end if

dim UserName,BmNo, Ksh, Sfzh, Xm, Xb, Mz, ZzMm, OldSchool, OldZy, Jlqk, Addr, Yzbm, Tel, ZyZhcp, English, Computer, Tc,ZyLb,Zy1,Zy2,Zy3,SfYxTj
Dim IsSuccessed

UserName = Session("UserName")
ZyLb = Request.Form("ZyLb")
Zy1 = Request.Form("Zy1")
Zy2 = Request.Form("Zy2")
Zy3 = Request.Form("Zy3")
SfYxTj = Request.Form("ZyTj")

If  ZyLb="" Then 
	Response.redirect "show_error.asp?eid=������Ϣ¼�벻ȫ�����������Ϊ��!"
end if

If  Zy1="" Then 
	Response.redirect "show_error.asp?eid=������Ϣ¼�벻ȫ������־Ըһ����Ϊ��!"
end if

IsSuccessed  = objSOAPClient.KsBK(UserName,ZyLb,Zy1,Zy2,Zy3,SfYxTj)
if IsSuccessed then
	Response.write"<script language='JavaScript'>alert('����������Ϣ�ύ�ɹ�! ��������ɴ�ӡ������');"
	Response.write"javascript:window.location.href='index.asp';</script>"
	'Response.Redirect("Index.asp")
else
	Response.write"<SCRIPT language=JavaScript>alert('����������Ϣ�ύʧ��! ����������ύ��');"
	Response.write"javascript:history.go(-1)</SCRIPT>"
  	'Response.Redirect "show_error.asp?eid=��ȡ������Ϣʧ��!"
end if
%>