<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file = "session.jsp" %>
<%@ page import="java.sql.*,java.util.*,com.my.shop.*,com.my.shop.DAO.*" %>
<%!
	List<Category> list = new ArrayList<Category>();
	List<Category> l = new Category().getCList(list,0);
	int index = 1;
%>
<%
	request.setCharacterEncoding("utf-8");
	String action = request.getParameter("action");
	if(action != null && action.equals("add")) {
		String name = request.getParameter("name");
		String descr = request.getParameter("descr");
		double normalPrice = Double.parseDouble(request.getParameter("normalPrice"));
		double memberPrice = Double.parseDouble(request.getParameter("memberPrice"));
		int categoryId = Integer.parseInt(request.getParameter("categoryId"));
		//System.out.println(addr);
		Category c = CategoryDAO.getById(categoryId);
		//方法不足之处 你是提交了之后  在判断 可以用js在点击选择时就做出警告
		//懂了 现在一切都是模拟服务器 客户端没有c那个对象！
		//if(!c.isLeaf()){
		//out.println("不可添加类别,请您在子类别中添加！");
			//return;
		//}
			//Product.addChild(pid,name,descr);
			Product p = new Product();
			p.setId(-1);
			p.setName(name);
			p.setDescr(descr);
			p.setNormalPrice(normalPrice);
			p.setCategoryId(categoryId);
			p.setMemberPrice(memberPrice);
			p.setPdate(new java.sql.Timestamp(System.currentTimeMillis()));
			ProductManager.getInstance().addProducts(p);
		
		//out.println("增加类成功");
		response.sendRedirect("productlist.jsp");
	}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script language = "javascript" src = "script/check.js" ></script>
</head>
<body>
	<center>添加产品</center>
	
	<form action="productadd.jsp" method="post" name = "form" onSubmit="return checkleaf()">
		<input type="hidden" name="action" value="add">
		<table>
			<tr>
				<td>产品名</td>
				<td><input type="text" name="name"></td>
				<td><span id = "wrongname"></span></td>
			</tr>
			<tr>
				<td>类别<select name="categoryId">
				
		<%
			if(request.getParameter("id")!=null&&request.getParameter("id")!=""){
				int id = Integer.parseInt( request.getParameter("id"));
		%>
			<option value=<%= id %>><%= CategoryDAO.getById(id).getName() %></option>
		<% 	
			} else{
		%>
		<option value=0>全部分类</option>
		<script type="text/javascript">
			leafArray[0] = "no";
		</script>
		
		<%		
			
		 	for(Iterator<Category> i = l.iterator(); i.hasNext();){
				Category ca = i.next();
				String pre = "";
				for(int j = 1;j< ca.getGrade();j++){
					pre += "--";
				}
		%>
		
		<option value=<%= ca.getId() %>><%= pre+ca.getName() %></option>
		<script type="text/javascript">
		//想了很久  吃面也在想 一直以为后面的出现问题  其实 自己想想 其实是index没有传进去  我知道循环有问题
		//想写个基本的循环 却连基本的js都忘  这个肯定不能少  甚至去想 看源码  以后想问题  想不通 回到最根本的额地方
			leafArray[<%= index%>] = '<%=ca.isLeaf() ? "yes":"no"%>';
		</script>
		<% index ++;
			}
		} 
		%>
		</select>
		</td><td><span id = "wrongcategory"></span></td>
			</tr>
			<tr>
				<td>普通价格</td>
				<td><input type="text" name="normalPrice"></td>
				<td><span id = "wrongnormalprice"></span></td>
			</tr>
			<tr>
				<td>会员价</td>
				<td><input type="text" name="memberPrice"></td>
				<td><span id = "wrongmemberprice"></span></td>
			</tr>
			<tr>
				<td>宝贝详情</td>
				<td><textarea name="descr" cols="20" rows="5" ></textarea></td>
			</tr>
			<tr><td><input type = "submit" value="提交"></td></tr>
		</table>
	</form>
</body>
</html>