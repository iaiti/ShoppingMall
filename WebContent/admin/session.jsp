<%
String login = (String)session.getAttribute("login");
String admin = (String)session.getAttribute("admin");
if(admin == null || !admin.equals("true")) {
	response.sendRedirect("login.jsp");
} else{
	if(login == null || !login.equals("true")) {
		response.sendRedirect("login.jsp");
	}
}

%>