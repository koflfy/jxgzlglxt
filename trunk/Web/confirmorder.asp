<!-- #include file="inc/WebSvcURL.asp" -->
<!-- #include file="inc/security.asp" -->
<!-- #include file="inc/function.asp" -->
<link href="images/style.css" type="text/css" rel="stylesheet"/>
<SCRIPT type=text/javascript>
<!--
function Confirm(){
  document.getElementById('confirm').disabled=true;
  document.myform.submit();
}
//-->
</SCRIPT><title>ȷ�϶���</title>
	<DIV id=payfrm>		
	   <%
		Dim sfmc,sfbz,XmlDetailInfo,objXml,objNode,objAtr,sTemp
		XmlDetailInfo=Request.Cookies("DetailInfo")
		'response.write Server.HtmlEnCode(XmlDetailInfo)

		Set objXml=Server.CreateObject("Microsoft.XMLDOM") 
		objXml.Async=False
		objXml.loadXML(XmlDetailInfo)
		'response.write ("<br>=======================<br>")
		'response.write Server.HtmlEnCode(objXml.XML)
		Set objNode = objXml.documentElement.selectSingleNode("ROWDATA")					

		'��ȡ���º����ϸ���ݣ�����XML����дcookie
		dim iCount,sfxm,sfje,i,Temp,ChangeXML
		sfmc = Request.Cookies("sfmc")
		iCount= Request.Form("sfCount")
		sfbz=0
		for i=0 to iCount-1
		  Temp="sfje"&cstr(i)
		  sfje=Request.Form(Temp)
	'	  Temp="sfxm"&cstr(i)
	'	  sfmc=Request.Form(Temp)
		  set objAtr=objNode.ChildNodes.item(i)
		  sTemp = objAtr.GetAttributeNode("xF2").Value
'		  Response.Write(Temp& " " & sfje) 
		  sTemp = Hz2UTF8(sTemp)	'��ģ�û�취ֻ���ֶ��Ѻ��ֹ�����ת��UTF8�ٷ��ظ�WebService
'		  Response.Write(Server.HtmlEncode(sTemp) & i) 
		  objAtr.SetAttribute "xF2",sTemp
		  if sfje<>"" then
		  	  objAtr.SetAttribute "xF3",sfje		  
		  End if
		  sfje = objAtr.GetAttributeNode("xF3").Value
		  sfbz=sfbz+sfje		'���¼���Ӧ���ܶ�
		  'objAtr.SetAttribute " �շѱ�׼",sfje		  
		Next
		Response.Cookies("sfbz")=sfbz	'����Ӧ���ܶ�Cookies
		ChangeXML = objXml.XML
		ChangeXML = Replace(ChangeXML,"&amp;#","&#")	'XMLDom���Զ���"&#"�ַ�ת���"&amp;#"����ֻ���ְ���ת����
		Response.Cookies("DetailInfo")=ChangeXML

'		sTemp=Server.MapPath("SXmlDetailTemp_Chnaged.xml")	
'	    Call CreateXmlFile(sTemp,ChangeXML)
'		ChangeXML=Request.Cookies("DetailInfo")
'		response.write Server.HtmlEnCode(request.Cookies("DetailInfo"))
'		Response.End()
		
		'���ɶ���ҳ������ݣ������ɽɷѵ���		
		Dim OrderId
		OrderId=objSOAPClient.GetPayNo
		
		Response.Cookies("OrderId")=OrderId
		%>
			<table width="698" border="0" cellspacing="0" cellpadding="0">
				<form name="myform" method="post" action="selectbank.asp">
			  	<tr>
					<td width="20%" height="30" align="right" class="f_14_grey">&nbsp;</td>
					<td width="53%" height="30" class="f_14_red">������˶�������Ϣ��</td>
					</tr>
			  	<tr>
					<td height="30" align="right" class="f_14_grey">�ɷѵ��ţ�</td>
					<td height="30" class="f_14_grey">
					<input name="OrderId" type="hidden" value="<%=OrderId%>" size="25" /><%=OrderId%>
					</td>
					</tr>
				<tr>
					<td height="30" align="right" class="f_14_grey">�շ����ƣ�</td>
					<td height="30" class="f_14_grey">
					<input name="sfmc" type="hidden" id="sfmc" value=<%=Request.Cookies("sfmc")%> size="25" /><%=Request.Cookies("jfxn")&Request.Cookies("sfmc")%>
					</td>
					</tr>
				<tr>
			   	<td height="30" align="right" class="f_14_grey">Ӧ�ɷѽ�</td>
			   	<td height="30" class="f_14_grey">
					<input name="sfbz" type="hidden" id="sfbz" value="<%=Request.Cookies("sfbz")%>" size="25" />
					<%=FormatNumber(Request.Cookies("sfbz"),2)%>Ԫ
					</td>
			   	</tr>
		  	<tr>
					<td height="30" align="right">&nbsp;</td>
					<td><INPUT type=button class=button id=confirm value=ȷ�϶��� onclick=Confirm();></td>
					</tr>
			</form>
		</table>
</DIV>