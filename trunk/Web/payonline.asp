<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head><meta http-equiv="Content-Type" content="text/html; charset=gbk" />
	<title>深圳电大网上缴费查询系统</title>
	<link href="images/style.css" type="text/css" rel="stylesheet"/>
	<SCRIPT language=javascript src="images/image.js"></SCRIPT>
	<!-- #include file="inc/security.asp" -->
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
<DIV id=main>
  <!--左边按钮 -->
	<DIV class=leftbox id=leftbg>
		<DIV class=left_btn><A onMouseOver="MM_swapImage('Image1','','images/zzjf.gif',1)" onmouseout=MM_swapImgRestore()><IMG id=Image1 height=52 src="images/zzjf.gif" width=173 border=0 name=Image1></A>
		</DIV>
	  <DIV class=left_btn><A onMouseOver="MM_swapImage('Image2','','images/lscx.gif',1)" onmouseout=MM_swapImgRestore() 
href="paid.asp"><IMG id=Image2 height=52 src="images/lscx2.gif" width=173 border=0 name=Image2></A>
	</DIV>
	  <DIV class=left_btn><A onMouseOver="MM_swapImage('Image3','','images/sycx.gif',1)" onmouseout=MM_swapImgRestore()
href="usedpay.asp"><IMG id=Image3 height=52 src="images/sycx2.gif" width=173 border=0 name=Image3></A>
	</DIV>
	  <DIV class=left_btn><A onMouseOver="MM_swapImage('Image4','','images/tfcx.gif',1)" onmouseout=MM_swapImgRestore() 
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
		<DIV id=r_data><br>
		<iframe width="750" height="430" frameborder=0 scrolling=no marginwidth=0 src="buildorder.asp"></iframe>			
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