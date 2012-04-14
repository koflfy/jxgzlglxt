<div align="Center">
<img src="images/top.png" alt="top" border="0" />
</div>
<table width="1000" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="360" nowrap="nowrap">	
        <div align="left">|
<a class="top" href="index.asp"><span>报名首页</span></a>&nbsp;| 
<%if Session("Logined")<>"" then %>
<a class="top" href="RepPrint.asp?sRepName=Rep_Bmb.asp" target="_self"><span>打印报名表</span></a>&nbsp;|
<a class="top" href="RepPrint.asp?sRepName=Rep_Zkz.asp" target="_self"><span>打印准考证</span></a>&nbsp;|
<a class="top" href="LocateCj.asp" target="_self"><span>成绩查询</span></a>&nbsp;|
<%else%>
<span>打印报名表</span>&nbsp;|
<span>打印准考证</span>&nbsp;|
<span>成绩查询</span>&nbsp;|
<%end if%>
	  </div>
	</td>
    <td width="100%">
        <div align="right">
<%if Session("Logined")<>"" then %>	
	|&nbsp;当前已登录用户：<%=Session("UserName")%>&nbsp;|&nbsp;考生报名序号：<%=Session("BmNo")%>&nbsp;|&nbsp;<a href="logout.asp"><font color="#ff0000">退出登录</font></a>&nbsp;|
<%else%>
	|&nbsp;考生未登录&nbsp;|　
<%end if%>
</div>
	</td>
  </tr>
</table>
