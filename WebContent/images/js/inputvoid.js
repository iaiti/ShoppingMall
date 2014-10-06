var defaultValue = "输入宝贝名称";
		function cls(){
//捕获触发事件的对象，并设置为以下语句的默认对象
	with(event.srcElement)
     //如果当前值为默认值，则清空
	if(value==defaultValue) value=""
	}
	function res(){
	//捕获触发事件的对象，并设置为以下语句的默认对象
	with(event.srcElement)
	//如果当前值为空，则重置为默认值
	if(value=="") value=defaultValue
} 
			
