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
'��ȡ����������Ϣ

%>
<title>���׽����ѯ</title>
</head>
<body>
<DIV id=payfrm>
<table id="c3" style="display" class=border cellSpacing=1 cellPadding=2 width="80%" align=center border=0>
<tr class=title>
  <td align=middle height=22  class="f_14_orange"><B> �� ʾ �� Ϣ</B></td>
	</tr>
	<%
		Dim IsPaid
		'�ж��Ƿ��ѽɷ�
		'ͨ�����֤�Ż�ȡѧ���Ƿ��ѽɷ���Ϣ
		If TeacherSfzh<>"" Then  
			IsPaid=objSOAPClient.StuIsPaidBySfzh(TeacherSfzh,jfxn,sfmc)
		'ͨ��ѧ�Ż�ȡѧ���Ƿ��ѽɷ���Ϣ
		ElseIf TeacherNo<>"" Then  
			IsPaid=objSOAPClient.StuIsPaidByXH(TeacherNo,jfxn,sfmc)
		End If

		If IsPaid Then
	%>
			<tr class=tdbg>
			  <td align=center height="40"  class="f_14_grey">���ѳɹ��������ʷ�ɷѿɲ�ѯ����ʷ�ɷ���Ϣ��</td>
			</tr>
	<%
		Else
	%>
			<tr class=tdbg>
			  <td align=center height="40"  class="f_14_grey">���ܻ�û�и���ɹ������Ժ�������ѯ����������һ��֧���ʻ��Ŀ۷�״̬������Ѿ��۷ѣ�����ˢ��һ�����״̬��</td>
			</tr>
	<%
		End If
	%>	
	<tr class=tdbg>
	  <td align=center height="30">
	  <form name="display_state" id="display_state" action="" method="post" target="_self">
	  <input name="ask" id="ask" type="submit" value="�鿴����״̬"/>
	  </form>
	  </td>
	</tr>			
</table>
</DIV>
</body>