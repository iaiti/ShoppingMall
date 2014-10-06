<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,java.util.*,com.my.shop.*,com.my.shop.DAO.*" %>
<%
	request.setCharacterEncoding("utf-8");
	int id = Integer.parseInt(request.getParameter("id"));
	List<OrderItem> l = OrderFormManager.getInstance().getOrderItemById(id);
	//out.println(l.size());
	if(l==null){
		out.println("当前订单为空");	
	}
%>    
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	function showdescr(descr){
		document.getElementById("showdetail").innerHTML=descr;
	}
	function movedescr(descr){
		document.getElementById("showdetail").innerHTML=descr;
	}
</script>
</head>
<body>
<%
	if(l!=null){
%>
	<table border=1 align=center>
		<tr>
			<td>订单号</td>
			<td>宝贝名字</td>
			<td>价格</td>
			<td>数量</td>
		</tr>
		<%
				for(Iterator<OrderItem> it = l.iterator();it.hasNext();){
					OrderItem of = it.next();
		%>
		<tr>
			<td><%= of.getId()%></td>
			<!--  刚刚学到的东西  两者的引号区别开 -->
			<td onmouseover="showdescr('<%= of.getP().getDescr() %>')" onmouseout="movedescr('鼠标移至宝贝名称即可显示')"><%= of.getP().getName()%></td>
			<td><%= of.getUnitprice()%></td>
			<td><%= of.getPcount()%></td>
		</tr>
		<%
				}
		}
		%>
	</table>
	宝贝详情<div style="border:5px double blue;width:600;" id="showdetail">
	鼠标移至宝贝名称即可显示
	</div>
	
	<a href="orderformlist.jsp" >返回查看订单详情</a>
</body>
</html>