<%
'错误显示信息
'eid为错误信息内容
errorbody=trim(request.querystring("eid"))
errorbody=replace(errorbody,"<","＜")
if errorbody="" then
	errorbody="未知错误!"
end if
%>
<html>
<head>
<LINK href="images/style.css" type=text/css rel=stylesheet>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>操作错误!--专升本报名系统</title>
</head>
<body>
<center>
<div id=r_top2></div>
<div id=showerr>
<table border=0 align=center cellpadding=5 cellspacing=2>
    <tr><td height="2">&nbsp;</td></tr>
	<tr><td align="center" class="f_14_blue"> 〓 Sorry!出现错误! 〓</td>
	</tr>
	<tr><td class="f_14_blue">&nbsp; 〓</font> <b><%=errorbody%></b></td></tr>
	<tr><td class="f_14_blue">&nbsp; ▲</font> 若是操作失误,你可以<a href="javascript:history.back(1)"><font color=red>后退</font></a>重新操作!</td>
	</tr>
</table>
</div>
<div id=bottom2></div>
</body>
</html>
