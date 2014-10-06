<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.util.*,java.sql.*,java.util.*,com.my.shop.*" %>
<%
	request.setCharacterEncoding("utf-8");
	User u  = (User)session.getAttribute("User");
	if(u==null){
		response.sendRedirect("userlogin.jsp");
	}
	String action = request.getParameter("action");
	if(action != null && action.equals("register")) {
		String username = request.getParameter("username");
		String phone = request.getParameter("phone");
		String addr = request.getParameter("addr");
		//System.out.println(addr);
		u.setName(username);
		u.setPhone(phone);
		u.setAddr(addr);
		u.updatesql();
		out.println("修改成功");
	}
	//u.savesql();
%>

<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>用户修改</title>
	</head>

<body>
	<form name = "form" action = "usermodify.jsp" method = "post"  onSubmit = "return checkdata()">
	<input type="hidden" name="action" value="register"/>
	<table border = 1 align = "center" width="80%">
		<tr>
		<img src="../images/table.jpg" width="1065" height="300" />		</tr>
		<tr>
			<th  colspan = 2 align = "center">用户修改</th>
		</tr>
		<tr>
			<td width="30%" height="31" >用户名：</td>
		  <td valign="bottom">
				<input name = "username" type="text" value=<%= u.getName()%> onblur = "checkUserName(this.value.toLowerCase())">
				<!--<div id = "usernameErr"></div>-->
				<span id = "usernameErr"></span>
	  </td>
		</tr>
		<tr>
		<td>电话：</td>
		<td>
		<input type="text" name="phone" size="20" value=<%= u.getPhone()%>>
	  	</td>
		</tr>
		<tr>
		<td>地址：</td>
		<td>
		  <textarea name = "addr" cols = 50 rows = 6><%= u.getAddr()%></textarea>
		</td>
		</tr>
		<tr>
		<td>
		<input type = "submit" value="提交修改"/>
		<input type = "button" value="返回购物车" onClick="window.location.reload('../confirmbuy.jsp')"/>
		<input type = "button" value="返回个人主页" onClick="window.location.reload('userservice.jsp')"/>
		</td>
		</tr>
	</table>
	</form>
	
</body>
</html>
