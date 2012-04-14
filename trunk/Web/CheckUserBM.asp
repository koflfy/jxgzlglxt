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
	Response.redirect "show_error.asp?eid=身份证号位数必须为18位或15位!"
end if

if Xm="" then
	Response.redirect "show_error.asp?eid=考生信息录入不全，姓名不能为空，请填写完整后再提交!"
end if

if Xb="" then
	Response.redirect "show_error.asp?eid=考生信息录入不全，性别不能为空，请填写完整后再提交!"
end if

if Len(Ksh)<>14 and Len(Ksh)<>10 and Len(Ksh)<>9 then
	Response.redirect "show_error.asp?eid=考生号信息录入格式不正确，考生号长度必须为14位、10位或者9位！"
end if

if Mz="" then 
	Response.redirect "show_error.asp?eid=考生信息录入不全，民族不能为空，请填写完整后再提交!"
end if

if Zzmm="" then
	Response.redirect "show_error.asp?eid=考生信息录入不全，政治面貌不能为空，请填写完整后再提交!"
end if

if OldSchool="" then 
	Response.redirect "show_error.asp?eid=考生就读学校不能为空，请填写完整后再提交!"
end if

if OldZy="" then 
	Response.redirect "show_error.asp?eid=考生现读专业不能为空，请填写完整后再提交!"
end if

if Addr="" or Yzbm="" or Tel="" then
	Response.redirect "show_error.asp?eid=考生暑期通讯地址、邮政编码和联系电话不能为空，请填写完整后再提交!"
end if

if ZyZhcp="" then
	ZyZhcp = "无"
	'Response.redirect "show_error.asp?eid=专业综合测评情况不能为空，如果不清楚请填写“无”!"
end if

if English="" or Computer="" then
	Response.redirect "show_error.asp?eid=全省高校英语和计算等级考试情况不能为空，请填写完整后再提交!"
end if

if Jlqk="" then 
	Jlqk = "无"
end if

IsSuccessed  = objSOAPClient.KsBM(UserName,BmNo, Ksh, Sfzh, Xm, Xb, Mz, ZzMm, OldSchool, OldZy, Jlqk, Addr, Yzbm, Tel, ZyZhcp, English, Computer,Tc)
if IsSuccessed then
	Response.write"<SCRIPT language=JavaScript>alert('操作完成！考生个人信息已保存! ');"
	Response.write"javascript:window.location.href='index.asp';</script>"
	'Response.Redirect("Index.asp")
else
	Response.write"<SCRIPT language=JavaScript>alert('考生个人信息提交失败! 请检查后重新提交！');"
	Response.write"javascript:history.go(-1)</SCRIPT>"
  	'Response.Redirect "show_error.asp?eid=考生个人信息提交失败!"
end if
%>