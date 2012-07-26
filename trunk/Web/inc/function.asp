<%
'ʮ����ת2����
function c10to2(x)
	dim i
	dim mysign,DigS,tempnum
    mysign=sgn(x)
    x=abs(x)
    DigS=1
    do 
        if x<2^DigS then
            exit do
        else
            DigS=DigS+1
        end if
    loop
    tempnum=x
    
    i=0
    for i=DigS to 1 step-1
        if tempnum>=2^(i-1) then
            tempnum=tempnum-2^(i-1)
            c10to2=c10to2 & "1"   
        else
            c10to2=c10to2 & "0"
        end if
    next
    if mysign=-1 then c10to2="-" & c10to2
end function 

'��������ʮ����
function c2to10(x)
	dim i
    c2to10=0
    if x="0" then exit function
    i=0
    for i= 0 to len(x) -1
        if mid(x,len(x)-i,1)="1" then c2to10=c2to10+2^(i)
    next 
end function

'ʮ�����ƶ�����
function c16to2(x)
	dim i,tempstr
    i=0
    for i=1 to len(trim(x)) 
        tempstr= c10to2(cint(int("&h" & mid(x,i,1))))
        do while len(tempstr)<4
        tempstr="0" & tempstr
        loop
        c16to2=c16to2 & tempstr
    next
end function

'����ת����UTF8��ʽ������10���Ƶ�����
function Hz2UTF8(Str) 
  dim i 
  dim Str_one 
  dim Str_unicode
  dim iCode 
  for i=1 to len(Str) 
    Str_one=Mid(Str,i,1) 
    Str_unicode=Str_unicode&chr(38) '&
    Str_unicode=Str_unicode&chr(35) '#
'    Str_unicode=Str_unicode&chr(120) 
'    Str_unicode=Str_unicode& Hex(ascw(Str_one)) 
	 iCode = Hex(ascw(Str_one)) 
	 iCode = c2to10(c16to2(iCode))
    Str_unicode=Str_unicode& iCode 
'	 Response.Write server.htmlEncode(Str_unicode)&"<br>" 
    Str_unicode=Str_unicode&chr(59) 
  next 
  Hz2UTF8=Str_unicode
  'Response.Write server.htmlEncode(Str_unicode) 
end function

'XML�ļ���������
'����һ���ļ�,��д��XML���ݣ��رո��ļ���
Sub CreateXmlFile(MyFileName,XmlDataSet)
	Dim fso, MyFile
	Set fso = CreateObject("Scripting.FileSystemObject")
	Set MyFile= fso.CreateTextFile(MyFileName, True)
	MyFile.WriteLine(XmlDataSet)
	MyFile.Close
End Sub
%>

<%
'ȡ�õ�ǰϵͳʱ��-תΪ�ַ�������20091005142319
function getCurTimeStr
	dim curYear,curMonth,curDay,curHour,curMinute,curSecond	
	curYear = Year(now)
	curMonth = Month(now)
	If curMonth < 10 Then
		curMonth= "0" & curMonth
	End If
	curDay = Day(now)
	If curDay < 10 Then
		curDay = "0" & curDay
	End If
	curHour = Hour(now)
	If curHour < 10 Then
		curHour = "0" & curHour
	End If
	curMinute = Minute(now)
	If curMinute < 10 Then
		curMinute = "0" & curMinute
	End If
	curSecond = Second(now)
	If curSecond < 10 Then
		curSecond = "0" & curSecond
	End If
	getCurTimeStr = curYear & curMonth & curDay & curHour & curMinute & curSecond
end function
%>
<%
'ʱ���ʽת�����ַ���תΪ��������ʽ����2009-10-05 14:09:19
'20091002T21:23:00000
function StrtoDate(curTime)
	dim nDate	
	nDate=left(curTime,4) & "-" & mid(curTime,5,2) & "-" & mid(curTime,7,2) & " " & mid(curTime,10,8)
	StrtoDate=nDate
end function
%>
<%
'----------------------------------------------------------------
'������: ���asp���Զ�XML�ĵ���ָ���ڵ��ı������ӡ�ɾ�����޸ġ��鿴
'------------------------------------------------
'�������֣�ConnectXml()
'��ڲ���: filename ��Ҫ���ӻ�򿪵�xml�ļ���
'���ڲ���: ��
'����ֵ ��ConnectXml=0��XmlDom����һ���ɹ�װ��XML�ĵ��Ķ����ˡ�
'ConnectXml<>0,���ӡ������ϢstrError
'------------------------------------------------
function ConnectXml(filename)
	dim strSourceFile
	dim XmlDom
	strSourceFile = Server.MapPath(filename)
	Set XmlDom = Server.CreateObject("Microsoft.XMLDOM") 
	XmlDom.async = false 
	XmlDom.load(strSourceFile)
	ConnectXml=XmlDom.parseerror.errorcode
	if XmlDom.parseerror.errorcode<>0 then
		strError="<h2>error"&XmlDom.parseerror.errorcode&"</h2>"
		strError=strError&XmlDom.parseerror.reason&"<br>"
		strError=strError&XmlDom.parseerror.url&"<br>"
		strError=strError&XmlDom.parseerror.line&"<br>"
		strError=strError&XmlDom.parseerror.filepos&"<br>"
		strError=strError&XmlDom.parseerror.srcText&"<br>"
		response.write strError
	end if
end function

'------------------------------------------------
'�������֣�ConnXml()   �����ַ�����XMLDOM
'��ڲ���: XmlString ��Ҫ���ӵ�xml�ַ���
'���ڲ���: ��
'����ֵ ��ConnXml=0��XmlDom����һ���ɹ�װ��XML�ĵ��Ķ����ˡ�
'ConnXml<>0,���ӡ������ϢstrError
'------------------------------------------------
function ConnXml(XmlString)
	dim XmlDom
	Set XmlDom=Server.CreateObject("Microsoft.XMLDOM") 
	XmlDom.Async=False
	XmlDom.loadXML(XmlString)     '��XML�ַ�������DOM����	
end function

'------------------------------------------------
'�������֣�CloseXml()
'��ڲ���: ��
'���ڲ���: ��
'------------------------------------------------
function CloseXml(XmlDom)
	if IsObject(XmlDom) then
		set XmlDom=nothing
	end if
end function

'------------------------------------------------
'�������֣�SelectXmlNodeText(elementname)
'��ڲ���: elementname Ԫ�ص�����
'���ڲ���: ��
'------------------------------------------------
function SelectXmlNodeText(elementname) 
	elementname="//"&elementname
	temp=XmlDom.selectSingleNode(elementname).text
	selectXmlNodeText= server.htmlencode(temp) 
end function 

'------------------------------------------------
'�������֣�InsertXmlNodeText(befelementname,elementname,elementtext)
'��ڲ���: elementname �����Ԫ�ص�����
'          befelementname�ڴ�Ԫ�ص�����ǰ�����Ԫ��
'          elementtext �����Ԫ�ص��ı�
'���ڲ���: ��
'------------------------------------------------
function InsertXmlNodeText(befelementname,elementname,elementtext) 
	dim befelement,element
	set befelement=XmlDom.selectSingleNode("//"&befelementname)
	set element= XmlDom.createelement(elementname)
	befelement.insertBefore element,befelement.firstchild
	element.text=elementtext
end function 

'------------------------------------------------
'�������֣�UpdateXmlNodeText(elementname,newelementtext)
'��ڲ���: elementname Ԫ�ص�����
'          newelementtextԪ�ص����ı�
'���ڲ���: ��
'------------------------------------------------
function UpdateXmlNodeText(elementname,newelementtext) 
	dim element
	set element=XmlDom.selectSingleNode("//"&elementname)
	element.text=newelementtext
end function 

'------------------------------------------------
'�������֣�DeleteXmlNodeText(elementname)
'��ڲ���: elementname Ԫ�ص�����
'���ڲ���: ��
'------------------------------------------------
function DeleteXmlNodeText(elementname) 
	XmlDom.selectSingleNode("//"&elementname).text =""
end function 
%>
<%
'************************************************************************
'  ����һ�����BASE64��׼�淶�Ŀ������������ĵ�BASE64���롢���뺯����   '
'  ����Ҳ�кܶ������������ĵ�BASE64���������������ɵ�BASE64�����淶     '
'  �����Ǵ�һ��VB 6.0��BASE64���롢���뺯����д���ɵ�                   '
'  ��������ɼ����й��������е������ӿڵ�BASE64���뷽ʽ                 '
'                               ---Modified by xieyunc from Internet    '
'                                         2009-09-16                    '
'************************************************************************
Function StringToBytes(ByVal strData, ByVal strCharset)
    Dim objTemp
    Set objTemp = Server.CreateObject("ADODB.Stream")
    objTemp.Type = 2'adTypeText
    objTemp.Charset = strCharset
    objTemp.Open
    objTemp.WriteText strData
    objTemp.Position = 0
    objTemp.Type = 1'adTypeBinary
    Select Case UCase(strCharset)
    Case "UNICODE", "UTF-16", "UTF-16BE", "UTF-16LE"
        objTemp.Read 2 'ȥ�� UNICODE ǩ��
    Case "UTF-8"
        objTemp.Read 3 'ȥ�� UTF-8 BOM ǩ��
    Case Else
    End Select
    StringToBytes = objTemp.Read(-1)'adReadAll
    objTemp.Close
    Set objTemp = Nothing
End Function

Function EnBase64(ByVal vtData, ByVal strCharset)
    Dim xmlDoc, xmlNode
    Set xmlDoc = Server.CreateObject("MSXML2.DOMDocument")
    Set xmlNode = xmlDoc.createElement("temp")
    xmlNode.dataType = "bin.base64"
    If VarType(vtData) = (vbByte Or vbArray) Then
        xmlNode.nodeTypedValue = vtData
    Else
        xmlNode.nodeTypedValue = StringToBytes(vtData, strCharset)
    End If
    EnBase64 = xmlNode.text
    Set xmlNode = Nothing
    Set xmlDoc = Nothing
End Function

Function DeBase64(ByVal strData, ByVal strCharset)
    Dim xmlDoc, xmlNode
    Set xmlDoc = Server.CreateObject("MSXML2.DOMDocument")
    Set xmlNode = xmlDoc.createElement("temp")
    xmlNode.dataType = "bin.base64"
    xmlNode.text = strData
    DeBase64 = BytesToString(xmlNode.nodeTypedValue, strCharset)
    Set xmlNode = Nothing
    Set xmlDoc = Nothing
End Function

Function BytesToString(vtData, ByVal strCharset)
    Dim objTemp
    Set objTemp = Server.CreateObject("ADODB.Stream")
    objTemp.Type = 1'adTypeBinary
    objTemp.Open
    objTemp.Write vtData
    objTemp.Position = 0
    objTemp.Type = 2'adTypeText
    objTemp.Charset = strCharset
    BytesToString = objTemp.ReadText(-1)'adReadAll
    objTemp.Close
    Set objTemp = Nothing
End Function

Function Base64Decode(ByVal strData)
    Base64Decode = DeBase64(strData,"GBK")
End Function

Function Base64Encode(ByVal vtData)
    Base64Encode = EnBase64(vtData,"GBK")
End Function

Function GetNetBankInfo(UserDM,UserAccount,BankSrvUrl,BankWapSrvUrl)
		
	'ȡ������������Ϣ		
	GetNetBankInfo=objSOAPClient.GetUserNetBankInfo(UserDM,UserAccount,BankSrvUrl,BankWapSrvUrl)
End Function

' ============================================
' ��ʽ��ʱ��(��ʾ)
' ������n_Flag
' 1:"yyyy-mm-dd hh:mm:ss"
' 2:"yyyy-mm-dd"
' 3:"hh:mm:ss"
' 4:"yyyy��mm��dd��"
' 5:"yyyymmdd"
'   6:"yyyymmddhhmmss" 
' ============================================
Function Format_Time(s_Time, n_Flag)
 Dim y, m, d, h, mi, s
 Format_Time = ""
 If IsDate(s_Time) = False Then Exit Function
 y = cstr(year(s_Time))
 m = cstr(month(s_Time))
 If len(m) = 1 Then m = "0" & m
 d = cstr(day(s_Time))
 If len(d) = 1 Then d = "0" & d
 h = cstr(hour(s_Time))
 If len(h) = 1 Then h = "0" & h
 mi = cstr(minute(s_Time))
 If len(mi) = 1 Then mi = "0" & mi
 s = cstr(second(s_Time))
 If len(s) = 1 Then s = "0" & s
 Select Case n_Flag
 Case 1
  ' yyyy-mm-dd hh:mm:ss
  Format_Time = y & "-" & m & "-" & d & " " & h & ":" & mi & ":" & s
 Case 2
  ' yyyy-mm-dd
  Format_Time = y & "-" & m & "-" & d
 Case 3
  ' hh:mm:ss
  Format_Time = h & ":" & mi & ":" & s
 Case 4
  ' yyyy��mm��dd��
  Format_Time = y & "��" & m & "��" & d & "��"
 Case 5
  ' yyyymmdd
  Format_Time = y & m & d
 case 6
  'yyyymmddhhmmss
  format_time= y & m & d & h & mi & s
 End Select
End Function

Function GetWeekStr(s_Time)
	dim weeknum,data
	If IsDate(s_Time) = False Then Exit Function
	weeknum = weekDay(s_Time,1)
	select case weeknum
	 case "1"
	  data="������"
	 case "2"
	  data="����һ"
	 case "3"
	  data="���ڶ�"
	 case "4"
	  data="������"
	 case "5"
	  data="������"
	 case "6"
	  data="������"
	 case "7"
	  data="������"
	 case else
	  data="�����ʱ��"
	end select
	GetWeekStr = data
end function

%>