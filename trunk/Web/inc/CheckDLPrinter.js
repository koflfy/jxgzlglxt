function getDLPrinter(oOBJECT,oEMBED){
        var strHtml1="<br><font color='#FF00FF'>��ӡ�ؼ�δ��װ!�������<a href='inc/Webprt_install.exe'>ִ�а�װ</a>,��װ����ˢ��ҳ������½��롣</font>";
        var DLPrinter=oEMBED;		
	try{		     
	     if (navigator.appVersion.indexOf("MSIE")>=0) DLPrinter=oOBJECT;

	     if ((DLPrinter==null)||(typeof(DLPrinter.CopyCount)=="undefined")) {
	     //if (DLPrinter==null) {
			 if (navigator.appVersion.indexOf("MSIE")>=0) 
			 	document.write(strHtml1);
	     }
	     //*****���¿հ�λ���ʺϵ���ͳһ����:*********	

	     //*******************************************
	     return DLPrinter; 
	}catch(err){
	     document.documentElement.innerHTML="Error:"+strHtml1+document.documentElement.innerHTML;
	     return DLPrinter; 
	}
}
