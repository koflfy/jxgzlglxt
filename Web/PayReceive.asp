<!-- #include file="inc/WebSvcURL.asp" -->
<!-- #include file="inc/security.asp" -->
<!-- #include file="inc/function.asp" -->
<html>
<head><title>交费后返回商户页面处理</title></head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<link href="images/style.css" type="text/css" rel="stylesheet"/>
<% 
'Response.Cookies("TeacherNo")="0744201200001"

'If Request.Cookies("TeacherSfzh")=""  Then
	'Response.Redirect("login.asp")
'End If
%>
<body>
<center>
<div id=r_data2>
	<DIV id=r_top2></DIV><!--标题图片 -->
<%
	Dim bb,rc,XmlPaidDetail
	Dim xmlReceiveStr
	Dim merVAR,notifyData,signMsg
	'以下变量是为了取出银行返回的notifyData数据中的内容而定义的变量				
	Dim orderDate,orderID,amount,tranSerialNo,notifyDate,tranStat,comment
	Dim PromptInfo,sMemo

	'***********************开始取出银行返回的表单内容，并解码************************
	merVAR = request.form("merVAR")				'用户自定义的变量数据
	notifyData = request.form("notifyData")		'银行返回的交易结果数据
	signMsg = request.form("signMsg")
	'signMsg是银行返回的签名数据，用来对交易结果数据进行验证签名之用，除此之外，暂无它用
	
	If merVAR<>"" Then                  '如果有数据
	
		Set bb = CreateObject("ICBCEBANKUTIL.B2CUtil")
		rc=bb.init (Server.Mappath("bank/ebb2cpublic.crt"),Server.Mappath("bank/ectest01.crt"),Server.Mappath("bank/ectest01.key"),"12345678")
		
		if rc <> 0 then
	%>
			<table id=table_return width="698" cellpadding="3" cellspacing="1">
			<tr><td height="30" valign="top" align="center">初始化失败。</td></tr></table>
  <%
		end if		
		
		xmlReceiveStr = base64DeCode(notifyData) 					'对交易数据进行BASE64解码
		
		'验证签名是否成功，只有返回的银行数据才需要验签
		rc=bb.verifySignC(xmlReceiveStr, Len(xmlReceiveStr), signMsg, Len(signMsg))
		If rc <>0 Then
		%>
			<table id=table_return width="698" cellpadding="3" cellspacing="1">
			<tr><td height="30" valign="top" align="center">验证签名失败，错误原因：<%=rc%></td></tr></table>
  		<%
		Else
	'******************************结束取数据*************************************	
			Dim objXml,objNode,objAtr
			Dim bank_orderId,bank_amount
			Set objXml=Server.CreateObject("Microsoft.XMLDOM") 
			objXml.Async=False	
			objXml.loadXML(xmlReceiveStr)
			
			Set objNode = objXml.documentElement.selectSingleNode("//B2CRes")
			
			bank_orderId=objNode.childNodes.item(2).childNodes.item(1).text	
			bank_amount=objNode.childNodes.item(2).childNodes.item(2).text		   
			bank_amount=bank_amount/100	'银行返回的金额是人民币【分】为计量单位的，必须转换为以人民币【元】为单位。		   
			TranSerialNo=objNode.childNodes.item(4).childNodes.item(0).text		
			tranStat=objNode.childNodes.item(4).childNodes.item(2).text		
			
		End If
	Else
		tranStat = -1
		PromptInfo="<tr><td valign=top align=center>银行返回数据为空，交易失败！</td></tr>"
'		Response.Write("银行返回数据为空，交易失败！")
'		Response.End()
	End If
'******************************根据银行返回交易状态更新本地数据库*************************************
	%>
			<table id=table_return width="698" cellpadding="3" cellspacing="1">
			<tr><td height="40" class="f_14_orange" valign="middle" align="center">网上支付反馈情况</td></tr>
			<%
			sMemo = "本地交易流水号："&Request.Cookies("OrderId")	'为了便于银行对帐，请把本地流水号作为备注字段写入数据库中
			
	'		Response.Write(tranStat)
	'		Response.Write(bank_orderId)&"&nbsp;"&Request.Cookies("OrderId")
	'		Response.Write(bank_amount)&"&nbsp;"&Request.Cookies("sfbz")	
	'      		TranSerialNo="1234567890123456789"
	'		tranStat=1
	'		bank_amount=Request.Cookies("sfbz")

			Dim TeacherNo,TeacherSfzh,sMsg 
			if (tranStat=1) or (tranStat=3) then
					XmlPaidDetail=Request.Cookies("DetailInfo")
					TeacherNo = Request.Cookies("TeacherNo")
					TeacherSfzh   = Request.Cookies("TeacherSfzh")
					
					'通过学号缴费
					If TeacherNo<>"" Then  
						sMsg=objSOAPClient.NetPayByXH(TeacherNo,bank_amount,TranSerialNo,tranStat,XmlPaidDetail,sMemo)
					'通过身份证号缴费
					ElseIf TeacherSfzh<>"" Then  
						sMsg=objSOAPClient.NetPayBySfzh(TeacherSfzh,bank_amount,TranSerialNo,tranStat,XmlPaidDetail,sMemo)	
					End If
			End if
			dim sHint
			sHint = ""
			Select Case tranStat
				Case 1  
					If sMsg=True Then
						sHint = "本次交易成功！请查询您的帐户余额和历史缴费记录！"
					Else
						sHint = "银行交易成功，但本地缴费未入库，请与深圳电大财务处联系！"
					End If
				Case 2
					sHint = ""
					PromptInfo="<tr><td valign=top align=center>本次交易失败，请重新缴费！</td></tr>"
				Case 3
					If sMsg=True Then
						sHint = "银行交易可疑，但本地缴费已入库，请查询您的帐户余额或与工行联系！"
					Else
						sHint = "银行交易可疑，且本地缴费未入库，请查询您的帐户余额或与工行联系！"
					End If
			End Select
			
			If sHint<>"" Then
				PromptInfo="<tr><td valign=top align=left>"&sHint&"<br>交易订单号为："&bank_orderId&"，<br>银行流水号为："&TranSerialNo&"，<br>交易总金额为：￥"&FormatNumber(bank_amount,2)&"元</td></tr>"
			End If
			
			Response.Write(PromptInfo)			
		%>
			</table>
</div>
<div id=bottom2></div>
</body></html>