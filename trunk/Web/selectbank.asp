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
'��ȡ����������Ϣ

%>
<%
function getTranDataXML
		orderId=JfId 
		'���ж��������������ҵķ�Ϊ��λ�ģ�������ԪΪ��λ���ʱ��� X*100       									'������ţ��ɷ���ˮ�ţ�
		amount=sfbz*100          									'�������ɷѱ�׼��
		orderDate = getCurTimeStr								'�ɷ�ʱ��
		'orderDate = gbDebugDate & mid(orderDate,9)   			'������ʱ��
	 	'�̻�����	
		'merID = "4000EC23386693"		
		merID=objSOAPClient.GetUserDM							'�̻�����
		'�̻��˺�					
		'merAcct = "4000023029200124946"	
		merAcct=objSOAPClient.GetUserAccount					'�̻��˺�
		goodsID = "001"											'��Ʒ���
		goodsName = jfxn&sfmc 				'��Ʒ����
		goodsNum = "1"											'��Ʒ����
		carriageAmt = amount									'�Ѻ��˷ѽ��
		merHint = "�����������ķ�����"&jfxn&sfmc             	'�̳���ʾ(ѡ��)
		remark1 = "remark1"										'��ע�ֶ�1(ѡ��)
		remark2 = "remark2"										'��ע�ֶ�2(ѡ��)
		merURL  = gbBackUrl&"PayReceive.asp"
		merVAR  = "netpay"										'�����̻�����(ѡ��)
		getTranDataXML = "<?xml version="&Chr(34)&"1.0"&Chr(34)&" encoding="&Chr(34)&"GBK"&Chr(34)&" standalone="&Chr(34)&"no"&Chr(34)&"?><B2CReq><interfaceName>ICBC_PERBANK_B2C</interfaceName><interfaceVersion>1.0.0.3</interfaceVersion><orderInfo><orderDate>"&orderDate&"</orderDate><orderid>"&orderID&"</orderid><amount>"&amount&"</amount><curType>001</curType><merID>"&merID&"</merID><merAcct>"&merAcct&"</merAcct></orderInfo><custom><verifyJoinFlag>0</verifyJoinFlag><Language>ZH_CN</Language></custom><message><goodsID>"&goodsID&"</goodsID><goodsName>"&goodsName&"</goodsName><goodsNum>"&goodsNum&"</goodsNum><carriageAmt>"&carriageAmt&"</carriageAmt><merHint>"&merHint&"</merHint><remark1>"&remark1&"</remark1><remark2>"&remark2&"</remark2><merURL>"&merURL&"</merURL><merVAR>"&merVAR&"</merVAR></message></B2CReq>"
end function
%>

<title>������������</title>
</head>
<body>
<DIV id=payfrm>
<%
	'����������������
		Dim orderDate,orderId,amount,merID,merAcct,goodsID,goodsName,goodsNum,carriageAmt,merHint,merURL,remark1,remark2,merVAR	
		Dim bb,rc,xmlStr				
		Dim tranData													'��������
		Dim merSignMsg												'����ǩ������
		Dim merCert														'�̳�֤�鹫Կ
		Dim BankSrvUrl
		BankSrvUrl=objSOAPClient.GetBankSrvUrl        '���нӿ�
'		BankSrvUrl="PayReceive.asp"										'���������ύֻ���Ա��ؽ��ף��������

		Set bb = CreateObject("ICBCEBANKUTIL.B2CUtil")	
'		ebb2cpublic.crt�������Ҫ��֤���ѵ�ǩ�������Ƿ�ɹ����������̻�֤������������֤�飬�Ա�����ѵ�ǩ�����ݽ�����ǩ	
'		init(
'			BSTR certFN,����֤���ļ���
'			BSTR certFNM,�̻�֤���ļ���
'			BSTR keyFN,˽Կ�ļ���
'			BSTR key˽Կ��������
'			)
'		rc=bb.init (Server.Mappath("bank/ebb2cpublic.crt"),Server.Mappath("bank/ectest01.crt"),Server.Mappath("bank/ectest01.key"),"12345678")
		rc=bb.init (Server.Mappath("bank/ebb2cpublic.crt"),Server.Mappath("bank/user.crt"),Server.Mappath("bank/user.key"),"37214728")
		if rc <> 0 then
%>
		<table id=table_return width="698" cellpadding="0" cellspacing="1">
			<tr><td height="30" class="f_14_orange" align="center">��ʾ��Ϣ</td></tr>	
			<tr><td height="50" valign="top" align="center">���нӿڳ�ʼ��ʧ�ܡ�</td></tr>
			<tr><td align="center" valign="top"><input type="button" name="close" value="�رմ���" onClick="javascript:window.close()"/></td></tr>		
		</table>
<%		
		end if	
	
		xmlStr=getTranDataXML

		tranData = base64Encode(xmlStr) 					'�Խ������ݽ���BASE64����
		'	response.write "Base64������XML��<br>"
		'	response.write tranData & "<br>"
			
		'	response.write "Base64������XML��<br>"
		'	response.write Server.HtmlEnCode(base64Decode(tranData)) & "<br>"
			
		'�Զ���ǩ�����ݽ���ǩ�������ص����Ѿ�����BASE64����������
		merSignMsg = bb.signC(xmlStr, Len(xmlStr))
		If merSignMsg = "" Then
%>
		<table id=table_return width="698" cellpadding="3" cellspacing="1">
			<tr><td height="30" class="f_14_orange" align="center">��ʾ��Ϣ</td></tr>	
			<tr><td height="50" valign="top" align="center">ǩ��ʧ�ܣ�����ԭ��<%=bb.getRC%></td></tr>
			<tr><td align="center" valign="top"><input type="button" name="close" value="�رմ���" onClick="javascript:window.close()"/></td></tr>	
		</table>
<%	
		End If
		'��ȡ�̻�֤��
		merCert=bb.getCert(1)
		If merCert = "" Then
%>
		<table id=table_return width="698" cellpadding="3" cellspacing="1">
			<tr><td height="30" class="f_14_orange" align="center">��ʾ��Ϣ</td></tr>	
			<tr><td height="50" valign="top" align="center">��ȡ�̻�֤��ʧ�ܣ�����ԭ��<%=bb.getRC%></td></tr>
			<tr><td align="center" valign="top"><input type="button" name="close" value="�رմ���" onClick="javascript:window.close()"/></td></tr>		
		</table>
<%
		End If
%>		
		<table id="c1" width="698" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="20%" height="30" align="right" class="f_14_grey">&nbsp;</td>
				<td width="53%" height="30"><span class="f_14_red">������˶������ύ�����е���Ϣ��</span></td>
			</tr>
			<tr>
				<td height="30" align="right" class="f_14_grey">�ɷѵ��ţ�</td>
				<td height="30" class="f_14_grey"><% =orderId %></td>
			</tr>
			
			<tr>
				<td height="30" align="right" class="f_14_grey">Ӧ�ɷѽ�</td>
				<td height="30" class="f_14_grey"><%=formatNumber(sfbz,2)%>Ԫ</td>
			</tr>
			<tr>
				<td height="30" align="right"  class="f_14_grey">ѡ�����У�</td>
				<td  class="f_14_grey"><input name="radiobutton" type="radio" value="radiobutton" checked="checked" />
		  					��������<br />
		  					�������ȷ��֧������ť�󣬽����빤������֧�����档��</td>
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
				<td><input name="bank" type="button" value="������������֧��"  onclick="Gobank();" /></td>
			</tr>
			</form>
		</table>

<% '=====================================================��ͬ����ָ���====================================================================== %>

	  <table id="c2" style="display:none" class=border cellSpacing=1 cellPadding=2 width="80%" align=center border=0>
		<tr class=title>
		  <td align=middle height=22  class="f_14_orange"><B> �� ʾ �� Ϣ</B></td>
			</tr>
			<tr class=tdbg>
			  <td align=center height="40"  class="f_14_grey"><label id="PromptInfo">�𾴵��û��������ڵ�����ҳ���м�������֧���ͳ�ֵ�������벻Ҫ�رձ����ڡ�</label></td>
			</tr>
			<tr class=tdbg>
			  <td align=center height="30">
			  <form name="getstate" id="getstate" action="paystate.asp" method="post" target="_self">
			  <input name="ask" type="submit" value="�鿴����״̬" />
			  </form>
			  </td>
			</tr>			
     </table>
	 
</DIV>
</body>