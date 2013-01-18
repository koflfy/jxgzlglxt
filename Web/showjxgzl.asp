<!-- #include file="inc/WebSvcURL.asp" -->
<!-- #include file="inc/function.asp" -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<title>江西科技师范大学教学工作量查询系统</title>
<link href="images/style.css" type="text/css" rel="stylesheet"/>
<SCRIPT language=javascript src="images/image.js"></SCRIPT>
<!-- #include file="inc/security.asp" -->
<%
   Dim TeacherSfzh,TeacherNo,XmlJxgzlInfo,XmlFileName,XmlXnxqList,xnxq,iPage,iTotalRecord
	
	'通过职工号获取教学工作量信息
	If Request.Cookies("TeacherNo")<>"" Then  
	 	TeacherNo=Request.Cookies("TeacherNo")
		XmlXnxqList=objSOAPClient.GetXnxqList
		xnxq = Request.QueryString("xnxq")
		iPage = Request.QueryString("page")
		if iPage = "" then
			iPage = 1
		end if
		iTotalRecord = ""
		XmlJxgzlInfo = objSOAPClient.GetJxgzlInfo(TeacherNo,xnxq,17,iPage)
		iTotalRecord = objSOAPClient.GetJxgzlRecordCount(TeacherNo,xnxq)
		'response.Write iPage
	End If
%>
</head>
<body onload="MM_preloadImages('images/zzjf.gif')">
<!--头部 -->
<DIV id=top></DIV>
<DIV id=sidebar>
		<UL>
			<LI class=exit><A class=red title=退出 href="logout.asp">安全退出</A></LI>
			<LI class=home><A class=red title=回首页 href="index.asp">回首页</A></LI>
			<LI class=title style="BACKGROUND-IMAGE: none"><%=Request.Cookies("TeacherName")%>老师:欢迎使用教学工作量查询系统!</A></LI>
		</UL>
</DIV>
<!--网页主体 -->
<div id=main>
  <!--左边按钮 -->
	<DIV class=leftbox id=leftbg>
		<DIV class=left_btn><A onmouseover="MM_swapImage('Image1','','images/zzjf.gif',1)" onmouseout=MM_swapImgRestore() href="#"><a onmouseover="MM_swapImage('Image1','','images/zzjf.gif',1)" onmouseout=MM_swapImgRestore() href="#"><img id=Image1 height=52 src="images/zzjf.gif" width=173 border=0 name=Image1 /></a></DIV>
    <br>
		<DIV class=left_btn><A onmouseover="MM_swapImage('Image5','','images/exit.gif',1)" onmouseout=MM_swapImgRestore() 
href="logout.asp"><IMG id=Image5 height=52 src="images/exit2.gif" width=173 border=0 name=Image5></A>
    </DIV>
  </DIV>
  <!--右边-->
  <DIV id=rightbox>
		<DIV id=r_top></DIV>
		<DIV id=r_data>
		  <TABLE id=table_bullit  cellSpacing=0 cellPadding=0 width=750 align=center border=0>
  			<TBODY>
  			<TR>
    			<TD height=37>
      			<TABLE cellSpacing=0 cellPadding=0 width=100% border=0>
        		<TBODY>
				<TR>
				  <TD width=11 height=30  background="images/bg_title.gif" class=f_14_orange>&nbsp;</TD>
				  <TD height=30 colspan="8"  background="images/bg_title.gif" class=f_14_orange>
                  <form id="form1" name="form1" method="get" action="">
                  <select name="xnxq" id="xnxq">
                  <option value="">选择学期</option>
				<%
					Dim objDom,objNodes,objAtrs,nCntAtr,i,nCntChd,element
					Set objDom=Server.CreateObject("Microsoft.XMLDOM") 
					objDom.Async=False
					If objDom.loadXML(XmlXnXqList) Then    '把XML字符串读入内存
						set objnodes=objdom.documentElement.SelectSingleNode("//ROWDATA").ChildNodes
						i=0
						for each element in objnodes
							i=i+1	
							set objAtrs=element.attributes
							xnxq=objAtrs.item(0).Value
				%>
                  <option <%if xnxq=request.QueryString("xnxq") then response.Write("selected='selected'") end if%>><%=xnxq%></option>
				<%
						next
						Set objAtrs=Nothing 
						Set objNodes=Nothing 
						Set objDom=Nothing
	               	End If
				%>
                  </select>
                  <input type="submit" name="submit" id="submit" value="查询" />
                  查询结果： 
                  </form>
                  </TD>
				</TR>
				<TR height="30">
				  <TD width=11 height=25 class=f_14_orange>&nbsp;</TD>
				  <TD width="48">序号</TD>
				  <TD width="88">学年学期</TD>
				  <TD width="204">课程名称</TD>
				  <!--<TD width="70">学时数</TD> //-->
				  <TD>授课对象</TD>
				  <!--<TD width="84">核算类型</TD> //-->
				  <TD width="58">工作量</TD>
				  <TD width="45">操作</TD>
				</TR>
				<%
					Dim kcmc,xss,lx,gzl,cz,id,skdx
					Set objDom=Server.CreateObject("Microsoft.XMLDOM") 
					objDom.Async=False
					If objDom.loadXML(XmlJxgzlInfo) Then    '把XML字符串读入内存
						set objnodes=objdom.documentElement.SelectSingleNode("//ROWDATA")
						nCntChd=objnodes.ChildNodes.length-1
						i=0
						for i=0 to nCntChd
							set objAtrs=objnodes.ChildNodes.item(i)
							if not (objAtrs.GetAttributeNode("id") is nothing) then
								id=objAtrs.GetAttributeNode("id").Value
							end if
							if not (objAtrs.GetAttributeNode("xnxq") is nothing) then
								xnxq=objAtrs.GetAttributeNode("xnxq").Value
							end if
							if not (objAtrs.GetAttributeNode("kcmc") is nothing) then
								kcmc=objAtrs.GetAttributeNode("kcmc").Value
							end if
							if not (objAtrs.GetAttributeNode("xss") is nothing) then
								xss=objAtrs.GetAttributeNode("xss").Value 
							end if
							if not (objAtrs.GetAttributeNode("skdx") is nothing) then
								skdx=objAtrs.GetAttributeNode("skdx").Value
							end if
							if not (objAtrs.GetAttributeNode("gzlx") is nothing) then
								lx=objAtrs.GetAttributeNode("gzlx").Value
							end if
							if not (objAtrs.GetAttributeNode("gzl") is nothing) then
								gzl=objAtrs.GetAttributeNode("gzl").Value
							end if
				%>
				<TR height="25">
	 			   <TD width=11 class=f_14_orange>&nbsp;</TD>
					<TD width="48"><%=(iPage-1)*17+i+1%></TD>
                    <TD width="88"><%=xnxq%></TD>
                    <TD width="204" nowrap="nowrap">
					<%if len(kcmc)>20 then response.Write left(kcmc,20)&"..." else response.Write kcmc end if %>
                    </TD>
                    <TD  nowrap="nowrap">
					<%if len(skdx)>26 then response.Write left(skdx,26)&"..." else response.Write skdx end if %>
                    </TD>
                    <TD width="58"><%=gzl%></TD>
                    <TD><a href="#" onclick="window.open('jxgzldetail.asp?id=<%=id%>','Dwin','top=100,left=300,width=620,height=450');">明细</a></TD>
				</TR>
				<%
						next
						Set objAtrs=Nothing 
						Set objNodes=Nothing 
						Set objDom=Nothing
					Else
				%>
				  		<TR><TD width=11 height=25 class=f_14_orange>&nbsp;</TD>
						<TD colspan="7">暂无记录</TD></TR>
				<%	
	               	End If
				%>
             </TBODY>
			</TABLE>
			</TD>
      </TR></TBODY></TABLE><br />
      <div style="text-align:right; margin-right:15px">
      <%if iPage>1 then %>
      <a href="showjxgzl.asp?xnxq=<%=xnxq%>&amp;page=<%=ipage-1%>" title="上一页">上一页</a>
      <%else%>
      上一页
      <%end if%>
      &nbsp;
      <%if iPage*17<iTotalRecord then %>
      <a href="showjxgzl.asp?xnxq=<%=xnxq%>&amp;page=<%=ipage+1%>" title="下一页">下一页</a>
      <%else%>
      下一页
      <%end if%>
      &nbsp;&nbsp;
      </div>
		</DIV>		
		<DIV id=r_bottom></DIV>
	</DIV>
</DIV>
<DIV id=bottom>
	<TABLE class=f_12_white cellSpacing=0 cellPadding=0 width="100%" align=center border=0>
  	<TBODY>
  		<TR>
    		<TD vAlign=center align=right width="15%" rowSpan=3><A href="http://www.hd315.gov.cn/beian/view.asp?bianhao= " target=_blank><IMG height=36 hspace=5 src="images/biaozhi.gif" width=30 border=0></A><!--备案信息--></TD>
    		<TD vAlign=center noWrap align=left width="85%">&copy; 版权所有 江西科技师范大学版权所有 &nbsp;&nbsp;&nbsp;<A href="#" target=_blank>联系我们</A> |  <A href="#" target=_blank>服务电话：0791-83831019</A> 
				</TD>
	</TR></TBODY></TABLE>
</DIV>
</body>
</html>