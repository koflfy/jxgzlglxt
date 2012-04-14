function getDLPrinter(oOBJECT,oEMBED){
        var strHtml1="<br><font color='#FF00FF'>打印控件未安装!点击这里<a href='inc/Webprt_install.exe'>执行安装</a>,安装后请刷新页面或重新进入。</font>";
        var DLPrinter=oEMBED;		
	try{		     
	     if (navigator.appVersion.indexOf("MSIE")>=0) DLPrinter=oOBJECT;

	     if ((DLPrinter==null)||(typeof(DLPrinter.CopyCount)=="undefined")) {
	     //if (DLPrinter==null) {
			 if (navigator.appVersion.indexOf("MSIE")>=0) 
			 	document.write(strHtml1);
	     }
	     //*****如下空白位置适合调用统一功能:*********	

	     //*******************************************
	     return DLPrinter; 
	}catch(err){
	     document.documentElement.innerHTML="Error:"+strHtml1+document.documentElement.innerHTML;
	     return DLPrinter; 
	}
}
