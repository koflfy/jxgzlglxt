<!--#include file="inc/WebSvcURL.asp" -->
<!--#include file="inc/UpLoad_Config.asp"-->
<!--#include file="Inc/Upfile_Class.asp"-->
<%session("adminname")="name"%>
<%
const upload_type=0   '上传方法：0=无惧无组件上传类，1=FSO上传 2=lyfupload，3=aspupload，4=chinaaspupload

dim upload,oFile,formName,SavePath,FileName,fileExt,oFileSize
dim EnableUpload
dim arrUpFileType
dim ranNum
dim msg,FoundErr
dim PhotoUrlID,BmNo

msg=""
FoundErr=false
EnableUpload=false

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">

</head>
<body leftmargin="2" topmargin="5" marginwidth="0" marginheight="0" >
<%
if EnableUploadFile="No" then
	response.write "系统未开放文件上传功能"
else
	if Session("AdminName")="" then
		Response.Write("请登录后再使用本功能！")
	else
		select case upload_type
			case 0
				call upload_0()  '使用化境无组件上传类
			case else
				'response.write "本系统未开放插件功能"
				'response.end
		end select
	end if
end if
%>
</body>
</html>
<%
sub upload_0()    '使用化境无组件上传类
	set upload=new upfile_class ''建立上传对象
	'upload.GetData(104857600)   '取得上传数据,限制最大上传100M
	upload.GetData(200*1024)   '取得上传数据,限制最大上传200K，以KB为单位
	if upload.err > 0 then  '如果出错
		select case upload.err
			case 1
				'Response.write "请先选择你要上传的文件！"
				msg = "请先选择你要上传的文件！"
			case 2
				'Response.write "你上传的文件总大小超出了最大限制（200K）"
				msg = "你上传的文件总大小超出了最大限制（200K）"
		end select
		Response.Write "<script language=javascript> alert('" & msg & "  ');</script>"
		Response.end
	end if
	
	'==================================================
	'PhotoUrlID=Clng(Trim(upload.form("PhotoUrlID")))
	PhotoUrlID=3
	BmNo=upload.form("BmNo")			'必须的
	'==================================================
	
	if PhotoUrlID>0 then
		SavePath = SaveUpFilesPath   '存放上传文件的目录
	else
		SavePath = SaveUpFilesPath   '存放上传文件的目录
	end if
	if right(SavePath,1)<>"/" then SavePath=SavePath&"/" '在目录后加(/)
		
	for each formName in upload.file '列出所有上传了的文件
		set ofile=upload.file(formName)  '生成一个文件对象
		oFileSize=ofile.filesize
		if oFileSize<100 then
			msg="请先选择你要上传的文件！"
			FoundErr=True
		else
		 select case PhotoUrlID
		   case 0		 
		    if oFileSize>(MaxFileSize*1024) then
         	 msg="文件大小超过了限制，最大只能上传" & CStr(MaxFileSize) & "K的文件！"
			 FoundErr=true
		    end if
	       case 1
		    if oFileSize>(10000*1024) then
         	 msg="文件大小超过了限制，最大只能上传10M的文件！"
			 FoundErr=true
		    end if
		 end select		
		end if

		fileExt=lcase(ofile.FileExt)
		arrUpFileType=split(UpFileType,"|")
		
		dim i,strJS,ranNum
		
		for i=0 to ubound(arrUpFileType)
			if fileEXT=trim(arrUpFileType(i)) then
				EnableUpload=true
				exit for
			end if
		next
		if fileEXT="asp" or fileEXT="asa" or fileEXT="aspx" or fileEXT="php" or fileEXT="jsp" then
			EnableUpload=false
		end if
		if EnableUpload=false then
			msg="这种文件类型不允许上传！\n\n只允许上传这几种文件类型：" & UpFileType & "  "
			FoundErr=true
		end if
		
		
		strJS="<SCRIPT language=javascript>" & vbcrlf
		if FoundErr<>true then
			if BmNo="" then
				randomize
				ranNum=int(900*rnd)+100
				Filename=SavePath&year(now)&month(now)&day(now)&hour(now)&minute(now)&second(now)&ranNum&"."&fileExt
			'===============================================================
			else
				FileName=SavePath&BmNo&"."&fileExt
			end if
			'===============================================================

			ofile.SaveToFile Server.mappath(FileName)   '保存文件

			'===============================================================
			if BmNo<>"" then
				if objSOapClient.SetPhotoUrlByBmNo(BmNo,FileName) then
					Response.write "<script language=javascript> alert('图片上传成功！图片大小为：" & cstr(round(oFileSize/1024)) & "K');</script>"
					Session("Photo_Url")=FileName
				end if
			end if
			'===============================================================
			select case PhotoUrlID
				case 0
					strJS=strJS & "parent.document.addNEWS.PhotoUrl.value='" & fileName & "';" & vbcrlf
					strJS=strJS & "parent.document.addNEWS.PhotoSize1.value='" & cstr(round(oFileSize/1024)) & "';" & vbcrlf
				case 1
					strJS=strJS & "parent.document.addNEWS.DownloadUrl.value='" & fileName & "';" & vbcrlf
					strJS=strJS & "parent.document.addNEWS.FileSize.value='" & cstr(round(oFileSize/1024)) & "';" & vbcrlf
				case 2
					strJS=strJS & "parent.document.addNEWS.PhotoUrl2.value='" & fileName & "';" & vbcrlf
					strJS=strJS & "parent.document.addNEWS.PhotoSize2.value='" & cstr(round(oFileSize/1024)) & "';" & vbcrlf
				case 3
					strJS=strJS & "parent.document.form1.Photo.src='" & BmNo & "';" & vbcrlf
					strJS=strJS & "parent.document.form1.Photo.src='" & fileName & "';" & vbcrlf
					'strJS=strJS & "parent.document.form1.Photo.src='" & fileName & "';" & vbcrlf
					'strJS=strJS & "parent.document.addNEWS.PhotoSize3.value='" & cstr(round(oFileSize/1024)) & "';" & vbcrlf
				case 4
					strJS=strJS & "parent.document.addNEWS.PhotoUrl4.value='" & fileName & "';" & vbcrlf
					strJS=strJS & "parent.document.addNEWS.PhotoSize4.value='" & cstr(round(oFileSize/1024)) & "';" & vbcrlf
			end select
		else
			strJS=strJS & "alert('" & msg & "');" & vbcrlf
		  	strJS=strJS & "history.go(-1);" & vbcrlf
		end if
		strJS=strJS & "</script>" & vbcrlf
		Response.Write strJS
		
		set ofile=nothing
	next
	set upload=nothing
end sub
%>
