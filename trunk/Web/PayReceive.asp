<!-- #include file="inc/WebSvcURL.asp" -->
<!-- #include file="inc/security.asp" -->
<!-- #include file="inc/function.asp" -->
<html>
<head><title>���Ѻ󷵻��̻�ҳ�洦��</title></head>
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
	<DIV id=r_top2></DIV><!--����ͼƬ -->
<%
	Dim bb,rc,XmlPaidDetail
	Dim xmlReceiveStr
	Dim merVAR,notifyData,signMsg
	'���±�����Ϊ��ȡ�����з��ص�notifyData�����е����ݶ�����ı���				
	Dim orderDate,orderID,amount,tranSerialNo,notifyDate,tranStat,comment
	Dim PromptInfo,sMemo

	'***********************��ʼȡ�����з��صı����ݣ�������************************
	merVAR = request.form("merVAR")				'�û��Զ���ı�������
	notifyData = request.form("notifyData")		'���з��صĽ��׽������
	signMsg = request.form("signMsg")
	'signMsg�����з��ص�ǩ�����ݣ������Խ��׽�����ݽ�����֤ǩ��֮�ã�����֮�⣬��������
	
	If merVAR<>"" Then                  '���������
	
		Set bb = CreateObject("ICBCEBANKUTIL.B2CUtil")
		rc=bb.init (Server.Mappath("bank/ebb2cpublic.crt"),Server.Mappath("bank/ectest01.crt"),Server.Mappath("bank/ectest01.key"),"12345678")
		
		if rc <> 0 then
	%>
			<table id=table_return width="698" cellpadding="3" cellspacing="1">
			<tr><td height="30" valign="top" align="center">��ʼ��ʧ�ܡ�</td></tr></table>
  <%
		end if		
		
		xmlReceiveStr = base64DeCode(notifyData) 					'�Խ������ݽ���BASE64����
		
		'��֤ǩ���Ƿ�ɹ���ֻ�з��ص��������ݲ���Ҫ��ǩ
		rc=bb.verifySignC(xmlReceiveStr, Len(xmlReceiveStr), signMsg, Len(signMsg))
		If rc <>0 Then
		%>
			<table id=table_return width="698" cellpadding="3" cellspacing="1">
			<tr><td height="30" valign="top" align="center">��֤ǩ��ʧ�ܣ�����ԭ��<%=rc%></td></tr></table>
  		<%
		Else
	'******************************����ȡ����*************************************	
			Dim objXml,objNode,objAtr
			Dim bank_orderId,bank_amount
			Set objXml=Server.CreateObject("Microsoft.XMLDOM") 
			objXml.Async=False	
			objXml.loadXML(xmlReceiveStr)
			
			Set objNode = objXml.documentElement.selectSingleNode("//B2CRes")
			
			bank_orderId=objNode.childNodes.item(2).childNodes.item(1).text	
			bank_amount=objNode.childNodes.item(2).childNodes.item(2).text		   
			bank_amount=bank_amount/100	'���з��صĽ��������ҡ��֡�Ϊ������λ�ģ�����ת��Ϊ������ҡ�Ԫ��Ϊ��λ��		   
			TranSerialNo=objNode.childNodes.item(4).childNodes.item(0).text		
			tranStat=objNode.childNodes.item(4).childNodes.item(2).text		
			
		End If
	Else
		tranStat = -1
		PromptInfo="<tr><td valign=top align=center>���з�������Ϊ�գ�����ʧ�ܣ�</td></tr>"
'		Response.Write("���з�������Ϊ�գ�����ʧ�ܣ�")
'		Response.End()
	End If
'******************************�������з��ؽ���״̬���±������ݿ�*************************************
	%>
			<table id=table_return width="698" cellpadding="3" cellspacing="1">
			<tr><td height="40" class="f_14_orange" valign="middle" align="center">����֧���������</td></tr>
			<%
			sMemo = "���ؽ�����ˮ�ţ�"&Request.Cookies("OrderId")	'Ϊ�˱������ж��ʣ���ѱ�����ˮ����Ϊ��ע�ֶ�д�����ݿ���
			
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
					
					'ͨ��ѧ�Žɷ�
					If TeacherNo<>"" Then  
						sMsg=objSOAPClient.NetPayByXH(TeacherNo,bank_amount,TranSerialNo,tranStat,XmlPaidDetail,sMemo)
					'ͨ�����֤�Žɷ�
					ElseIf TeacherSfzh<>"" Then  
						sMsg=objSOAPClient.NetPayBySfzh(TeacherSfzh,bank_amount,TranSerialNo,tranStat,XmlPaidDetail,sMemo)	
					End If
			End if
			dim sHint
			sHint = ""
			Select Case tranStat
				Case 1  
					If sMsg=True Then
						sHint = "���ν��׳ɹ������ѯ�����ʻ�������ʷ�ɷѼ�¼��"
					Else
						sHint = "���н��׳ɹ��������ؽɷ�δ��⣬�������ڵ�������ϵ��"
					End If
				Case 2
					sHint = ""
					PromptInfo="<tr><td valign=top align=center>���ν���ʧ�ܣ������½ɷѣ�</td></tr>"
				Case 3
					If sMsg=True Then
						sHint = "���н��׿��ɣ������ؽɷ�����⣬���ѯ�����ʻ������빤����ϵ��"
					Else
						sHint = "���н��׿��ɣ��ұ��ؽɷ�δ��⣬���ѯ�����ʻ������빤����ϵ��"
					End If
			End Select
			
			If sHint<>"" Then
				PromptInfo="<tr><td valign=top align=left>"&sHint&"<br>���׶�����Ϊ��"&bank_orderId&"��<br>������ˮ��Ϊ��"&TranSerialNo&"��<br>�����ܽ��Ϊ����"&FormatNumber(bank_amount,2)&"Ԫ</td></tr>"
			End If
			
			Response.Write(PromptInfo)			
		%>
			</table>
</div>
<div id=bottom2></div>
</body></html>