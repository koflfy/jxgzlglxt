<!-- #include file="inc/function.asp" -->
<%
'������ʾ��Ϣ
'eidΪ������Ϣ����
errorbody=trim(request.querystring("eid"))
errorbody=replace(errorbody,"<","��")
if errorbody="" then
	errorbody="δ֪����!"
end if
%>
<html>
<head>
<LINK href="images/style.css" type=text/css rel=stylesheet>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>��¼����!--ѧ���ɷ�ϵͳ</title>
</head>
<body>
<center>
<div id=r_top2></div>
<div id=showerr>
<table border=0 align=center cellpadding=5 cellspacing=2>
    <tr><td height="2">&nbsp;</td></tr>
	<tr><td align="center" class="f_14_blue"> �� Sorry!���ִ���! ��</td>
	</tr>
	<tr><td class="f_14_blue">&nbsp; ��</font> <b><%=errorbody%></b></td></tr>
	<tr><td class="f_14_blue">&nbsp; ��</font> ���ǲ���ʧ��,�����<a href="javascript:history.back(1)"><font color=red>����</font></a>���²���!</td>
	</tr>
</table>
</div>
<div id=bottom2></div>
</body>
</html>
