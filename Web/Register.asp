<HEAD><TITLE>江西科技师范学院专升本报名网</TITLE>
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
    <td colspan="4" align="left" class="bg">用户已注册信息</td>
    </tr>
  <tr>
    <td width="100" align="right" bgcolor="#FFFFFF" class="tr1">用户登录名</td>
    <td colspan="3" bgcolor="#FFFFFF" class="tr1">
      <%=Session("UserName")%> </td>
    </tr>
  <tr>
    <td align="right" bgcolor="#FFFFFF" class="tr1">身份证号</td>
    <td colspan="3" bgcolor="#FFFFFF" class="tr1"><%=Session("Sfzh")%></td>
  </tr>
  <tr>
    <td colspan="4" align="left" class="bg">报名信息</td>
    </tr>
  <tr>
    <td align="right" bgcolor="#FFFFFF" class="tr1">姓名</td>
    <td bgcolor="#FFFFFF" class="tr1"><input name="un" type="text" >
      *</td>
    <td width="163" rowspan="8" bgcolor="#FFFFFF" class="tr1"> 　　 　 　 　 　　　　　　</td>
  </tr>
  <tr>
    <td align="right" bgcolor="#FFFFFF" class="tr1">性别</td>
    <td bgcolor="#FFFFFF" class="tr1">　
	
      <input name="xb" type="radio" value="男" checked="" id="男"/><label for="男"> 男</label>
      <input name="xb" type="radio" value="女" id="女"/><label for="女"> 女</label>      *	</td>
    </tr>
    <tr><td align="right" bgcolor="#FFFFFF" class="tr1">考生号</td>
    <td bgcolor="#FFFFFF" class="tr1"><input name="un" type="text" >
      *</td>
    </tr>
  <tr>
    <td align="right" bgcolor="#FFFFFF" class="tr1">身份证号</td>
    <td bgcolor="#FFFFFF" class="tr1"><%=Session("Sfzh")%>
      *</td>
    </tr>
  <tr>
    <td align="right" bgcolor="#FFFFFF" class="tr1">民族</td>
    <td bgcolor="#FFFFFF" class="tr1">
	<select name="Mz" id="Mz">
	<option>汉族</option>
	</select>
      *</td>
    </tr>
  <tr>
    <td align="right" nowrap="nowrap" bgcolor="#FFFFFF" class="tr1">政治面貌</td>
    <td bgcolor="#FFFFFF" class="tr1">
	<select name="ZzMm" id="ZzMm">
	<option>中共党员</option>
	</select>
      *</td>
    </tr>
  <tr>
    <td align="right" nowrap="nowrap" bgcolor="#FFFFFF" class="tr1">现就读学校</td>
    <td bgcolor="#FFFFFF" class="tr1"><input name="sr" type="text" size="50">
      *</td>
    </tr>
  <tr>
    <td align="right" bgcolor="#FFFFFF" class="tr1">所学专业</td>
    <td bgcolor="#FFFFFF" class="tr1"><input name="tel" type="text" size="40">
      *</td>
    </tr>
  <tr>
    <td align="right" bgcolor="#FFFFFF" class="tr1">特长</td>
    <td bgcolor="#FFFFFF" class="tr1"><input name="qq" type="text" size="60"></td>
    <td width="163" bgcolor="#FFFFFF" class="tr1">&nbsp;</td>
  </tr>
  
  <tr>
    <td align="right" nowrap="nowrap" bgcolor="#FFFFFF" class="tr1">暑期通讯地址</td>
    <td bgcolor="#FFFFFF" class="tr1"><input name="xl" type="text" id="xl" />
      *</td>
    <td width="163" bgcolor="#FFFFFF" class="tr1">&nbsp;</td>
  </tr>
  <tr>
    <td align="right" bgcolor="#FFFFFF" class="tr1">邮政编码</td>
    <td bgcolor="#FFFFFF" class="tr1"><input name="dz" type="text" size="40"></td>
    <td width="163" bgcolor="#FFFFFF" class="tr1">&nbsp;</td>
  </tr>
  <tr>
    <td align="right" bgcolor="#FFFFFF" class="tr1">暑期联系电话</td>
    <td bgcolor="#FFFFFF" class="tr1"><input name="email" type="text" size="40" /></td>
    <td bgcolor="#FFFFFF" class="tr1"></td>
    </tr>
  <tr>
    <td align="right" bgcolor="#FFFFFF" class="tr1">照片地址</td>
    <td bgcolor="#FFFFFF" class="tr1">
      <input name="img" type="text" class="inputtext" size="30" maxlength="50" /></td>
    <td bgcolor="#FFFFFF" class="tr1">
      　</td>
  </tr>
  <tr>
    <td align="right" bgcolor="#FFFFFF" class="tr1">上传照片</td>
    <td bgcolor="#FFFFFF" class="tr1">
      <iframe style="top:2px" id="UploadFiles" src="Upload_Photo.asp?PhotoUrlID=3" frameborder="0" scrolling="No" width="400" height="22" name="I1"></iframe>    </td>
    <td bgcolor="#FFFFFF" class="tr1">
      　</td>
    </tr>
  <tr>
    <td align="right" bgcolor="#FFFFFF" class="tr1">　</td>
    <td colspan="2" align="right" bgcolor="#FFFFFF" class="tr1"><a href="Upload_index.asp" target="_blank"></a></td>
  </tr>
  <tr>
    <td align="right" bgcolor="#FFFFFF" class="tr1">受奖励情况</td>
    <td bgcolor="#FFFFFF" class="tr1"><input name="qq" type="text" size="60"></td>
    <td bgcolor="#FFFFFF" class="tr1"></td>
    </tr>
  <tr>
    <td align="right" bgcolor="#FFFFFF" class="tr1">专业综合<br />
      测评情况</td>
    <td colspan="3" bgcolor="#FFFFFF" class="tr1"><textarea name="jj" cols="95" rows="4"></textarea>    </td>
  </tr>
    <td align="right" bgcolor="#FFFFFF" class="tr1">专业综合<br />
      测评情况</td>
    <td colspan="3" bgcolor="#FFFFFF" class="tr1"><textarea name="jj" cols="95" rows="4"></textarea>    </td>
  </tr>
  <tr>
    <td colspan="4" align="right" bgcolor="#FFFFFF" class="tr1">　</td>
    </tr>
  <tr>
    <td colspan="4" align="left" class="bg"> 选报专业</td>
    </tr>
  <tr>
    <td height="21" colspan="4" align="left" bgcolor="#FFFFFF" class="bg2">　</td>
    </tr>
<tr>
    <td align="right" bgcolor="#FFFFFF" class="tr1">报考科类</td>
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
     
    <td bgcolor="#FFFFFF" class="tr1">　</td>
    </tr>
<tr>
    <td height="26" align="center" bgcolor="#FFFFFF" class="bg3">编号</td>
    <td width="719" bgcolor="#FFFFFF" class="bg3">　专业名称</td>
    <td colspan="2" bgcolor="#FFFFFF" class="bg3"> 　报名说明(点击简要说明可看相关祥细介绍) </td>
    </tr>

  
<% do while not rs.eof %> 

  <tr bgcolor="#FFFFFF" <% 'if i mod 2=0 then Response.write"class=bg2" else response.write"class=bg4"%> onMouseOver="javascript:this.bgColor='#E6F7FB';"onMouseOut="javascript:this.bgColor='#FFFFFF';" >	 
    <td align="center" class="tr1"><%=i%></td>
   
    <td class="tr1">
	　
	  <input name="zy" type="radio" value="<%=rs("zy")%>" id="<%=rs("id")%>" /><label for="<%=rs("id")%>"> <%=rs("zy")%>
	</label></td>
    <td colspan="2" class="tr1"><a href="sm.asp?id=<%=rs("id")%>"><%=cut(rs("zysm"),36)%></a> 　 <%=rs("kc")%></td>
    </tr>
      <%rs.movenext%>
      <% loop %>
        <tr>
    <td height="30" colspan="4" align="left" bgcolor="#FFFFFF" class="tr1">　　注意：带 * 的为必要内容, 带 # 的为
	有要求的同学选填,您可根据所填报专业要求填写!</td>
    </tr>
	    
		 
  <tr>
    <td colspan="4" bgcolor="#FFFFFF"><p>
      　　　　　　　　　　　　　　　　　
      <input name="Submit" type="submit" class="aniu" value="提交">
    </p>      </td>
    </tr>
</table>
</form>
<!--#include file= "bottom.asp"-->
