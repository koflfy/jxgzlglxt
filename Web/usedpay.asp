<!-- #include file="inc/WebSvcURL.asp" -->
<!-- #include file="inc/function.asp" -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<title>深圳电大网上缴费系统-教材费查询</title>
<link href="images/style.css" type="text/css" rel="stylesheet"/>
<SCRIPT language=javascript src="images/image.js"></SCRIPT>
<!-- #include file="inc/security.asp" -->
<%  
    Dim StuSfzh,StudentNo,XmlUsedInfo,XmlFileName
	'通过身份证号获取教材费缴纳信息（单项明细）   
	 If Request.Cookies("StuSfzh")<>"" Then  
	 	StuSfzh=Request.Cookies("StuSfzh")
		XmlUsedInfo=objSOAPClient.GetJcfUsedInfoBySfzh(StuSfzh)
	 End If
  
	'通过学号获取教材费缴纳信息（单项明细）
	If Request.Cookies("StudentNo")<>"" Then  
	 	StudentNo=Request.Cookies("StudentNo")
		XmlUsedInfo=objSOAPClient.GetJcfUsedInfoByXH(StudentNo)
	End If		
	
	'XmlFileName=Server.MapPath("UsedTemp.xml")
	'CreateXmlFile XmlFileName,XmlUsedInfo
%>
</head>
<body>
<!--头部 -->
<DIV id=top></DIV>
<DIV id=sidebar>
		<UL>
			<LI class=exit><A class=red title=退出 href="logout.asp">安全退出</A></LI>
			<LI class=home><A class=red title=回首页 href="index.asp">回首页</A></LI>
			<LI class=title style="BACKGROUND-IMAGE: none"><%=Request.Cookies("StuName")%>老师:欢迎使用教学工作量查询系统!</A></LI>
		</UL>
</DIV>
<!--网页主体 -->
<div id=main>
  <!--左边按钮 -->
	<DIV class=leftbox id=leftbg>
		<DIV class=left_btn><A onmouseover="MM_swapImage('Image1','','images/zzjf.gif',1)" onmouseout=MM_swapImgRestore() href="payonline.asp"><IMG id=Image1 height=52 src="images/zzjf2.gif" width=173 border=0 name=Image1></A>
		</DIV>
	  <DIV class=left_btn><A onmouseover="MM_swapImage('Image2','','images/lscx.gif',1)" onmouseout=MM_swapImgRestore() href="paid.asp"><IMG id=Image2 height=52 src="images/lscx2.gif" width=173 border=0 name=Image2></A>
    </DIV>
	  <DIV class=left_btn><A onmouseover="MM_swapImage('Image3','','images/sycx.gif',1)" onmouseout=MM_swapImgRestore()><IMG id=Image3 height=52 src="images/sycx.gif" width=173 border=0 name=Image3></A>
    </DIV>
	  <DIV class=left_btn><A onmouseover="MM_swapImage('Image4','','images/tfcx.gif',1)" onmouseout=MM_swapImgRestore() 
href="refund.asp"><IMG id=Image4 height=52 src="images/tfcx2.gif" width=173 border=0 name=Image4></A>
    </DIV>
		<br>
		<DIV class=left_btn><A onmouseover="MM_swapImage('Image5','','images/exit.gif',1)" onmouseout=MM_swapImgRestore() 
href="logout.asp"><IMG id=Image5 height=52 src="images/exit2.gif" width=173 border=0 name=Image5></A>
    </DIV>
  </DIV>
	<!--右边-->
  <DIV id=rightbox>
		<DIV id=r_top></DIV>
		<DIV id=r_data>
		  <TABLE id=table_bullit  cellSpacing=0 cellPadding=0 width=698 align=center border=0>
  			<TBODY>
  			<TR>
    			<TD height=37>
      			<TABLE cellSpacing=0 cellPadding=0 width=100% border=0>
        		<TBODY>
					<TR>
					  <TD colspan="6" height=30 class=f_14_orange  background="images/bg_title.gif">教材费缴纳信息</TD>
					</TR>
					<TR height="30">
						<TD width="33">序号</TD>				  
						<TD width="146">缴费号</TD>
						<TD width="103">缴费学年</TD>
						<TD width="120">缴费名称</TD>							
						<TD width="112">缴费金额(元)</TD>
						<TD width="182">缴费时间</TD>
				  	</TR>
				    <%
					Dim objDom,objNodes,objAtrs,nCntChd,element
					Dim jfid,jfmc,jfje,jfsj,cz,jfxn,i
					Set objDom=Server.CreateObject("Microsoft.XMLDOM") 
					objDom.Async=False
					If objDom.loadXML(XmlUsedInfo) Then    '把XML字符串读入内存
						set objnodes=objdom.documentElement.SelectSingleNode("//ROWDATA").ChildNodes
						If objnodes is nothing Then
					%>
							<TR><TD colspan="6" height="30">没有使用记录！</TD></TR>
					<%							
						Else
							for each element in objnodes
								i=1
								set objAtrs=element.attributes
								jfid=objAtrs.item(3).Value
								jfxn=objAtrs.item(4).Value
								jfmc=objAtrs.item(5).Value 
								jfje=objAtrs.item(7).Value 
								jfsj=StrtoDate(objAtrs.item(8).Value)
						%>
							<TR height="30">
								<TD width="33"><%=i%></TD>
								<TD width="146"><%=jfid%></TD>
							   <TD width="103"><%=jfxn%></TD>
								<TD width="120"><%=jfmc%></TD>
								<TD width="112"><%=jfje%></TD>
								<TD><%=jfsj%></TD>
							</TR>
						<%
							next
							Set objAtrs=Nothing 
							Set objNodes=Nothing 
							Set objDom=Nothing
						End If
					Else
					%>
						<TR><TD colspan="6" height="30">没有使用记录！</TD></TR>
					<%	
	               	End If
					%>
             </TBODY>
			</TABLE>
		  </TD>
      </TR></TBODY></TABLE><br />
		</DIV>		
		<DIV id=r_bottom></DIV>
	</DIV>
</DIV>
<DIV id=bottom>
	<TABLE class=f_12_white cellSpacing=0 cellPadding=0 width="100%" align=center border=0>
  	<TBODY>
  		<TR>
    		<TD vAlign=center align=right width="15%" rowSpan=3><A href="http://www.hd315.gov.cn/beian/view.asp?bianhao= " target=_blank><IMG height=36 hspace=5 src="images/biaozhi.gif" width=30 border=0></A><!--备案信息--></TD>
    		<TD vAlign=center noWrap align=left width="85%">&copy; 版权所有 江西科技师范大学版权所有 &nbsp;&nbsp;&nbsp;<A href="#" target=_blank>联系我们</A> |  <A href="#" target=_blank>服务电话：</A> 
				</TD>
	</TR></TBODY></TABLE>
</DIV>
</body>
</html>