<!-- #include file="inc/WebSvcURL.asp" -->
<!-- #include file="inc/function.asp" -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<title>���ڵ�����Ͻɷ�ϵͳ-�˷���Ϣ��ѯ</title>
<link href="images/style.css" type="text/css" rel="stylesheet"/>
<SCRIPT language=javascript src="images/image.js"></SCRIPT>
<!-- #include file="inc/security.asp" -->
<%
    Dim TeacherSfzh,TeacherNo,XmlRefundInfo,XmlFileName
	'ͨ�����֤�Ż�ȡ�˷���Ϣ    
	 If Request.Cookies("TeacherSfzh")<>"" Then  
	 	TeacherSfzh=Request.Cookies("TeacherSfzh")
		XmlRefundInfo=objSOAPClient.GetRefundedInfoBySfzh(TeacherSfzh)
	 End If
  
	'ͨ��ѧ�Ż�ȡ�˷���Ϣ
	If Request.Cookies("TeacherNo")<>"" Then  
	 	TeacherNo=Request.Cookies("TeacherNo")
		XmlRefundInfo=objSOAPClient.GetRefundedInfoByXH(TeacherNo)
	End If
	
'	XmlFileName=Server.MapPath("RefundTemp.xml")
'	CreateXmlFile XmlFileName,XmlRefundInfo
%>
</head>
<body>
<!--ͷ�� -->
<DIV id=top></DIV>
<DIV id=sidebar>
		<UL>
			<LI class=exit><A class=red title=�˳� href="logout.asp">��ȫ�˳�</A></LI>
			<LI class=home><A class=red title=����ҳ href="index.asp">����ҳ</A></LI>
			<LI class=title style="BACKGROUND-IMAGE: none"><%=Request.Cookies("StuName")%>��ʦ:��ӭʹ�ý�ѧ��������ѯϵͳ!</A></LI>
		</UL>
</DIV>
<!--��ҳ���� -->
<div id=main>
  <!--��߰�ť -->
	<DIV class=leftbox id=leftbg>
		<DIV class=left_btn><A onmouseover="MM_swapImage('Image1','','images/zzjf.gif',1)" onmouseout=MM_swapImgRestore() href="payonline.asp"><IMG id=Image1 height=52 src="images/zzjf2.gif" width=173 border=0 name=Image1></A>
		</DIV>
	  <DIV class=left_btn><A onmouseover="MM_swapImage('Image2','','images/lscx.gif',1)" onmouseout=MM_swapImgRestore() href="paid.asp"><IMG id=Image2 height=52 src="images/lscx2.gif" width=173 border=0 name=Image2></A>
    </DIV>
	  <DIV class=left_btn><A onmouseover="MM_swapImage('Image3','','images/sycx.gif',1)" onmouseout=MM_swapImgRestore() href="usedpay.asp"><IMG id=Image3 height=52 src="images/sycx2.gif" width=173 border=0 name=Image3></A>
    </DIV>
	  <DIV class=left_btn><A onmouseover="MM_swapImage('Image4','','images/tfcx.gif',1)" onmouseout=MM_swapImgRestore() ><IMG id=Image4 height=52 src="images/tfcx.gif" width=173 border=0 name=Image4></A>
    </DIV>
		<br>
		<DIV class=left_btn><A onmouseover="MM_swapImage('Image5','','images/exit.gif',1)" onmouseout=MM_swapImgRestore() 
href="logout.asp"><IMG id=Image5 height=52 src="images/exit2.gif" width=173 border=0 name=Image5></A>
    </DIV>
  </DIV>
	<!--�ұ�-->
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
					<TD colspan="6" height=30 class=f_14_orange  background="images/bg_title.gif">�˷���Ϣ</TD>
				  </TR>
				  <TR height="30">
					<TD width="6%">���</TD>				  
					<TD width="23%">�˷ѵ���</TD>
					<TD width="16%">�˷�ѧ��</TD>	
					<TD width="14%">�˷�����</TD>							
					<TD width="16%">�˷ѽ��(Ԫ)</TD>
					<TD width="25%">�˷�ʱ��</TD>
				  </TR>
				  <%
					Dim objDom,objNodes,objAtrs,nCntAtr,nCntChd,element
					Dim jfid,jfxn,jfmc,jfje,jfsj,cz,i
					Set objDom=Server.CreateObject("Microsoft.XMLDOM") 
					objDom.Async=False
					If objDom.loadXML(XmlRefundInfo) Then    '��XML�ַ��������ڴ�
						set objnodes=objdom.documentElement.SelectSingleNode("//ROWDATA").ChildNodes
						If objnodes is nothing Then
					%>
							<TR><TD colspan="6" height="30">û���˷Ѽ�¼��</TD></TR>
					<%							
						Else
							i=0
							for each element in objnodes
							    i=i+1
								set objAtrs=element.attributes
								jfid=objAtrs.item(0).Value
								jfxn=objAtrs.item(8).Value
								jfmc=objAtrs.item(9).Value 
								jfje=objAtrs.item(10).Value 
								jfsj=StrtoDate(objAtrs.item(15).Value)
						%>
							<TR height="30">
								<TD width="6%"><%=i%></TD>							
								<TD width="23%"><%=jfid%></TD>
								<TD width="16%"><%=jfxn%></TD>
								<TD width="14%"><%=jfmc%></TD>
								<TD width="16%"><%=jfje%></TD>
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
						<TR><TD colspan="6" height="30">û���˷Ѽ�¼��</TD></TR>
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
    		<TD vAlign=center align=right width="15%" rowSpan=3><A href="http://www.hd315.gov.cn/beian/view.asp?bianhao= " target=_blank><IMG height=36 hspace=5 src="images/biaozhi.gif" width=30 border=0></A><!--������Ϣ--></TD>
    		<TD vAlign=center noWrap align=left width="85%">&copy; ��Ȩ���� �����Ƽ�ʦ����ѧ��Ȩ���� &nbsp;&nbsp;&nbsp;<A href="#" target=_blank>��ϵ����</A> |  <A href="#" target=_blank>����绰��</A> 
				</TD>
	</TR></TBODY></TABLE>
</DIV>
</body>
</html>