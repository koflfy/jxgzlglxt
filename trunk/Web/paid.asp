<!-- #include file="inc/WebSvcURL.asp" -->
<!-- #include file="inc/function.asp" -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<title>���ڵ�����Ͻɷ�ϵͳ-��ʷ�ɷѲ�ѯ</title>
<link href="images/style.css" type="text/css" rel="stylesheet"/>
<SCRIPT language=javascript src="images/image.js"></SCRIPT>
<!-- #include file="inc/security.asp" -->
<%
   Dim StuSfzh,StudentNo,XmlPaidInfo,XmlFileName
	
	'ͨ�����֤�Ż�ȡ��ʷ�ɷ���Ϣ    
	 If Request.Cookies("StuSfzh")<>"" Then  
	 	StuSfzh=Request.Cookies("StuSfzh")
		XmlPaidInfo=objSOAPClient.GetPaidInfoBySfzh(StuSfzh)
	 End If
  
	'ͨ��ѧ�Ż�ȡ��ʷ�ɷ���Ϣ
	If Request.Cookies("StudentNo")<>"" Then  
	 	StudentNo=Request.Cookies("StudentNo")
		XmlPaidInfo=objSOAPClient.GetPaidInfoByXH(StudentNo)
	End If
%>
</head>
<body onload="MM_preloadImages('images/zzjf.gif')">
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
		<DIV class=left_btn><A onmouseover="MM_swapImage('Image1','','images/zzjf.gif',1)" onmouseout=MM_swapImgRestore() href="payonline.asp"><a onmouseover="MM_swapImage('Image1','','images/zzjf.gif',1)" onmouseout=MM_swapImgRestore() href="payonline.asp"><img id=Image1 height=52 src="images/zzjf2.gif" width=173 border=0 name=Image1 /></a></A></DIV>
	  <DIV class=left_btn><A onmouseover="MM_swapImage('Image2','','images/lscx.gif',1)" onmouseout=MM_swapImgRestore()><IMG id=Image2 height=52 src="images/lscx.gif" width=173 border=0 name=Image2></A>
    </DIV>
	  <DIV class=left_btn><A onmouseover="MM_swapImage('Image3','','images/sycx.gif',1)" onmouseout=MM_swapImgRestore()
href="usedpay.asp"><IMG id=Image3 height=52 src="images/sycx2.gif" width=173 border=0 name=Image3></A>
    </DIV>
	  <DIV class=left_btn><A onmouseover="MM_swapImage('Image4','','images/tfcx.gif',1)" onmouseout=MM_swapImgRestore() 
href="refund.asp"><IMG id=Image4 height=52 src="images/tfcx2.gif" width=173 border=0 name=Image4></A>
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
				  <TD width=7 height=30  background="images/bg_title.gif" class=f_14_orange>&nbsp;</TD>
				  <TD height=30 colspan="7"  background="images/bg_title.gif" class=f_14_orange>��ʷ�ɷ���Ϣ</TD>
				</TR>
				<TR height="30">
				  <TD width=7 height=30 class=f_14_orange>&nbsp;</TD>
				  <TD width="34">���</TD>
				  <TD width="157">�ɷѺ�</TD>
				  <TD width="92">�ɷ�ѧ��</TD>
				  <TD width="91">�ɷ�����</TD>
				  <TD width="86">�ɷѽ��(Ԫ)</TD>
				  <TD width="164">�ɷ�ʱ��</TD>
				  <TD width="65">����</TD>
				</TR>
				<%
					Dim objDom,objNodes,objAtrs,nCntAtr,i,nCntChd,element
					Dim jfid,jfxn,jfmc,jfje,jfsj,cz
					Set objDom=Server.CreateObject("Microsoft.XMLDOM") 
					objDom.Async=False
					If objDom.loadXML(XmlPaidInfo) Then    '��XML�ַ��������ڴ�
						set objnodes=objdom.documentElement.SelectSingleNode("//ROWDATA").ChildNodes
						i=0
						for each element in objnodes
							i=i+1	
							set objAtrs=element.attributes
							jfid=objAtrs.item(0).Value
							jfxn=objAtrs.item(8).Value
							jfmc=objAtrs.item(9).Value 
							jfje=objAtrs.item(10).Value
							if jfje<0 then jfje="<font color='Red'>"&jfje&"</font>"
								 
							jfsj=StrtoDate(objAtrs.item(15).Value)
				%>
				<TR height="30">
	 			   <TD width=7 height=30 class=f_14_orange>&nbsp;</TD>
					<TD width="34"><%=i%></TD><TD width="157"><%=jfid%></TD><TD width="92"><%=jfxn%></TD><TD width="91"><%=jfmc%></TD><TD width="86"><%=jfje%></TD><TD width="164"><%=jfsj%></TD><TD><a href="#" onclick="window.open('paiddetail.asp?jfid=<%=jfid%>','Dwin','top=100,left=300,width=400,height=300');">�鿴��ϸ</a></TD>
				</TR>
				<%
						next
						Set objAtrs=Nothing 
						Set objNodes=Nothing 
						Set objDom=Nothing
					Else
				%>
				  		<TR><TD width=7 height=30 class=f_14_orange>&nbsp;</TD>
						<TD colspan="6" height=30>���޼�¼</TD></TR>
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