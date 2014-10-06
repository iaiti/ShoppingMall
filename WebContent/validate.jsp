<%@ page import="java.sql.*,java.util.*,com.my.shop.*" %>
<%
	response.setContentType("text/xml");
	response.setHeader("Cache-Control","no-store");
	response.setHeader("Pragma","no-cache");
	response.setDateHeader("Expires",0);
	String username = request.getParameter("username");
	String s = "";
	boolean whether = false;
	List<User> l = User.showuser();
	for(int i = 0;i < l.size();i++) {
		User u = l.iterator().next();
		//查来查去  发现 if条件有问题  == 和equals的问题   这个回去查查！
		if(username.equals(u.getName())){
			whether = true;
		}
	}
	if(whether){
		response.getWriter().write("<message>invalid</message>");
	} else{
		//response.getWriter().write("<message>"+s+username+"</message>");
		response.getWriter().write("<message>valid</message>");
	}
%>