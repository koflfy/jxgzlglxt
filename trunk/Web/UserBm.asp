<!-- #include file="inc/WebSvcURL.asp" --><HEAD><TITLE>�����Ƽ�ʦ��ѧԺר����������</TITLE>
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
    	alert("�������������������֣�");
	
	if (xm.length<=4)
	{
    	alert("�������������������֣�");
		document.form1.Xm.focus();
    	return false;
  	}
	if (xb.length!=2)
	{
    	alert("�Ա���Ϊ�գ�");
		document.form1.xb.focus();
    	return false;
  	}

	if ((sfzh.length!=18) && (sfzh.length!=15))
	{
    	alert("���֤�ų��Ȳ���ȷ��");
		document.form1.Sfzh.focus();
    	return false;
  	}
	
	if ((ksh.length!=14) || (ksh.length!=10))
	{
    	alert("�����Ų���Ϊ�գ�");
		document.form1.Ksh.focus();
    	return false;
  	}

	if (oldschool=="")
	{
    	alert("�־Ͷ�ѧУ����Ϊ�գ�");
		document.form1.OldSchool.focus();
    	return false;
  	}
	if (oldzy=="")
	{
    	alert("��ѧרҵ����Ϊ�գ�");
		document.form1.OldZy.focus();
    	return false;
  	}
	if (addr=="")
	{
    	alert("���ڵ�ַ����Ϊ�գ�");
		document.form1.addr.focus();
    	return false;
  	}
	if (yzbm.length!=6)
	{
    	alert("��������λ������ȷ��");
		document.form1.addr.focus();
    	return false;
  	}
	if (tel=="")
	{
    	alert("������ϵ�绰����Ϊ�գ�");
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
    <td colspan="4" align="left" class="bg">�û���ע����Ϣ</td>
    </tr>
  <tr>
    <td width="116" align="right" bgcolor="#FFFFFF" class="tr1">�û���¼��</td>
    <td colspan="3" bgcolor="#FFFFFF" class="tr1">
      <%=Session("UserName")%> </td>
    </tr>
  <tr>
    <td width="116" align="right" bgcolor="#FFFFFF" class="tr1">�������</td>
    <td colspan="3" bgcolor="#FFFFFF" class="tr1">
      <%=Session("BmNo")%> </td>
    </tr>
  <tr>
    <td align="right" bgcolor="#FFFFFF" class="tr1">���֤��</td>
    <td colspan="3" bgcolor="#FFFFFF" class="tr1"><input name="Sfzh" type="text" id="sfzh" value="<%=Sfzh%>" size="20" maxlength="18"/> 
    (*18λ/15λ)     </td>
  </tr>
  <tr>
    <td colspan="4" align="left" class="bg">������Ϣ</td>
    </tr>
  <tr>
    <td align="right" bgcolor="#FFFFFF" class="tr1">����</td>
    <td width="702" bgcolor="#FFFFFF" class="tr1"><input name="Xm" type="text" id="Xm" value="<%=Xm%>" size="15" maxlength="10" />
    (*������2������)</td>
    <td width="164" rowspan="8" bgcolor="#FFFFFF" class="tr1">
	<div align="center">
	��Ƭ���120X150<br>
	<img name="Photo" id="Photo" src='<%=Session("Photo_Url")%>' alt="��Ƭ" width="120" height="150" />
	<br>��Ƭ��С����200K
	<iframe style="top:2px" id="UploadFiles" src="Upload_Photo.asp?PhotoUrlID=3" frameborder="0" scrolling="No" width="135" height="50" name="I1"></iframe>
	</div>	</td>
  </tr>
  <tr>
    <td align="right" bgcolor="#FFFFFF" class="tr1">�Ա�</td>
    <td bgcolor="#FFFFFF" class="tr1">
	  <select name="xb" id="xb">
	    <option value="��" <%if xb="��" then %>selected="selected"<%end if%>>��</option>
	    <option value="Ů" <%if xb="Ů" then %>selected="selected"<%end if%>>Ů</option>
      </select> 
      *</td>
    </tr>
    <tr><td align="right" valign="top" bgcolor="#FFFFFF" class="tr1">������</td>
    <td bgcolor="#FFFFFF" class="tr1"><input name="Ksh" type="text" id="Ksh" value="<%=Ksh%>" size="20" maxlength="14">
      (*�����ų��ȱ�����14λ��10λ����9λ)&nbsp;&nbsp; <br>
<!--
      <a href="Ksh_cx.asp?Sfzh=<%=Sfzh%>" target="_blank"><font color="red">��У���������Ų�ѯ</font></a>
//-->
      <a href="#" onclick="window.open('Ksh_Cx.asp?Sfzh=<%=Sfzh%>', '�����Ų�ѯ', 'height=430; width=600; toolbar= no; menubar=no; scrollbars=no; resizable=no; location=no; status=no;top='+(window.screen.height-100)/2+';left='+(window.screen.width-400)/2)"><font color="red">��У���������Ų�ѯ</font></a>
      </td>
    </tr>
  <tr>
    <td align="right" bgcolor="#FFFFFF" class="tr1">����</td>
    <td bgcolor="#FFFFFF" class="tr1">
	<select name="Mz" id="Mz" style="width:100">
<%
	XmlDataInfo=objSOAPClient.GetMzList
	Set objDom=Server.CreateObject("Microsoft.XMLDOM") 
	objDom.Async=False
	If objDom.loadXML(XmlDataInfo) Then    '��XML�ַ��������ڴ�
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
    <td align="right" nowrap="nowrap" bgcolor="#FFFFFF" class="tr1">������ò</td>
    <td bgcolor="#FFFFFF" class="tr1">
	<select name="ZzMm" id="ZzMm" style="width:100">
<%
	XmlDataInfo=objSOAPClient.GetZzmmList
	Set objDom=Server.CreateObject("Microsoft.XMLDOM") 
	objDom.Async=False
	If objDom.loadXML(XmlDataInfo) Then    '��XML�ַ��������ڴ�
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
    <td align="right" nowrap="nowrap" bgcolor="#FFFFFF" class="tr1">�־Ͷ�ѧУ</td>
    <td bgcolor="#FFFFFF" class="tr1">
	<select name="OldSchool" id="OldSchool" style="width:300">
<%
	XmlDataInfo=objSOAPClient.GetSchoolList
	Set objDom=Server.CreateObject("Microsoft.XMLDOM") 
	objDom.Async=False
	If objDom.loadXML(XmlDataInfo) Then    '��XML�ַ��������ڴ�
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
    <td align="right" bgcolor="#FFFFFF" class="tr1">��ѧרҵ</td>
    <td bgcolor="#FFFFFF" class="tr1"><input name="OldZy" type="text" id="OldZy" Value="<%=OldZy%>" size="43" maxlength="30">
      *</td>
    </tr>
  <tr>
    <td align="right" bgcolor="#FFFFFF" class="tr1">�س�</td>
    <td bgcolor="#FFFFFF" class="tr1"><input name="Tc" type="text" value="<%=Tc%>" size="70" maxlength="50" />
      (#�25������)</td>
    </tr>
  
  <tr>
    <td align="right" nowrap="nowrap" bgcolor="#FFFFFF" class="tr1">����ͨѶ��ַ</td>
    <td bgcolor="#FFFFFF" class="tr1"><input name="Addr" type="text" id="Addr" value="<%=Addr%>" size="70" maxlength="80" />
      (*�50������)</td>
    <td width="164" bgcolor="#FFFFFF" class="tr1">&nbsp;</td>
  </tr>
  <tr>
    <td align="right" bgcolor="#FFFFFF" class="tr1">��������</td>
    <td bgcolor="#FFFFFF" class="tr1"><input name="Yzbm" type="text" id="yzbm" value="<%=yzbm%>" size="6" maxlength="6" />
    (*6λ)</td>
    <td width="164" bgcolor="#FFFFFF" class="tr1">&nbsp;</td>
  </tr>
  <tr>
    <td align="right" bgcolor="#FFFFFF" class="tr1">������ϵ�绰</td>
    <td bgcolor="#FFFFFF" class="tr1"><input name="Tel" type="text" id="Tel" value="<%=Tel%>" size="35" maxlength="30" />
      (*���й̶��绰����д�����ţ��磺13970889503��0791-3818297)</td>
    <td bgcolor="#FFFFFF" class="tr1"></td>
    </tr>
  <tr>
    <td align="right" bgcolor="#FFFFFF" class="tr1">��Ƭ��ַ</td>
    <td bgcolor="#FFFFFF" class="tr1">
      <%=Session("Photo_Url")%></td>
    <td bgcolor="#FFFFFF" class="tr1">
      ��</td>
  </tr>
  <tr>
    <td align="right" bgcolor="#FFFFFF" class="tr1">�ܽ������</td>
    <td bgcolor="#FFFFFF" class="tr1"><input name="Jlqk" type="text" id="Jlqk" value="<%=Jlqk%>" size="70" maxlength="80">
      (#�50������)</td>
    <td bgcolor="#FFFFFF" class="tr1"></td>
    </tr>
  <tr>
    <td align="right" bgcolor="#FFFFFF" class="tr1">רҵ�ۺϲ������</td>
    <td bgcolor="#FFFFFF" class="tr1"><input name="ZyZhcp" type="text" size="21" id="ZyZhcp" value="<%=ZyZhcp%>">
    &nbsp;(��ʽΪ����������/��רҵ�������磺7/35)</td>
    <td bgcolor="#FFFFFF" class="tr1"></td>
    </tr>
  <tr>
    <td align="right" bgcolor="#FFFFFF" class="tr1">ʡӢ��ȼ�����</td>
    <td bgcolor="#FFFFFF" class="tr1">
    <select name="English" id="English" style="width:150">
      <option <%if English="����" then Response.write "selected"%> value="����">����</option>
      <option <%if English="Ӧ������A" then Response.write "selected"%> value="Ӧ������A">Ӧ������A</option>
      <option <%if English="Ӧ������B" then Response.write "selected"%> value="Ӧ������B">Ӧ������B</option>
      <option <%if English="����" then Response.write "selected"%> value="����">����</option>
    </select>
    *</td>
    <td bgcolor="#FFFFFF" class="tr1"></td>
    </tr>
  <tr>
    <td align="right" bgcolor="#FFFFFF" class="tr1">ʡ������ȼ�����</td>
    <td bgcolor="#FFFFFF" class="tr1"><select name="Computer" id="Computer" style="width:150">
      <option <%if Computer="����" then Response.write "selected"%> value="����">����</option>
      <option <%if Computer="ʡһ��" then Response.write "selected"%> value="ʡһ��">ʡһ��</option>
      <option <%if Computer="ʡ����" then Response.write "selected"%> value="ʡ����">ʡ����</option>
      <option <%if Computer="����" then Response.write "selected"%> value="����">����</option>
    </select>
      *</td>
    <td bgcolor="#FFFFFF" class="tr1"></td>
    </tr>
  <tr>
    <td height="30" colspan="4" align="left" bgcolor="#FFFFFF" class="tr1">����ע�⣺�� * ��Ϊ��������, �� # ��Ϊ
      ��Ҫ���ͬѧѡ��,���ɸ��ݸ��˵ľ��������д!</td>
    </tr>
	    
		 
  <tr>
    <td colspan="4" align="center" bgcolor="#FFFFFF"><p>
      <input name="Submit" type="submit" class="aniu" value="ȷ���ύ������Ϣ">
    </p>      </td>
    </tr>
</table>
</form>
<!--#include file= "bottom.asp"-->
