<%
'十进制转2进制
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

'二进制制十进制
function c2to10(x)
	dim i
    c2to10=0
    if x="0" then exit function
    i=0
    for i= 0 to len(x) -1
        if mid(x,len(x)-i,1)="1" then c2to10=c2to10+2^(i)
    next 
end function

'十六进制二进制
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

'汉字转换成UTF8格式，返回10进制的数据
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

'XML文件操作函数
'创建一个文件,并写入XML数据，关闭该文件。
Sub CreateXmlFile(MyFileName,XmlDataSet)
	Dim fso, MyFile
	Set fso = CreateObject("Scripting.FileSystemObject")
	Set MyFile= fso.CreateTextFile(MyFileName, True)
	MyFile.WriteLine(XmlDataSet)
	MyFile.Close
End Sub
%>

<%
'取得当前系统时间-转为字符串，如20091005142319
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
'时间格式转换，字符串转为年月日形式，如2009-10-05 14:09:19
'20091002T21:23:00000
function StrtoDate(curTime)
	dim nDate	
	nDate=left(curTime,4) & "-" & mid(curTime,5,2) & "-" & mid(curTime,7,2) & " " & mid(curTime,10,8)
	StrtoDate=nDate
end function
%>
<%
'----------------------------------------------------------------
'程序简介: 完成asp语言对XML文档中指定节点文本的增加、删除、修改、查看
'------------------------------------------------
'函数名字：ConnectXml()
'入口参数: filename 需要连接或打开的xml文件名
'出口参数: 无
'返回值 ：ConnectXml=0，XmlDom就是一个成功装载XML文档的对象了。
'ConnectXml<>0,则打印错误信息strError
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
'函数名字：ConnXml()   加载字符串到XMLDOM
'入口参数: XmlString 需要连接的xml字符串
'出口参数: 无
'返回值 ：ConnXml=0，XmlDom就是一个成功装载XML文档的对象了。
'ConnXml<>0,则打印错误信息strError
'------------------------------------------------
function ConnXml(XmlString)
	dim XmlDom
	Set XmlDom=Server.CreateObject("Microsoft.XMLDOM") 
	XmlDom.Async=False
	XmlDom.loadXML(XmlString)     '把XML字符串读入DOM对象	
end function

'------------------------------------------------
'函数名字：CloseXml()
'入口参数: 无
'出口参数: 无
'------------------------------------------------
function CloseXml(XmlDom)
	if IsObject(XmlDom) then
		set XmlDom=nothing
	end if
end function

'------------------------------------------------
'函数名字：SelectXmlNodeText(elementname)
'入口参数: elementname 元素的名字
'出口参数: 无
'------------------------------------------------
function SelectXmlNodeText(elementname) 
	elementname="//"&elementname
	temp=XmlDom.selectSingleNode(elementname).text
	selectXmlNodeText= server.htmlencode(temp) 
end function 

'------------------------------------------------
'函数名字：InsertXmlNodeText(befelementname,elementname,elementtext)
'入口参数: elementname 插入的元素的名字
'          befelementname在此元素的名字前面插入元素
'          elementtext 插入的元素的文本
'出口参数: 无
'------------------------------------------------
function InsertXmlNodeText(befelementname,elementname,elementtext) 
	dim befelement,element
	set befelement=XmlDom.selectSingleNode("//"&befelementname)
	set element= XmlDom.createelement(elementname)
	befelement.insertBefore element,befelement.firstchild
	element.text=elementtext
end function 

'------------------------------------------------
'函数名字：UpdateXmlNodeText(elementname,newelementtext)
'入口参数: elementname 元素的名字
'          newelementtext元素的新文本
'出口参数: 无
'------------------------------------------------
function UpdateXmlNodeText(elementname,newelementtext) 
	dim element
	set element=XmlDom.selectSingleNode("//"&elementname)
	element.text=newelementtext
end function 

'------------------------------------------------
'函数名字：DeleteXmlNodeText(elementname)
'入口参数: elementname 元素的名字
'出口参数: 无
'------------------------------------------------
function DeleteXmlNodeText(elementname) 
	XmlDom.selectSingleNode("//"&elementname).text =""
end function 
%>
<%
'************************************************************************
'  这是一组符合BASE64标准规范的可完美处理中文的BASE64编码、解码函数，   '
'  网上也有很多其他处理中文的BASE64函数，但最终生成的BASE64并不规范     '
'  它们是从一组VB 6.0的BASE64编码、解码函数改写而成的                   '
'  而且这个可兼容中国工商银行的网银接口的BASE64编码方式                 '
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
        objTemp.Read 2 '去掉 UNICODE 签名
    Case "UTF-8"
        objTemp.Read 3 '去掉 UTF-8 BOM 签名
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
		
	'取得网银配置信息		
	GetNetBankInfo=objSOAPClient.GetUserNetBankInfo(UserDM,UserAccount,BankSrvUrl,BankWapSrvUrl)
End Function

%>