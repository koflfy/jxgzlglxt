<!-- #include file="inc/WebSvcURL.asp" --><HEAD><TITLE>�����Ƽ�ʦ��ѧԺר����������</TITLE>
<META http-equiv=Content-Type content="text/html; charset=gb2312"><LINK 
href="images/main_right.css" type=text/css rel=stylesheet>
<SCRIPT language=javascript src="images/ShowProcessBar.js"></SCRIPT>

<META content="MSHTML 6.00.3790.4807" name=GENERATOR>
<script src="Scripts/AC_RunActiveContent.js" type="text/javascript"></script>
</HEAD>
<!--#include file= "top.asp"-->
<%
	sError = objSOAPClient.IsCanNetBm
	if sError<>"OK" then
    	Response.Redirect "Show_Error.asp?eid="&sError
	end if
%>
<%
if Session("Logined")="" then Response.Redirect("index.asp")

dim UserName,BmNo, Ksh, Sfzh, Xm, Xb, Mz, ZzMm, OldSchool, OldZy, Jlqk, Addr, Yzbm, Tel, ZyZhcp, English, Computer, Tc,bkLb,Zy1,Zy2,Zy3,SftyTj,Photo_Url
dim XmlDataInfo,objDom,objNodes,objAtrs,nCntAtr,i,nCntChd,element

dim Param,StrTemp
Param = Request.QueryString("Param")

UserName=Session("UserName")
if Session("Logined")<>"" then
	GetKsInfo
end if

%>

<form action="CheckUserBK.asp" method="post" name="myform" id="user">
<table width="1000" border="0" align="center" cellpadding="2" cellspacing="1" bgcolor="#A8D9EC" class="bx">
  <tr>
    <td colspan="3" align="left" class="bg">�û���ע����Ϣ</td>
    </tr>
  <tr>
    <td width="149" align="right" bgcolor="#FFFFFF" class="tr1">�û���¼��</td>
    <td width="696" bgcolor="#FFFFFF" class="tr1">
      <%=Session("UserName")%> </td>
	<td width="137" rowspan="8" align="center" valign="top" bgcolor="#FFFFFF" >�������˽���
      <div align="center"><img name="Photo" id="Photo" src='<%=Session("Photo_Url")%>' alt="��Ƭ" width="120" height="150" /><br>��Ƭ���150X120</div></td>
    </tr>
  <tr>
    <td align="right" bgcolor="#FFFFFF" class="tr1">�������</td>
    <td bgcolor="#FFFFFF" class="tr1"><%=Session("BmNo")%></td>
	</tr>
  <tr>
    <td align="right" bgcolor="#FFFFFF" class="tr1">����</td>
    <td bgcolor="#FFFFFF" class="tr1"><%=Xm%></td>
	</tr>
  <tr>
    <td align="right" bgcolor="#FFFFFF" class="tr1">�Ա�</td>
    <td bgcolor="#FFFFFF" class="tr1"><%=Xb%></td>
	</tr>
  <tr>
    <td align="right" bgcolor="#FFFFFF" class="tr1">���֤��</td>
    <td bgcolor="#FFFFFF" class="tr1"><%=Sfzh%></td>
	</tr>
    <tr><td align="right" bgcolor="#FFFFFF" class="tr1">������</td>
    <td bgcolor="#FFFFFF" class="tr1"><%=Ksh%></td>
	</tr>
    <tr><td align="right" bgcolor="#FFFFFF" class="tr1">�־Ͷ�ѧУ</td>
    <td bgcolor="#FFFFFF" class="tr1"><%=OldSchool%></td>
	</tr>
    <tr><td align="right" bgcolor="#FFFFFF" class="tr1">����ѧרҵ</td>
    <td bgcolor="#FFFFFF" class="tr1"><%=OldZy%></td>
	</tr>
  <tr>
    <td colspan="3" align="left" class="bg"> ѡ��רҵ</td>
    </tr>
  <tr>
    <td align="right" bgcolor="#FFFFFF" class="tr1">��������</td>
    <td colspan="2" bgcolor="#FFFFFF" class="tr1">
  <%
  Dim MyArray1()

	if Param<>"" then bkLb=Param
	
	XmlDataInfo=objSOAPClient.GetZyLbList
	Set objDom=Server.CreateObject("Microsoft.XMLDOM") 
	objDom.Async=False
	If objDom.loadXML(XmlDataInfo) Then    '��XML�ַ��������ڴ�
		set objnodes=objdom.documentElement.SelectSingleNode("//ROWDATA").ChildNodes
		i=0
		for each element in objnodes
			set objAtrs=element.attributes
			i=i+1
		next
    ReDim MyArray1(i)
    i=0
		for each element in objnodes
			set objAtrs=element.attributes
			MyArray1(i) = objAtrs.item(0).Value
'      Response.Write MyArray1(i) & "<br>"
			i=i+1
		next
		Set objAtrs=Nothing 
		Set objNodes=Nothing 
		Set objDom=Nothing
		strTemp = MyArray1(0)
	end if
	
%>	
      <select name="ZyLb" type="text" id="ZyLb" size="1" style="width:180" onchange="location.href='SelectZyList.asp?Param='+this.value">
  <%
'  Response.write UBound(MyArray1)
		for i=LBound(MyArray1) to UBound(MyArray1)
			if MyArray1(i)=bkLb then 
				Response.Write "<option selected='selected' value="&MyArray1(i)&">"&MyArray1(i)&"</option>"
			else
				Response.Write "<option value="&MyArray1(i)&">"&MyArray1(i)&"</option>"
			end if
		next
%>
        </select>
      *</td>
    </tr>
<%
	'Response.Write( "Param:"&Param )
	if bkLb="" then
		XmlDataInfo=objSOAPClient.GetZyList(strTemp)
	else
		XmlDataInfo=objSOAPClient.GetZyList(bkLb)
	end if
	Set objDom=Server.CreateObject("Microsoft.XMLDOM") 
	objDom.Async=False
	
	Dim MyArray2()
	If objDom.loadXML(XmlDataInfo) Then    '��XML�ַ��������ڴ�
		set objnodes=objdom.documentElement.SelectSingleNode("//ROWDATA").ChildNodes
		i=0
		for each element in objnodes
			set objAtrs=element.attributes
			'MyArray2(element) =  objAtrs.item(0).Value
			'Response.Write MyArray2(i)&"<br>"
			i=i+1
		next
		ReDim MyArray2(i)
		i = 0
		for each element in objnodes
			set objAtrs=element.attributes
			MyArray2(i) =  objAtrs.item(0).Value
			'Response.Write MyArray2(i)&"<br>"
			i = i+1
		next
		Set objAtrs=Nothing 
		Set objNodes=Nothing 
		Set objDom=Nothing
	end if
	'Response.End()
%>	
<tr>
    <td align="right" height="26" bgcolor="#FFFFFF"  class="tr1">רҵ־Ըһ</td>
    <td colspan="2" bgcolor="#FFFFFF" class="bg3">
      <select name="Zy1" type="text" id="Zy1" size="1" style="width:280">
  <%
		for i=LBound(MyArray2) to UBound(MyArray2)
			if MyArray2(i)=Zy1 then 
				Response.Write "<option selected='selected' value="&MyArray2(i)&">"&MyArray2(i)&"</option>"
			else
				Response.Write "<option value="&MyArray2(i)&">"&MyArray2(i)&"</option>"
			end if
		next
%>	
        </select>
      *</td>
    </tr>
<tr>
    <td align="right" height="26" bgcolor="#FFFFFF"  class="tr1">רҵ־Ը��</td>
    <td colspan="2" bgcolor="#FFFFFF" class="bg3">
      <select name="Zy2" type="text" id="Zy2" size="1" style="width:280">
  <%
		for i=LBound(MyArray2) to UBound(MyArray2)
			if MyArray2(i)=Zy2 then 
				Response.Write "<option selected='selected' value="&MyArray2(i)&">"&MyArray2(i)&"</option>"
			else
				Response.Write "<option value="&MyArray2(i)&">"&MyArray2(i)&"</option>"
			end if
		next
%>	
        </select>
      *</td>
    </tr>
<tr>
    <td align="right" height="26" bgcolor="#FFFFFF"  class="tr1">רҵ־Ը��</td>
    <td colspan="2" bgcolor="#FFFFFF" class="bg3">
      <select name="Zy3" type="text" id="Zy3" size="1" style="width:280">
  <%
		for i=LBound(MyArray2) to UBound(MyArray2)
			if MyArray2(i)=Zy3 then 
				Response.Write "<option selected='selected' value="&MyArray2(i)&">"&MyArray2(i)&"</option>"
			else
				Response.Write "<option value="&MyArray2(i)&">"&MyArray2(i)&"</option>"
			end if
		next
%>	
        </select>
      *</td>
    </tr>

  <tr>
    <td align="right" bgcolor="#FFFFFF" class="tr1">�Ƿ�רҵ����</td>
    <td colspan="2" bgcolor="#FFFFFF" class="bg3">
      <input name="ZyTj" type="radio" value="1" <% if SftyTj="TRUE" then %>checked<%end if%> id="ZyTj"/><label for="ͬ��"> ͬ��</label>
      <input name="ZyTj" type="radio" value="0" <% if SftyTj="FALSE" then %>checked<%end if%> id="ZyTj"/>
      <label for="��ͬ��">��ͬ�� * (�Ƿ�ͬ���ڱ��������н���רҵ����)</label></td>
    </tr>

 <tr> 
    <td height="30" colspan="3" align="center" bgcolor="#FFFFFF" class="tr1">ע�⣺�� * ��Ϊ�������ݡ���</td>
    </tr>
	    
		 
  <tr>
    <td colspan="3" bgcolor="#FFFFFF"><p>
      ����������������������������������
          <input name="Submit" type="submit" class="aniu" value="ȷ���ύ������Ϣ" />
    </p>      </td>
    </tr>
</table>
</form>
<!--#include file= "bottom.asp"-->
