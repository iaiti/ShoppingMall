<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,java.util.*,com.my.shop.*,com.my.shop.DAO.*" %>
<%! 
	String s = "";
%>
<%
	request.setCharacterEncoding("utf-8");
	String strpageno = request.getParameter("pageno");
	int pageno = 1;
	int pagesize = 3;
	int totalpage = 0;
	totalpage = OrderFormManager.getInstance().getTotalpage(pagesize);
	if(strpageno!=null){
		pageno = Integer.parseInt(strpageno);
	} 
	if (pageno<1){
		pageno = 1;
	}
	if(pageno > totalpage){
		pageno = totalpage;
	}
	List<OrderForm> o = OrderFormManager.getInstance().getOrderForms(pageno,pagesize);
	if(o==null){
		out.println("当前订单为空");	
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
	if(o!=null){
%>
	<table border=1 align=center>
		<tr>
			<td>订单id</td>
			<td>用户</td>
			<td>送货地址</td>
			<td>拍下时间</td>
			<td>状态</td>
		</tr>
		<%
				for(Iterator<OrderForm> it = o.iterator();it.hasNext();){
					OrderForm of = it.next();
		%>
		<tr>
			<td><%= of.getId()%></td>
			<td><%= of.getU().getName()%></td>
			<td><%= of.getAddr()%></td>
			<td><%= of.getOdate()%></td>
			<%
				switch(of.getStatus()){
				case 0:
			%>
					<td>未发货</td>
			<% 
				break;
				case 1:
			%>
					<td>发货</td>
			<% 
				break;
				case 2:
			%>
					<td>交易完成</td>
			<% 
				break;
				}
			%>
			<td><a href="ordermodify.jsp?id=<%= of.getId() %>">更改订单状态</a></td>
			<td><a href="orderformitems.jsp?id=<%= of.getId() %>" >查看订单详情</a></td>
			<td><a href="orderformdelete.jsp?id=<%= of.getId() %>" >删除订单</a></td>
		</tr>
		<%
				}
		%>
	</table>
	<center>
		共 <%= totalpage %> 页
		第 <%= pageno %> 页<p/>
		<a href="orderformlist.jsp?pageno=1">首页</a>
		<a href="orderformlist.jsp?pageno=<%= (pageno-1) %>">上一页</a>
		<a href="orderformlist.jsp?pageno=<%= (pageno+1) %>">下一页</a>
		<a href="orderformlist.jsp?pageno=<%= totalpage %>">最后一页</a>
		<form name="choosepage" action=orderformlist.jsp>
		<select name="pageno" onchange="document.choosepage.submit()">
		<%
			for (int i = 1; i <= totalpage; i++) {
		%>
		<option value=<%= i %> <%= pageno==i?"selected":"" %>>第 <%=i%> 页</option>
		<%
			}
		    }
		%>
		</select>
		</form>
	</center>
</body>
</html>