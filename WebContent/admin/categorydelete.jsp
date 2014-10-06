<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "session.jsp" %>
<%@ page import="java.sql.*,java.util.*,com.my.shop.*,com.my.shop.DAO.*" %>
<%
	
	String getpid = request.getParameter("pid");
	int pid = Integer.parseInt(getpid);
	String getid = request.getParameter("id");
	int id = Integer.parseInt(getid);
	Category c = new Category();
	int[] idArray = new int[1];
	idArray[0] = id;
	List<Product> l = new ArrayList<Product>();
	int number = ProductManager.getInstance().getTotalpage(l,idArray
			,"",-1,-1,-1,-1,null,null,0,3);
	System.out.println(number);
	if(number ==0){
		CategoryDAO.delete(pid,id);
	} else {
		out.println("该类别下有产品 若要删除 请清空产品");
		return;
	}
	//out.println(pid);
	response.sendRedirect("categorylist.jsp");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.my.shop.DAO.ProductDAO"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
删除成功！

</body>
</html>