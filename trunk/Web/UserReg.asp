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
	Response.write"<SCRIPT language=JavaScript>alert('������ע�ᣡ"&sResult&"');"
	Response.write"javascript:history.go(-1)</SCRIPT>"
end if
%><HEAD><TITLE>�����Ƽ�ʦ��ѧԺר����������</TITLE>
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
    	alert("��¼������Ϊ�գ�");
		document.form1.UserName.focus();
    	return false;
  	}
	
	if (str2=="")
	{
    	alert("���֤�Ų���Ϊ�գ�");
		document.form1.Sfzh.focus();
    	return false;
  	}

	if ((str2.length!=18) && (str2.length!=15))
	{
    	alert("���֤��λ�����ԣ�");
		document.form1.Sfzh.focus();
    	return false;
  	}

	if (str3.length<6)
	{
    	alert("���볤�Ȳ�������6λ");
		document.form1.UserPwd.focus();
    	return false;
  	}

	if (str3!=str4)
	{
    	alert("���벻��Ϊ�ջ����������벻һ�£�");
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
    <td colspan="4" align="left" class="bg">ע����Ϣ</td>
    </tr>
  <tr>
    <td width="100" align="right" bgcolor="#FFFFFF" class="tr1">��¼��</td>
    <td colspan="3" bgcolor="#FFFFFF" class="tr1">
      <input name="UserName" type="text" value="<%=UserName%>" maxlength="15" />
      
      (*������6λ���15λ) 
	  <input type="button" class="aniu" value="����û���¼���Ƿ����" name="un" onClick="location.href='Check/_CheckUserName.asp?UserName='+form.UserName.value;"/>
      ���û���ظ�,�ɼ�����д!��������    </td>
    </tr>
  <tr>
    <td align="right" bgcolor="#FFFFFF" class="tr1">���֤��</td>
    <td colspan="3" bgcolor="#FFFFFF" class="tr1"><input name="Sfzh" type="text" id="Sfzh" maxlength="18" />
      (*���ȱ�����18λ/15λ)
        <input type="button" class="aniu" value="������֤���Ƿ���ע��" name="un2" onclick="location.href='Check/_CheckSfzh.asp?Sfzh='+form.Sfzh.value;"/>
���û���ظ�,�ɼ�����д!</td>
    </tr>
  <tr>
    <td align="right" bgcolor="#FFFFFF" class="tr1">����</td>
    <td colspan="3" bgcolor="#FFFFFF" class="tr1"><input name="UserPwd" type="password" id="UserPwd" maxlength="15">
      (*������6λ���15λ)</td>
    </tr>
  <tr>
    <td align="right" bgcolor="#FFFFFF" class="tr1">ȷ������</td>
    <td colspan="3" bgcolor="#FFFFFF" class="tr1"><input name="UserPwd2" type="password" id="UserPwd2" maxlength="15"/>
      (*������6λ���15λ)</td>
    </tr>
  <tr>
    <td height="30" colspan="4" align="left" bgcolor="#FFFFFF" class="tr1">����ע�⣺�� * ��Ϊ��Ҫ����!</td>
    </tr>
	    
		 
  <tr>
    <td colspan="4" bgcolor="#FFFFFF"><p>
      ����������������������������������
          <input name="Submit" type="submit" class="aniu" value="��  ��" />
         </td>
    </tr>
</table>
</form>
<!--#include file= "bottom.asp"-->
