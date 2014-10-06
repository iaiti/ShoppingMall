<%@ page language="java" contentType="text/html; charset=UTF-8" 
    pageEncoding="UTF-8"%>
    <%@ page import="java.util.*,java.sql.*,java.util.*,com.my.shop.*" %>
<% List<User> u = User.showuser(); %>

    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<table border=1 align=center>
		<tr>
			<td>用户id</td>
			<td>用户名</td>
			<td>电话</td>
			<td>住址</td>
			<td>注册时间</td>
		</tr>
		<%
			for(Iterator<User> it = u.iterator();it.hasNext();){
				User ue = it.next();
		%>
		<tr>
			<td><%= ue.getId()%></td>
			<td><%= ue.getName()%></td>
			<td><%= ue.getPhone()%></td>
			<td><%= ue.getAddr()%></td>
			<td><%= ue.getRdate()%></td>
			<td><a href=delete.jsp?id=<%= ue.getId() %>  target=detail onClick="return confirm('确认删除')">删除</a></td>
		</tr>
		<%
			}
		%>
	</table>
</body>
</html>