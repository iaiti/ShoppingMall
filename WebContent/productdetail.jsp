<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%! Product p = null; %>
<%@ page import="java.sql.*,java.util.*,com.my.shop.*" %>
<%

	request.setCharacterEncoding("utf-8");
	int id = 1;
	id = Integer.parseInt(request.getParameter("id"));
	p = ProductManager.getInstance().getProductById(id);
		
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>宝贝详情</title>
	<script language = "javascript" src = "images/form_new.js">
	</script>
	</head>

<body>
<center><h1>宝贝详情</h1></center>
									<p><img 
											src="images/product/<%= p.getId() %>.jpg">
									</img></P>
								<P style="COLOR: #ff0000; FONT-WEIGHT: bold">
									宝贝名：<%=p.getName() %>
								</P>
								<p>
									<A title=<%=p.getName() %> ></A>
								</p>
								<p style="COLOR: #ff0000; FONT-WEIGHT: bold">
									价格：<%=p.getNormalPrice() %>
								</p>
								<p style="COLOR: #ff0000; FONT-WEIGHT: bold">
									宝贝详情：<%= p.getDescr() %>
								</p>
								
								<a href="cartitem.jsp?id=<%= p.getId() %>">点击购买</a>
								<a href="cartitem.jsp?id=<%= p.getId()%>">加入购物车</a>
								<a href="index2.jsp">回到首页</a>
</body>
</html>
