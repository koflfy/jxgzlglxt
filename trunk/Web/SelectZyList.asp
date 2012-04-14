<%
Dim Param
Param = Request.QueryString("Param")
Response.Redirect( "UserBK.asp?Param="&Param)
%>
