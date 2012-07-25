<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<title>教学工作量查询系统登陆</title>
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
	background-color: #1D3647;
}
-->
</style>
<script language="JavaScript">
function correctPNG()
{
    var arVersion = navigator.appVersion.split("MSIE")
    var version = parseFloat(arVersion[1])
    if ((version >= 5.5) && (document.body.filters)) 
    {
       for(var j=0; j<document.images.length; j++)
       {
          var img = document.images[j]
          var imgName = img.src.toUpperCase()
          if (imgName.substring(imgName.length-3, imgName.length) == "PNG")
          {
             var imgID = (img.id) ? "id='" + img.id + "' " : ""
             var imgClass = (img.className) ? "class='" + img.className + "' " : ""
             var imgTitle = (img.title) ? "title='" + img.title + "' " : "title='" + img.alt + "' "
             var imgStyle = "display:inline-block;" + img.style.cssText 
             if (img.align == "left") imgStyle = "float:left;" + imgStyle
             if (img.align == "right") imgStyle = "float:right;" + imgStyle
             if (img.parentElement.href) imgStyle = "cursor:hand;" + imgStyle
             var strNewHTML = "<span " + imgID + imgClass + imgTitle
             + " style=\"" + "width:" + img.width + "px; height:" + img.height + "px;" + imgStyle + ";"
             + "filter:progid:DXImageTransform.Microsoft.AlphaImageLoader"
             + "(src=\'" + img.src + "\', sizingMethod='scale');\"></span>" 
             img.outerHTML = strNewHTML
             j = j-1
          }
       }
    }    
}
window.attachEvent("onload", correctPNG);
</script>
<link href="images/style.css" rel="stylesheet" type="text/css">
</head>
<body>
<center>
<table width="1088" height="166" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="42" valign="top">
			<table class="login_top_bg" width="100%" height="42" border="0" cellpadding="0" cellspacing="0" >
      <tr>
        <td width="1%" height="21">&nbsp;</td>
        <td height="42">&nbsp;</td>
        <td width="17%">&nbsp;</td>
      </tr>
    </table>
	</td>
  </tr>
	<tr>
    <td valign="top">
		<table width="100%" height="532" border="0" align="center" cellpadding="0" cellspacing="0" class="login_bg">
      <tr>
        <td width="30%" >&nbsp;</td>
        <td width="70%" valign="bottom">
				  <table width="100%" height="59" border="0" align="center" cellpadding="0" cellspacing="0">
            <tr>
              <td width="96%" height="38" class="login_txt_bt"><img src="images/logo.gif" width="279" height="68"></td>
            </tr>
            <tr>
              <td width="96%" height="38" class="login_txt_bt">用户登录 </td>
            </tr>
            <tr>
              <td height="21">
								<table cellSpacing="0" cellPadding="0" width="100%" border="0" id="table211" height="328">
                  <tr>
                    <td height="164" colspan="2" align="middle"><form name="myform" action="checklogin.asp" method="post">
                        <table id="table212"cellSpacing="0" cellPadding="0" width="100%" border="0" height="178" >
                          <tr>
                            <td width="15%" height="38" class="login_txt">选择角色：</td>
                            <td height="38" colspan="2" class="login_txt"><p>
                              <select name="LoginType">
                                <option>任课教师</option>
                              </select>
                            </td>
                          </tr>
                          <tr>
                            <td width="15%" height="35" class="login_txt">教师工号：&nbsp;&nbsp;</td>
                            <td height="35" colspan="2" class="login_txt"><input name="TeacherNo" class="editbox4" id="TeacherNo" value="" size="20" maxlength="18"></td>
                          </tr>
                          <tr>
                            <td width="15%" height="35" class="login_txt">教师姓名： </td>
                            <td height="35" colspan="2" class=""><input name="TeacherName" class="editbox4" id="TeacherName" value="" size="20"></td>
                          </tr>
                          <tr>
                            <td width="15%" height="35" class="login_txt">验证码：</td>
                            <td  height="35" >
                              <input class=wenbenkuang name=verifycode type=text value="" maxlength=4 size=10>
                              <%=getcode1()%></td>
                            <td width="61%">&nbsp;</td>
                          </tr>
                          <tr>
                            <td height="45" >&nbsp;</td>
                            <td height="45" >
														  <input name="Submit" type="submit" class="button" id="Submit" value="登 录">　 
															<input name="cs" type="button" class="button" id="cs" value="取 消" onClick="showConfirmMsg1()"></td>
                            <td>&nbsp;</td>
                          </tr>
                        </table>
                        <br>
                    </form></td>
                  </tr>
                  <tr>
                    <td width="433" height="144" align="right" valign="bottom">
												<img src="images/login-wel.gif" width="242" height="138">										</td>
                    <td width="57" align="right" valign="bottom">&nbsp;</td>
                  </tr>
              </table></td>
            </tr>
          </table>          </td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td height="30"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="login_bottom_bg">
      <tr>
        <td align="center"><span class="login_bottom_txt">Copyright &copy; 2009-2012 江西科技师范大学</span></td>
      </tr>
    </table></td>
  </tr>
</table>
<%
'显示验证码
Function getcode1()
	Dim test
	On Error Resume Next
	Set test=Server.CreateObject("Adodb.Stream")
	Set test=Nothing
	If Err Then
		Dim zNum
		Randomize timer
		zNum = cint(8999*Rnd+1000)
		Session("GetCode") = zNum
		getcode1= Session("GetCode")		
	Else
		getcode1= "<img src=""getcode.asp"">"		
	End If
End Function
%>
</body></html>