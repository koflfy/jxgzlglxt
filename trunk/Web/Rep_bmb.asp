<!-- #include file="inc/WebSvcURL.asp" -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>ר���������ǼǱ��ӡ</title>
<style type="text/css">
<!--
    .STYLE7 {font-family: "����"; font-size: 14px; }
    .STYLE8 {font-size: 14px}
    .STYLE9 {font-size: 12px}
    .STYLE11 {font-family: "����"; font-size: 16px;}
-->
</style>
</head>
<%

dim UserName,BmNo, Ksh, Sfzh, Xm, Xb, Mz, ZzMm, OldSchool, OldZy, Jlqk, Addr, Yzbm, Tel, ZyZhcp, English, Computer, Tc,bkLb,Zy1,Zy2,Zy3,SftyTj,Photo_Url,Csrq

UserName=Session("UserName")

if Session("Photo_Url")="" then
  	Response.redirect "Show_Error.asp?eid=������Ƭ�����ڣ���ӡ֮ǰ���ϴ���Ƭ!"
else
	GetKsInfo	'�õ�������Ϣ
end if

%>

<body>
<div align="center"><br />
<table width="690" border="0" cellpadding="0" cellspacing="0">
<tr>
<td height="34" colspan="2">
  <div align="center"><span class="STYLE11">����ʡ�ߵ�ѧУ�Ƽ�ѡ������ר�������뱾�����׶�ѧϰ�ǼǱ�</span><br>  
  </div></td>
</tr>
<tr>
<td width="530" height="25" align="left" class="STYLE8">
����ѧУ�������Ƽ�ʦ��ѧԺ</td>
<td width="206" class="STYLE8">
  <div align="right">������ţ�<%=BmNo%></div></td>
</tr>
<tr>
<td colspan="2">
<table width="690" height="807" border="1" align="center" cellpadding="0" cellspacing="0" style="border-collapse:collapse" bordercolor="#111111">
  <tr>
    <td height="40" colspan="3" align="center" valign="middle" bgcolor="#FFFFFF"><span class="STYLE7">�ա���</span></td>
    <td width="111" height="40" align="center" valign="middle" bgcolor="#FFFFFF"><span class="STYLE8"><%=Xm%></span></td>
    <td width="62" height="40" align="center" valign="middle" bgcolor="#FFFFFF"><span class="STYLE7">�Ա�</span></td>
    <td width="66" height="40" align="center" valign="middle" bgcolor="#FFFFFF"><span class="STYLE8"><%=Xb%></span></td>
    <td height="40" align="center" valign="middle" bgcolor="#FFFFFF"><span class="STYLE8"><span class="STYLE7">������ò</span></span></td>
    <td height="40" colspan="2" align="center" valign="middle" bgcolor="#FFFFFF"><span class="STYLE8"><%=Zzmm%>&nbsp;</span></td>
    <td width="132" height="40" rowspan="4" align="center" valign="middle" bgcolor="#FFFFFF"><span class="STYLE8"><img width="120" height="150" alt="��Ƭ" src="<%=Photo_Url%>" /></span></td>
  </tr>
  <tr>
    <td height="40" colspan="3" align="center" valign="middle" nowrap="nowrap" bgcolor="#FFFFFF"><span class="STYLE8"><span class="STYLE7">������</span></span></td>
    <td height="40" align="center" valign="middle" nowrap="nowrap" bgcolor="#FFFFFF"><span class="STYLE8"><%=Ksh%></span></td>
    <td height="40" align="center" valign="middle" bgcolor="#FFFFFF"><span class="STYLE7">���<br />
      ֤��</span></td>
    <td height="40" colspan="2" align="center" valign="middle" bgcolor="#FFFFFF"><span class="STYLE8"><%=Sfzh%></span></td>
    <td width="49" height="40" align="center" valign="middle" bgcolor="#FFFFFF"><span class="STYLE8"><span class="STYLE7">����</span></span></td>
    <td width="105" height="40" align="center" valign="middle" bgcolor="#FFFFFF"><span class="STYLE8"><%=Mz%></span></td>
  </tr>
  <tr>
    <td height="40" colspan="5" align="center" valign="middle" bgcolor="#FFFFFF"><span class="STYLE7">�־Ͷ�ѧУ</span></td>
    <td height="40" colspan="4" align="center" valign="middle" bgcolor="#FFFFFF"><span class="STYLE7">��ѧרҵ</span></td>
    </tr>
  <tr>
    <td height="40" colspan="5" align="center" valign="middle" bgcolor="#FFFFFF"><span class="STYLE8"><%=OldSchool%></span></td>
    <td height="40" colspan="4" align="center" valign="middle" bgcolor="#FFFFFF"><span class="STYLE8"><%=OldZy%>&nbsp;</span></td>
    </tr>
  <tr>
    <td height="40" colspan="2" align="center" valign="middle" nowrap="nowrap" bgcolor="#FFFFFF"><span class="STYLE7">����ͨѶ<br />
      ��ַ</span></td>
    <td height="40" colspan="6" align="left" valign="middle" bgcolor="#FFFFFF" class="STYLE8">&nbsp;<%=Addr%></td>
    <td height="40" align="center" valign="middle" bgcolor="#FFFFFF"><span class="STYLE7">��������</span></td>
    <td height="40" align="center" valign="middle" bgcolor="#FFFFFF"><span class="STYLE8"><%=Yzbm%></span></td>
    </tr>
  <tr>
    <td height="40" colspan="2" align="center" valign="middle" nowrap="nowrap" bgcolor="#FFFFFF"><span class="STYLE7">������ϵ<br />
�绰</span></td>
    <td height="40" colspan="4" align="left" valign="middle" bgcolor="#FFFFFF" class="STYLE8">&nbsp;<%=Tel%></td>
    <td width="78" height="40" align="center" valign="middle" bgcolor="#FFFFFF"><span class="STYLE7">�ܽ������</span></td>
    <td height="40" colspan="3" align="left" valign="middle" bgcolor="#FFFFFF"><span class="STYLE8">&nbsp;<%=Jlqk%></span></td>
    </tr>
  <tr>
    <td height="40" colspan="4" align="center" valign="middle" bgcolor="#FFFFFF"><span class="STYLE7">רҵ�ۺϲ������</span></td>
    <td height="40" colspan="2" align="center" valign="middle" bgcolor="#FFFFFF"><span class="STYLE7">ȫʡ��УӢ��<br />
    �ȼ��������</span></td>
    <td height="40" colspan="2" align="center" valign="middle" bgcolor="#FFFFFF"><span class="STYLE7">ȫʡ��У�����<br />
    �ȼ��������</span></td>
    <td height="40" colspan="2" align="center" valign="middle" bgcolor="#FFFFFF"><span class="STYLE7">�س�</span></td>
  </tr>
  <tr>
    <td height="40" colspan="4" align="center" valign="middle" bgcolor="#FFFFFF" class="STYLE8"><%=ZyZhcp%></td>
    <td height="40" colspan="2" align="center" valign="middle" bgcolor="#FFFFFF"><span class="STYLE8"><%=English%></span></td>
    <td height="40" colspan="2" align="center" valign="middle" bgcolor="#FFFFFF"><span class="STYLE8"><%=Computer%></span></td>
    <td height="40" colspan="2" align="center" valign="middle" bgcolor="#FFFFFF"><span class="STYLE8"><%=Tc%>&nbsp;</span></td>
  </tr>
  <tr>
    <td height="40" colspan="4" align="center" valign="middle" bgcolor="#FFFFFF"><span class="STYLE7">�������(������д)</span></td>
    <td height="40" colspan="6" align="center" valign="middle" bgcolor="#FFFFFF"><span class="STYLE8"><%=bkLb%></span></td>
  </tr>
  <tr>
    <td colspan="4" rowspan="3" align="center" valign="middle" bgcolor="#FFFFFF" class="STYLE7">רҵ־Ը<br />
      <span class="STYLE9">(������д�������á�/����ʾ)</span></td>
    <td height="40" colspan="6" align="left" valign="middle" bgcolor="#FFFFFF"><span class="STYLE8">&nbsp;��һ־Ը��<%=Zy1%></span></td>
    </tr>
  <tr>
    <td height="40" colspan="6" align="left" valign="middle" bgcolor="#FFFFFF"><span class="STYLE8">&nbsp;�ڶ�־Ը��<%=Zy2%></span></td>
    </tr>
  <tr>
    <td height="40" colspan="6" align="left" valign="middle" bgcolor="#FFFFFF"><span class="STYLE8">&nbsp;����־Ը��<%=Zy3%></span></td>
    </tr>
  <tr>
    <td height="51" colspan="5" align="center" valign="middle" bgcolor="#FFFFFF"><span class="STYLE7">�Ƿ�ͬ���ڱ��������н���רҵ����<br />
      <span class="STYLE9">(������д��������Ϊ��������רҵ)</span></span></td>
    <td height="51" colspan="5" align="center" valign="middle" bgcolor="#FFFFFF"><span class="STYLE8">
      <% if SfTyTj="TRUE" then %>
      ͬ�����
      <%else%>
      ��ͬ�����
      <%end if%>
    </span></td>
    </tr>
  <tr>
    <td width="55" rowspan="3" align="center" valign="middle" bgcolor="#FFFFFF"><p class="STYLE7">��<br />
      ��<br />
      ��<br />
      ��<br />
      ��<br />
    ��</p></td>
    <td height="100" colspan="3" align="center" valign="middle" bgcolor="#FFFFFF"><span class="STYLE7">Ժϵ���<br />
      �����£�</span></td>
    <td height="120" colspan="6" align="center" valign="middle" bgcolor="#FFFFFF">&nbsp;</td>
    </tr>
  <tr>
    <td height="113" colspan="3" align="center" valign="middle" bgcolor="#FFFFFF"><span class="STYLE7">�Ͷ�ѧУ���</span><br />
      <span class="STYLE7">�����£�</span></td>
    <td height="120" colspan="6" align="center" valign="middle" bgcolor="#FFFFFF">&nbsp;</td>
    </tr>
  <tr>
    <td height="97" colspan="3" align="center" valign="middle" bgcolor="#FFFFFF"><span class="STYLE7">����ѧУ���<br />
      �����£�    </span></td>
    <td height="120" colspan="6" align="center" valign="middle" bgcolor="#FFFFFF">&nbsp;</td>
    </tr>
</table></td>
<tr>
<td height="50" colspan="2" align="left" class="STYLE8">����ע��1.����һʽ���ݣ�����ѧУ��ѧ�����˵�������һ�ݡ�2.��רҵ�ۺϲ����������Ŀ��д��ʽΪ����������/��רҵ������3.ѧ������ͨѶ��ַ����ϵ�绰������д׼ȷ���������Ը���</td>
</tr>
</table>
</div>
</body>
</html>
