<!-- #include file="inc/WebSvcURL.asp" -->
<!-- #include file="inc/function.asp" -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<title>�����Ƽ�ʦ����ѧ��ѧ��������ѯϵͳ</title>
<link href="images/style.css" type="text/css" rel="stylesheet"/>
<SCRIPT language=javascript src="images/image.js"></SCRIPT>
<!-- #include file="inc/security.asp" -->
<%
   Dim TeacherSfzh,TeacherNo,XmlPaidInfo,XmlFileName,XmlXnxqList
	
	'ͨ��ְ���Ż�ȡ��ѧ��������Ϣ
	If Request.Cookies("TeacherNo")<>"" Then  
	 	TeacherNo=Request.Cookies("TeacherNo")
		XmlXnxqList=objSOAPClient.GetXnxqList
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
			<LI class=title style="BACKGROUND-IMAGE: none"><%=Request.Cookies("TeacherName")%>��ʦ:��ӭʹ�ý�ѧ��������ѯϵͳ!</A></LI>
		</UL>
</DIV>
<!--��ҳ���� -->
<div id=main>
  <!--��߰�ť -->
	<DIV class=leftbox id=leftbg>
		<DIV class=left_btn><A onmouseover="MM_swapImage('Image1','','images/zzjf.gif',1)" onmouseout=MM_swapImgRestore() href="#"><a onmouseover="MM_swapImage('Image1','','images/zzjf.gif',1)" onmouseout=MM_swapImgRestore() href="#"><img id=Image1 height=52 src="images/zzjf.gif" width=173 border=0 name=Image1 /></a></DIV>
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
				  <TD height=30 colspan="7"  background="images/bg_title.gif" class=f_14_orange>
                  <form id="form1" name="form1" method="post" action="">
                  <select name="xnxq" id="xnxq">
				<%
					Dim objDom,objNodes,objAtrs,nCntAtr,i,nCntChd,element
					Dim xnxq
					Set objDom=Server.CreateObject("Microsoft.XMLDOM") 
					objDom.Async=False
					If objDom.loadXML(XmlXnXqList) Then    '��XML�ַ��������ڴ�
						set objnodes=objdom.documentElement.SelectSingleNode("//ROWDATA").ChildNodes
						i=0
						for each element in objnodes
							i=i+1	
							set objAtrs=element.attributes
							xnxq=objAtrs.item(0).Value
				%>
                  <option <%if xnxq=request("xnxq") then response.Write("selected='selected'") end if%>><%=xnxq%></option>
				<%
						next
						Set objAtrs=Nothing 
						Set objNodes=Nothing 
						Set objDom=Nothing
					Else
				%>
                  <option selected="selected">ѡ��ѧ��</option>
				<%	
	               	End If
				%>
                  </select>
                  <input type="submit" name="submit" id="submit" value="��ѯ" />
                  ��ѯ����� 
                  </form>
                  </TD>
				</TR>
				<TR height="30">
				  <TD width=7 height=30 class=f_14_orange>&nbsp;</TD>
				  <TD width="34">���</TD>
				  <TD width="64">ѧ��ѧ��</TD>
				  <TD width="294">�γ�����</TD>
				  <TD width="70">ѧʱ��</TD>
				  <TD width="84">����������</TD>
				  <TD width="85">��ѧ������</TD>
				  <TD width="58">����</TD>
				</TR>
				<%
					XmlPaidInfo=objSOAPClient.GetJxgzlInfoByNo(TeacherNo,request("xnxq"))
					Dim objDom,objNodes,objAtrs,nCntAtr,i,nCntChd,element
					Dim kcmc,xss,lx,gzl,cz
					Set objDom=Server.CreateObject("Microsoft.XMLDOM") 
					objDom.Async=False
					If objDom.loadXML(XmlPaidInfo) Then    '��XML�ַ��������ڴ�
						set objnodes=objdom.documentElement.SelectSingleNode("//ROWDATA").ChildNodes
						i=0
						for each element in objnodes
							i=i+1	
							set objAtrs=element.attributes
							xnxq=objAtrs.item(2).Value
							kcmc=objAtrs.item(8).Value
							xss=objAtrs.item(16).Value 
							lx=objAtrs.item(3).Value
							gzl=objAtrs.item(19).Value
				%>
				<TR height="30">
	 			   <TD width=7 height=30 class=f_14_orange>&nbsp;</TD>
					<TD width="34"><%=i%></TD><TD width="64"><%=xnxq%></TD><TD width="294"><%=kcmc%></TD><TD width="70"><%=xss%></TD><TD width="84"><%=lx%></TD><TD width="85"><%=gzl%></TD><TD><a href="#" onclick="window.open('paiddetail.asp?jfid=<%=jfid%>','Dwin','top=100,left=300,width=400,height=300');">�鿴��ϸ</a></TD>
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