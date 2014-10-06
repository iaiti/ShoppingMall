function checkdata() {
//alert(form.pwd.value);
	var ssn = form.username.value.toLowerCase();
	<!--检查用户名-->
	if(!checkUserName(ssn)) {
		return false;
		}
	<!--检查密码-->
	if(strlen(form.pwd.value)<6 || strlen(form.pwd.value) > 16) {
		//alert("正确登录密码长度为6-16");
		document.getElementById("pwdErr").innerHTML = "<font color = 'red'>正确登录密码长度为6-16</font>";
		form.pwd.focus();
		return false;
	}else {
			document.getElementById("pwdErr2").innerHTML = "";
	}
	if(strlen2(form.pwd.value)) {
		alert("非法字符密码，只能是数字和字母");
		form.pwd.focus();
		return false;
	}
	if(form.pwd2.value == "") {
		//alert("请输入确认密码");
		document.getElementById("pwdErr2").innerHTML = "<font color = 'red'>请输入确认密码</font>";
		form.pwd2.focus();
		return false;
	}
	if(form.pwd2.value != form.pwd.value) {
		//alert("两次输入的密码不一致！");
		document.getElementById("pwdErr2").innerHTML = "<font color = 'red'>两次输入的密码不一致！</font>";
		form.pwd2.focus();
		return false;
	} else {
			document.getElementById("pwdErr2").innerHTML = "";
	}
	
	
	return true;
}
	

		<!-- 这是检查用户名的函数-->
	function checkUserName(ssn) {
			if(ssn.length < 3 ||ssn.length > 18) {
				//alert("用户名应该大于3个小于18个字符");
				document.getElementById("wrongusername").innerHTML = "<font color = 'red'>请输入正确的用户名，应该大于3个小于18个字符</font>";
				form.username.focus();
				return false;
			}
			if(isWhiteSpace(ssn)) {
				//alert("用户名不能包含空格");
				form.username.focus();
				return false;
			}
			if(!isString(ssn)) {
				//alert("用户名输入错误，请重新输入。。应该以字母或者数字开始或结束，忽略大小写");
				form.username.focus();
				return false;
			}	
				document.getElementById("wrongusername").innerHTML = "";
				return true;
	}
		<!--检查是否空格-->
		function isWhiteSpace(ssn) {
			var space = " \t\n\r";
			var i;
			for(i=0;i < ssn.length;i++) {
				var c = ssn.charAt(i);
				if(space.indexOf(c) >= 0) {
					return true;
					}
			}
				return false;
		}
			
		<!--正则表达式来检查串-->
	function isString(ssn) {
			var re = /^[0-9a-z][\w-.]*[0-9a-z]$/i;
			if(re.test(ssn)) {
				return true;
			}
			else return false;
	}
		<!--密码的长度检查-->
	function strlen(str) {
		var len;
		var i;
		len = 0;
		for(i=0;i<str.length;i++) {
			if(str.charCodeAt(i) > 255) len+=2;
			else len++;
		}
		return len;
	}
	
	function strlen2(str) {
		var len;
		var i;
		len = 0;
		for(i=0;i<str.length;i++) {
			if(str.charCodeAt(i) > 255) return true;
		}
		return false;
	}
			