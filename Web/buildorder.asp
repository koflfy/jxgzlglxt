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
	 
//也可以直接下面这样：
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

<title>生成订单</title>
	<style type="text/css">
<!--
.STYLE1 {color: #D4D0C8}
-->
	</style>
	<DIV id=payfrm>		
	<%
	Dim IsPaid,sfmc,sfxm,jfxn,StuSfzh,StudentNo
	'判断是否已缴费
	jfxn=trim(objSOAPClient.GetCurToPayXn)
	sfmc=trim(objSOAPClient.GetCurToPayName)
	Response.Cookies("jfxn")=jfxn
	Response.Cookies("sfmc")=sfmc
	
	'通过身份证号获取学生是否已缴费信息
	If Request.Cookies("StuSfzh")<>"" Then  
	 	StuSfzh=Request.Cookies("StuSfzh")
		IsPaid=objSOAPClient.StuIsPaidBySfzh(StuSfzh,jfxn,sfmc)
	 End If
   
	'通过学号获取学生是否已缴费信息
	If Request.Cookies("StudentNo")<>"" Then  
	 	StudentNo=Request.Cookies("StudentNo")
		IsPaid=objSOAPClient.StuIsPaidByXH(StudentNo,jfxn,sfmc)
	End If
	
	If  IsPaid Then
	%>
		<table width="698" border="0" cellspacing="0" cellpadding="0">
			<tr><td width="80%" height="40" align="center" class="f_14_grey">当前正在进行<%=jfxn%><%=sfmc%>的收取。</td></tr>	
			<tr><td width="80%" height="40" align="center" class="f_14_grey">您已交过该项目的费用，请在历史缴费记录中查询。</td></tr>	
			<% Response.Cookies("State")=0 %>
		</table>
	<%
	Else
		Dim IsReady
		IsReady=objSOAPClient.IsCanNetPay
		If IsReady<>"OK" Then
		'服务器等未准备好，不可以进行网上支付。
		%>
			<table width="698" border="0" cellspacing="0" cellpadding="0">
				<tr><td width="80%" height="40" align="center" class="f_14_grey">现在不可以进行网上支付，错误原因：</td></tr>
				<tr><td width="80%" height="40" align="center" class="f_14_grey"><%=IsReady%></td></tr>
			</table>
	   <%
		Else
		'服务器等准备好，可以进行网上支付		
			IF (Trim(Request.Cookies("CooStuState"))<>"在籍") and (Trim(Request.Cookies("CooStuState"))<>"新生") Then
			'如果不是在籍的学生则不允许缴费
			%>
				<table width="698" border="0" cellspacing="0" cellpadding="0">
					<tr><td height="30" align="right" class="f_14_grey">&nbsp;</td>
						 <td height="30" class="f_14_grey">您的学籍不是在籍状态，请联系教务处学籍科。您当前的学籍状态为：<%=Trim(Request.Cookies("CooStuState"))%></td>
					</tr>
				</table>
			<%
			Else
			'学籍状态正常，可以缴费
						
				'取得当前应缴费信息和明细XML格式数据		
				Dim XmlPayInfo,XmlDetailInfo,XmlFileName
				
				'通过身份证号获取学生应缴费信息
				If Request.Cookies("StuSfzh")<>"" Then  
	 				StuSfzh=Request.Cookies("StuSfzh")
					XmlPayInfo=objSOAPClient.GetToPayInfoBySfzh(StuSfzh)
					XmlDetailInfo=objSOAPClient.GetToPayDeltaInfoBySfzh(StuSfzh)
				End If
   
				'通过学号获取学生应缴费信息
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
				'加载缴费信息XML数据
					Set objNode = objXml.documentElement.selectSingleNode("ROWDATA")
					set objAtr=objNode.ChildNodes.item(0) 	
					If objAtr is nothing Then						
					%>
						<TR>
							<TD height="30">当前没有应缴费信息。</TD>
						</TR>
					<%
					Else
						'有缴费信息XML数据
						If objAtr.GetAttributeNode("xF4") is nothing Then
							Response.Write("<table width=698 border=0 cellspacing=0 cellpadding=0><tr><td height=30 align=right class=f_14_grey>&nbsp;</td><td height=30 class=f_14_grey>当前没有应缴费信息。</td></tr></table>")
						Else
							'Sfmc=trim(objAtr.GetAttributeNode("xF5").Value)
							'Sfmc=trim(objAtr.GetAttributeNode("收费项目").Value)
							Sfbz=trim(objAtr.GetAttributeNode("xF6").Value)
							'Sfbz=trim(objAtr.GetAttributeNode("收费标准").Value)
							Response.Cookies("sfbz")=sfbz
							If Sfmc<>"" and Sfbz<>"" Then 
								Set objXml=Nothing
								Set objNode=Nothing
								Set objAtr=Nothing
								
								Dim nCntChd,nCntAtr,i
								Set objXml=Server.CreateObject("Microsoft.XMLDOM") 
								objXml.Async=False
								if not objXml.loadXML(XmlDetailInfo) then
									Response.Write("获取明细收费标准失败！")
									Response.End()
								End if
								Set objNode = objXml.documentElement.selectSingleNode("ROWDATA")					
								nCntChd=objNode.ChildNodes.length-1 												
								%>
									<table width="698" border="0" cellspacing="0" cellpadding="0">
										<form name="myform" id="myform" method="post" action="confirmorder.asp">
										<tr>
											<td width="20%" height="30" align="right" class="f_14_grey">&nbsp;</td>
											<td width="53%" height="30" valign="middle" class="f_14_red">当前应缴费信息：</td>
											</tr>
										<tr>
											<td height="30" align="right" class="f_14_grey">收费名称：</td>
											<td height="30" class="f_14_grey">
<!--
											<input name="sfmc" type="text" id="sfmc" value="<%=sfmc%>" size="25" readonly="True"/>
//-->
											<%=jfxn%><%=sfmc%>
											</td>
											</tr>
										<tr>
											<td height="30" align="right" class="f_14_grey">收费标准：</td>
											<td height="30" class="f_14_grey">
<!--
											<input name="sfbz" type="text" id="sfbz" value="<%=sfbz%>" size="25" readonly="True" />
//-->
											<label id="sfbz"><%=sfbz%></label>
											</td>
											</tr>
										<tr>
											<td height="30" align="right" class="f_14_grey">其明细如下：</td>
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
											'IsFixed=objAtr.GetAttributeNode("固定收费").Value
											'sfxm=objAtr.GetAttributeNode("收费项目").Value
											'FeeTmp=objAtr.GetAttributeNode("收费标准").Value
											NameTmp="sfje"
											If IsFixed Then
											%>
											<tr>
				 								<td height="30" align="right" class="f_14_grey"><%=sfxm %>：</td>
												<td height="30" class="f_14_grey">
<!--												<input name=<%=NameTmp&cstr(i)%> type=text id=<%=NameTmp&cstr(i)%> value=<%=FeeTmp %> readonly="true" /><span class="f_14_red">（该项为固定收费，不可修改。）</span>
//-->
												<%=FeeTmp %>
												</td>
											</tr>											
											<% 
											Else	
											%>
										   <tr>
												<td height="30" align="right" class="f_14_grey"><%=sfxm %>：</td>
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
											<td><INPUT type=button class=button id=create value=生成订单 onclick=CreateOrder();></td>
											</tr>
									</form>
									</table>
								<%
								Else
									Response.Write("<table width=698 border=0 cellspacing=0 cellpadding=0><tr><td height=30 align=right class=f_14_grey>&nbsp;</td><td height=30 class=f_14_grey>当前没有应缴费信息。</td></tr></table>")
								End If
							End If
						End If
				Else
				%>
				<table width="698" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td height="30" align="right" class="f_14_grey">&nbsp;</td>
						<td height="30" class="f_14_grey">当前没有应缴费信息。</td>
					</tr>
				</table>
				<%
				End If
			End If
		End If
	End If
	%>
</DIV>
