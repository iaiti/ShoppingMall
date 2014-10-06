<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%! Category c = null; %>
<%@ include file = "session.jsp" %>
<%@ page import="java.sql.*,java.util.*,com.my.shop.*" %>
<%
	request.setCharacterEncoding("utf-8");
	int id = Integer.parseInt(request.getParameter("id"));
	if(id==0){
		response.sendRedirect("categorylistall.jsp");
	} else {
		
		c = Category.getById(id);
		String action = request.getParameter("action");
		if(action != null && action.equals("modify")) {
			String cname = request.getParameter("cname");
			String descr = request.getParameter("descr");
			//System.out.println(addr);
			c.setName(cname);
			c.setDescr(descr);
%>
	<script type="text/javascript">
		window.parent.main.location.reload();
	</script>
<% 
			out.println("修改成功");
			c.update();
		}
	}
	//u.savesql();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<% 
	if(c!= null){ 
%>
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>类别修改</title>
	<script language = "javascript" src = "images/form_new.js">
	</script>
	
	</head>

<body>
	<form name = "form" action = "categorymodify.jsp?id=<%= c.getId() %>" method = "post"  onSubmit = "return checkdata()">
	<input type="hidden" name="action" value="modify"/>
	<table border = 1 align = "center" ">
		<tr>
		<tr>
			<th  colspan = 2 align = "center">类别修改</th>
		</tr>
		<tr>
			<td >类名：</td>
		  <td valign="bottom">
				<input name = "cname" type="text" value=<%= c.getName()%> onblur = "checkUserName(this.value.toLowerCase())">
				<!--<div id = "usernameErr"></div>-->
				<span id = "usernameErr"></span>
	  </td>
		</tr>
		<tr>
		<td>描述：</td>
		<td>
		  <textarea name = "descr" cols = 50 rows = 6><%= c.getDescr()%></textarea>
		</td>
		</tr>
		<tr>
		<td>
		<input type = "submit" value="提交修改"/>
		</td>
		</tr>
	</table>
	</form>
</body>
</html>
<% 
	}
%>