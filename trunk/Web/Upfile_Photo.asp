<!--#include file="inc/WebSvcURL.asp" -->
<!--#include file="inc/UpLoad_Config.asp"-->
<!--#include file="Inc/Upfile_Class.asp"-->
<%session("adminname")="name"%>
<%
const upload_type=0   '�ϴ�������0=�޾�������ϴ��࣬1=FSO�ϴ� 2=lyfupload��3=aspupload��4=chinaaspupload

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
	response.write "ϵͳδ�����ļ��ϴ�����"
else
	if Session("AdminName")="" then
		Response.Write("���¼����ʹ�ñ����ܣ�")
	else
		select case upload_type
			case 0
				call upload_0()  'ʹ�û���������ϴ���
			case else
				'response.write "��ϵͳδ���Ų������"
				'response.end
		end select
	end if
end if
%>
</body>
</html>
<%
sub upload_0()    'ʹ�û���������ϴ���
	set upload=new upfile_class ''�����ϴ�����
	'upload.GetData(104857600)   'ȡ���ϴ�����,��������ϴ�100M
	upload.GetData(200*1024)   'ȡ���ϴ�����,��������ϴ�200K����KBΪ��λ
	if upload.err > 0 then  '�������
		select case upload.err
			case 1
				'Response.write "����ѡ����Ҫ�ϴ����ļ���"
				msg = "����ѡ����Ҫ�ϴ����ļ���"
			case 2
				'Response.write "���ϴ����ļ��ܴ�С������������ƣ�200K��"
				msg = "���ϴ����ļ��ܴ�С������������ƣ�200K��"
		end select
		Response.Write "<script language=javascript> alert('" & msg & "  ');</script>"
		Response.end
	end if
	
	'==================================================
	'PhotoUrlID=Clng(Trim(upload.form("PhotoUrlID")))
	PhotoUrlID=3
	BmNo=upload.form("BmNo")			'�����
	'==================================================
	
	if PhotoUrlID>0 then
		SavePath = SaveUpFilesPath   '����ϴ��ļ���Ŀ¼
	else
		SavePath = SaveUpFilesPath   '����ϴ��ļ���Ŀ¼
	end if
	if right(SavePath,1)<>"/" then SavePath=SavePath&"/" '��Ŀ¼���(/)
		
	for each formName in upload.file '�г������ϴ��˵��ļ�
		set ofile=upload.file(formName)  '����һ���ļ�����
		oFileSize=ofile.filesize
		if oFileSize<100 then
			msg="����ѡ����Ҫ�ϴ����ļ���"
			FoundErr=True
		else
		 select case PhotoUrlID
		   case 0		 
		    if oFileSize>(MaxFileSize*1024) then
         	 msg="�ļ���С���������ƣ����ֻ���ϴ�" & CStr(MaxFileSize) & "K���ļ���"
			 FoundErr=true
		    end if
	       case 1
		    if oFileSize>(10000*1024) then
         	 msg="�ļ���С���������ƣ����ֻ���ϴ�10M���ļ���"
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
			msg="�����ļ����Ͳ������ϴ���\n\nֻ�����ϴ��⼸���ļ����ͣ�" & UpFileType & "  "
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

			ofile.SaveToFile Server.mappath(FileName)   '�����ļ�

			'===============================================================
			if BmNo<>"" then
				if objSOapClient.SetPhotoUrlByBmNo(BmNo,FileName) then
					Response.write "<script language=javascript> alert('ͼƬ�ϴ��ɹ���ͼƬ��СΪ��" & cstr(round(oFileSize/1024)) & "K');</script>"
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
