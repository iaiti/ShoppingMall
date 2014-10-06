<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,java.util.*,com.my.shop.*" %>
<jsp:useBean id="cart" class="com.my.shop.Cart" scope="session"></jsp:useBean>
<%! 
	int id =0;
%>
<%
	List<CartItem> l = new ArrayList<CartItem>();
	l = cart.getItems();
	User u  = (User)session.getAttribute("User"); 
%>    

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
%>
	<a href="index2.jsp">回到首页</a>
<%
	} else {
%>
<a  href="index2.jsp">回到首页</a>
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
				Product p =ProductManager.getInstance().getProductById(ci.getProductId());
				if(u == null){
					ci.setPrice(p.getNormalPrice());
				} else{
					ci.setPrice(p.getMemberPrice());
				}
		%>
			<tr>
				<td><%= ProductManager.getInstance().getProductById(ci.getProductId()).getName() %></td>
				<td><%= ci.getPrice() %></td>
				<td><input name="p<%= ci.getProductId() %>" type="text" size="6" value=<%= ci.getCount()%>></td>
				<td><%= ci.getTotalPrice()%></td>
			</tr>
		<%
			}
		%>
			<tr>
				<td>总计 <%= Math.round(cart.getAllPrice()*100)/100.0%> 元</td>
			</tr>
			<tr>
				
				
			</tr>
			<tr>
				<td><input type="submit" value="确认数量"></input></td>
			</tr>
		</table>
		
	</form>
	<button   onclick="document.location.href('confirmbuy.jsp')">确认购买</button>
	</center>
	<%
	}
	%>
</body>
</html>