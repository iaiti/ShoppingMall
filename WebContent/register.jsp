<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.sql.*,java.util.*,com.my.shop.*" %>

<%
	request.setCharacterEncoding("utf-8");
	String action = request.getParameter("action");
	if(action != null && action.equals("register")) {
	String username = request.getParameter("username");
	String password = request.getParameter("pwd");
	String phone = request.getParameter("phone");
	String addr = request.getParameter("addr");
	//System.out.println(addr);
	User u = new User();
	u.setName(username);
	u.setPw(password);
	u.setPhone(phone);
	u.setAddr(addr);
	u.setRdate(new Timestamp(System.currentTimeMillis()));
	u.savesql();
%>
	<center>注册成功!欢迎来到购物世界！</center>
		<!-- <a href="javascript:" onClick="delayURL('index2.jsp','1000')">1秒后返回主页</a> -->
		<a href="index2.jsp">返回首页</a>
<%
	return;
}
%>

<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>注册新用户</title>
	
	<script  type="text/javascript">
	var req;
	function validate(){
		var username = document.getElementById("username");
		var url = "validate.jsp?username="+escape(username.value);
		 if(window.ActiveXObject) {
			req = new ActiveXObject("Microsoft.XMLHTTP");
		} else if(window.XMLHttpRequest){
			req = new XMLHttpRequest();
		}
		req.open("GET",url,true);
		req.onreadystatechange = callback;
		req.send(null);
	}
	
	function callback(){
		//alert(req.readyState);
		// 1 连上 2 loading 3 loaded 4
		if(req.readyState == 4){
			//alert(req.responseText);
			if(req.status==200){
				var msg = req.responseXML.getElementsByTagName("message")[0];
				//alert(msg.childNodes[0].nodeValue);
				sendmsg(msg.childNodes[0].nodeValue);
			}
		}
	}
	
	function sendmsg(msg){
		if(msg == "invalid"){
			document.getElementById("wrongusername").innerHTML="<font color=red>用户名已注册</font>";
		} else {
			document.getElementById("wrongusername").innerHTML="<font color=green>此用户名可用</font>";
		}
	}
	</script>
	
	</head>

<body>
<script language = "javascript" src = "images/js/form_new.js">
	</script>
	<form name = "form" action = "EmailRegister" method = "post"  onSubmit = "return checkdata()">
	<input type="hidden" name="action" value="register"/>
	<table border = 1 align = "center" width="80%">
		<tr>
		<img src="images/table.jpg" width="1065" height="300" />		</tr>
		<tr>
			<th  colspan = 2 align = "center">用户注册</th>
		</tr>
		<tr>
			<td width="30%" height="31" >用户名：</td>
		  <td valign="bottom">
				<input name = "username" type="text" id="username"onblur="validate()">
			<span id = "wrongusername"></span>
			<!--  span和div区别 span和输入框在同一行 比较好， div跳到下面去了 -->
	  </td>
	  
		</tr>
		<tr>
			<td width="30%" height="39" >密码： </td>
			<td>
				<input type="password" id="pwd" name = "pwd" >
				<span id = "pwdErr"></span>
		</td>
		</tr>
		<tr>
			<td width = "30%" height = "40" name = "pwd2">确认密码：</td>
			<td>
				<input type = "password" name = "pwd2">
				<span id = "pwdErr2"></span>
			</td>
		<tr>
			<td>电话：</td>
			<td>
				<input type="text" name="phone" size="20" />
  			</td>
		</tr>
		<tr>
			<td>邮箱地址：</td>
			<td>
				<input type="text" name="email" size="20" />
  			</td>
		</tr>
		<tr>
			<td>地址：</td>
			<td>
		 		 <textarea name = "addr" cols = 50 rows = 6></textarea>
			</td>
		</tr>
		<tr>
			<td>
				<input type = "image" src="images/zhuce.gif" />
				<input type = "reset" value="重新填写"/>
			</td>
		</tr>
	</table>
	</form>
</body>
</html>
