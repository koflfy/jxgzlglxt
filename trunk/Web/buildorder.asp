<!-- #include file="inc/WebSvcURL.asp" -->
<!-- #include file="inc/security.asp" -->
<!-- #include file="inc/function.asp" -->
<link href="images/style.css" type="text/css" rel="stylesheet"/>
<SCRIPT type=text/javascript>
<!--
function CreateOrder(){
  document.getElementById('create').disabled=true;
  document.myform.submit();
}

function isIE(){ //ie?
if (window.navigator.userAgent.toLowerCase().indexOf("msie")>=1)
    return true;
else
    return false;
	 
//Ҳ����ֱ������������
// return (document.all);	 
}

function UpdateTotalJe(new_totalje)
{
	//var key = window.event ? e.keyCode : e.which;
	//alert(new_totalje);
	document.getElementById("sfbz").innerHTML=new_totalje;
/*
	if (isIE()) // //ie
	{
			document.getElementById("sfbz").innerText=new_totalje;
	}
	else
	{
	  	//alert(new_totalje);
	  	document.getElementById("sfbz").textContent=new_totalje;
	}
*/
	return true;
}

//-->
</SCRIPT>

<title>���ɶ���</title>
	<style type="text/css">
<!--
.STYLE1 {color: #D4D0C8}
-->
	</style>
	<DIV id=payfrm>		
	<%
	Dim IsPaid,sfmc,sfxm,jfxn,StuSfzh,StudentNo
	'�ж��Ƿ��ѽɷ�
	jfxn=trim(objSOAPClient.GetCurToPayXn)
	sfmc=trim(objSOAPClient.GetCurToPayName)
	Response.Cookies("jfxn")=jfxn
	Response.Cookies("sfmc")=sfmc
	
	'ͨ�����֤�Ż�ȡѧ���Ƿ��ѽɷ���Ϣ
	If Request.Cookies("StuSfzh")<>"" Then  
	 	StuSfzh=Request.Cookies("StuSfzh")
		IsPaid=objSOAPClient.StuIsPaidBySfzh(StuSfzh,jfxn,sfmc)
	 End If
   
	'ͨ��ѧ�Ż�ȡѧ���Ƿ��ѽɷ���Ϣ
	If Request.Cookies("StudentNo")<>"" Then  
	 	StudentNo=Request.Cookies("StudentNo")
		IsPaid=objSOAPClient.StuIsPaidByXH(StudentNo,jfxn,sfmc)
	End If
	
	If  IsPaid Then
	%>
		<table width="698" border="0" cellspacing="0" cellpadding="0">
			<tr><td width="80%" height="40" align="center" class="f_14_grey">��ǰ���ڽ���<%=jfxn%><%=sfmc%>����ȡ��</td></tr>	
			<tr><td width="80%" height="40" align="center" class="f_14_grey">���ѽ�������Ŀ�ķ��ã�������ʷ�ɷѼ�¼�в�ѯ��</td></tr>	
			<% Response.Cookies("State")=0 %>
		</table>
	<%
	Else
		Dim IsReady
		IsReady=objSOAPClient.IsCanNetPay
		If IsReady<>"OK" Then
		'��������δ׼���ã������Խ�������֧����
		%>
			<table width="698" border="0" cellspacing="0" cellpadding="0">
				<tr><td width="80%" height="40" align="center" class="f_14_grey">���ڲ����Խ�������֧��������ԭ��</td></tr>
				<tr><td width="80%" height="40" align="center" class="f_14_grey"><%=IsReady%></td></tr>
			</table>
	   <%
		Else
		'��������׼���ã����Խ�������֧��		
			IF (Trim(Request.Cookies("CooStuState"))<>"�ڼ�") and (Trim(Request.Cookies("CooStuState"))<>"����") Then
			'��������ڼ���ѧ��������ɷ�
			%>
				<table width="698" border="0" cellspacing="0" cellpadding="0">
					<tr><td height="30" align="right" class="f_14_grey">&nbsp;</td>
						 <td height="30" class="f_14_grey">����ѧ�������ڼ�״̬������ϵ����ѧ���ơ�����ǰ��ѧ��״̬Ϊ��<%=Trim(Request.Cookies("CooStuState"))%></td>
					</tr>
				</table>
			<%
			Else
			'ѧ��״̬���������Խɷ�
						
				'ȡ�õ�ǰӦ�ɷ���Ϣ����ϸXML��ʽ����		
				Dim XmlPayInfo,XmlDetailInfo,XmlFileName
				
				'ͨ�����֤�Ż�ȡѧ��Ӧ�ɷ���Ϣ
				If Request.Cookies("StuSfzh")<>"" Then  
	 				StuSfzh=Request.Cookies("StuSfzh")
					XmlPayInfo=objSOAPClient.GetToPayInfoBySfzh(StuSfzh)
					XmlDetailInfo=objSOAPClient.GetToPayDeltaInfoBySfzh(StuSfzh)
				End If
   
				'ͨ��ѧ�Ż�ȡѧ��Ӧ�ɷ���Ϣ
				If Request.Cookies("StudentNo")<>"" Then  
					StudentNo=Request.Cookies("StudentNo")
					XmlPayInfo=objSOAPClient.GetToPayInfoByXH(StudentNo)
					XmlDetailInfo=objSOAPClient.GetToPayDeltaInfoByXH(StudentNo)
				End If					
				
				'response.write Server.HtmlEnCode(XmlDetailInfo)
				response.Cookies("DetailInfo")=XmlDetailInfo
'				response.write Server.HtmlEnCode(request.Cookies("DetailInfo"))
				
'				XmlFileName=Server.MapPath("SXmlDetailTemp.xml")	
'			   Call CreateXmlFile(XmlFileName,XmlDetailInfo)
				
				Dim objXml,objNode,objAtr,Sfbz					
				Set objXml=Server.CreateObject("Microsoft.XMLDOM") 
				objXml.Async=False
							
				IF objXml.loadXML(XmlPayInfo) Then
				'���ؽɷ���ϢXML����
					Set objNode = objXml.documentElement.selectSingleNode("ROWDATA")
					set objAtr=objNode.ChildNodes.item(0) 	
					If objAtr is nothing Then						
					%>
						<TR>
							<TD height="30">��ǰû��Ӧ�ɷ���Ϣ��</TD>
						</TR>
					<%
					Else
						'�нɷ���ϢXML����
						If objAtr.GetAttributeNode("xF4") is nothing Then
							Response.Write("<table width=698 border=0 cellspacing=0 cellpadding=0><tr><td height=30 align=right class=f_14_grey>&nbsp;</td><td height=30 class=f_14_grey>��ǰû��Ӧ�ɷ���Ϣ��</td></tr></table>")
						Else
							'Sfmc=trim(objAtr.GetAttributeNode("xF5").Value)
							'Sfmc=trim(objAtr.GetAttributeNode("�շ���Ŀ").Value)
							Sfbz=trim(objAtr.GetAttributeNode("xF6").Value)
							'Sfbz=trim(objAtr.GetAttributeNode("�շѱ�׼").Value)
							Response.Cookies("sfbz")=sfbz
							If Sfmc<>"" and Sfbz<>"" Then 
								Set objXml=Nothing
								Set objNode=Nothing
								Set objAtr=Nothing
								
								Dim nCntChd,nCntAtr,i
								Set objXml=Server.CreateObject("Microsoft.XMLDOM") 
								objXml.Async=False
								if not objXml.loadXML(XmlDetailInfo) then
									Response.Write("��ȡ��ϸ�շѱ�׼ʧ�ܣ�")
									Response.End()
								End if
								Set objNode = objXml.documentElement.selectSingleNode("ROWDATA")					
								nCntChd=objNode.ChildNodes.length-1 												
								%>
									<table width="698" border="0" cellspacing="0" cellpadding="0">
										<form name="myform" id="myform" method="post" action="confirmorder.asp">
										<tr>
											<td width="20%" height="30" align="right" class="f_14_grey">&nbsp;</td>
											<td width="53%" height="30" valign="middle" class="f_14_red">��ǰӦ�ɷ���Ϣ��</td>
											</tr>
										<tr>
											<td height="30" align="right" class="f_14_grey">�շ����ƣ�</td>
											<td height="30" class="f_14_grey">
<!--
											<input name="sfmc" type="text" id="sfmc" value="<%=sfmc%>" size="25" readonly="True"/>
//-->
											<%=jfxn%><%=sfmc%>
											</td>
											</tr>
										<tr>
											<td height="30" align="right" class="f_14_grey">�շѱ�׼��</td>
											<td height="30" class="f_14_grey">
<!--
											<input name="sfbz" type="text" id="sfbz" value="<%=sfbz%>" size="25" readonly="True" />
//-->
											<label id="sfbz"><%=sfbz%></label>
											</td>
											</tr>
										<tr>
											<td height="30" align="right" class="f_14_grey">����ϸ���£�</td>
											<td height="30" class="f_14_grey">&nbsp;</td>
											</tr>
										<%
										for i=0 to nCntChd
											set objAtr=objNode.ChildNodes.item(i) 		
										%>
											<% 
											Dim IsFixed,FeeTmp,ChangedXml,NameTmp
											IsFixed=objAtr.GetAttributeNode("xF5").Value
											FeeTmp=objAtr.GetAttributeNode("xF3").Value
											sfxm=objAtr.GetAttributeNode("xF2").Value
											'IsFixed=objAtr.GetAttributeNode("�̶��շ�").Value
											'sfxm=objAtr.GetAttributeNode("�շ���Ŀ").Value
											'FeeTmp=objAtr.GetAttributeNode("�շѱ�׼").Value
											NameTmp="sfje"
											If IsFixed Then
											%>
											<tr>
				 								<td height="30" align="right" class="f_14_grey"><%=sfxm %>��</td>
												<td height="30" class="f_14_grey">
<!--												<input name=<%=NameTmp&cstr(i)%> type=text id=<%=NameTmp&cstr(i)%> value=<%=FeeTmp %> readonly="true" /><span class="f_14_red">������Ϊ�̶��շѣ������޸ġ���</span>
//-->
												<%=FeeTmp %>
												</td>
											</tr>											
											<% 
											Else	
											%>
										   <tr>
												<td height="30" align="right" class="f_14_grey"><%=sfxm %>��</td>
												<td height="30" class="f_14_grey">												
												<input name=<%=NameTmp&cstr(i)%> id=<%=NameTmp&cstr(i)%> type=text value=<%=FeeTmp %> onkeyup="UpdateTotalJe(<%=sfbz%>-<%=FeeTmp %>+parseFloat(this.value));" />
												</td>
											</tr>	
											<% 
											End If
											%>
											</tr>
										<%
										next
										Set objXml=Nothing
										Set objNode=Nothing
										Set objAtr=Nothing
										%>
										<input name=sfCount type=hidden value=<%=i%>>
										<tr>
											<td align="right">&nbsp;</td>
											<td><INPUT type=button class=button id=create value=���ɶ��� onclick=CreateOrder();></td>
											</tr>
									</form>
									</table>
								<%
								Else
									Response.Write("<table width=698 border=0 cellspacing=0 cellpadding=0><tr><td height=30 align=right class=f_14_grey>&nbsp;</td><td height=30 class=f_14_grey>��ǰû��Ӧ�ɷ���Ϣ��</td></tr></table>")
								End If
							End If
						End If
				Else
				%>
				<table width="698" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td height="30" align="right" class="f_14_grey">&nbsp;</td>
						<td height="30" class="f_14_grey">��ǰû��Ӧ�ɷ���Ϣ��</td>
					</tr>
				</table>
				<%
				End If
			End If
		End If
	End If
	%>
</DIV>
