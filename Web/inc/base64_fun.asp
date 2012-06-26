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
%>