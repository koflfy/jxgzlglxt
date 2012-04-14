<SCRIPT language=javascript>
function check() 
{
	var strFileName=document.form1.aFileName.value;
	if (strFileName=="")
	{
    	alert("请选择要上传的文件");
		document.form1.FileName.focus();
    	return false;
  	}
}
</SCRIPT>
</head>
<style type="text/css">
<!--
body {
	margin-top: 0px;
	margin-left: 0px;
}
-->
</style>
<body>
<%
if Session("BmNo")="" then Response.Redirect "Index.asp"
Dim PhotoUrlId,PhotoFileName
PhotoUrlId=Trim(Request("PhotoUrlID"))
PhotoFileName=Trim(Request("PhotoFileName"))
if PhotoUrlID="" then
	PhotoUrlId="3"
end if

%>
<center>
<form action="Upfile_Photo.asp" method="post" name="form1" onSubmit="return check()" enctype="multipart/form-data">
	<input name="aFileName" type="FILE" size="6"><br>
    <input type="submit" name="Submit" value="开始上传新照片" >
    <input name="PhotoUrlID" type="hidden" id="PhotoUrlID" value="<%=Clng(PhotoUrlID)%>">
    <input name="BmNo" type="hidden" id="BmNo" value='<%=Session("BmNo")%>'>
</form>
</center>