<HEAD><TITLE>�����Ƽ�ʦ��ѧԺר����������</TITLE>
<META http-equiv=Content-Type content="text/html; charset=gb2312"><LINK 
href="images/main_right.css" type=text/css rel=stylesheet>
<SCRIPT language=javascript src="images/ShowProcessBar.js"></SCRIPT>

<META content="MSHTML 6.00.3790.4807" name=GENERATOR>
<script src="Scripts/AC_RunActiveContent.js" type="text/javascript"></script>
</HEAD>
<!--#include file= "top.asp"-->
<form action="user/user_zhuche_bc.asp" method="post" name="myform" id="user">
<table width="1000" border="0" align="center" cellpadding="2" cellspacing="1" bgcolor="#A8D9EC" class="bx">
  <tr>
    <td colspan="4" align="left" class="bg">�û���ע����Ϣ</td>
    </tr>
  <tr>
    <td width="100" align="right" bgcolor="#FFFFFF" class="tr1">�û���¼��</td>
    <td colspan="3" bgcolor="#FFFFFF" class="tr1">
      <%=Session("UserName")%> </td>
    </tr>
  <tr>
    <td align="right" bgcolor="#FFFFFF" class="tr1">���֤��</td>
    <td colspan="3" bgcolor="#FFFFFF" class="tr1"><%=Session("Sfzh")%></td>
  </tr>
  <tr>
    <td colspan="4" align="left" class="bg">������Ϣ</td>
    </tr>
  <tr>
    <td align="right" bgcolor="#FFFFFF" class="tr1">����</td>
    <td bgcolor="#FFFFFF" class="tr1"><input name="un" type="text" >
      *</td>
    <td width="163" rowspan="8" bgcolor="#FFFFFF" class="tr1"> ���� �� �� �� ������������</td>
  </tr>
  <tr>
    <td align="right" bgcolor="#FFFFFF" class="tr1">�Ա�</td>
    <td bgcolor="#FFFFFF" class="tr1">��
	
      <input name="xb" type="radio" value="��" checked="" id="��"/><label for="��"> ��</label>
      <input name="xb" type="radio" value="Ů" id="Ů"/><label for="Ů"> Ů</label>      *	</td>
    </tr>
    <tr><td align="right" bgcolor="#FFFFFF" class="tr1">������</td>
    <td bgcolor="#FFFFFF" class="tr1"><input name="un" type="text" >
      *</td>
    </tr>
  <tr>
    <td align="right" bgcolor="#FFFFFF" class="tr1">���֤��</td>
    <td bgcolor="#FFFFFF" class="tr1"><%=Session("Sfzh")%>
      *</td>
    </tr>
  <tr>
    <td align="right" bgcolor="#FFFFFF" class="tr1">����</td>
    <td bgcolor="#FFFFFF" class="tr1">
	<select name="Mz" id="Mz">
	<option>����</option>
	</select>
      *</td>
    </tr>
  <tr>
    <td align="right" nowrap="nowrap" bgcolor="#FFFFFF" class="tr1">������ò</td>
    <td bgcolor="#FFFFFF" class="tr1">
	<select name="ZzMm" id="ZzMm">
	<option>�й���Ա</option>
	</select>
      *</td>
    </tr>
  <tr>
    <td align="right" nowrap="nowrap" bgcolor="#FFFFFF" class="tr1">�־Ͷ�ѧУ</td>
    <td bgcolor="#FFFFFF" class="tr1"><input name="sr" type="text" size="50">
      *</td>
    </tr>
  <tr>
    <td align="right" bgcolor="#FFFFFF" class="tr1">��ѧרҵ</td>
    <td bgcolor="#FFFFFF" class="tr1"><input name="tel" type="text" size="40">
      *</td>
    </tr>
  <tr>
    <td align="right" bgcolor="#FFFFFF" class="tr1">�س�</td>
    <td bgcolor="#FFFFFF" class="tr1"><input name="qq" type="text" size="60"></td>
    <td width="163" bgcolor="#FFFFFF" class="tr1">&nbsp;</td>
  </tr>
  
  <tr>
    <td align="right" nowrap="nowrap" bgcolor="#FFFFFF" class="tr1">����ͨѶ��ַ</td>
    <td bgcolor="#FFFFFF" class="tr1"><input name="xl" type="text" id="xl" />
      *</td>
    <td width="163" bgcolor="#FFFFFF" class="tr1">&nbsp;</td>
  </tr>
  <tr>
    <td align="right" bgcolor="#FFFFFF" class="tr1">��������</td>
    <td bgcolor="#FFFFFF" class="tr1"><input name="dz" type="text" size="40"></td>
    <td width="163" bgcolor="#FFFFFF" class="tr1">&nbsp;</td>
  </tr>
  <tr>
    <td align="right" bgcolor="#FFFFFF" class="tr1">������ϵ�绰</td>
    <td bgcolor="#FFFFFF" class="tr1"><input name="email" type="text" size="40" /></td>
    <td bgcolor="#FFFFFF" class="tr1"></td>
    </tr>
  <tr>
    <td align="right" bgcolor="#FFFFFF" class="tr1">��Ƭ��ַ</td>
    <td bgcolor="#FFFFFF" class="tr1">
      <input name="img" type="text" class="inputtext" size="30" maxlength="50" /></td>
    <td bgcolor="#FFFFFF" class="tr1">
      ��</td>
  </tr>
  <tr>
    <td align="right" bgcolor="#FFFFFF" class="tr1">�ϴ���Ƭ</td>
    <td bgcolor="#FFFFFF" class="tr1">
      <iframe style="top:2px" id="UploadFiles" src="Upload_Photo.asp?PhotoUrlID=3" frameborder="0" scrolling="No" width="400" height="22" name="I1"></iframe>    </td>
    <td bgcolor="#FFFFFF" class="tr1">
      ��</td>
    </tr>
  <tr>
    <td align="right" bgcolor="#FFFFFF" class="tr1">��</td>
    <td colspan="2" align="right" bgcolor="#FFFFFF" class="tr1"><a href="Upload_index.asp" target="_blank"></a></td>
  </tr>
  <tr>
    <td align="right" bgcolor="#FFFFFF" class="tr1">�ܽ������</td>
    <td bgcolor="#FFFFFF" class="tr1"><input name="qq" type="text" size="60"></td>
    <td bgcolor="#FFFFFF" class="tr1"></td>
    </tr>
  <tr>
    <td align="right" bgcolor="#FFFFFF" class="tr1">רҵ�ۺ�<br />
      �������</td>
    <td colspan="3" bgcolor="#FFFFFF" class="tr1"><textarea name="jj" cols="95" rows="4"></textarea>    </td>
  </tr>
    <td align="right" bgcolor="#FFFFFF" class="tr1">רҵ�ۺ�<br />
      �������</td>
    <td colspan="3" bgcolor="#FFFFFF" class="tr1"><textarea name="jj" cols="95" rows="4"></textarea>    </td>
  </tr>
  <tr>
    <td colspan="4" align="right" bgcolor="#FFFFFF" class="tr1">��</td>
    </tr>
  <tr>
    <td colspan="4" align="left" class="bg"> ѡ��רҵ</td>
    </tr>
  <tr>
    <td height="21" colspan="4" align="left" bgcolor="#FFFFFF" class="bg2">��</td>
    </tr>
<tr>
    <td align="right" bgcolor="#FFFFFF" class="tr1">��������</td>
    <td bgcolor="#FFFFFF" class="tr1">
	<select name="xx" type="text" id="xx" size="1">
<%
xysa="select * from xueyuan"
set rs=server.CreateObject("adodb.recordset")
rs.open xysa,conn,1,1
%>
<% do while not rs.eof %> 
  	<option><%=rs("xueyuan")%></option>
	<% rs.movenext %>
	<% loop %>
    <% rs.close
    exec="select * from zhuanye"
set rs=server.CreateObject("adodb.recordset")
     rs.open exec,conn,1,1%>
	</select>



<%
img=server.htmlencode(Trim(Request("img")))
%>
      *</td>
     
    <td bgcolor="#FFFFFF" class="tr1">��</td>
    </tr>
<tr>
    <td height="26" align="center" bgcolor="#FFFFFF" class="bg3">���</td>
    <td width="719" bgcolor="#FFFFFF" class="bg3">��רҵ����</td>
    <td colspan="2" bgcolor="#FFFFFF" class="bg3"> ������˵��(�����Ҫ˵���ɿ������ϸ����) </td>
    </tr>

  
<% do while not rs.eof %> 

  <tr bgcolor="#FFFFFF" <% 'if i mod 2=0 then Response.write"class=bg2" else response.write"class=bg4"%> onMouseOver="javascript:this.bgColor='#E6F7FB';"onMouseOut="javascript:this.bgColor='#FFFFFF';" >	 
    <td align="center" class="tr1"><%=i%></td>
   
    <td class="tr1">
	��
	  <input name="zy" type="radio" value="<%=rs("zy")%>" id="<%=rs("id")%>" /><label for="<%=rs("id")%>"> <%=rs("zy")%>
	</label></td>
    <td colspan="2" class="tr1"><a href="sm.asp?id=<%=rs("id")%>"><%=cut(rs("zysm"),36)%></a> �� <%=rs("kc")%></td>
    </tr>
      <%rs.movenext%>
      <% loop %>
        <tr>
    <td height="30" colspan="4" align="left" bgcolor="#FFFFFF" class="tr1">����ע�⣺�� * ��Ϊ��Ҫ����, �� # ��Ϊ
	��Ҫ���ͬѧѡ��,���ɸ������רҵҪ����д!</td>
    </tr>
	    
		 
  <tr>
    <td colspan="4" bgcolor="#FFFFFF"><p>
      ����������������������������������
      <input name="Submit" type="submit" class="aniu" value="�ύ">
    </p>      </td>
    </tr>
</table>
</form>
<!--#include file= "bottom.asp"-->
