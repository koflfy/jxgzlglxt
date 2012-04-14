<!-- #include file="inc/WebSvcURL.asp" -->
<!-- #include file="inc/function.asp" -->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD><TITLE>江西科技师范学院专升本报名网</TITLE>
<META http-equiv=Content-Type content="text/html; charset=gb2312">
<LINK href="images/main_right.css" type=text/css rel=stylesheet>
<SCRIPT language=javascript src="images/ShowProcessBar.js"></SCRIPT>

<META content="MSHTML 6.00.3790.4807" name=GENERATOR>
<script src="Scripts/AC_RunActiveContent.js" type="text/javascript"></script>
</HEAD>
<BODY>
<!--#include file= "top.asp"-->
<DIV id=index align="center">
<LINK href="images/main.css" type=text/css rel=stylesheet>
<TABLE cellSpacing="0" cellPadding="0" width="1000" border="0">
  <TBODY>
  <TR>
    <TD vAlign=top width="248">
		<!-- #include file="login.asp" -->
      </TD>
    <TD vAlign=top>
      <TABLE cellSpacing=0 cellPadding=0 width="752" border=0>
        <TBODY>
        <TR>
          <TD></TD></TR>
        <TR>
          <TD>
            <DIV style="MARGIN-BOTTOM: 10px" align=center>
            <TABLE id=news cellSpacing=0 cellPadding=0 width="100%" border=0>
              <TBODY>
              <TR>
                <TD id=index_title>最新通知</TD></TR>
              <TR>
                <TD>
                  <UL>
<%
'===================================================================================
				'获取最新4条公告信息
				Dim BullitInfo		
				BullitInfo=objSOAPClient.GetBullitInfo(9)

				Dim objBulXml,objBulNode,objBulAtr,nCntChd,nCntAtr
				Set objBulXml=Server.CreateObject("Microsoft.XMLDOM") 
				objBulXml.Async=False	
				
				If objBulXml.loadXML(BullitInfo) Then
				
					Set objBulNode = objBulXml.documentElement.selectSingleNode("//ROWDATA")
					nCntChd=objBulNode.ChildNodes.length-1 

					'遍历记录（节点）
					Dim j
					for j=0 to nCntChd
						set objBulAtr=objBulNode.ChildNodes.item(j) 		
%>
						<LI>[<%=StrtoDate(objBulAtr.GetAttributeNode("ActionTime").Value)%>]&nbsp;&nbsp;<%=objBulAtr.GetAttributeNode("xF1").Value%></LI>
<%
					next 
												
					Set objBulAtr=Nothing 
					Set objBulNode=Nothing 
					Set objBulXml=Nothing
				Else
					Response.Write "<LI>暂无公告通知"
				End If
'===================================================================================
%>
                  </UL>
                  <p>&nbsp;</p>
				  </TD></TR></TBODY></TABLE></DIV>
            <DIV style="MARGIN-BOTTOM: 10px" align=center>
            <TABLE id=news cellSpacing=0 cellPadding=0 width="100%" border=0>
              <TBODY>
              <TR>
                <TD id=index_title>报名系统说明</TD></TR>
              <TR>
                <TD>
                  <UL>
<%				  
'					'获取帮助信息
'					Dim HelpInfo,XmlFileName	
'					HelpInfo=objSOAPClient.GetHelpInfo
'					Response.Write "<LI>" & "<pre>"& HelpInfo & "</pre>"
'					
'					Set HelpInfo=Nothing 
%>
					<Li><font size=4>专升本报名流程：</font>
                  </UL>
				<img src="images/zsb_step.gif">
        		</TD>
			  </TR>
			  </TBODY>
</TABLE></DIV></TD></TR></TBODY></TABLE></TD></TR></TBODY></TABLE></DIV>
  <div align="center">
	<DIV id=flooter>
  	<!--#include file="bottom.asp"-->
	</DIV>
  </div>
</BODY>
</HTML>
