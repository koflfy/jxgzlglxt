<TABLE width=208 border="0" cellPadding=0 cellSpacing=0>
<tbody>
<tr><td></td></tr>
<tr>
<td>
<%
if Session("Logined")="" then
%>
<FORM name=Form1 Action="CheckLogin.asp" method="Post">
<TABLE width=205 border="0" cellPadding=0 cellSpacing=0 id=login>
  <TBODY>
    <TR>
      <TD id=index_title background=images/title6.png colSpan=2 
      height=24>
        <P 
        style="PADDING-LEFT: 15px; FONT-WEIGHT: bold; COLOR: #ff9900">������¼</P></TD></TR>
    <TR>
  <TR>
    <TD width="30%" height="35" align=right>�û���</TD>
    <TD width="70%" height=35><input type="text" name="UserName" class=inputbox id="UserName" size=18 /></TD>
  </TR>
  <TR>
    <TD height="35" align=right>���룺</TD>
    <TD height=35><INPUT name="UserPwd" type=password class=inputbox id="UserPwd" size=18></TD></TR>
  <TR>
    <TD colSpan=2 height=26>
      <P align=center>��������?&nbsp;&nbsp; <A 
      href="UserReg.asp">����ע��</A></P></TD></TR>
  <TR>
    <TD colSpan=2 height=28>
	<P align=center><INPUT type=image 
      src="images/login_butten.png"></P></TD></TR></TBODY>
 </TABLE>
</FORM>
<%
else
%>
<TABLE width=205 border="0" cellPadding=0 cellSpacing=0 id=login>
	<TBODY>
    <TR>
      <TD id=index_title background=images/title6.png colSpan=2 
      height=24>
        <P 
        style="PADDING-LEFT: 15px; FONT-WEIGHT: bold; COLOR: #ff9900">������Ƭ</P></TD></TR>
	<TR>
	  <TD height="160">
	    <P align=center><img height=150 src="<%=Session("Photo_Url")%>" 
		width=120 border=0 alt="��Ƭ" /></P>      </TD>
	  </TR>
    <TR>
      <TD id=index_title background=images/title6.png colSpan=2 
      height=24>
        <P 
        style="PADDING-LEFT: 15px; FONT-WEIGHT: bold; COLOR: #ff9900">��Ϣ����</P></TD></TR>
	<TR>
	  <TD >
		<UL>
		  <LI><A href="UserBM.asp">��д������Ϣ</A> </LI>
		  <LI><A href="UserBK.asp">��д������Ϣ</A> </LI>
		  <LI><A href="RepPrint.asp?sRepName=Rep_Bmb.asp" target="_self">��ӡ[������]</A></LI>
		  <LI><A href="RepPrint.asp?sRepName=Rep_Zkz.asp" target="_self">��ӡ[׼��֤]</A></LI>
		  <LI><A href="LocateCj.asp" target="_self">���Գɼ���ѯ</A></LI>
		  <br>
		  <LI><A href="logout.asp"><FONT color=#ff0000>���˳���¼��</FONT></A></LI>
	  </UL>
      </TD>
	  </TR>
	</TBODY>
</TABLE>
<%
end if
%>
</td>
</tr>
</TR>
</Tbody>
</Table>