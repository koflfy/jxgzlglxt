<!-- #include file="inc/WebSvcURL.asp" -->
<!-- #include file="inc/function.asp" -->
<link href="images/style.css" type="text/css" rel="stylesheet"/>
<%
    Dim jfid,TeacherSfzh
	jfid=Request.QueryString("jfid")
	TeacherSfzh=Request.Cookies("TeacherSfzh")
	
	'取得指定单号的缴费明细		
	Dim XmlDetailInfo,XmlFileName
	XmlDetailInfo=objSOAPClient.GetPaidDeltaInfoById(jfid)

'   XmlFileName=Server.MapPath("paiddetailTemp.xml")
'	CreateXmlFile XmlFileName,XmlDetailInfo
	
	Dim objDom,objNode,objAtr,nCntChd,i
	Set objDom=Server.CreateObject("Microsoft.XMLDOM") 
	objDom.Async=False
	
	If objDom.loadXML(XmlDetailInfo) Then    '把XML字符串读入内存
		set objnode=objDom.documentElement.SelectSingleNode("//ROWDATA")
		nCntChd=objNode.ChildNodes.length-1
	%>
		<Table width="207" border="0" cellpadding="0" cellspacing="0">
			<tr><td colspan="2" height="30" class="f_14_orange">本次交费项目明细如下：</td></tr>
	<%	
		for i=0 to nCntChd
			set objAtr=objNode.ChildNodes.item(i) 		
	%>
			<tr>
			<td width="44%" height="30" align="right" class="f_14_grey" nowrap="nowrap"><%=objAtr.GetAttributeNode("xF2").Value %>：</td>
			<td width="56%" nowrap="nowrap" class="f_14_grey"><%=objAtr.GetAttributeNode("xF3").Value %></td>
			</tr>
	<%
		next

		Set objAtr=Nothing
		Set objNode=Nothing 
		Set objDom=Nothing
	Else
		Response.Write("没有该项缴费明细信息。")
	End If
	%>
	</Table>