<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,java.util.*,com.my.shop.*,com.my.shop.DAO.*" %>
<%
	request.setCharacterEncoding("utf-8");
	int id = Integer.parseInt(request.getParameter("id"));
	OrderForm of = OrderFormManager.getInstance().getOrderFormById(id);
	
	String action = request.getParameter("action");
	if(action!=null&&!action.equals("")){
		//out.println("a");
		of.setStatus(Integer.parseInt(request.getParameter("status")));
		//out.println(of.getStatus());
		OrderFormManager.getInstance().updateOrderForm(of);
		out.println("修改成功！");
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
	<form action="ordermodify.jsp?id=<%= of.getId() %>"  method="post">
	<input type="hidden" name="action" value="modify"></input>
		<table>
			<tr><td>收货人：<%= of.getU().getName() %></td></tr>
			<tr><td>收货地址：<%= of.getU().getAddr() %></td></tr>
			<tr>
				<td>订单状态 ：
					<select name="status">
						<%
				switch(of.getStatus()){
				case 0:
			%>
						<option value="0">未发货</option>
					<option value="1">已发货</option>
						<option value="2">交易完成</option>
			<% 
				break;
				case 1:
			%>
					<option value="1" >已发货</option>
						<option value="2">交易完成</option>
						<option value="0">未发货</option>
			<% 
				break;
				case 2:
			%>
						<option value="2">交易完成</option>
					<option value="1">已发货</option>
						<option value="0">未发货</option>
			<% 
				break;
				}
			%>
						
					</select>
				</td>
			</tr>
			
		</table>
		<input type="submit" value="确认修改"></input>
	</form>
	<a href="orderformlist.jsp" >返回查看订单详情</a>
</center>
</body>
</html>

<!--<script type="text/javascript">

	//for(var option in document.forms("form").status.options){
	//	if(option.value=of.getStatus()){
	//		document.forms("form").status.selectedIndex = option.index;
	//	}
	//}  这个写法 有问题  optionvalue 为undifined   调了很久  果然不是这么写的 
	
	for(i=0; i < document.forms("form").status.options.length; i++){
		if(document.forms("form").status.options[i].value==<%= of.getStatus() %>){
			document.forms("form").status.selectedIndex = i;
		}
	}
</script>-->