<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "session.jsp" %>
<%@ page import="java.sql.*,java.util.*,com.my.shop.*" %>
<%! String s = ""; %>
<%
	request.setCharacterEncoding("utf-8");
	List<Category> list = new ArrayList<Category>();
	List<Category> c = Category.getCList(list,0	);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<table border=1 align=center>
		<tr>
			<td>类id</td>
			<td>类别名</td>
			<td>描述</td>
			<td>pid</td>
			<td>是否叶子节点</td>
			<td>级别数</td>
		</tr>
		<%
			for(Iterator<Category> it = c.iterator();it.hasNext();){
				Category ca = it.next();
				String prefix = "";
				for(int i = 1; i<ca.getGrade();i++){
					prefix += "----";
				}
		%>
		<tr>
			<td><%= ca.getId()%></td>
			<td><%= prefix+ca.getName()%></td>
			<td><%= ca.getDescr()%></td>
			<td><%= ca.getPid()%></td>
			<td><%= ca.isLeaf()%></td>
			<td><%= ca.getGrade()%></td>
				<td><a href=categorymodify.jsp?id=<%= ca.getId() %> >修改</a></td>
			<td><a href=categorydelete.jsp?id=<%= ca.getId() %>&pid=<%=ca.getPid() %> onClick="return confirm('确认删除')">删除</a></td>
			<td><a href=categoryadd.jsp?pid=<%= ca.getId() %> >添加子类</a></td>
			<% if(ca.isLeaf()&&ca.getPid()!=0){ %>
				<td><a href=productadd.jsp?id=<%= ca.getId() %> >该类别下添加商品</a></td>
			<% } %>
		</tr>
		<%
			}
		%>
	</table>
</body>
</html>