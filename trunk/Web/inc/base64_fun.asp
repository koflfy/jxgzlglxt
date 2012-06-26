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
%>