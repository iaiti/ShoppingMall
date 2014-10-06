<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.my.shop.*" %>
<%@page import="java.sql.*"%>

<jsp:useBean id="db" class="com.my.shop.DB" scope="page"></jsp:useBean>
<%
	Connection c = db.getConn();
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>connect successfully!</h1>
</body>
</html>