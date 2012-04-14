<!-- #include file="inc/WebSvcURL.asp" -->
<%
	sError = objSOAPClient.IsCanNetBm
	if sError<>"OK" then
    	Response.Redirect "Show_Error.asp?eid="&sError
	end if
%>
<%
Dim sResult
sResult = objSOAPClient.IsCanNetBm
if sResult<>"OK" then
	Response.write"<SCRIPT language=JavaScript>alert('不允许注册！"&sResult&"');"
	Response.write"javascript:history.go(-1)</SCRIPT>"
end if
%><HEAD><TITLE>江西科技师范学院专升本报名网</TITLE>
<META http-equiv=Content-Type content="text/html; charset=gb2312"><LINK 
href="images/main_right.css" type=text/css rel=stylesheet>
<SCRIPT language=javascript src="images/ShowProcessBar.js"></SCRIPT>
<SCRIPT language=javascript>
function check() 
{
	var str;
	str1=document.form1.UserName.value;
	str2=document.form1.Sfzh.value;
	str3=document.form1.UserPwd.value;
	str4=document.form1.UserPwd2.value;
	if (str1=="")
	{
    	alert("登录名不能为空！");
		document.form1.UserName.focus();
    	return false;
  	}
	
	if (str2=="")
	{
    	alert("身份证号不能为空！");
		document.form1.Sfzh.focus();
    	return false;
  	}

	if ((str2.length!=18) && (str2.length!=15))
	{
    	alert("身份证号位数不对！");
		document.form1.Sfzh.focus();
    	return false;
  	}

	if (str3.length<6)
	{
    	alert("密码长度不能少于6位");
		document.form1.UserPwd.focus();
    	return false;
  	}

	if (str3!=str4)
	{
    	alert("密码不能为空或者两次密码不一致！");
		document.form1.UserPwd2.focus();
    	return false;
  	}

}
</SCRIPT>

<META content="MSHTML 6.00.3790.4807" name=GENERATOR>
<script src="Scripts/AC_RunActiveContent.js" type="text/javascript"></script>
</HEAD>
<%
Dim UserName
%>
<!--#include file= "top.asp"-->

<form action="CheckUserReg.asp" method="Post" name="form1" id="form1" onSubmit="return check();">
<table width="1000" border="0" align="center" cellpadding="2" cellspacing="1" bgcolor="#A8D9EC" class="bx">
  <tr>
    <td colspan="4" align="left" class="bg">注册信息</td>
    </tr>
  <tr>
    <td width="100" align="right" bgcolor="#FFFFFF" class="tr1">登录名</td>
    <td colspan="3" bgcolor="#FFFFFF" class="tr1">
      <input name="UserName" type="text" value="<%=UserName%>" maxlength="15" />
      
      (*不少于6位，最长15位) 
	  <input type="button" class="aniu" value="检测用户登录名是否可用" name="un" onClick="location.href='Check/_CheckUserName.asp?UserName='+form.UserName.value;"/>
      如果没有重复,可继续填写!　　　　    </td>
    </tr>
  <tr>
    <td align="right" bgcolor="#FFFFFF" class="tr1">身份证号</td>
    <td colspan="3" bgcolor="#FFFFFF" class="tr1"><input name="Sfzh" type="text" id="Sfzh" maxlength="18" />
      (*长度必须是18位/15位)
        <input type="button" class="aniu" value="检测身份证号是否已注册" name="un2" onclick="location.href='Check/_CheckSfzh.asp?Sfzh='+form.Sfzh.value;"/>
如果没有重复,可继续填写!</td>
    </tr>
  <tr>
    <td align="right" bgcolor="#FFFFFF" class="tr1">密码</td>
    <td colspan="3" bgcolor="#FFFFFF" class="tr1"><input name="UserPwd" type="password" id="UserPwd" maxlength="15">
      (*不少于6位，最长15位)</td>
    </tr>
  <tr>
    <td align="right" bgcolor="#FFFFFF" class="tr1">确认密码</td>
    <td colspan="3" bgcolor="#FFFFFF" class="tr1"><input name="UserPwd2" type="password" id="UserPwd2" maxlength="15"/>
      (*不少于6位，最长15位)</td>
    </tr>
  <tr>
    <td height="30" colspan="4" align="left" bgcolor="#FFFFFF" class="tr1">　　注意：带 * 的为必要内容!</td>
    </tr>
	    
		 
  <tr>
    <td colspan="4" bgcolor="#FFFFFF"><p>
      　　　　　　　　　　　　　　　　　
          <input name="Submit" type="submit" class="aniu" value="提  交" />
         </td>
    </tr>
</table>
</form>
<!--#include file= "bottom.asp"-->
