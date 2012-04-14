<!-- #include file="inc/WebSvcURL.asp" --><HEAD><TITLE>江西科技师范学院专升本报名网</TITLE>
<META http-equiv=Content-Type content="text/html; charset=gb2312">
<LINK href="images/main_right.css" type=text/css rel=stylesheet>
<SCRIPT language=javascript src="images/ShowProcessBar.js"></SCRIPT>

<META content="MSHTML 6.00.3790.4807" name=GENERATOR>
<script src="Scripts/AC_RunActiveContent.js" type="text/javascript"></script>
<SCRIPT language="javascript" type="text/javascript">
function bmcheck() 
{
	var xm,xb,ksh,sfzh,oldschool,oldzy,addr,yzbm,tel;
	xm=document.form1.Xm.value;
	xb=document.form1.Xb.value;
	ksh=document.form1.Ksh.value;
	sfzh=document.form1.Sfzh.value;
	oldschool=document.form1.OldSchool.value;
	oldzy=document.form1.OldZy.value;
	addr=document.form1.Addr.value;
	yzbm=document.form1.Yzbm.value;
	tel=document.form1.Tel.value;
    	alert("姓名不得少于两个汉字！");
	
	if (xm.length<=4)
	{
    	alert("姓名不得少于两个汉字！");
		document.form1.Xm.focus();
    	return false;
  	}
	if (xb.length!=2)
	{
    	alert("性别不能为空！");
		document.form1.xb.focus();
    	return false;
  	}

	if ((sfzh.length!=18) && (sfzh.length!=15))
	{
    	alert("身份证号长度不正确！");
		document.form1.Sfzh.focus();
    	return false;
  	}
	
	if ((ksh.length!=14) || (ksh.length!=10))
	{
    	alert("考生号不能为空！");
		document.form1.Ksh.focus();
    	return false;
  	}

	if (oldschool=="")
	{
    	alert("现就读学校不能为空！");
		document.form1.OldSchool.focus();
    	return false;
  	}
	if (oldzy=="")
	{
    	alert("所学专业不能为空！");
		document.form1.OldZy.focus();
    	return false;
  	}
	if (addr=="")
	{
    	alert("暑期地址不能为空！");
		document.form1.addr.focus();
    	return false;
  	}
	if (yzbm.length!=6)
	{
    	alert("邮政编码位数不正确！");
		document.form1.addr.focus();
    	return false;
  	}
	if (tel=="")
	{
    	alert("暑期联系电话不能为空！");
		document.form1.addr.focus();
    	return false;
  	}
}
</SCRIPT>
<style type="text/css">
<!--
.STYLE8 {font-size: 14px}
-->
</style>
</HEAD>
<%
	sError = objSOAPClient.IsCanNetBm
	if sError<>"OK" then
    	Response.Redirect "Show_Error.asp?eid="&sError
	end if
%>
<%
if Session("Logined")="" then Response.Redirect("index.asp")
%>
<!--#include file= "top.asp"-->
<%
dim UserName,BmNo, Ksh, Sfzh, Xm, Xb, Mz, ZzMm, OldSchool, OldZy, Jlqk, Addr, Yzbm, Tel, ZyZhcp, English, Computer, Tc,Photo_Url
dim bkLb,Zy1,Zy2,Zy3,sftytj
Dim XmlDataInfo,objDom,objNodes,objAtrs,nCntAtr,i,nCntChd,element 

UserName=Session("UserName")
if Session("Logined")<>"" then
	GetKsInfo
end if
%>

<form action="CheckUserBm.asp" method="Post" name="form1" id="form1" onSubmit="return bmcheck();">
<table width="1000" border="0" align="center" cellpadding="2" cellspacing="1" bgcolor="#A8D9EC" class="bx">
  <tr>
    <td colspan="4" align="left" class="bg">用户已注册信息</td>
    </tr>
  <tr>
    <td width="116" align="right" bgcolor="#FFFFFF" class="tr1">用户登录名</td>
    <td colspan="3" bgcolor="#FFFFFF" class="tr1">
      <%=Session("UserName")%> </td>
    </tr>
  <tr>
    <td width="116" align="right" bgcolor="#FFFFFF" class="tr1">报名序号</td>
    <td colspan="3" bgcolor="#FFFFFF" class="tr1">
      <%=Session("BmNo")%> </td>
    </tr>
  <tr>
    <td align="right" bgcolor="#FFFFFF" class="tr1">身份证号</td>
    <td colspan="3" bgcolor="#FFFFFF" class="tr1"><input name="Sfzh" type="text" id="sfzh" value="<%=Sfzh%>" size="20" maxlength="18"/> 
    (*18位/15位)     </td>
  </tr>
  <tr>
    <td colspan="4" align="left" class="bg">报名信息</td>
    </tr>
  <tr>
    <td align="right" bgcolor="#FFFFFF" class="tr1">姓名</td>
    <td width="702" bgcolor="#FFFFFF" class="tr1"><input name="Xm" type="text" id="Xm" value="<%=Xm%>" size="15" maxlength="10" />
    (*不少于2个汉字)</td>
    <td width="164" rowspan="8" bgcolor="#FFFFFF" class="tr1">
	<div align="center">
	照片规格：120X150<br>
	<img name="Photo" id="Photo" src='<%=Session("Photo_Url")%>' alt="照片" width="120" height="150" />
	<br>照片大小：≤200K
	<iframe style="top:2px" id="UploadFiles" src="Upload_Photo.asp?PhotoUrlID=3" frameborder="0" scrolling="No" width="135" height="50" name="I1"></iframe>
	</div>	</td>
  </tr>
  <tr>
    <td align="right" bgcolor="#FFFFFF" class="tr1">性别</td>
    <td bgcolor="#FFFFFF" class="tr1">
	  <select name="xb" id="xb">
	    <option value="男" <%if xb="男" then %>selected="selected"<%end if%>>男</option>
	    <option value="女" <%if xb="女" then %>selected="selected"<%end if%>>女</option>
      </select> 
      *</td>
    </tr>
    <tr><td align="right" valign="top" bgcolor="#FFFFFF" class="tr1">考生号</td>
    <td bgcolor="#FFFFFF" class="tr1"><input name="Ksh" type="text" id="Ksh" value="<%=Ksh%>" size="20" maxlength="14">
      (*考生号长度必须是14位、10位或者9位)&nbsp;&nbsp; <br>
<!--
      <a href="Ksh_cx.asp?Sfzh=<%=Sfzh%>" target="_blank"><font color="red">本校考生考生号查询</font></a>
//-->
      <a href="#" onclick="window.open('Ksh_Cx.asp?Sfzh=<%=Sfzh%>', '考生号查询', 'height=430; width=600; toolbar= no; menubar=no; scrollbars=no; resizable=no; location=no; status=no;top='+(window.screen.height-100)/2+';left='+(window.screen.width-400)/2)"><font color="red">本校考生考生号查询</font></a>
      </td>
    </tr>
  <tr>
    <td align="right" bgcolor="#FFFFFF" class="tr1">民族</td>
    <td bgcolor="#FFFFFF" class="tr1">
	<select name="Mz" id="Mz" style="width:100">
<%
	XmlDataInfo=objSOAPClient.GetMzList
	Set objDom=Server.CreateObject("Microsoft.XMLDOM") 
	objDom.Async=False
	If objDom.loadXML(XmlDataInfo) Then    '把XML字符串读入内存
		set objnodes=objdom.documentElement.SelectSingleNode("//ROWDATA").ChildNodes
		for each element in objnodes
			set objAtrs=element.attributes
			if objAtrs.item(0).Value=Mz then 
				Response.Write "<option selected='selected'>"&objAtrs.item(0).Value&"</option>"
			else
				Response.Write "<option>"&objAtrs.item(0).Value&"</option>"
			end if
		next
		Set objAtrs=Nothing 
		Set objNodes=Nothing 
		Set objDom=Nothing
	end if
	
%>	
	</select>
      *</td>
    </tr>
  <tr>
    <td align="right" nowrap="nowrap" bgcolor="#FFFFFF" class="tr1">政治面貌</td>
    <td bgcolor="#FFFFFF" class="tr1">
	<select name="ZzMm" id="ZzMm" style="width:100">
<%
	XmlDataInfo=objSOAPClient.GetZzmmList
	Set objDom=Server.CreateObject("Microsoft.XMLDOM") 
	objDom.Async=False
	If objDom.loadXML(XmlDataInfo) Then    '把XML字符串读入内存
		set objnodes=objdom.documentElement.SelectSingleNode("//ROWDATA").ChildNodes
		for each element in objnodes
			set objAtrs=element.attributes
			if objAtrs.item(0).Value=ZzMm then 
				Response.Write "<option selected='selected'>"&objAtrs.item(0).Value&"</option>"
			else
				Response.Write "<option>"&objAtrs.item(0).Value&"</option>"
			end if
		next
		Set objAtrs=Nothing 
		Set objNodes=Nothing 
		Set objDom=Nothing
	end if
	
%>	
	</select>
	*</td>
    </tr>
  <tr>
    <td align="right" nowrap="nowrap" bgcolor="#FFFFFF" class="tr1">现就读学校</td>
    <td bgcolor="#FFFFFF" class="tr1">
	<select name="OldSchool" id="OldSchool" style="width:300">
<%
	XmlDataInfo=objSOAPClient.GetSchoolList
	Set objDom=Server.CreateObject("Microsoft.XMLDOM") 
	objDom.Async=False
	If objDom.loadXML(XmlDataInfo) Then    '把XML字符串读入内存
		set objnodes=objdom.documentElement.SelectSingleNode("//ROWDATA").ChildNodes
		for each element in objnodes
			set objAtrs=element.attributes
			if objAtrs.item(0).Value=OldSchool then 
				Response.Write "<option selected='selected'>"&objAtrs.item(0).Value&"</option>"
			else
				Response.Write "<option>"&objAtrs.item(0).Value&"</option>"
			end if
		next
		Set objAtrs=Nothing 
		Set objNodes=Nothing 
		Set objDom=Nothing
	end if
	
%>	
	</select>
      *</td>
    </tr>
  <tr>
    <td align="right" bgcolor="#FFFFFF" class="tr1">所学专业</td>
    <td bgcolor="#FFFFFF" class="tr1"><input name="OldZy" type="text" id="OldZy" Value="<%=OldZy%>" size="43" maxlength="30">
      *</td>
    </tr>
  <tr>
    <td align="right" bgcolor="#FFFFFF" class="tr1">特长</td>
    <td bgcolor="#FFFFFF" class="tr1"><input name="Tc" type="text" value="<%=Tc%>" size="70" maxlength="50" />
      (#最长25个汉字)</td>
    </tr>
  
  <tr>
    <td align="right" nowrap="nowrap" bgcolor="#FFFFFF" class="tr1">暑期通讯地址</td>
    <td bgcolor="#FFFFFF" class="tr1"><input name="Addr" type="text" id="Addr" value="<%=Addr%>" size="70" maxlength="80" />
      (*最长50个汉字)</td>
    <td width="164" bgcolor="#FFFFFF" class="tr1">&nbsp;</td>
  </tr>
  <tr>
    <td align="right" bgcolor="#FFFFFF" class="tr1">邮政编码</td>
    <td bgcolor="#FFFFFF" class="tr1"><input name="Yzbm" type="text" id="yzbm" value="<%=yzbm%>" size="6" maxlength="6" />
    (*6位)</td>
    <td width="164" bgcolor="#FFFFFF" class="tr1">&nbsp;</td>
  </tr>
  <tr>
    <td align="right" bgcolor="#FFFFFF" class="tr1">暑期联系电话</td>
    <td bgcolor="#FFFFFF" class="tr1"><input name="Tel" type="text" id="Tel" value="<%=Tel%>" size="35" maxlength="30" />
      (*如有固定电话，请写上区号，如：13970889503，0791-3818297)</td>
    <td bgcolor="#FFFFFF" class="tr1"></td>
    </tr>
  <tr>
    <td align="right" bgcolor="#FFFFFF" class="tr1">照片地址</td>
    <td bgcolor="#FFFFFF" class="tr1">
      <%=Session("Photo_Url")%></td>
    <td bgcolor="#FFFFFF" class="tr1">
      　</td>
  </tr>
  <tr>
    <td align="right" bgcolor="#FFFFFF" class="tr1">受奖励情况</td>
    <td bgcolor="#FFFFFF" class="tr1"><input name="Jlqk" type="text" id="Jlqk" value="<%=Jlqk%>" size="70" maxlength="80">
      (#最长50个汉字)</td>
    <td bgcolor="#FFFFFF" class="tr1"></td>
    </tr>
  <tr>
    <td align="right" bgcolor="#FFFFFF" class="tr1">专业综合测评情况</td>
    <td bgcolor="#FFFFFF" class="tr1"><input name="ZyZhcp" type="text" size="21" id="ZyZhcp" value="<%=ZyZhcp%>">
    &nbsp;(格式为：测评名次/本专业人数，如：7/35)</td>
    <td bgcolor="#FFFFFF" class="tr1"></td>
    </tr>
  <tr>
    <td align="right" bgcolor="#FFFFFF" class="tr1">省英语等级考试</td>
    <td bgcolor="#FFFFFF" class="tr1">
    <select name="English" id="English" style="width:150">
      <option <%if English="免修" then Response.write "selected"%> value="免修">免修</option>
      <option <%if English="应用能力A" then Response.write "selected"%> value="应用能力A">应用能力A</option>
      <option <%if English="应用能力B" then Response.write "selected"%> value="应用能力B">应用能力B</option>
      <option <%if English="待考" then Response.write "selected"%> value="待考">待考</option>
    </select>
    *</td>
    <td bgcolor="#FFFFFF" class="tr1"></td>
    </tr>
  <tr>
    <td align="right" bgcolor="#FFFFFF" class="tr1">省计算机等级考试</td>
    <td bgcolor="#FFFFFF" class="tr1"><select name="Computer" id="Computer" style="width:150">
      <option <%if Computer="免修" then Response.write "selected"%> value="免修">免修</option>
      <option <%if Computer="省一级" then Response.write "selected"%> value="省一级">省一级</option>
      <option <%if Computer="省二级" then Response.write "selected"%> value="省二级">省二级</option>
      <option <%if Computer="待考" then Response.write "selected"%> value="待考">待考</option>
    </select>
      *</td>
    <td bgcolor="#FFFFFF" class="tr1"></td>
    </tr>
  <tr>
    <td height="30" colspan="4" align="left" bgcolor="#FFFFFF" class="tr1">　　注意：带 * 的为必填内容, 带 # 的为
      有要求的同学选填,您可根据个人的具体情况填写!</td>
    </tr>
	    
		 
  <tr>
    <td colspan="4" align="center" bgcolor="#FFFFFF"><p>
      <input name="Submit" type="submit" class="aniu" value="确认提交考生信息">
    </p>      </td>
    </tr>
</table>
</form>
<!--#include file= "bottom.asp"-->
