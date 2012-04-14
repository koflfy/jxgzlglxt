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
	Response.redirect "show_error.asp?eid=报考信息录入不全，报考类别不能为空!"
end if

If  Zy1="" Then 
	Response.redirect "show_error.asp?eid=报考信息录入不全，报考志愿一不能为空!"
end if

IsSuccessed  = objSOAPClient.KsBK(UserName,ZyLb,Zy1,Zy2,Zy3,SfYxTj)
if IsSuccessed then
	Response.write"<script language='JavaScript'>alert('考生报考信息提交成功! 检查无误后可打印报名表！');"
	Response.write"javascript:window.location.href='index.asp';</script>"
	'Response.Redirect("Index.asp")
else
	Response.write"<SCRIPT language=JavaScript>alert('考生报考信息提交失败! 请检查后重新提交！');"
	Response.write"javascript:history.go(-1)</SCRIPT>"
  	'Response.Redirect "show_error.asp?eid=读取考生信息失败!"
end if
%>