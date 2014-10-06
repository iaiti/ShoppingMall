<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "session.jsp" %>
<%@ page import="java.sql.*,java.util.*,com.my.shop.*" %>
<%
	request.setCharacterEncoding("utf-8");
List<Category> list = new ArrayList<Category>();
	List<Category> c = Category.getCList(list,0);
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script language="javascript" src="script/TV20.js"></script>
<script type="text/javascript">
	function tv(key,parentkey){
		document.form.pid.value = key;
	}
	function modify(key,parentkey){
		window.parent.frames.detail.location.href="categorymodify.jsp?id="+key;
	}
</script>
</head>

<body>

	<form action="categoryadd.jsp" method="post" name="form">
		<input type="hidden" name="action" value="add">
		<table align="center" border="1">
			<tr>
				<td id="show"></td>
			</tr>
			<tr>
			<tr>
				<td>在当前类下添加新类</td>
			</tr>
			<tr>
				<td>类pid</td>
				<td><input type="text" name="pid" value="" readonly></td>
			</tr>
			<tr>
				<td>类名</td>
				<td><input type="text" name="name"></td>
			</tr>
			<tr>
				<td>描述信息</td>
				<td><textarea name="descr" cols="20" rows="5" ></textarea></td>
			</tr>
			<tr>
				<td><input type="submit" name="submit" value="提交添加类" ></td>
			</tr>
		</table>
	</form>
	<script language="javascript">
<!--	
  	addNode(-1,0,"所有类别","images/top.gif");
	<%
			for(Iterator<Category> it = c.iterator();it.hasNext();){
				Category ca = it.next();
	%>
	addNode(<%= ca.getPid()%>,<%= ca.getId()%>,"<%= ca.getName()%>","images/top.gif");
	<%
			}
	%>
	showTV();
	addListener("click","tv");
	addListener("dblclick","modify");
-->
</script>
</body>
</html>
