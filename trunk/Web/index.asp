<!-- #include file="inc/WebSvcURL.asp" -->
<!-- #include file="inc/function.asp" -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<title>���ڵ�����ϽɷѲ�ѯϵͳ</title>
<link href="images/style.css" type="text/css" rel="stylesheet"/>
<SCRIPT language=javascript src="images/image.js"></SCRIPT>
<!-- #include file="inc/security.asp" -->
<%
    Dim StudentNo,StuSfzh,XmlStuInfo,StuName,HintInfo
	 'ͨ�����֤�Ż�ȡѧ����Ϣ    
	 If Request.Cookies("StuSfzh")<>"" Then  
	 	StuSfzh=Request.Cookies("StuSfzh")
		StudentNo=objSOAPClient.GetStuXHBySfzh(StuSfzh)
		XmlStuInfo=objSOAPClient.GetStuInfoBySfzh(StuSfzh)
	 End If
   
	'ͨ��ѧ�Ż�ȡѧ����Ϣ
	If Request.Cookies("StudentNo")<>"" Then  
	 	StudentNo=Request.Cookies("StudentNo")
		XmlStuInfo=objSOAPClient.GetStuInfoByXH(StudentNo)
	End If
	
	Dim objStuXml,objStuNode,objStuAtr,StuClass,StuState	
	Set objStuXml=Server.CreateObject("Microsoft.XMLDOM") 
	objStuXml.Async=False
	objStuXml.loadXML(XmlStuInfo)
	Set objStuNode = objStuXml.documentElement.selectSingleNode("ROWDATA")
	Set objStuAtr=objStuNode.ChildNodes.item(0) 
	StuClass=trim(objStuAtr.GetAttributeNode("nj").Value)
	StuClass=StuClass & trim(objStuAtr.GetAttributeNode("zy").Value)
	StuClass=StuClass & "��" & trim(objStuAtr.GetAttributeNode("lb").Value) & "��"
	StuName=objStuAtr.GetAttributeNode("xm").Value
	StuState=objStuAtr.GetAttributeNode("state").Value
  Response.Cookies("CooStuState")=StuState
	Response.Cookies("StuName")=StuName
%>
</head>
<body>
<!--ͷ�� -->
<DIV id=top></DIV>
<DIV id=sidebar>
		<UL>
			<LI class=exit><A class=red title=�˳� href="logout.asp">��ȫ�˳�</A></LI>
			<LI class=home><A class=red title=����ҳ href="index.asp">����ҳ</A></LI>
			<LI class=title style="BACKGROUND-IMAGE: none">��ӭʹ�ý�ѧ��������ѯϵͳ!</A></LI>
		</UL>
</DIV>
<!--��ҳ���� -->
<div id=main>
  <!--��߰�ť -->
	<DIV class=leftbox id=leftbg>
		<DIV class=left_btn><A onmouseover="MM_swapImage('Image1','','images/zzjf.gif',1)" onmouseout=MM_swapImgRestore() href="payonline.asp"><IMG id=Image1 height=52 src="images/zzjf2.gif" width=173 border=0 name=Image1></A>		</DIV>
	  <br>
		<DIV class=left_btn><A onmouseover="MM_swapImage('Image5','','images/exit.gif',1)" onmouseout=MM_swapImgRestore() 
href="logout.asp"><IMG id=Image5 height=52 src="images/exit2.gif" width=173 border=0 name=Image5></A>
    </DIV>
  </DIV>
	<!--�ұ�-->
  <DIV id=rightbox>
		<DIV id=r_top></DIV>
		<DIV id=r_data>
			<TABLE height=60 cellSpacing=1 cellPadding=1 width=698 align=center bgColor=#78a5cd border=0>
  			<TBODY>
  			<TR>
    			<TD bgColor=#f8fcfe>
      			<TABLE id=table_tip height=60 cellSpacing=0 cellPadding=5 width="100%" align=center border=0>
        			<TBODY>
        			<TR>
          			<TD width="10%" valign=top background=images/bg_tip.gif><IMG height=49 src="images/icon_tip.gif" width=48></TD>
          			<TD width="90%" background=images/bg_tip.gif>
						<SPAN class=f_14_orange><%= StuClass %><br />
				    <%= StuName %>��ʦ:����</SPAN><br />
						��ӭʹ�ý����Ƽ�ʦ����ѧ<span class="title" style="BACKGROUND-IMAGE: none">��ѧ��������ѯϵͳ</span>��						</p>
					 </TD>
					 </TR>
				  </TBODY>
				  </TABLE>
			</TD></TR></TBODY></TABLE>
					<br>
			<TABLE id=table_bullit  cellSpacing=0 cellPadding=0 width=698 align=center border=0>
  			<TBODY>
  			<TR>
    			<TD height=37>
      			<TABLE cellSpacing=0 cellPadding=0 width=100% border=0>
        		<TBODY>
						  <TR><TD width=20 height=30 class=f_14_orange  background="images/bg_title.gif">&nbsp;</TD>
						  			<TD class=f_14_orange  background="images/bg_title.gif">����֪ͨ</TD>
						  </TR>
							<%
							'��ȡ����4��������Ϣ
							Dim BullitInfo		
							BullitInfo=objSOAPClient.GetBullitInfo(4)

							Dim objBulXml,objBulNode,objBulAtr,nCntChd,nCntAtr
							Set objBulXml=Server.CreateObject("Microsoft.XMLDOM") 
							objBulXml.Async=False	
							
							If objBulXml.loadXML(BullitInfo) Then
							
								Set objBulNode = objBulXml.documentElement.selectSingleNode("//ROWDATA")
								nCntChd=objBulNode.ChildNodes.length-1 
	
								'������¼���ڵ㣩
								Dim j
								for j=0 to nCntChd
									set objBulAtr=objBulNode.ChildNodes.item(j) 		
								%>
									<TR><TD  height=30>&nbsp;</TD>
												<TD><%=objBulAtr.GetAttributeNode("xF1").Value %>&nbsp;&nbsp;<%=StrtoDate(objBulAtr.GetAttributeNode("ActionTime").Value) %></TD>
									</TR> 
								<%
								next 
															
								Set objBulAtr=Nothing 
								Set objBulNode=Nothing 
								Set objBulXml=Nothing
								%>
							<%
							Else
							%>
								<TR><TD  height=30>&nbsp;</TD>
											<TD>���޹���</TD>
								</TR>
							<%
							End If
							%>
             </TBODY>
						</TABLE>
					</TD>
      </TR></TBODY></TABLE><br />
<TABLE height=60 cellSpacing=1 cellPadding=1 width=698 align=center bgColor=#78a5cd border=0>
  			<TBODY>
  			<TR>
    			<TD bgColor=#f8fcfe>
      			<TABLE id=table_tip height=60 cellSpacing=0 cellPadding=5 width="100%" align=center border=0>
        			<TBODY>
        			<TR>
          			<TD width="10%" valign=top background=images/bg_tip.gif><IMG height=49 src="images/icon_tip.gif" width=48></TD>
          			<TD width="90%" background=images/bg_tip.gif>
							<p class=f_14_orange>ʹ�ð���:</p>
							<%
							'��ȡ������Ϣ
							Dim HelpInfo,XmlFileName	
							HelpInfo=objSOAPClient.GetHelpInfo
                     %>
							<pre><%=HelpInfo%></pre>
					  </TD>
					</TR>
					</TBODY>
				  </TABLE>
			</TD></TR></TBODY></TABLE>			
		</DIV>		
		<DIV id=r_bottom></DIV>
	</DIV>
</DIV>
<DIV id=bottom>
	<TABLE class=f_12_white cellSpacing=0 cellPadding=0 width="100%" align=center border=0>
  	<TBODY>
  		<TR>
    		<TD vAlign=center align=right width="15%" rowSpan=3><A href="http://www.hd315.gov.cn/beian/view.asp?bianhao= " target=_blank><IMG height=36 hspace=5 src="images/biaozhi.gif" width=30 border=0></A><!--������Ϣ--></TD>
    		<TD vAlign=center noWrap align=left width="85%">&copy; ��Ȩ���� �����Ƽ�ʦ����ѧ��Ȩ���� &nbsp;&nbsp;&nbsp;<A href="#" target=_blank>��ϵ����</A> |  <A href="#" target=_blank>����绰��0791-83831019</A> 
				</TD>
	</TR></TBODY></TABLE>
</DIV>
</body>
</html>