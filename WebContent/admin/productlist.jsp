<!--  绝对好用的return confirm 当初早就想这样 但是不知道怎么写  原来如此  -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "session.jsp" %>
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
	totalpage = ProductManager.getInstance().getTotalpage(pagesize);
	//out.println(totalpage);
	if(strpageno!=null){
		pageno = Integer.parseInt(strpageno);
	} 
	if (pageno<1){
		pageno = 1;
	}
	if(pageno > totalpage){
		pageno = totalpage;
	}
	List<Product> p = ProductManager.getInstance().getProducts(pageno,pagesize);
	if(p==null){
		out.println("当前产品为空，请回去添加商品");	
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
	if(p!=null){
%>
	<table border=1 align=center>
		<tr>
			<td>产品id</td>
			<td>产品名</td>
			<td>宝贝详情</td>
			<td>单价</td>
			<td>会员价</td>
			<td>发表时间</td>
			<td>类别</td>
		</tr>
		<%
				for(Iterator<Product> it = p.iterator();it.hasNext();){
					Product pd = it.next();
		%>
		<tr>
			<td><%= pd.getId()%></td>
			<td><%= pd.getName()%></td>
			<td><%= pd.getDescr()%></td>
			<td><%= pd.getNormalPrice()%></td>
			<td><%= pd.getMemberPrice()%></td>
			<td><%= pd.getPdate()%></td>
			<!-- 			
			<td><%= CategoryDAO.getById(pd.getCategoryId()).getName()%></td>
			存在缺陷  每次categroy都要连接数据库 所以初始化更好 用另一种方法 下面这种在用
			 -->
			 <!-- hibernate 会封装 传一个参数 判断要不要初始化category 因为我们有时候用不到 没必要初始化 -->
			<td><%= pd.getCategory().getName()%></td>
			<td><a href=productmodify.jsp?id=<%= pd.getId() %> >修改</a></td>
			<td><a href= productdelete.jsp?id=<%= pd.getId() %> onClick="return confirm('确认删除')">删除</a></td>
			<td><a href= addpicture.jsp?id=<%= pd.getId() %> >添加图片</a></td>
		</tr>
		<%
				}
		%>
	</table>
	<center>
		共 <%= totalpage %> 页
		第 <%= pageno %> 页<p/>
		<a href="productlist.jsp?pageno=1">首页</a>
		<a href="productlist.jsp?pageno=<%= (pageno-1) %>">上一页</a>
		<a href="productlist.jsp?pageno=<%= (pageno+1) %>">下一页</a>
		<a href="productlist.jsp?pageno=<%= totalpage %>">最后一页</a>
		<form name="choosepage" action=productlist.jsp>
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