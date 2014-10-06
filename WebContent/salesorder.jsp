<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*,java.sql.*,java.util.*,com.my.shop.*" %>  
<jsp:useBean id="cart" class="com.my.shop.Cart" scope="session"></jsp:useBean>
<%
	request.setCharacterEncoding("utf-8");
	User u = (User)session.getAttribute("User");
	if(u==null){
		out.println("用户登录超时");
		return;
	}
%>
  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	String s = request.getParameter("addr");
	OrderForm o =  new OrderForm();
	o.setAddr(s);
	o.setUserid(u.getId());
	o.setStatus(0);
	o.setC(cart);
	o.setOdate(new Timestamp(System.currentTimeMillis()));
	o.addOrderForms();
	//这一步很重要 提交完后 把之前购物车的东西删掉
	session.removeAttribute("cart");
	
%>
你的订单已提交，我们会尽快安排工作人员在24小时内送达！<br><br>
<a href="index2.jsp">回到商城首页</a>
</body>
</html>