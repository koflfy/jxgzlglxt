<!-- #include file="inc/WebSvcURL.asp" -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>打印准考证</title>
<style type="text/css">
<!--
    .STYLE7 {font-family: "宋体"; font-size: 14px; }
    .STYLE8 {font-size: 14px}
    .STYLE9 {font-size: 12px}
    .STYLE11 {font-family: "黑体"; font-size: 16px;}
    .STYLE12 {font-family: "黑体"; font-size: 24px;}
-->
</style>
</head>
<%

dim UserName,BmNo, Ksh, Sfzh, Xm, Xb, Mz, ZzMm, OldSchool, OldZy, Jlqk, Addr, Yzbm, Tel, ZyZhcp, English, Computer, Tc,bkLb,Zy1,Zy2,Zy3,SftyTj,Photo_Url,Csrq

dim xxdm,zkzh,kcbh,zwbh,kskc,ksrq,kssj,ksxz,room

UserName=Session("UserName")

if Session("Logined")="" then
 	Response.redirect "show_error.asp?eid=用户没有登录！请先登录系统!"
end if
if not objSOAPClient.IsCanNetPrintZKZ then
 	Response.redirect "show_error.asp?eid=准考证打印功能已关闭，具体打印时间请关注网站通知!"
end if

if Session("Photo_Url")="" then
  	Response.redirect "Show_Error.asp?eid=考生照片不存在！打印之前请上传照片!"
else
	GetKsZkzInfo	'得到考生准考证信息
	'GetKsKcTime(BkLb)		'得到考生考试课程和考试时间信息
	ksxz = GetKsXz '考生须知
	'Response.Write("可以打印准考证了！")
end if

%>
<body>
<div align="center">
<table width="720" border="0" cellpadding="5" cellspacing="1" bgcolor="#000066"><br />
<tr>
<td align="center" bgcolor="#FFFFFF">
<table width="690" border="0" cellpadding="0" cellspacing="0">
<tr>
<td width="100%" height="18" align="center" class="STYLE12">江西科技师范学院<%=mid(date,1,4)%>年“专升本”准考证<br /></td>
</tr>
<tr>
<td>
<table width="690" height="194" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="302" height="30" align="left" valign="middle" bgcolor="#FFFFFF" class="STYLE7"><span class="STYLE8"><span class="STYLE7">准考证号：<%=Zkzh%></span></span></td>
    <td height="30" colspan="2" align="left" valign="middle" bgcolor="#FFFFFF" class="STYLE8"><span class="STYLE8"><span class="STYLE7">考生姓名：<%=Xm%>(<%=Xb%>)</span></span></td>
    <td width="128" rowspan="6" align="center" valign="top" bgcolor="#FFFFFF"><span class="STYLE8"><img width="120" height="150" alt="照片" src="<%=Session("Photo_Url")%>" /><span class="STYLE9">照片规格:120X150</span></span></td>
    </tr>
  <tr>
    <td height="30" align="left" valign="middle" nowrap="nowrap" bgcolor="#FFFFFF" class="STYLE7">报考类别：<span class="STYLE8"><%=bkLb%></span></td>
    <td height="30" colspan="2" align="left" valign="middle" nowrap="nowrap" bgcolor="#FFFFFF" class="STYLE8"><span class="STYLE8"><span class="STYLE7">学校代码：<%=xxdm%></span></span></td>
    </tr>
  <tr>
    <td height="30" align="left" valign="middle" bgcolor="#FFFFFF" class="STYLE7"><span class="STYLE8">考场编号</span>：<span class="STYLE8">第<%=Kcbh%>考场</span></td>
    <td height="30" colspan="2" align="left" valign="middle" bgcolor="#FFFFFF" class="STYLE8">座位编号：<%=zwbh%></td>
    </tr>
  <tr>
    <td height="30" align="left" valign="middle" bgcolor="#FFFFFF" class="STYLE7">考试地点：<span class="STYLE8"><%=room%>教室</span></td>
    <td height="30" colspan="2" align="left" valign="middle" bgcolor="#FFFFFF" class="STYLE8">&nbsp;</td>
    </tr>
  <tr>
    <td height="30" colspan="3" align="left" valign="middle" nowrap="nowrap" bgcolor="#FFFFFF" class="STYLE7">现读学校：<span class="STYLE8"><%=OldSchool%></span><span class="STYLE8">&nbsp;</span></td>
    </tr>
  <tr>
    <td height="30" colspan="3" align="left" valign="middle" nowrap="nowrap" bgcolor="#FFFFFF" class="STYLE7">所学专业：<span class="STYLE8"><%=OldZy%></span><span class="STYLE8">&nbsp;</span></td>
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
考试课程及考试时间：<br />
</span><br />
<table width="100%" height="80" border="1" cellpadding="0" cellspacing="0" style="border-collapse:collapse" bordercolor="#111111">
  <tr class="STYLE7">
  <td width="15%" height="30" align="center" valign="middle">科目</td>
  <td width="28%" align="center" valign="middle">考试课程</td>
  <td width="24%" align="center" valign="middle">考试日期</td>
  <td width="33%" align="center" valign="middle">考试时间</td></tr>
<%
	dim XmlDataInfo,objAtrs,objNodes,objDom,element,ii
	XmlDataInfo=objSOAPClient.GetKsKcTime(bkLb)
	Set objDom=Server.CreateObject("Microsoft.XMLDOM") 
	objDom.Async=False
	If objDom.loadXML(XmlDataInfo) Then    '把XML字符串读入内存
		set objnodes=objdom.documentElement.SelectSingleNode("//ROWDATA").ChildNodes
		ii = 1
		for each element in objnodes
			set objAtrs=element.attributes
			'objAtrs.GetAttributeNode("bmno").Value
%>
<tr class="STYLE8">
  <td height="30" align="center" valign="middle">科目<%=ii%></td>
  <td align="center" valign="middle"><%=objAtrs.item(2).Value%>&nbsp;</td>
  <td align="center" valign="middle"><%=objAtrs.item(3).Value%>&nbsp;</td>
  <td align="center" valign="middle"><%=objAtrs.item(4).Value%>&nbsp;</td>
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
  <td height="50" align="left" valign="top" class="STYLE8"><br />
    <div class="STYLE11" align="center">考　生　须　知</div><br />
	<%=ksxz%>
    </td>
</tr>
</table>
</td>
</tr>
</table>
</div>
</body>
