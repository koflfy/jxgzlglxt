<!-- #include file="inc/WebSvcURL.asp" -->
<%
Dim CardType,CardNo,StudentName,StudentNo,verifycode,StuSfzh
Dim LoginSuccess
CardType=Trim(request("CardType"))
CardNo=Trim(Request("CardNo"))
StudentName=Trim(request("StudentName"))
verifycode=Trim(request("verifycode"))

If CardNo="" or StudentName="" Then Response.redirect "show_error.asp?eid=证件号码或姓名不能为空!"
If verifycode="" Then response.redirect "show_error.asp?eid=验证码不能为空!"
If cstr(session("getcode"))<>cstr(verifycode) then response.redirect "show_error.asp?eid=验证码出现错误!"

If CardType="学生证" Then
	StudentNo=Trim(Request("CardNo"))
   response.cookies("LoginIp")=Request.servervariables("REMOTE_ADDR")
	LoginSuccess  = objSOAPClient.StuLoginByXH(StudentNo,StudentName)
 	Response.Cookies("StudentNo")=StudentNo	
Else
 	StuSfzh=Trim(Request("CardNo"))	
   response.cookies("LoginIp")=Request.servervariables("REMOTE_ADDR")
	LoginSuccess =objSOAPClient.StuLoginBySfzh(StuSfzh,StudentName) 	   
	Response.Cookies("StuSfzh")=StuSfzh
End If
  
If LoginSuccess  then
	response.redirect "index.asp"
else
  	Response.redirect "show_error.asp?eid=证件号或姓名不正确!"
end if
%>