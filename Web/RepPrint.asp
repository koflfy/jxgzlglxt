<HTML>
<HEAD>
<%
if Session("Logined")="" then 
  	Response.redirect "show_error.asp?eid=用户没登录！打印之前必须先登录!"
end if  
%> 
<TITLE>专升本报名系统--报表打印</TITLE>  
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
	
	'如果是Firefox
	'if Instr(BrowserString, broFirefox) <> 0 then
	'	Response.Redirect(broFirefox & ".asp")
	'end if
	'如果是MSIE
	'if Instr(BrowserString, broMSIE) <> 0 then
	'	Response.Redirect(broMSIE & ".asp")
	'end if
	'如果是Opera
	'if Instr(BrowserString, broOpera) <> 0 then
	'	Response.Redirect(broOpera & ".asp")
	'end if
	'如果是Wap（没有用过所以还要看HTTP_USER_AGENT表示的结果）
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
//		alert('你是使用IE');
//		return true;
//	}
//	else if (navigator.userAgent.indexOf('Firefox') >= 0)
//	{
//		alert('你是使用Firefox');
//	}else if (navigator.userAgent.indexOf('Opera') >= 0)
//	{
//		alert('你是使用Opera');
//	}else
//	{
//		alert('你是使用其他的浏览器浏览网页！');
//	} 
}

</script>  
<SCRIPT language=javascript>  
function printSeting() //预览函数  
{  
	document.all("qingkongyema").click();//打印之前去掉页眉，页脚  
	//document.all("dayinDiv").style.display="none";
	//打印之前先隐藏不想打印输出的元素（此例中隐藏“打印”和“打印预览”两个按钮）  
	//if IsIE()
	　　document.getElementById('WB').ExecWB(8,1);
		//WB.execwb(8,1);

	document.all("dayinDiv").style.display="";
	//打印之后将该元素显示出来（显示出“打印”和“打印预览”两个按钮，方便别人下次打印）  
}  

function printPrv() //预览函数  
{  
	document.all("qingkongyema").click();//打印之前去掉页眉，页脚  
	//document.all("dayinDiv").style.display="none";
	//打印之前先隐藏不想打印输出的元素（此例中隐藏“打印”和“打印预览”两个按钮）  
	//if IsIE() 
	　　document.getElementById('WB').ExecWB(7,1);
	　　//WB.execwb(7,1);

	document.all("dayinDiv").style.display="";
	//打印之后将该元素显示出来（显示出“打印”和“打印预览”两个按钮，方便别人下次打印）  
}  
  
function printByIE() //打印函数  
{  
　　if (confirm('确定打印吗？')) 
	{
		document.all('qingkongyema').click();//同上  
	　　document.getElementById('WB').ExecWB(6,6);
		//WB.execwb(6,1);
		document.all("dayinDiv").style.display="";  
	}
}  

function printTure() //打印函数  
{  
　　if (confirm('确定打印吗？')) 
	{
		document.all('qingkongyema').click();//同上  
		//document.all("dayinDiv").style.display="none";//同上  
		window.print();  
		document.all("dayinDiv").style.display="";  
	}
}  

function doPage()  
{  
	layLoading.style.display = "none";//同上  
}  
  
</SCRIPT>  
  
<script language="VBScript">  
Dim hkey_root,hkey_path,hkey_key  
hkey_root="HKEY_CURRENT_USER"  
hkey_path="\Software\Microsoft\Internet Explorer\PageSetup"  
'//设置网页打印的页眉页脚为空'  
function pagesetup_null()  
	on error resume next  
	Set RegWsh = CreateObject("Wscript.Shell")  
	hkey_key="\header"  
	RegWsh.RegWrite hkey_root+hkey_path+hkey_key,""  
	hkey_key="\footer"  
	RegWsh.RegWrite hkey_root+hkey_path+hkey_key,""  
end function  
'//设置网页打印的页眉页脚为默认值'  
function pagesetup_default()  
	on error resume next  
	Set RegWsh = CreateObject("Wscript.Shell")  
	hkey_key="\header"  
	RegWsh.RegWrite hkey_root+hkey_path+hkey_key,"&w&b页码，&p/&P"  
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

<!--  如果要使用IE本身的打印技术，则使用下面这个Object
<OBJECT Name="WB" ID="WB" WIDTH="0" HEIGHT="0" CLASSID="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2"></OBJECT>
//-->
<% if IsIE_ByASP() then %>
<!--
	<input type="button" class="tab" value="打印设置" onClick="printSeting();">&nbsp;&nbsp; 
	<input type="button" class="tab" value="打印预览" onClick="printPrv();">&nbsp;&nbsp; 
	<input type="button" class="tab" value="精确打印" onClick="printByIE();">&nbsp;&nbsp;  
	<input type="button" class="tab" value="兼容打印" onClick="printTure();">&nbsp;&nbsp;  
	<input type="button" name="Button" value="关闭窗口" onClick="document.all.WB.ExecWB(45,1)">
    <font color="#FF0000"><p />使用兼容打印模式时，请在浏览器菜单中设置页面边距均为0</font>
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
      DLPrinter.CopyCount=1;  //打印份数
      //DLPrinter.PageHeader="这是测试的页眉";
      //DLPrinter.PageFooter="这是测试的页脚";
      DLPrinter.IsLandScape=0;  //是否横向打印，0：纵向，1：横向
      //DLPrinter.ContentURL="http://www.cnblogs.com/Yahong111/archive/2007/09/19/898326.html";
      //DLPrinter.ContentURL="http://localhost/bm/rep_bmb.asp";
    </script>
    &nbsp;&nbsp;<br />
    &nbsp;&nbsp; &nbsp;&nbsp; 
    <input type="button" id="btnPrint" value="打印预览" onClick="DLPrinter.PrintPreview()" />&nbsp;&nbsp; 
    <input type="button" id="btnPrint" value="直接打印" onClick="DLPrinter.Print()" />&nbsp;&nbsp; 
<!--
    <input type="button" id="btnPrint" value="打印" onclick="DLPrinter.PrintDirect()" />
//-->
<!--
    |&nbsp;&nbsp;如果无法精确打印，可以选择==>
	<input type="button" class="tab" value="兼容打印" onClick="printTure();">&nbsp;&nbsp;  
//-->
<% else %>
	&nbsp;&nbsp;<br />
    <font color="#FFFFFF">打印前请在浏览器页面设置中把页边距全部设置为0</font>
	<input type="button" class="tab" value="开始打印" onClick="printTure();">&nbsp;&nbsp;  
<% end if %>
<!--
	<input type="hidden" class="tab" value="取消打印" onClick="javascript:window.close()">&nbsp;&nbsp;  
	<input type="hidden" name="qingkongyema" id="qingkongyema" class="tab" value="清空页码" onClick="pagesetup_null()">&nbsp;&nbsp;  
	<input type="hidden" class="tab" value="恢复页码" onClick="pagesetup_default()">  
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