<!-- #include file="inc/WebSvcURL.asp" -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>�����ɼ���ѯ</title>
<style type="text/css">
<!--
    .STYLE7 {font-family: "����"; font-size: 14px; }
    .STYLE8 {font-size: 14px}
    .STYLE9 {font-size: 12px}
    .STYLE11 {font-family: "����"; font-size: 16px;}
    .STYLE12 {font-family: "����"; font-size: 24px;}
-->
</style>
</head>
<%

dim UserName,BmNo, Ksh, Sfzh, Xm, Xb, Mz, ZzMm, OldSchool, OldZy, Jlqk, Addr, Yzbm, Tel, ZyZhcp, English, Computer, Tc,bkLb,Zy1,Zy2,Zy3,SftyTj,Photo_Url,Csrq

dim xxdm,zkzh,kcbh,zwbh,kskc,ksrq,kssj,ksxz,room

UserName=Session("UserName")

if Session("Logined")="" then
  	Response.redirect "show_error.asp?eid=�û�û�е�¼�����ȵ�¼ϵͳ!"
end if
if not objSOAPClient.IsCanNetLocateCj then
 	Response.redirect "show_error.asp?eid=�ɼ���ѯ����δ���ţ������ѯʱ�����ע��վ֪ͨ!"
end if

GetKsZkzInfo	'�õ�����׼��֤��Ϣ
%>
<body>
<div align="center">
<table width="720" border="0" cellpadding="5" cellspacing="1" bgcolor="#000066"><br />
<tr>
<td align="center" bgcolor="#FFFFFF">
<table width="690" border="0" cellpadding="0" cellspacing="0">
<tr>
<td width="100%" height="18" align="center" class="STYLE12"><p>�����Ƽ�ʦ��ѧԺ<%=mid(date,1,4)%>�ꡰר�������ɼ���</p>
  <p>
  </p></td>
</tr>
<tr>
<td>
<table width="690" height="194" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="302" height="30" align="left" valign="middle" bgcolor="#FFFFFF" class="STYLE7"><span class="STYLE8"><span class="STYLE7">׼��֤�ţ�<%=Zkzh%></span></span></td>
    <td height="30" colspan="2" align="left" valign="middle" bgcolor="#FFFFFF" class="STYLE8"><span class="STYLE8"><span class="STYLE7">����������<%=Xm%>(<%=Xb%>)</span></span></td>
    <td width="128" rowspan="6" align="center" valign="top" bgcolor="#FFFFFF"><span class="STYLE8"><img width="120" height="150" alt="��Ƭ" src="<%=Session("Photo_Url")%>" /><span class="STYLE9">��Ƭ���:120X150</span></span></td>
    </tr>
  <tr>
    <td height="30" align="left" valign="middle" nowrap="nowrap" bgcolor="#FFFFFF" class="STYLE7">�������<span class="STYLE8"><%=bkLb%></span></td>
    <td height="30" colspan="2" align="left" valign="middle" nowrap="nowrap" bgcolor="#FFFFFF" class="STYLE8"><span class="STYLE8"><span class="STYLE7">ѧУ���룺<%=xxdm%></span></span></td>
    </tr>
  <tr>
    <td height="30" align="left" valign="middle" bgcolor="#FFFFFF" class="STYLE7"><span class="STYLE8">�������</span>��<span class="STYLE8">��<%=Kcbh%>����</span></td>
    <td height="30" colspan="2" align="left" valign="middle" bgcolor="#FFFFFF" class="STYLE8">��λ��ţ�<%=zwbh%></td>
    </tr>
  <tr>
    <td height="30" align="left" valign="middle" bgcolor="#FFFFFF" class="STYLE7">���Եص㣺<span class="STYLE8"><%=room%>����</span></td>
    <td height="30" colspan="2" align="left" valign="middle" bgcolor="#FFFFFF" class="STYLE8">&nbsp;</td>
    </tr>
  <tr>
    <td height="30" colspan="3" align="left" valign="middle" nowrap="nowrap" bgcolor="#FFFFFF" class="STYLE7">�ֶ�ѧУ��<span class="STYLE8"><%=OldSchool%></span><span class="STYLE8">&nbsp;</span></td>
    </tr>
  <tr>
    <td height="30" colspan="3" align="left" valign="middle" nowrap="nowrap" bgcolor="#FFFFFF" class="STYLE7">��ѧרҵ��<span class="STYLE8"><%=OldZy%></span><span class="STYLE8">&nbsp;</span></td>
    </tr>
  <tr>
    <td height="14" align="left" valign="middle" bgcolor="#FFFFFF" class="STYLE7">&nbsp;</td>
    <td colspan="2" align="left" valign="middle" bgcolor="#FFFFFF" class="STYLE8"><span class="STYLE8">&nbsp;</span></td>
    <td height="14" align="center" valign="middle" bgcolor="#FFFFFF" class="STYLE9">&nbsp;</td>
    </tr>
 </table></td>
<tr>
<td height="50" align="center" class="STYLE8">
<span class="STYLE11"><br />
�������Գɼ���<br />
</span><br />
<table width="100%" height="80" border="1" cellpadding="0" cellspacing="0" style="border-collapse:collapse" bordercolor="#111111">
  <tr class="STYLE7">
  <td width="15%" height="30" align="center" valign="middle">��Ŀ</td>
  <td width="33%" align="center" valign="middle">���Կγ�</td>
  <td width="28%" align="center" valign="middle">���Գɼ�</td>
  <td width="24%" align="center" valign="middle">����״̬</td>
  </tr>
<%
	dim XmlDataInfo,objAtrs,objNodes,objDom,element,ii
	XmlDataInfo=objSOAPClient.GetKsCjInfo(UserName)
	Set objDom=Server.CreateObject("Microsoft.XMLDOM") 
	objDom.Async=False
	If objDom.loadXML(XmlDataInfo) Then    '��XML�ַ��������ڴ�
		set objnodes=objdom.documentElement.SelectSingleNode("//ROWDATA").ChildNodes
		ii = 1
		for each element in objnodes
			set objAtrs=element.attributes
			'response.write objAtrs.GetAttributeNode("bmno").Value
%>
<tr class="STYLE8">
  <td height="30" align="center" valign="middle">��Ŀ<%=ii%></td>
  <td align="center" valign="middle"><%=objAtrs.item(5).Value%>&nbsp;</td>
  <td align="center" valign="middle"><%=objAtrs.item(6).Value%>&nbsp;</td>
  <td align="center" valign="middle"><%=objAtrs.item(7).Value%>&nbsp;</td>
  </tr>

<%
		ii = ii+1
		next
		Set objAtrs=Nothing 
		Set objNodes=Nothing 
		Set objDom=Nothing
	end if
%>

</table>
</td>
</tr>
<tr>
  <td height="50" align="center" valign="top" class="STYLE8"><br />
�������ʣ����뿼�Ե�λ��ϵ����ϵ�绰��0791-3847551 ��<br /><br />
    </td>
</tr>
<tr>
  <td height="50" align="right" valign="top" class="STYLE8"><br />
��ѯʱ�䣺<%=Now()%>&nbsp;&nbsp;&nbsp;<br /><br />
    </td>
</tr>
</table>
</td>
</tr>
</table>
</div>
</body>
