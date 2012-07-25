<!-- #include file="inc/WebSvcURL.asp" -->
<!-- #include file="inc/function.asp" -->
<!-- #include file="inc/security.asp" -->
<link href="images/style.css" type="text/css" rel="stylesheet"/>
<head>
<%
Dim TeacherNo,TeacherSfzh,jfxn,sfmc
TeacherSfzh=Request.Cookies("TeacherSfzh")
TeacherNo=Request.Cookies("TeacherNo")
jfxn=Request.Cookies("jfxn")
sfmc=Request.Cookies("sfmc")
'读取网银配置信息

%>
<title>交易结果查询</title>
</head>
<body>
<DIV id=payfrm>
<table id="c3" style="display" class=border cellSpacing=1 cellPadding=2 width="80%" align=center border=0>
<tr class=title>
  <td align=middle height=22  class="f_14_orange"><B> 提 示 信 息</B></td>
	</tr>
	<%
		Dim IsPaid
		'判断是否已缴费
		'通过身份证号获取学生是否已缴费信息
		If TeacherSfzh<>"" Then  
			IsPaid=objSOAPClient.StuIsPaidBySfzh(TeacherSfzh,jfxn,sfmc)
		'通过学号获取学生是否已缴费信息
		ElseIf TeacherNo<>"" Then  
			IsPaid=objSOAPClient.StuIsPaidByXH(TeacherNo,jfxn,sfmc)
		End If

		If IsPaid Then
	%>
			<tr class=tdbg>
			  <td align=center height="40"  class="f_14_grey">交费成功。点击历史缴费可查询到历史缴费信息。</td>
			</tr>
	<%
		Else
	%>
			<tr class=tdbg>
			  <td align=center height="40"  class="f_14_grey">可能还没有付款成功，请稍候再来查询。或者您查一下支付帐户的扣费状态，如果已经扣费，再来刷新一下这个状态。</td>
			</tr>
	<%
		End If
	%>	
	<tr class=tdbg>
	  <td align=center height="30">
	  <form name="display_state" id="display_state" action="" method="post" target="_self">
	  <input name="ask" id="ask" type="submit" value="查看交易状态"/>
	  </form>
	  </td>
	</tr>			
</table>
</DIV>
</body>