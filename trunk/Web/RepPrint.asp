<HTML>
<HEAD>
<%
if Session("Logined")="" then 
  	Response.redirect "show_error.asp?eid=�û�û��¼����ӡ֮ǰ�����ȵ�¼!"
end if  
%> 
<TITLE>ר��������ϵͳ--�����ӡ</TITLE>  
<META http-equiv=Content-Type content="text/html; charset=gb2312">
<script language="javascript" src="inc/CheckDLPrinter.js"></script>
<%
function IsIE_ByASP()
	Dim BrowserString
	BrowserString = Request.ServerVariables("HTTP_USER_AGENT")
	BrowserString = Lcase(BrowserString)
	
	IsIE_ByASP = Instr(BrowserString, "msie") <> 0
	
	'Dim broFirefox,broMSIE,broOpera,broWap
	'broFirefox = "firefox"
	'broMSIE = "msie"
	'broOpera = "opera"
	'broWap = "wap"
	
	'�����Firefox
	'if Instr(BrowserString, broFirefox) <> 0 then
	'	Response.Redirect(broFirefox & ".asp")
	'end if
	'�����MSIE
	'if Instr(BrowserString, broMSIE) <> 0 then
	'	Response.Redirect(broMSIE & ".asp")
	'end if
	'�����Opera
	'if Instr(BrowserString, broOpera) <> 0 then
	'	Response.Redirect(broOpera & ".asp")
	'end if
	'�����Wap��û���ù����Ի�Ҫ��HTTP_USER_AGENT��ʾ�Ľ����
	'if Instr(BrowserString, broWap) <> 0 then
	'	Response.Redirect(broWap & ".asp")
	'end if 
end function
%>
<script language="JavaScript" type="text/javascript"> 
function IsIE()
{
	if ((navigator.userAgent.indexOf('MSIE') >= 0) && (navigator.userAgent.indexOf('Opera') < 0))
		return true;
	else
		return false;

//	if ((navigator.userAgent.indexOf('MSIE') >= 0) && (navigator.userAgent.indexOf('Opera') < 0))
//	{
//		alert('����ʹ��IE');
//		return true;
//	}
//	else if (navigator.userAgent.indexOf('Firefox') >= 0)
//	{
//		alert('����ʹ��Firefox');
//	}else if (navigator.userAgent.indexOf('Opera') >= 0)
//	{
//		alert('����ʹ��Opera');
//	}else
//	{
//		alert('����ʹ������������������ҳ��');
//	} 
}

</script>  
<SCRIPT language=javascript>  
function printSeting() //Ԥ������  
{  
	document.all("qingkongyema").click();//��ӡ֮ǰȥ��ҳü��ҳ��  
	//document.all("dayinDiv").style.display="none";
	//��ӡ֮ǰ�����ز����ӡ�����Ԫ�أ����������ء���ӡ���͡���ӡԤ����������ť��  
	//if IsIE()
	����document.getElementById('WB').ExecWB(8,1);
		//WB.execwb(8,1);

	document.all("dayinDiv").style.display="";
	//��ӡ֮�󽫸�Ԫ����ʾ��������ʾ������ӡ���͡���ӡԤ����������ť����������´δ�ӡ��  
}  

function printPrv() //Ԥ������  
{  
	document.all("qingkongyema").click();//��ӡ֮ǰȥ��ҳü��ҳ��  
	//document.all("dayinDiv").style.display="none";
	//��ӡ֮ǰ�����ز����ӡ�����Ԫ�أ����������ء���ӡ���͡���ӡԤ����������ť��  
	//if IsIE() 
	����document.getElementById('WB').ExecWB(7,1);
	����//WB.execwb(7,1);

	document.all("dayinDiv").style.display="";
	//��ӡ֮�󽫸�Ԫ����ʾ��������ʾ������ӡ���͡���ӡԤ����������ť����������´δ�ӡ��  
}  
  
function printByIE() //��ӡ����  
{  
����if (confirm('ȷ����ӡ��')) 
	{
		document.all('qingkongyema').click();//ͬ��  
	����document.getElementById('WB').ExecWB(6,6);
		//WB.execwb(6,1);
		document.all("dayinDiv").style.display="";  
	}
}  

function printTure() //��ӡ����  
{  
����if (confirm('ȷ����ӡ��')) 
	{
		document.all('qingkongyema').click();//ͬ��  
		//document.all("dayinDiv").style.display="none";//ͬ��  
		window.print();  
		document.all("dayinDiv").style.display="";  
	}
}  

function doPage()  
{  
	layLoading.style.display = "none";//ͬ��  
}  
  
</SCRIPT>  
  
<script language="VBScript">  
Dim hkey_root,hkey_path,hkey_key  
hkey_root="HKEY_CURRENT_USER"  
hkey_path="\Software\Microsoft\Internet Explorer\PageSetup"  
'//������ҳ��ӡ��ҳüҳ��Ϊ��'  
function pagesetup_null()  
	on error resume next  
	Set RegWsh = CreateObject("Wscript.Shell")  
	hkey_key="\header"  
	RegWsh.RegWrite hkey_root+hkey_path+hkey_key,""  
	hkey_key="\footer"  
	RegWsh.RegWrite hkey_root+hkey_path+hkey_key,""  
end function  
'//������ҳ��ӡ��ҳüҳ��ΪĬ��ֵ'  
function pagesetup_default()  
	on error resume next  
	Set RegWsh = CreateObject("Wscript.Shell")  
	hkey_key="\header"  
	RegWsh.RegWrite hkey_root+hkey_path+hkey_key,"&w&bҳ�룬&p/&P"  
	hkey_key="\footer"  
	RegWsh.RegWrite hkey_root+hkey_path+hkey_key,"&u&b&d"  
end function  
</script>  
<style media="print" type="text/css">
    .Noprint{display:none;}
    .PageNext{page-break-after: always;}
    .MySet{margin:0px 0px 0px 0px;}
</style>

</HEAD>  
<BODY leftMargin=0 topMargin=5 rightMargin=0 bottomMargin=0>
<DIV align="center" id="dayinDiv" name="dayinDiv" class="Noprint" style="background-color:#066">

<!--  ���Ҫʹ��IE����Ĵ�ӡ��������ʹ���������Object
<OBJECT Name="WB" ID="WB" WIDTH="0" HEIGHT="0" CLASSID="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2"></OBJECT>
//-->
<% if IsIE_ByASP() then %>
<!--
	<input type="button" class="tab" value="��ӡ����" onClick="printSeting();">&nbsp;&nbsp; 
	<input type="button" class="tab" value="��ӡԤ��" onClick="printPrv();">&nbsp;&nbsp; 
	<input type="button" class="tab" value="��ȷ��ӡ" onClick="printByIE();">&nbsp;&nbsp;  
	<input type="button" class="tab" value="���ݴ�ӡ" onClick="printTure();">&nbsp;&nbsp;  
	<input type="button" name="Button" value="�رմ���" onClick="document.all.WB.ExecWB(45,1)">
    <font color="#FF0000"><p />ʹ�ü��ݴ�ӡģʽʱ������������˵�������ҳ��߾��Ϊ0</font>
//-->
    <OBJECT ID="DLPrinter" CLASSID="CLSID:5C230622-45E5-4e3c-893C-3BFDDC4DB5E4" codebase="inc/DLPrinter.cab" height="0" width="0" >
    <embed id="DLPrinter_EM" type="application/x-print-DLPrinter" width=0 height=0></embed>
    </OBJECT>
    <script>
      var DLPrinter=getDLPrinter(document.getElementById('DLPrinter'),document.getElementById('DLPrinter_EM'));
    
      DLPrinter.MarginLeft=2;
      DLPrinter.MarginRight=2;
      DLPrinter.MarginTop=2;
      DLPrinter.MarginBottom=2;
      DLPrinter.CopyCount=1;  //��ӡ����
      //DLPrinter.PageHeader="���ǲ��Ե�ҳü";
      //DLPrinter.PageFooter="���ǲ��Ե�ҳ��";
      DLPrinter.IsLandScape=0;  //�Ƿ�����ӡ��0������1������
      //DLPrinter.ContentURL="http://www.cnblogs.com/Yahong111/archive/2007/09/19/898326.html";
      //DLPrinter.ContentURL="http://localhost/bm/rep_bmb.asp";
    </script>
    &nbsp;&nbsp;<br />
    &nbsp;&nbsp; &nbsp;&nbsp; 
    <input type="button" id="btnPrint" value="��ӡԤ��" onClick="DLPrinter.PrintPreview()" />&nbsp;&nbsp; 
    <input type="button" id="btnPrint" value="ֱ�Ӵ�ӡ" onClick="DLPrinter.Print()" />&nbsp;&nbsp; 
<!--
    <input type="button" id="btnPrint" value="��ӡ" onclick="DLPrinter.PrintDirect()" />
//-->
<!--
    |&nbsp;&nbsp;����޷���ȷ��ӡ������ѡ��==>
	<input type="button" class="tab" value="���ݴ�ӡ" onClick="printTure();">&nbsp;&nbsp;  
//-->
<% else %>
	&nbsp;&nbsp;<br />
    <font color="#FFFFFF">��ӡǰ���������ҳ�������а�ҳ�߾�ȫ������Ϊ0</font>
	<input type="button" class="tab" value="��ʼ��ӡ" onClick="printTure();">&nbsp;&nbsp;  
<% end if %>
<!--
	<input type="hidden" class="tab" value="ȡ����ӡ" onClick="javascript:window.close()">&nbsp;&nbsp;  
	<input type="hidden" name="qingkongyema" id="qingkongyema" class="tab" value="���ҳ��" onClick="pagesetup_null()">&nbsp;&nbsp;  
	<input type="hidden" class="tab" value="�ָ�ҳ��" onClick="pagesetup_default()">  
//-->
	<hr>
</DIV>  
<DIV align="center">  
<% 
Dim sRepName 
sRepName = Request.QueryString("sRepName")
if sRepName = "" then Response.Redirect "index.asp"
%>
<iframe align="middle" src="<%=sRepName%>" width="794" height="1123" frameborder="0" scrolling="No"></iframe>
</DIV>  
  
</BODY>  
</HTML>  