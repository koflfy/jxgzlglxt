<!-- #include file="inc/WebSvcURL.asp" -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>专升本报名登记表打印</title>
<style type="text/css">
<!--
    .STYLE7 {font-family: "宋体"; font-size: 14px; }
    .STYLE8 {font-size: 14px}
    .STYLE9 {font-size: 12px}
    .STYLE11 {font-family: "黑体"; font-size: 16px;}
-->
</style>
</head>
<%

dim UserName,BmNo, Ksh, Sfzh, Xm, Xb, Mz, ZzMm, OldSchool, OldZy, Jlqk, Addr, Yzbm, Tel, ZyZhcp, English, Computer, Tc,bkLb,Zy1,Zy2,Zy3,SftyTj,Photo_Url,Csrq

UserName=Session("UserName")

if Session("Photo_Url")="" then
  	Response.redirect "Show_Error.asp?eid=考生照片不存在！打印之前请上传照片!"
else
	GetKsInfo	'得到考生信息
end if

%>

<body>
<div align="center"><br />
<table width="690" border="0" cellpadding="0" cellspacing="0">
<tr>
<td height="34" colspan="2">
  <div align="center"><span class="STYLE11">江西省高等学校推荐选拔优秀专科生进入本科生阶段学习登记表</span><br>  
  </div></td>
</tr>
<tr>
<td width="530" height="25" align="left" class="STYLE8">
报考学校：江西科技师范学院</td>
<td width="206" class="STYLE8">
  <div align="right">报名序号：<%=BmNo%></div></td>
</tr>
<tr>
<td colspan="2">
<table width="690" height="807" border="1" align="center" cellpadding="0" cellspacing="0" style="border-collapse:collapse" bordercolor="#111111">
  <tr>
    <td height="40" colspan="3" align="center" valign="middle" bgcolor="#FFFFFF"><span class="STYLE7">姓　名</span></td>
    <td width="111" height="40" align="center" valign="middle" bgcolor="#FFFFFF"><span class="STYLE8"><%=Xm%></span></td>
    <td width="62" height="40" align="center" valign="middle" bgcolor="#FFFFFF"><span class="STYLE7">性别</span></td>
    <td width="66" height="40" align="center" valign="middle" bgcolor="#FFFFFF"><span class="STYLE8"><%=Xb%></span></td>
    <td height="40" align="center" valign="middle" bgcolor="#FFFFFF"><span class="STYLE8"><span class="STYLE7">政治面貌</span></span></td>
    <td height="40" colspan="2" align="center" valign="middle" bgcolor="#FFFFFF"><span class="STYLE8"><%=Zzmm%>&nbsp;</span></td>
    <td width="132" height="40" rowspan="4" align="center" valign="middle" bgcolor="#FFFFFF"><span class="STYLE8"><img width="120" height="150" alt="照片" src="<%=Photo_Url%>" /></span></td>
  </tr>
  <tr>
    <td height="40" colspan="3" align="center" valign="middle" nowrap="nowrap" bgcolor="#FFFFFF"><span class="STYLE8"><span class="STYLE7">考生号</span></span></td>
    <td height="40" align="center" valign="middle" nowrap="nowrap" bgcolor="#FFFFFF"><span class="STYLE8"><%=Ksh%></span></td>
    <td height="40" align="center" valign="middle" bgcolor="#FFFFFF"><span class="STYLE7">身份<br />
      证号</span></td>
    <td height="40" colspan="2" align="center" valign="middle" bgcolor="#FFFFFF"><span class="STYLE8"><%=Sfzh%></span></td>
    <td width="49" height="40" align="center" valign="middle" bgcolor="#FFFFFF"><span class="STYLE8"><span class="STYLE7">民族</span></span></td>
    <td width="105" height="40" align="center" valign="middle" bgcolor="#FFFFFF"><span class="STYLE8"><%=Mz%></span></td>
  </tr>
  <tr>
    <td height="40" colspan="5" align="center" valign="middle" bgcolor="#FFFFFF"><span class="STYLE7">现就读学校</span></td>
    <td height="40" colspan="4" align="center" valign="middle" bgcolor="#FFFFFF"><span class="STYLE7">所学专业</span></td>
    </tr>
  <tr>
    <td height="40" colspan="5" align="center" valign="middle" bgcolor="#FFFFFF"><span class="STYLE8"><%=OldSchool%></span></td>
    <td height="40" colspan="4" align="center" valign="middle" bgcolor="#FFFFFF"><span class="STYLE8"><%=OldZy%>&nbsp;</span></td>
    </tr>
  <tr>
    <td height="40" colspan="2" align="center" valign="middle" nowrap="nowrap" bgcolor="#FFFFFF"><span class="STYLE7">暑期通讯<br />
      地址</span></td>
    <td height="40" colspan="6" align="left" valign="middle" bgcolor="#FFFFFF" class="STYLE8">&nbsp;<%=Addr%></td>
    <td height="40" align="center" valign="middle" bgcolor="#FFFFFF"><span class="STYLE7">邮政编码</span></td>
    <td height="40" align="center" valign="middle" bgcolor="#FFFFFF"><span class="STYLE8"><%=Yzbm%></span></td>
    </tr>
  <tr>
    <td height="40" colspan="2" align="center" valign="middle" nowrap="nowrap" bgcolor="#FFFFFF"><span class="STYLE7">暑期联系<br />
电话</span></td>
    <td height="40" colspan="4" align="left" valign="middle" bgcolor="#FFFFFF" class="STYLE8">&nbsp;<%=Tel%></td>
    <td width="78" height="40" align="center" valign="middle" bgcolor="#FFFFFF"><span class="STYLE7">受奖励情况</span></td>
    <td height="40" colspan="3" align="left" valign="middle" bgcolor="#FFFFFF"><span class="STYLE8">&nbsp;<%=Jlqk%></span></td>
    </tr>
  <tr>
    <td height="40" colspan="4" align="center" valign="middle" bgcolor="#FFFFFF"><span class="STYLE7">专业综合测评情况</span></td>
    <td height="40" colspan="2" align="center" valign="middle" bgcolor="#FFFFFF"><span class="STYLE7">全省高校英语<br />
    等级考试情况</span></td>
    <td height="40" colspan="2" align="center" valign="middle" bgcolor="#FFFFFF"><span class="STYLE7">全省高校计算机<br />
    等级考试情况</span></td>
    <td height="40" colspan="2" align="center" valign="middle" bgcolor="#FFFFFF"><span class="STYLE7">特长</span></td>
  </tr>
  <tr>
    <td height="40" colspan="4" align="center" valign="middle" bgcolor="#FFFFFF" class="STYLE8"><%=ZyZhcp%></td>
    <td height="40" colspan="2" align="center" valign="middle" bgcolor="#FFFFFF"><span class="STYLE8"><%=English%></span></td>
    <td height="40" colspan="2" align="center" valign="middle" bgcolor="#FFFFFF"><span class="STYLE8"><%=Computer%></span></td>
    <td height="40" colspan="2" align="center" valign="middle" bgcolor="#FFFFFF"><span class="STYLE8"><%=Tc%>&nbsp;</span></td>
  </tr>
  <tr>
    <td height="40" colspan="4" align="center" valign="middle" bgcolor="#FFFFFF"><span class="STYLE7">报考类别(必须填写)</span></td>
    <td height="40" colspan="6" align="center" valign="middle" bgcolor="#FFFFFF"><span class="STYLE8"><%=bkLb%></span></td>
  </tr>
  <tr>
    <td colspan="4" rowspan="3" align="center" valign="middle" bgcolor="#FFFFFF" class="STYLE7">专业志愿<br />
      <span class="STYLE9">(必须填写，放弃用“/”表示)</span></td>
    <td height="40" colspan="6" align="left" valign="middle" bgcolor="#FFFFFF"><span class="STYLE8">&nbsp;第一志愿：<%=Zy1%></span></td>
    </tr>
  <tr>
    <td height="40" colspan="6" align="left" valign="middle" bgcolor="#FFFFFF"><span class="STYLE8">&nbsp;第二志愿：<%=Zy2%></span></td>
    </tr>
  <tr>
    <td height="40" colspan="6" align="left" valign="middle" bgcolor="#FFFFFF"><span class="STYLE8">&nbsp;第三志愿：<%=Zy3%></span></td>
    </tr>
  <tr>
    <td height="51" colspan="5" align="center" valign="middle" bgcolor="#FFFFFF"><span class="STYLE7">是否同意在报考大类中进行专业调剂<br />
      <span class="STYLE9">(必须填写，否则视为放弃调剂专业)</span></span></td>
    <td height="51" colspan="5" align="center" valign="middle" bgcolor="#FFFFFF"><span class="STYLE8">
      <% if SfTyTj="TRUE" then %>
      同意调剂
      <%else%>
      不同意调剂
      <%end if%>
    </span></td>
    </tr>
  <tr>
    <td width="55" rowspan="3" align="center" valign="middle" bgcolor="#FFFFFF"><p class="STYLE7">推<br />
      荐<br />
      审<br />
      批<br />
      情<br />
    况</p></td>
    <td height="100" colspan="3" align="center" valign="middle" bgcolor="#FFFFFF"><span class="STYLE7">院系意见<br />
      （公章）</span></td>
    <td height="120" colspan="6" align="center" valign="middle" bgcolor="#FFFFFF">&nbsp;</td>
    </tr>
  <tr>
    <td height="113" colspan="3" align="center" valign="middle" bgcolor="#FFFFFF"><span class="STYLE7">就读学校意见</span><br />
      <span class="STYLE7">（公章）</span></td>
    <td height="120" colspan="6" align="center" valign="middle" bgcolor="#FFFFFF">&nbsp;</td>
    </tr>
  <tr>
    <td height="97" colspan="3" align="center" valign="middle" bgcolor="#FFFFFF"><span class="STYLE7">招生学校意见<br />
      （公章）    </span></td>
    <td height="120" colspan="6" align="center" valign="middle" bgcolor="#FFFFFF">&nbsp;</td>
    </tr>
</table></td>
<tr>
<td height="50" colspan="2" align="left" class="STYLE8">　　注：1.本表一式二份，招生学校、学生本人档案各存一份。2.“专业综合测评情况”栏目填写格式为：测评名次/本专业人数。3.学生暑期通讯地址、联系电话必须填写准确，否则后果自负。</td>
</tr>
</table>
</div>
</body>
</html>
