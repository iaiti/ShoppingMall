<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%! Product p = null; %>
<%@ page import="java.sql.*,java.util.*,com.my.shop.*" %>
<!--    就在那里误导  明明是class 和new和include 区别在于 已经帮你new出来了  有些私有的不能new 使用bean会出错  -->
<jsp:useBean id="cart" class="com.my.shop.Cart" scope="session"></jsp:useBean>

<%
	User u  = (User)session.getAttribute("User"); 
	request.setCharacterEncoding("utf-8");
	List<CartItem> l = new ArrayList<CartItem>();
	l = cart.getItems();
	int id = 1;
	id = Integer.parseInt(request.getParameter("id"));
	p = ProductManager.getInstance().getProductById(id);
	CartItem c = new CartItem();
	c.setProductId(id);
	//需进行判断 是否会员登录
	//注意 登陆后设置已经完了  所以在订单详情那里还要多一次判断  因为用户分两种情况登陆
	if(u == null){
		c.setPrice(p.getNormalPrice());
	} else{
		c.setPrice(p.getNormalPrice());
		
	}
	c.setCount(1);
	cart.addItem(c);
	response.sendRedirect("cart.jsp");
		
%>

<%
	if(l.isEmpty()){
		//l不会null 用empty方法判断
		out.println("购物车为空！");
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

</body>
</html>