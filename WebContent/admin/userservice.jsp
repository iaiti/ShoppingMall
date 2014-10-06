<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*,java.sql.*,java.util.*,com.my.shop.*" %>
<%
	User u  = (User)session.getAttribute("User"); 
	if(u==null){
		response.sendRedirect("userlogin.jsp");
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>欢迎<%= u.getName() %>, 您的到来！</h1>
<a href="../index2.jsp">商城首页</a>
<a href="../confirmbuy.jsp">查看订单</a>
<a href="usermodify.jsp">查看修改用户信息</a>
</body>
</html>