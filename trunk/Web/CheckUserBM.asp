<!-- #include file="inc/WebSvcURL.asp" -->
<%
if Session("Logined")="" then
	Response.redirect "Index.asp"
end if
dim UserName,BmNo, Ksh, Sfzh, Xm, Xb, Mz, ZzMm, OldSchool, OldZy, Jlqk, Addr, Yzbm, Tel, ZyZhcp, English, Computer, Tc
Dim IsSuccessed

UserName = Session("UserName")
Ksh = Request.Form("Ksh")
Sfzh = Request.Form("Sfzh")
Xm = Request.Form("Xm")
Xb = Request.Form("Xb")
Mz = Request.Form("Mz")
Zzmm = Request.Form("ZzMm")
OldSchool = Request.Form("OldSchool")
OldZy = Request.Form("OldZy")
Jlqk = Request.Form("Jlqk")
Addr = Request.Form("Addr")
Yzbm = Request.Form("Yzbm")
Tel = Request.Form("Tel")
ZyZhcp = Request.Form("ZyZhcp")
English = Request.Form("English")
Computer = Request.Form("Computer")
Tc = Request.Form("Tc")

If  Len(Sfzh)<>18 and Len(SfZh)<>15 Then 
	Response.redirect "show_error.asp?eid=���֤��λ������Ϊ18λ��15λ!"
end if

if Xm="" then
	Response.redirect "show_error.asp?eid=������Ϣ¼�벻ȫ����������Ϊ�գ�����д���������ύ!"
end if

if Xb="" then
	Response.redirect "show_error.asp?eid=������Ϣ¼�벻ȫ���Ա���Ϊ�գ�����д���������ύ!"
end if

if Len(Ksh)<>14 and Len(Ksh)<>10 and Len(Ksh)<>9 then
	Response.redirect "show_error.asp?eid=��������Ϣ¼���ʽ����ȷ�������ų��ȱ���Ϊ14λ��10λ����9λ��"
end if

if Mz="" then 
	Response.redirect "show_error.asp?eid=������Ϣ¼�벻ȫ�����岻��Ϊ�գ�����д���������ύ!"
end if

if Zzmm="" then
	Response.redirect "show_error.asp?eid=������Ϣ¼�벻ȫ��������ò����Ϊ�գ�����д���������ύ!"
end if

if OldSchool="" then 
	Response.redirect "show_error.asp?eid=�����Ͷ�ѧУ����Ϊ�գ�����д���������ύ!"
end if

if OldZy="" then 
	Response.redirect "show_error.asp?eid=�����ֶ�רҵ����Ϊ�գ�����д���������ύ!"
end if

if Addr="" or Yzbm="" or Tel="" then
	Response.redirect "show_error.asp?eid=��������ͨѶ��ַ�������������ϵ�绰����Ϊ�գ�����д���������ύ!"
end if

if ZyZhcp="" then
	ZyZhcp = "��"
	'Response.redirect "show_error.asp?eid=רҵ�ۺϲ����������Ϊ�գ�������������д���ޡ�!"
end if

if English="" or Computer="" then
	Response.redirect "show_error.asp?eid=ȫʡ��УӢ��ͼ���ȼ������������Ϊ�գ�����д���������ύ!"
end if

if Jlqk="" then 
	Jlqk = "��"
end if

IsSuccessed  = objSOAPClient.KsBM(UserName,BmNo, Ksh, Sfzh, Xm, Xb, Mz, ZzMm, OldSchool, OldZy, Jlqk, Addr, Yzbm, Tel, ZyZhcp, English, Computer,Tc)
if IsSuccessed then
	Response.write"<SCRIPT language=JavaScript>alert('������ɣ�����������Ϣ�ѱ���! ');"
	Response.write"javascript:window.location.href='index.asp';</script>"
	'Response.Redirect("Index.asp")
else
	Response.write"<SCRIPT language=JavaScript>alert('����������Ϣ�ύʧ��! ����������ύ��');"
	Response.write"javascript:history.go(-1)</SCRIPT>"
  	'Response.Redirect "show_error.asp?eid=����������Ϣ�ύʧ��!"
end if
%>