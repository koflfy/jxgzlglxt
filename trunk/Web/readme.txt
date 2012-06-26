1. 文件说明
登录login.asp——检查登录，身份证号写入cookie，checklogin.asp——
进入首页 index.asp，首页显示公告和学生简单信息、应缴费信息

自助缴费 payonline.asp
      生成订单buildorder.asp——确认订单confirmorder.asp——selectbank.asp进入银行接口－－返回URL PayReceive.asp

历史缴费查询 paid.asp    显示缴费号、缴费名称、缴费金额，点击可查询明细

使用费用查询 usedpay.asp

退费查询 refund.asp

显示错误信息 show_error.asp   （登录错误）

产生验证码 getcode.asp

退出 logout.asp  （清除cookie）

inc文件夹
    function.asp
		创建XML文件函数（含写入数据），CreateXmlFile
		取得当前系统时间并转为字符串，getCurTimeStr
		将时间字符串转换为一般显示样式，ShowDateTime
	
	连接到WebService，WebSvcURL.asp  

bank文件夹
	ebb2public.crt 
	ectest01.crt
	ectest01.key
images文件夹
	图片文件， 样式表文件style.css
	
2. 用到的Cookie：StuSfzh(身份证号)，StudentNo(学号) CooStuState（学籍状态） JfId（缴费号），sfbz（收费标准（金额）），sfmc（收费名称）,StuName(姓名),XmlPaidDetail(缴费明细数据)

3. 调试时可能需要修改的常量
文件WebSvcURL.asp中：
      返回商户地址 BackUrl ：应为查询网站虚拟目录
	   调试日期 DebugDate：银行调试服务器的可用日期
	   WEB服务端地址 WebServiceUrl 



  

