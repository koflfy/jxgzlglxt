<!-- #include file="inc/WebSvcURL.asp" -->
<!-- #include file="inc/function.asp" -->
<link href="images/style.css" type="text/css" rel="stylesheet"/>
<%
    Dim id,TeacherSfzh
	id=Request.QueryString("id")
	TeacherSfzh=Request.Cookies("TeacherSfzh")
	
	'取得指定规则号的记录缴费明细		
	Dim XmlDetailInfo,XmlFileName
	XmlDetailInfo=objSOAPClient.GetJxgzlDelta(id)

    XmlFileName=Server.MapPath("paiddetailTemp.xml")
	CreateXmlFile XmlFileName,XmlDetailInfo
	
	Dim objDom,objNode,objAtr,nCntChd,i
	Set objDom=Server.CreateObject("Microsoft.XMLDOM") 
	objDom.Async=False
	
	If objDom.loadXML(XmlDetailInfo) Then    '把XML字符串读入内存
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
			  <td colspan="2" height="30" class="f_14_orange">本次教学任务详情：</td></tr>
			<tr>
			<td width="27%" height="25" align="right" class="f_14_grey" nowrap="nowrap">学年学期：</td>
            <td width="73%" class="f_14_grey"><%=txnxq %></td>
			</tr>
			<tr>
			<td width="27%" height="25" align="right" class="f_14_grey" nowrap="nowrap">核算类型：</td>
            <td width="73%" class="f_14_grey"><%=tgzlx %></td>
			</tr>
			<tr>
			<td width="27%" height="25" align="right" class="f_14_grey" nowrap="nowrap">选课课号：</td>
            <td width="73%" class="f_14_grey"><%=txkkh %></td>
			</tr>
			<tr>
			<td width="27%" height="25" align="right" class="f_14_grey" nowrap="nowrap">课程代码：</td>
            <td width="73%" class="f_14_grey"><%=tkcdm %></td>
			</tr>
			<tr>
			<td width="27%" height="25" align="right" class="f_14_grey" nowrap="nowrap">课程名称：</td>
            <td width="73%" class="f_14_grey"><%=tkcmc %></td>
			</tr>
			<tr>
			<td width="27%" height="25" align="right" class="f_14_grey" nowrap="nowrap">课程性质：</td>
            <td width="73%" class="f_14_grey"><%=tkcxz %></td>
			</tr>
			<tr>
			<td width="27%" height="25" align="right" class="f_14_grey" nowrap="nowrap">课程类别：</td>
            <td width="73%" class="f_14_grey"><%=tkclb %></td>
			</tr>
			<tr>
			<td width="27%" height="25" align="right" class="f_14_grey" nowrap="nowrap">开课学院：</td>
            <td width="73%" class="f_14_grey"><%=tkkxy %></td>
			</tr>
			<tr>
			<td width="27%" height="25" align="right" class="f_14_grey" nowrap="nowrap">授课对象：</td>
            <td width="73%" class="f_14_grey"><%=tskdx %></td>
			</tr>
			<tr>
			<td width="27%" height="25" align="right" class="f_14_grey" nowrap="nowrap">已选人数：</td>
            <td width="73%" class="f_14_grey"><%=trs %></td>
			</tr>
			<tr>
			<td width="27%" height="25" align="right" class="f_14_grey" nowrap="nowrap">周学时：</td>
            <td width="73%" class="f_14_grey"><%=tzxs %></td>
			</tr>
			<tr>
			<td width="27%" height="25" align="right" class="f_14_grey" nowrap="nowrap">起止周：</td>
            <td width="73%" class="f_14_grey"><%=tqzz %></td>
			</tr>
			<tr>
			<td width="27%" height="25" align="right" class="f_14_grey" nowrap="nowrap">总学时：</td>
            <td width="73%" class="f_14_grey"><%=txss %></td>
			</tr>
			<tr>
			<td width="27%" height="25" align="right" class="f_14_grey" nowrap="nowrap">课型系数：</td>
            <td width="73%" class="f_14_grey"><%=tkxxs %></td>
			</tr>
			<tr>
			<td width="27%" height="25" align="right" class="f_14_grey" nowrap="nowrap">规模系数：</td>
            <td width="73%" class="f_14_grey"><%=tgmxs %></td>
			</tr>
			<tr>
			<td width="27%" height="25" align="right" class="f_14_grey" nowrap="nowrap">核算工作量：</td>
            <td width="73%" class="f_14_grey"><%=tgzl %></td>
			</tr>
	<%
		Set objAtr=Nothing
		Set objNode=Nothing 
		Set objDom=Nothing
	End If
	%>
	</Table>