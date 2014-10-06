<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%	
	session.setAttribute("User", null);
	session.removeAttribute("User");
	session.setAttribute("login", null);
	session.removeAttribute("login");
	//无效  作废
	session.invalidate();
	response.sendRedirect("index2.jsp");
%>