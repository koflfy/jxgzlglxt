<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>
<%
	OPTION  EXPLICIT  
	dim sUrl,gbBackUrl,sError
	sUrl="http://" & Request.ServerVariables("HTTP_HOST") & Request.ServerVariables("HTTP_URL")
	sUrl=left(sUrl,instrRev(sUrl,"/"))		'�õ�����һ��������Ŀ¼��Urlֵ
	gbBackUrl=sUrl
	
	Const gbWebServiceUrl="http://localhost/ZsbBm/Srv/ZsbBmWebSrv.dll/wsdl/IZsbBm"

	Dim  strWebSvcWSDLURL  
	Dim  objSOAPClient    
	strWebSvcWSDLURL = gbWebServiceUrl
	'strWebSvcWSDLURL = "http://localhost:8081/ZsbBmWadSrv.ZsbBm/wsdl/IZsbBm"
	Set  objSOAPClient  =  Server.CreateObject("MSSOAP.SoapClient30")  
	objSOAPClient.ClientProperty("ServerHTTPRequest") = True    
	objSOAPClient.MSSoapInit   strWebSvcWSDLURL,   "",   "",   ""  
%>
<%
function text_chg(aBody)
    text_chg = replace(aBody,"<","&lt;")
    text_chg = replace(text_chg,">","&gt;")
    'text_chg = replace(text_chg,chr(39),"'")
    text_chg = replace(text_chg,chr(34),"&quot;")
    text_chg = replace(text_chg,vbcrlf,"<p>")
    text_chg = replace(text_chg,chr(32),"&nbsp;")
End Function

function GetKsXz
	'dim str
	GetksXz = objSOAPClient.GetKsXz
	'GetKsXz = text_chg(str)
end function

sub GetKsInfo
	Dim XmlInfo,XmlFileName
	Dim objXml,objNode,objAtr					
	'ͨ����¼����ȡ������Ϣ
	XmlInfo = objSOAPClient.GetKsInfo(Session("UserName")) 

'	XmlFileName=Server.MapPath("SXmlKsInfoTemp.xml")	
'	Call CreateXmlFile(XmlFileName,XmlInfo)
'	Response.Write Server.HTMLEncode(XmlInfo)				
	Set objXml=Server.CreateObject("Microsoft.XMLDOM") 
	objXml.Async=False
							
	IF objXml.loadXML(XmlInfo) Then
		'���ؿ�����ϢXML����
		Set objNode = objXml.documentElement.selectSingleNode("ROWDATA")
		set objAtr=objNode.ChildNodes.item(0) 	
		If not (objAtr is nothing) Then
			'�п�����ϢXML����
			'GetAttributeNode("Id") �е��ֶ��������ϸ�Ĵ�Сд֮��
			'Id=objAtr.GetAttributeNode("id").Value
			if not (objAtr.GetAttributeNode("bmno") is nothing) then
				BmNo=objAtr.GetAttributeNode("bmno").Value
				Session("BmNo")=BmNo
			end if
			if not (objAtr.GetAttributeNode("username") is nothing) then
				UserName=objAtr.GetAttributeNode("username").Value
			end if
			if not (objAtr.GetAttributeNode("xm") is nothing) then
				Xm=objAtr.GetAttributeNode("xm").Value
			end if
			if not (objAtr.GetAttributeNode("xb") is nothing) then
				Xb=objAtr.GetAttributeNode("xb").Value
			end if
			if not (objAtr.GetAttributeNode("sfzh") is nothing) then
				Sfzh=objAtr.GetAttributeNode("sfzh").Value
				Session("Sfzh")=Sfzh
			end if
			if not (objAtr.GetAttributeNode("ksh") is nothing) then
				Ksh=objAtr.GetAttributeNode("ksh").Value
			end if
			if not (objAtr.GetAttributeNode("mz") is nothing) then
				mz=objAtr.GetAttributeNode("mz").Value
			end if
			if not (objAtr.GetAttributeNode("zzmm") is nothing) then
				zzmm=objAtr.GetAttributeNode("zzmm").Value
			end if
			if not (objAtr.GetAttributeNode("english") is nothing) then
				English=objAtr.GetAttributeNode("english").Value
			end if
			if not (objAtr.GetAttributeNode("computer") is nothing) then
				computer=objAtr.GetAttributeNode("computer").Value
			end if
			if not (objAtr.GetAttributeNode("tc") is nothing) then
				Tc=objAtr.GetAttributeNode("tc").Value
			end if
			if not (objAtr.GetAttributeNode("oldschool") is nothing) then
				OldSchool=objAtr.GetAttributeNode("oldschool").Value
			end if
			if not (objAtr.GetAttributeNode("oldzy") is nothing) then
				OldZy=objAtr.GetAttributeNode("oldzy").Value
			end if
			if not (objAtr.GetAttributeNode("addr") is nothing) then
				addr=objAtr.GetAttributeNode("addr").Value
			end if
			if not (objAtr.GetAttributeNode("yzbm") is nothing) then
				yzbm=objAtr.GetAttributeNode("yzbm").Value
			end if
			if not (objAtr.GetAttributeNode("tel") is nothing) then
				tel=objAtr.GetAttributeNode("tel").Value
			end if
			if not (objAtr.GetAttributeNode("jlqk") is nothing) then
				jlqk=objAtr.GetAttributeNode("jlqk").Value
			end if
			if not (objAtr.GetAttributeNode("zyzhcp") is nothing) then
				zyzhcp=objAtr.GetAttributeNode("zyzhcp").Value
			end if
			if not (objAtr.GetAttributeNode("bklb") is nothing) then
				bkLb=objAtr.GetAttributeNode("bklb").Value
			end if
			if not (objAtr.GetAttributeNode("zy1") is nothing) then
				zy1=objAtr.GetAttributeNode("zy1").Value
			end if
			if not (objAtr.GetAttributeNode("zy2") is nothing) then
				zy2=objAtr.GetAttributeNode("zy2").Value
			end if
			if not (objAtr.GetAttributeNode("zy3") is nothing) then
				zy3=objAtr.GetAttributeNode("zy3").Value
			end if
			if not (objAtr.GetAttributeNode("sftytj") is nothing) then
				sftytj=objAtr.GetAttributeNode("sftytj").Value
			end if
			if not (objAtr.GetAttributeNode("photo_url") is nothing) then
				Photo_Url=objAtr.GetAttributeNode("photo_url").Value
				Session("Photo_Url") = Photo_Url
			end if
		End if
	End If
	Set objXml=Nothing
	Set objNode=Nothing
	Set objAtr=Nothing
end sub

sub GetKsZkzInfo
	Dim XmlInfo,XmlFileName
	Dim objXml,objNode,objAtr					
	'ͨ����¼����ȡ������Ϣ
	XmlInfo = objSOAPClient.GetKsZkzInfo(Session("UserName")) 

'	XmlFileName=Server.MapPath("SXmlKsInfoTemp.xml")	
'	Call CreateXmlFile(XmlFileName,XmlInfo)
'	Response.Write Server.HTMLEncode(XmlInfo)				
	Set objXml=Server.CreateObject("Microsoft.XMLDOM") 
	objXml.Async=False
							
	IF objXml.loadXML(XmlInfo) Then
		'���ؿ�����ϢXML����
		Set objNode = objXml.documentElement.selectSingleNode("ROWDATA")
		set objAtr=objNode.ChildNodes.item(0) 	
		If not (objAtr is nothing) Then
			'�п�����ϢXML����
			'GetAttributeNode("Id") �е��ֶ��������ϸ�Ĵ�Сд֮��
			'Id=objAtr.GetAttributeNode("id").Value
			if not (objAtr.GetAttributeNode("bmno") is nothing) then
				BmNo=objAtr.GetAttributeNode("bmno").Value
				Session("BmNo")=BmNo
			end if
			if not (objAtr.GetAttributeNode("username") is nothing) then
				UserName=objAtr.GetAttributeNode("username").Value
			end if
			if not (objAtr.GetAttributeNode("xm") is nothing) then
				Xm=objAtr.GetAttributeNode("xm").Value
			end if
			if not (objAtr.GetAttributeNode("xb") is nothing) then
				Xb=objAtr.GetAttributeNode("xb").Value
			end if
			if not (objAtr.GetAttributeNode("sfzh") is nothing) then
				Sfzh=objAtr.GetAttributeNode("sfzh").Value
				Session("Sfzh")=Sfzh
			end if
			if not (objAtr.GetAttributeNode("ksh") is nothing) then
				Ksh=objAtr.GetAttributeNode("ksh").Value
			end if
			if not (objAtr.GetAttributeNode("mz") is nothing) then
				mz=objAtr.GetAttributeNode("mz").Value
			end if
			if not (objAtr.GetAttributeNode("zzmm") is nothing) then
				zzmm=objAtr.GetAttributeNode("zzmm").Value
			end if
			if not (objAtr.GetAttributeNode("english") is nothing) then
				English=objAtr.GetAttributeNode("english").Value
			end if
			if not (objAtr.GetAttributeNode("computer") is nothing) then
				computer=objAtr.GetAttributeNode("computer").Value
			end if
			if not (objAtr.GetAttributeNode("tc") is nothing) then
				Tc=objAtr.GetAttributeNode("tc").Value
			end if
			if not (objAtr.GetAttributeNode("oldschool") is nothing) then
				OldSchool=objAtr.GetAttributeNode("oldschool").Value
			end if
			if not (objAtr.GetAttributeNode("oldzy") is nothing) then
				OldZy=objAtr.GetAttributeNode("oldzy").Value
			end if
			if not (objAtr.GetAttributeNode("addr") is nothing) then
				addr=objAtr.GetAttributeNode("addr").Value
			end if
			if not (objAtr.GetAttributeNode("yzbm") is nothing) then
				yzbm=objAtr.GetAttributeNode("yzbm").Value
			end if
			if not (objAtr.GetAttributeNode("tel") is nothing) then
				tel=objAtr.GetAttributeNode("tel").Value
			end if
			if not (objAtr.GetAttributeNode("jlqk") is nothing) then
				jlqk=objAtr.GetAttributeNode("jlqk").Value
			end if
			if not (objAtr.GetAttributeNode("zyzhcp") is nothing) then
				zyzhcp=objAtr.GetAttributeNode("zyzhcp").Value
			end if
			if not (objAtr.GetAttributeNode("bklb") is nothing) then
				bkLb=objAtr.GetAttributeNode("bklb").Value
			end if
			if not (objAtr.GetAttributeNode("zy1") is nothing) then
				zy1=objAtr.GetAttributeNode("zy1").Value
			end if
			if not (objAtr.GetAttributeNode("zy2") is nothing) then
				zy2=objAtr.GetAttributeNode("zy2").Value
			end if
			if not (objAtr.GetAttributeNode("zy3") is nothing) then
				zy3=objAtr.GetAttributeNode("zy3").Value
			end if
			if not (objAtr.GetAttributeNode("sftytj") is nothing) then
				sftytj=objAtr.GetAttributeNode("sftytj").Value
			end if
			if not (objAtr.GetAttributeNode("photo_url") is nothing) then
				Photo_Url=objAtr.GetAttributeNode("photo_url").Value
				Session("Photo_Url") = Photo_Url
			end if

			if not (objAtr.GetAttributeNode("zkzh") is nothing) then
				zkzh=objAtr.GetAttributeNode("zkzh").Value
			end if
			if not (objAtr.GetAttributeNode("room") is nothing) then	'���������ң�
				room=objAtr.GetAttributeNode("room").Value
			end if
			if not (objAtr.GetAttributeNode("xxdm") is nothing) then	'ѧУ����
				xxdm=objAtr.GetAttributeNode("xxdm").Value
			end if
			if not (objAtr.GetAttributeNode("kcbh") is nothing) then	'�������
				kcbh=objAtr.GetAttributeNode("kcbh").Value
			end if
			if not (objAtr.GetAttributeNode("zwbh") is nothing) then
				zwbh=objAtr.GetAttributeNode("zwbh").Value
			end if
		End if
	End If
	Set objXml=Nothing
	Set objNode=Nothing
	Set objAtr=Nothing
end sub

sub GetKsKcTime(sBkLb)
	Dim XmlInfo,XmlFileName
	Dim objXml,objNode,objAtr					
	'ͨ����¼����ȡ������Ϣ
	XmlInfo = objSOAPClient.GetKsKcTime(sBkLb) 

'	XmlFileName=Server.MapPath("SXmlKsInfoTemp.xml")	
'	Call CreateXmlFile(XmlFileName,XmlInfo)
'	Response.Write Server.HTMLEncode(XmlInfo)				
	Set objXml=Server.CreateObject("Microsoft.XMLDOM") 
	objXml.Async=False
							
	IF objXml.loadXML(XmlInfo) Then
		'���ؿ�����ϢXML����
		Set objNode = objXml.documentElement.selectSingleNode("ROWDATA")
		set objAtr=objNode.ChildNodes.item(0) 	
		If not (objAtr is nothing) Then
			'�п�����ϢXML����
			'GetAttributeNode("Id") �е��ֶ��������ϸ�Ĵ�Сд֮��
			'Id=objAtr.GetAttributeNode("id").Value
			if not (objAtr.GetAttributeNode("kskc") is nothing) then '���Կγ�
				kskc=objAtr.GetAttributeNode("kskc").Value
			end if
			if not (objAtr.GetAttributeNode("ksrq") is nothing) then	'��������
				ksrq=objAtr.GetAttributeNode("ksrq").Value
			end if
			if not (objAtr.GetAttributeNode("kssj") is nothing) then	'����ʱ��
				kssj=objAtr.GetAttributeNode("kssj").Value
			end if
		End if
	End If
	Set objXml=Nothing
	Set objNode=Nothing
	Set objAtr=Nothing
end sub

sub GetKsInfo2
'	Dim strResult,MyArray
'	strResult = objSOAPClient.GetKsBMInfo2(Session("UserName")) 
'	'Response.Write(strResult&"<br>")
'	MyArray = split(strResult,"<|>")
'	'For i = LBound(MyArray) To UBound(MyArray)
'	'    Response.Write("����ֵ�����е�Ԫ��[" & i & "]��" & MyArray(i) & "<br>")
'	'Next 
'	
'	BmNo=MyArray(0)
'	Ksh=MyArray(1)
'	Sfzh=MyArray(2)
'	Xm=MyArray(3)
'	Xb=MyArray(4)
'	Mz=MyArray(5)
'	ZzMm=MyArray(6)
'	OldSchool=MyArray(7)
'	OldZy=MyArray(8)
'	Jlqk=MyArray(9)
'	Addr=MyArray(10)
'	Yzbm=MyArray(11)
'	Tel=MyArray(12)
'	ZyZhcp=MyArray(13)
'	English=MyArray(14)
'	Computer=MyArray(15)
'	Tc=MyArray(16)
'	Session("Photo_Url")=objSOapClient.GetPhotoUrlByUserName(UserName)
'======================================================================	
end sub
%>