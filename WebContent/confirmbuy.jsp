<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.util.*,java.sql.*,java.util.*,com.my.shop.*" %>
<jsp:useBean id="cart" class="com.my.shop.Cart" scope="session"></jsp:useBean>
<%! 
	int id =0;
%>
<%
	User u  = (User)session.getAttribute("User"); 
	List<CartItem> l = new ArrayList<CartItem>();
	l = cart.getItems();
	if(u==null){
		//response.sendRedirect("userlogin.jsp");
		out.println("你尚未登录，登录可以才可以购买商城东西");
%>
	<a href="admin/userlogin.jsp">登录</a><br>
	免费注册 <a href="register.jsp">注册</a>
<%	
	} else {
%>
	<center>你好！<%= u.getName() %> </center>
	
	<div align="right">
			<a href="index2.jsp">商城首页</a>
			<a href="admin/usermodify.jsp">查看修改用户信息</a>
			<a href="quit.jsp">退出</a><br>
	</div>

<% 		
	}
%>    
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	if(u!=null){
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	if(l.isEmpty()){
		//l不会null 用empty方法判断
		out.println("购物车为空！");
		return;
	}
%>
	<center>
	<h2>购物车清单</h2>
	<form action="cartupdate.jsp" method="post">
		<table border="2">
			<tr>
				<td>宝贝名称</td>
				<td>单价<%= u==null?"(市场价)":"(会员价)" %></td>
				<td>数量</td>
				<td>总计</td>
			</tr>
		<%
			for(Iterator<CartItem> i = l.iterator(); i.hasNext();){
				CartItem ci = new CartItem();
				ci = i.next();
		%>
			<tr>
				<td><%= ProductManager.getInstance().getProductById(ci.getProductId()).getName() %></td>
				<td><%= ci.getPrice()%></td>
				<td><%= ci.getCount()%></td>
				<td><%= ci.getTotalPrice()%></td>
			</tr>
		<%
			}
		%>
			<tr>
				<td>总计 <%= Math.round(cart.getAllPrice()*100)/100.0%> 元</td>
			</tr>
		</table>
	</form>
	<form name="" action="salesorder.jsp" method="post">
	收货地址 ：<br>
		<textarea rows="3" cols="20" name="addr"><%= u==null?"":u.getAddr() %></textarea><br>
		<input type="submit" value="提交订单"></input>
	</form>
	</center>
</body>
</html>
<% 
}
%>