<!-- #include file="inc/WebSvcURL.asp" -->
<html>
<head>
<META http-equiv=Content-Type content="text/html; charset=gb2312">
<LINK href="images/main_right.css" type=text/css rel=stylesheet>
<title>本校考生考生号查询</title>
</head>
<body>
<%
dim Sfzh,Ksh,KsXx
if Request.Form("Sfzh")<>"" then
	Sfzh = Request.Form("Sfzh")
	if Sfzh<>"" then
		KsXx = objSOAPClient.GetKshBySfzh(Sfzh,Ksh)
		if KsXx="" then	Response.Redirect "Show_Error.asp?eid=身份证号为：【" & Sfzh & "】的考生号未找到！"
	end if
end if
if Sfzh="" then Sfzh = Request.QueryString("Sfzh")

%>
<div align="center">
<h3>
江西科技师范学院学生考生号查询
</h3>
</div>
<table width="472" height="45" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
  	<form name="Form1" id="Form1" action="Ksh_Cx.asp" method="post">
    <td width="98" height="47" align="right" bgcolor="#FFFFFF">身份证号：</td>
    <td width="232" bgcolor="#FFFFFF"><input name="Sfzh" type="text" id="Sfzh" value="<%=Sfzh%>" size="30" maxlength="18" /></td>
    <td width="140" bgcolor="#FFFFFF"><input type="submit" name="aPost" id="aPost" value="开始查询" /></td>
    </form>
  </tr>
</table>  
<%if KsXx<>"" then %>
<hr>
<table width="472" border="0" align="center" cellpadding="0" cellspacing="0">
<tbody>
  <tr>
    <td width="98" height="222" align="right" valign="top" bgcolor="#FFFFFF">考生入学时　<br>
    基本信息：</td>
    <td width="372" align="left" valign="top" bgcolor="#FFFFFF"><%=KsXx%>&nbsp;</td>
  </tr>
</tbody>
</table>
<%end if%>
<p>
<div align="center">
<font color="#FF0000">  （注：本查询系统只能查询江西科技师范学院学生的考生号！ ）</font>
</div>
</body>
</html>
