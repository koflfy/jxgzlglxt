<div align="Center">
<img src="images/top.png" alt="top" border="0" />
</div>
<table width="1000" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="360" nowrap="nowrap">	
        <div align="left">|
<a class="top" href="index.asp"><span>������ҳ</span></a>&nbsp;| 
<%if Session("Logined")<>"" then %>
<a class="top" href="RepPrint.asp?sRepName=Rep_Bmb.asp" target="_self"><span>��ӡ������</span></a>&nbsp;|
<a class="top" href="RepPrint.asp?sRepName=Rep_Zkz.asp" target="_self"><span>��ӡ׼��֤</span></a>&nbsp;|
<a class="top" href="LocateCj.asp" target="_self"><span>�ɼ���ѯ</span></a>&nbsp;|
<%else%>
<span>��ӡ������</span>&nbsp;|
<span>��ӡ׼��֤</span>&nbsp;|
<span>�ɼ���ѯ</span>&nbsp;|
<%end if%>
	  </div>
	</td>
    <td width="100%">
        <div align="right">
<%if Session("Logined")<>"" then %>	
	|&nbsp;��ǰ�ѵ�¼�û���<%=Session("UserName")%>&nbsp;|&nbsp;����������ţ�<%=Session("BmNo")%>&nbsp;|&nbsp;<a href="logout.asp"><font color="#ff0000">�˳���¼</font></a>&nbsp;|
<%else%>
	|&nbsp;����δ��¼&nbsp;|��
<%end if%>
</div>
	</td>
  </tr>
</table>
