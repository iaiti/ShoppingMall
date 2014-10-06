<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%! Product p = null; %>
<%@ page import="java.sql.*,java.util.*,com.my.shop.*" %>
<!--    就在那里误导  明明是class 和new和include 区别在于 已经帮你new出来了  有些私有的不能new 使用bean会出错  -->
<jsp:useBean id="cart" class="com.my.shop.Cart" scope="session"></jsp:useBean>

<%
	if(cart==null){
		//l不会null 用empty方法判断
		out.println("购物车为空！");
		return;
	}
%>
<%
	//其实自己写的传两个参数的也是可以的 只不过没for循环 而且教室关门 时间紧迫 视频那个string里面带有p不知道怎么转成int的
	request.setCharacterEncoding("utf-8");
	List<CartItem>l = cart.getItems();
	String s = "";
	for(int i = 0;i<l.size();i++){
		CartItem c = l.get(i);
		s = request.getParameter("p"+c.getProductId());
		if(s != null && !s.trim().equals("")){
			c.setCount(Integer.parseInt(s));;
		}
		Product p = ProductManager.getInstance().getProductById(c.getProductId());
		//需进行判断 是否会员登录
		c.setPrice(p.getNormalPrice());
		
	}
%>  

  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<center>
		<h1>更改数量成功</h1>
		<a id="time"></a>秒跳回页面
	<script type="text/javascript">
		var leftTime = 3;
		function jump(){
			document.getElementById("time").innerText=leftTime;
			leftTime -= 1;
			if(leftTime==0){
				document.location.href("cart.jsp");
			}
		}
		
		//setTimeout(jump,1000); 这个是个多长时间 执行函数 下面那个是每隔1秒执行jump一次
		setInterval(jump,1000);
	</script>
	
	
	
	</center>

</body>
</html>