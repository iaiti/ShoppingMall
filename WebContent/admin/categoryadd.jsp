<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file = "session.jsp" %>
<%@ page import="java.sql.*,java.util.*,com.my.shop.*" %>
<%	
	request.setCharacterEncoding("utf-8");
	String action = request.getParameter("action");
	String getpid = request.getParameter("pid");
	int pid = 0;
	if(getpid!=null){
		pid = Integer.parseInt(getpid);
	}
	
	if(action != null && action.equals("add")) {
		String name = request.getParameter("name");
		String descr = request.getParameter("descr");
		//System.out.println(addr);
		if(pid == 0){
			Category.addRoot(name,descr);
		} else{
			//Category.addChild(pid,name,descr);
			Category parent = Category.getById(pid);
			Category child = new Category();
			child.setId(pid);
			child.setName(name);
			child.setDescr(descr);
			parent.addLittleChild(child);
		}
		//out.println("增加类成功");
		response.sendRedirect("categorylist.jsp");
	}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	function check(){
	//alert(form.name.value);
		if(form.name.value==null||form.name.value==""){
			document.getElementById("voidname").innerHTML = "<font color = 'red'>类名不能为空</font>";
		form.name.focus();
		return false;
		}
		return true;
	}
</script>
</head>
<body>
	<center>添加根类别</center>
	<form name="form" action="categoryadd.jsp" method="post" onSubmit="return check()">
		<input type="hidden" name="action" value="add">
		<input type="hidden" name="pid" value=<%= pid %>>
		<table>
			<tr>
				<td>类名</td>
				<td><input type="text" name="name">
					<span id = "voidname"></span>
				</td>
			</tr>
			<tr>
				<td>描述信息</td>
				<td><textarea name="descr" cols="20" rows="5" ></textarea></td>
			</tr>
			<tr><td><input type = "submit" value="提交"></td></tr>
		</table>
	</form>
</body>
</html>