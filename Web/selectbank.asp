<!-- #include file="inc/WebSvcURL.asp" -->
<!-- #include file="inc/function.asp" -->
<!-- #include file="inc/security.asp" -->
<link href="images/style.css" type="text/css" rel="stylesheet"/>
<head>
<SCRIPT type=text/javascript>
<!--
function Gobank(){
	document.frmsend.submit();
	document.all.c1.style.display='none';
	document.all.c2.style.display='';
}
function ShowState(){
	document.all.c1.style.display='none';
	document.all.c2.style.display='';
	document.display_state.submit();
	return true;
}

//-->
</SCRIPT>
<%
Dim StudentNo,StuSfzh,sfmc,sfbz,JfId,jfxn
StuSfzh=Request.Cookies("StuSfzh")
StudentNo=Request.Cookies("StudentNo")
jfxn=Request.Cookies("jfxn")
sfmc=Request.Cookies("sfmc")
sfbz=Request.Cookies("sfbz")
JfId=Request.Cookies("OrderId")
'读取网银配置信息

%>
<%
function getTranDataXML
		orderId=JfId 
		'银行订单金额是以人民币的分为单位的，不是以元为单位，故必须 X*100       									'订单编号（缴费流水号）
		amount=sfbz*100          									'订单金额（缴费标准）
		orderDate = getCurTimeStr								'缴费时间
		'orderDate = gbDebugDate & mid(orderDate,9)   			'测试用时间
	 	'商户代码	
		'merID = "4000EC23386693"		
		merID=objSOAPClient.GetUserDM							'商户代码
		'商户账号					
		'merAcct = "4000023029200124946"	
		merAcct=objSOAPClient.GetUserAccount					'商户账号
		goodsID = "001"											'商品编号
		goodsName = jfxn&sfmc 				'商品名称
		goodsNum = "1"											'商品数量
		carriageAmt = amount									'已含运费金额
		merHint = "现在您所交的费用是"&jfxn&sfmc             	'商城提示(选输)
		remark1 = "remark1"										'备注字段1(选输)
		remark2 = "remark2"										'备注字段2(选输)
		merURL  = gbBackUrl&"PayReceive.asp"
		merVAR  = "netpay"										'返回商户变量(选输)
		getTranDataXML = "<?xml version="&Chr(34)&"1.0"&Chr(34)&" encoding="&Chr(34)&"GBK"&Chr(34)&" standalone="&Chr(34)&"no"&Chr(34)&"?><B2CReq><interfaceName>ICBC_PERBANK_B2C</interfaceName><interfaceVersion>1.0.0.3</interfaceVersion><orderInfo><orderDate>"&orderDate&"</orderDate><orderid>"&orderID&"</orderid><amount>"&amount&"</amount><curType>001</curType><merID>"&merID&"</merID><merAcct>"&merAcct&"</merAcct></orderInfo><custom><verifyJoinFlag>0</verifyJoinFlag><Language>ZH_CN</Language></custom><message><goodsID>"&goodsID&"</goodsID><goodsName>"&goodsName&"</goodsName><goodsNum>"&goodsNum&"</goodsNum><carriageAmt>"&carriageAmt&"</carriageAmt><merHint>"&merHint&"</merHint><remark1>"&remark1&"</remark1><remark2>"&remark2&"</remark2><merURL>"&merURL&"</merURL><merVAR>"&merVAR&"</merVAR></message></B2CReq>"
end function
%>

<title>生成银行数据</title>
</head>
<body>
<DIV id=payfrm>
<%
	'生成银行所需数据
		Dim orderDate,orderId,amount,merID,merAcct,goodsID,goodsName,goodsNum,carriageAmt,merHint,merURL,remark1,remark2,merVAR	
		Dim bb,rc,xmlStr				
		Dim tranData													'交易数据
		Dim merSignMsg												'订单签名数据
		Dim merCert														'商城证书公钥
		Dim BankSrvUrl
		BankSrvUrl=objSOAPClient.GetBankSrvUrl        '银行接口
'		BankSrvUrl="PayReceive.asp"										'不向银行提交只测试本地交易，请用这个

		Set bb = CreateObject("ICBCEBANKUTIL.B2CUtil")	
'		ebb2cpublic.crt，如果想要验证自已的签名数据是否成功，可以用商户证书来代替银行证书，以便对自已的签名数据进行验签	
'		init(
'			BSTR certFN,银行证书文件名
'			BSTR certFNM,商户证书文件名
'			BSTR keyFN,私钥文件名
'			BSTR key私钥保护口令
'			)
'		rc=bb.init (Server.Mappath("bank/ebb2cpublic.crt"),Server.Mappath("bank/ectest01.crt"),Server.Mappath("bank/ectest01.key"),"12345678")
		rc=bb.init (Server.Mappath("bank/ebb2cpublic.crt"),Server.Mappath("bank/user.crt"),Server.Mappath("bank/user.key"),"37214728")
		if rc <> 0 then
%>
		<table id=table_return width="698" cellpadding="0" cellspacing="1">
			<tr><td height="30" class="f_14_orange" align="center">提示信息</td></tr>	
			<tr><td height="50" valign="top" align="center">银行接口初始化失败。</td></tr>
			<tr><td align="center" valign="top"><input type="button" name="close" value="关闭窗口" onClick="javascript:window.close()"/></td></tr>		
		</table>
<%		
		end if	
	
		xmlStr=getTranDataXML

		tranData = base64Encode(xmlStr) 					'对交易数据进行BASE64编码
		'	response.write "Base64编码后的XML：<br>"
		'	response.write tranData & "<br>"
			
		'	response.write "Base64解码后的XML：<br>"
		'	response.write Server.HtmlEnCode(base64Decode(tranData)) & "<br>"
			
		'对订单签名数据进行签名，返回的是已经进行BASE64编码后的内容
		merSignMsg = bb.signC(xmlStr, Len(xmlStr))
		If merSignMsg = "" Then
%>
		<table id=table_return width="698" cellpadding="3" cellspacing="1">
			<tr><td height="30" class="f_14_orange" align="center">提示信息</td></tr>	
			<tr><td height="50" valign="top" align="center">签名失败，错误原因：<%=bb.getRC%></td></tr>
			<tr><td align="center" valign="top"><input type="button" name="close" value="关闭窗口" onClick="javascript:window.close()"/></td></tr>	
		</table>
<%	
		End If
		'获取商户证书
		merCert=bb.getCert(1)
		If merCert = "" Then
%>
		<table id=table_return width="698" cellpadding="3" cellspacing="1">
			<tr><td height="30" class="f_14_orange" align="center">提示信息</td></tr>	
			<tr><td height="50" valign="top" align="center">获取商户证书失败，错误原因：<%=bb.getRC%></td></tr>
			<tr><td align="center" valign="top"><input type="button" name="close" value="关闭窗口" onClick="javascript:window.close()"/></td></tr>		
		</table>
<%
		End If
%>		
		<table id="c1" width="698" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="20%" height="30" align="right" class="f_14_grey">&nbsp;</td>
				<td width="53%" height="30"><span class="f_14_red">请认真核对以下提交到银行的信息：</span></td>
			</tr>
			<tr>
				<td height="30" align="right" class="f_14_grey">缴费单号：</td>
				<td height="30" class="f_14_grey"><% =orderId %></td>
			</tr>
			
			<tr>
				<td height="30" align="right" class="f_14_grey">应缴费金额：</td>
				<td height="30" class="f_14_grey"><%=formatNumber(sfbz,2)%>元</td>
			</tr>
			<tr>
				<td height="30" align="right"  class="f_14_grey">选择银行：</td>
				<td  class="f_14_grey"><input name="radiobutton" type="radio" value="radiobutton" checked="checked" />
		  					工商银行<br />
		  					（点击“确认支付”按钮后，将进入工商银行支付界面。）</td>
		  	</tr>
<!--
			<form name="frmsend" id="frmsend" action="https://mybank3.dccnet.com.cn/servlet/NewB2cMerPayReqServlet" method="post" target="_blank">
//-->
			<form name="frmsend" id="frmsend" action=<%=BankSrvUrl%> method="post" target="_blank">

			<input name="interfaceName" type="hidden" value="ICBC_PERBANK_B2C" />
			<input name="interfaceVersion" type="hidden" value="1.0.0.3" />
			<input name="tranData" type="hidden" value=" <%=tranData%>" />
			<input name="merSignMsg" type="hidden" value=" <%=merSignMsg%>" />
			<input name="merCert" type="hidden" value=" <%=merCert%>" />
		  	<tr>
				<td height="30" align="right">&nbsp;</td>
				<td><input name="bank" type="button" value="工商银行在线支付"  onclick="Gobank();" /></td>
			</tr>
			</form>
		</table>

<% '=====================================================不同区域分隔线====================================================================== %>

	  <table id="c2" style="display:none" class=border cellSpacing=1 cellPadding=2 width="80%" align=center border=0>
		<tr class=title>
		  <td align=middle height=22  class="f_14_orange"><B> 提 示 信 息</B></td>
			</tr>
			<tr class=tdbg>
			  <td align=center height="40"  class="f_14_grey"><label id="PromptInfo">尊敬的用户，请您在弹出的页面中继续进行支付和充值操作，请不要关闭本窗口。</label></td>
			</tr>
			<tr class=tdbg>
			  <td align=center height="30">
			  <form name="getstate" id="getstate" action="paystate.asp" method="post" target="_self">
			  <input name="ask" type="submit" value="查看交易状态" />
			  </form>
			  </td>
			</tr>			
     </table>
	 
</DIV>
</body>