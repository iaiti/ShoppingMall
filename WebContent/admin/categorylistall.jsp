<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "session.jsp" %>
<%@ page import="java.sql.*,java.util.*,com.my.shop.*" %>
<%! String s = ""; %>
<%
	request.setCharacterEncoding("utf-8");
	List<Category> c = Category.getCList();
	
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
		</tr>
		<%
			}
		%>
	</table>
</body>
</html>