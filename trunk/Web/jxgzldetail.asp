<!-- #include file="inc/WebSvcURL.asp" -->
<!-- #include file="inc/function.asp" -->
<link href="images/style.css" type="text/css" rel="stylesheet"/>
<%
    Dim id,TeacherSfzh
	id=Request.QueryString("id")
	TeacherSfzh=Request.Cookies("TeacherSfzh")
	
	'ȡ��ָ������ŵļ�¼�ɷ���ϸ		
	Dim XmlDetailInfo,XmlFileName
	XmlDetailInfo=objSOAPClient.GetJxgzlDelta(id)

    XmlFileName=Server.MapPath("paiddetailTemp.xml")
	CreateXmlFile XmlFileName,XmlDetailInfo
	
	Dim objDom,objNode,objAtr,nCntChd,i
	Set objDom=Server.CreateObject("Microsoft.XMLDOM") 
	objDom.Async=False
	
	If objDom.loadXML(XmlDetailInfo) Then    '��XML�ַ��������ڴ�
		Set objNode = objDom.documentElement.selectSingleNode("ROWDATA")
		set objAtr=objNode.ChildNodes.item(0) 	
		
		dim txnxq,tgzlx,txkkh,tkcdm,tkcmc,tkcxz,tkclb,tkkxy,tskdx,trs,tzxs,tqzz,txss,tkxxs,tgmxs,tgzl
		if not (objAtr.GetAttributeNode("xnxq") is nothing) then
			txnxq=objAtr.GetAttributeNode("xnxq").Value
		end if
		if not (objAtr.GetAttributeNode("gzlx") is nothing) then
			tgzlx=objAtr.GetAttributeNode("gzlx").Value
		end if
		if not (objAtr.GetAttributeNode("xkkh") is nothing) then
			txkkh=objAtr.GetAttributeNode("xkkh").Value
		end if
		if not (objAtr.GetAttributeNode("kcdm") is nothing) then
			tkcdm=objAtr.GetAttributeNode("kcdm").Value
		end if
		if not (objAtr.GetAttributeNode("kcmc") is nothing) then
			tkcmc=objAtr.GetAttributeNode("kcmc").Value
		end if
		if not (objAtr.GetAttributeNode("kcxz") is nothing) then
			tkcxz=objAtr.GetAttributeNode("kcxz").Value
		end if
		if not (objAtr.GetAttributeNode("kclb") is nothing) then
			tkclb=objAtr.GetAttributeNode("kclb").Value
		end if
		if not (objAtr.GetAttributeNode("kkxy") is nothing) then
			tkkxy=objAtr.GetAttributeNode("kkxy").Value
		end if
		if not (objAtr.GetAttributeNode("skdx") is nothing) then
			tskdx=objAtr.GetAttributeNode("skdx").Value
		end if
		if not (objAtr.GetAttributeNode("rs") is nothing) then
			trs=objAtr.GetAttributeNode("rs").Value
		end if
		if not (objAtr.GetAttributeNode("zxs") is nothing) then
			tzxs=objAtr.GetAttributeNode("zxs").Value
		end if
		if not (objAtr.GetAttributeNode("qzz") is nothing) then
			tqzz=objAtr.GetAttributeNode("qzz").Value
		end if
		if not (objAtr.GetAttributeNode("xss") is nothing) then
			txss=objAtr.GetAttributeNode("xss").Value
		end if
		if not (objAtr.GetAttributeNode("kxxs") is nothing) then
			tkxxs=objAtr.GetAttributeNode("kxxs").Value
		end if
		if not (objAtr.GetAttributeNode("gmxs") is nothing) then
			tgmxs=objAtr.GetAttributeNode("gmxs").Value
		end if
		if not (objAtr.GetAttributeNode("gzl") is nothing) then
			tgzl=objAtr.GetAttributeNode("gzl").Value
		end if
	%>
		<Table id=table_bullit width="600" border="0" cellpadding="0" cellspacing="0">
			<tr>
			  <td colspan="2" height="30" class="f_14_orange">���ν�ѧ�������飺</td></tr>
			<tr>
			<td width="27%" height="25" align="right" class="f_14_grey" nowrap="nowrap">ѧ��ѧ�ڣ�</td>
            <td width="73%" class="f_14_grey"><%=txnxq %></td>
			</tr>
			<tr>
			<td width="27%" height="25" align="right" class="f_14_grey" nowrap="nowrap">�������ͣ�</td>
            <td width="73%" class="f_14_grey"><%=tgzlx %></td>
			</tr>
			<tr>
			<td width="27%" height="25" align="right" class="f_14_grey" nowrap="nowrap">ѡ�οκţ�</td>
            <td width="73%" class="f_14_grey"><%=txkkh %></td>
			</tr>
			<tr>
			<td width="27%" height="25" align="right" class="f_14_grey" nowrap="nowrap">�γ̴��룺</td>
            <td width="73%" class="f_14_grey"><%=tkcdm %></td>
			</tr>
			<tr>
			<td width="27%" height="25" align="right" class="f_14_grey" nowrap="nowrap">�γ����ƣ�</td>
            <td width="73%" class="f_14_grey"><%=tkcmc %></td>
			</tr>
			<tr>
			<td width="27%" height="25" align="right" class="f_14_grey" nowrap="nowrap">�γ����ʣ�</td>
            <td width="73%" class="f_14_grey"><%=tkcxz %></td>
			</tr>
			<tr>
			<td width="27%" height="25" align="right" class="f_14_grey" nowrap="nowrap">�γ����</td>
            <td width="73%" class="f_14_grey"><%=tkclb %></td>
			</tr>
			<tr>
			<td width="27%" height="25" align="right" class="f_14_grey" nowrap="nowrap">����ѧԺ��</td>
            <td width="73%" class="f_14_grey"><%=tkkxy %></td>
			</tr>
			<tr>
			<td width="27%" height="25" align="right" class="f_14_grey" nowrap="nowrap">�ڿζ���</td>
            <td width="73%" class="f_14_grey"><%=tskdx %></td>
			</tr>
			<tr>
			<td width="27%" height="25" align="right" class="f_14_grey" nowrap="nowrap">��ѡ������</td>
            <td width="73%" class="f_14_grey"><%=trs %></td>
			</tr>
			<tr>
			<td width="27%" height="25" align="right" class="f_14_grey" nowrap="nowrap">��ѧʱ��</td>
            <td width="73%" class="f_14_grey"><%=tzxs %></td>
			</tr>
			<tr>
			<td width="27%" height="25" align="right" class="f_14_grey" nowrap="nowrap">��ֹ�ܣ�</td>
            <td width="73%" class="f_14_grey"><%=tqzz %></td>
			</tr>
			<tr>
			<td width="27%" height="25" align="right" class="f_14_grey" nowrap="nowrap">��ѧʱ��</td>
            <td width="73%" class="f_14_grey"><%=txss %></td>
			</tr>
			<tr>
			<td width="27%" height="25" align="right" class="f_14_grey" nowrap="nowrap">����ϵ����</td>
            <td width="73%" class="f_14_grey"><%=tkxxs %></td>
			</tr>
			<tr>
			<td width="27%" height="25" align="right" class="f_14_grey" nowrap="nowrap">��ģϵ����</td>
            <td width="73%" class="f_14_grey"><%=tgmxs %></td>
			</tr>
			<tr>
			<td width="27%" height="25" align="right" class="f_14_grey" nowrap="nowrap">���㹤������</td>
            <td width="73%" class="f_14_grey"><%=tgzl %></td>
			</tr>
	<%
		Set objAtr=Nothing
		Set objNode=Nothing 
		Set objDom=Nothing
	End If
	%>
	</Table>