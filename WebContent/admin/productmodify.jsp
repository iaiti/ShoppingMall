<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@ include file = "session.jsp" %>
<%! Product p = null; %>
<%@ page import="java.sql.*,java.util.*,com.my.shop.*" %>
<%

	List<Category> list = new ArrayList<Category>();
	List<Category> l = new Category().getCList(list,0);
	request.setCharacterEncoding("utf-8");
	int id = 1;
	id = Integer.parseInt(request.getParameter("id"));
	p = ProductManager.getInstance().getProductById(id);
		
		String action = request.getParameter("action");
		if(action != null && action.equals("modify")) {
			if(! Category.getById(id).isLeaf()){
				out.println("修改的类别要为子类!");
				return;
			}
			String cname = request.getParameter("name");
			String descr = request.getParameter("descr");
			int categoryId = Integer.parseInt(request.getParameter("categoryId"));
			double normalPrice = Double.parseDouble(request.getParameter("normalPrice"));
			double memberPrice = Double.parseDouble(request.getParameter("memberPrice"));
			//System.out.println(addr);
			out.println("修改成功");
			p.setName(cname);
			p.setDescr(descr);
			p.setCategoryId(categoryId);
			p.setNormalPrice(normalPrice);
			p.setMemberPrice(memberPrice);
			//out.println(p.getName());
			ProductManager.getInstance().updateProduct(p);
	%>
			<script type="text/javascript">
				window.parent.main.location.reload();
			</script>
	<% 
		}
	//u.savesql();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>商品修改</title>
	<script language = "javascript" src = "images/form_new.js">
	</script>
	</head>

<body>
<form name = "form" action = "productmodify.jsp?id=<%= p.getId() %>" method = "post"  onSubmit = "return checkdata()">
	<input type="hidden" name="action" value="modify"/>
	<table border = 1 align = "center" ">
			<tr>
				<td>产品名</td>
				<td><input type="text" name="name" value="<%=p.getName() %>"></td>
			</tr>
			<tr>
				<td>类别</td><td><select name="categoryId">
		<%
		%>
			<option value=<%= p.getCategoryId() %> ><%= CategoryDAO.getById(p.getCategoryId()).getName() %></option>
		
		<%		
			
		 	for(Iterator<Category> i = l.iterator(); i.hasNext();){
				Category ca = i.next();
				String pre = "";
				for(int j = 1;j< ca.getGrade();j++){
					pre += "--";
				}
				if(ca.getId()!=p.getCategoryId()){
		%>
	
		<option value=<%= ca.getId() %>><%= pre+ca.getName() %></option>
		<% 
				}
			} 
		%>	
		</select></td>
			</tr>
			<tr>
				<td>普通价格</td>
				<td><input type="text" name="normalPrice" value="<%=p.getNormalPrice() %>"></td>
			</tr>
			<tr>
				<td>会员价</td>
				<td><input type="text" name="memberPrice" value="<%=p.getMemberPrice() %>"></td>
			</tr>
			<tr>
				<td>宝贝详情</td>
				<td><textarea name="descr" cols="20" rows="5" ><%= p.getDescr() %></textarea></td>
			</tr>
			<tr><td><input type = "submit" value="提交"></td></tr>
		</table>
	</form>

	
</body>
</html>
