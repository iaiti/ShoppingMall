<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "session.jsp" %>
<%@ page import="java.sql.*,java.util.*,com.my.shop.*,com.my.shop.DAO.*" %>

<%! 
	List<Category> list = new ArrayList<Category>();
	List<Category> l = new Category().getCList(list,0);
	String s = "";
	//只是声明对象 引用 感觉没必要加new arraylist 但是程序出错调了大半天  最后还是没事 为何
	List<Product> pl ;
	int totalpage = 0;
	int pageno = 0;
	int pagesize = 3;
	Timestamp sp = null;
	Timestamp ep = null;
	int categoryId = 0;
	double snormalPrice = -1;
	double enormalPrice = -1;
	double smemberPrice = -1;
	double ememberPrice = -1;
	String keyword="";
	String strpageno ="";
	String action ="";
	String[] categoryarray ;
	int[] idArray;
	String postcategoryId = "";
%>
<!-- 注意事项 include 才有flush 把文件读进来嘛 forward跳转哪有缓冲不缓冲的 -->
<%
// 程序的不足之处 日期怎么可能手工大的  肯定按一下日期会有一个阅历跑出来然你选择
	request.setCharacterEncoding("utf-8");
 	action = request.getParameter("action");
	strpageno = request.getParameter("pageno");
	if(action != null && action.equals("simple")) {
%>
	<jsp:forward page="simplesearch.jsp" ></jsp:forward>
<% 
	}
	if(action != null && action.equals("complex")) {
%>
	<jsp:forward page="complexsearch.jsp" ></jsp:forward>
<% 
	}
%>

<%
// 程序的不足之处 日期怎么可能手工大的  肯定按一下日期会有一个阅历跑出来然你选择
	request.setCharacterEncoding("utf-8");
	 action = request.getParameter("action");
	 strpageno = request.getParameter("pageno");
	if(action != null && action.equals("add")) {
		//当用户 不输入任何东西时 将所有的变量设成 特殊值 因为getproductlist方法里面需要传参
		 keyword = request.getParameter("keyword");
		 categoryId = Integer.parseInt(request.getParameter("categoryId"));
		int[] idArray = new int[1];
		//默认的全部分类 进行判断
		
		if(categoryId == 0){
			idArray = null;
			if(keyword==null||keyword==""){
				totalpage = ProductManager.getInstance().getTotalpage(pagesize);
			}else{
				//判断关键词是否为空 不像价格那样赋值了-1 如果两者都没有 记录是拿不到的
				totalpage = ProductManager.getInstance().getTotalpage(pl,idArray, keyword, snormalPrice,enormalPrice, smemberPrice,
						ememberPrice, sp, ep,pageno,pagesize);
			}
		} else {
			idArray[0] = categoryId;
			totalpage = ProductManager.getInstance().getTotalpage(pl,idArray, keyword, snormalPrice,enormalPrice, smemberPrice,
					ememberPrice, sp, ep,pageno,pagesize);
		}
		if(strpageno!=null){
			pageno = Integer.parseInt(strpageno);
		} 
		if (pageno<1){
			pageno = 1;
		}
		if(pageno > totalpage){
			pageno = totalpage;
		}
		pl =  ProductManager.getInstance().searchProducts(idArray
				,keyword,snormalPrice,enormalPrice,smemberPrice,ememberPrice,sp,ep,pageno,3);
		//out.println(pl.size());
	}
%>



<%
	if(pl != null ){
%>
<center>搜索结果</center>
	<table border=1 align=center>
		<tr>
			<td>产品id</td>
			<td>产品名</td>
			<td>宝贝详情</td>
			<td>单价</td>
			<td>会员价</td>
			<td>发表时间</td>
			<td>类别</td>
		</tr>
		<%
		    if(pl!=null){
				for(Iterator<Product> it = pl.iterator();it.hasNext();){
					Product pd = it.next();
		%>
		<tr>
			<td><%= pd.getId()%></td>
			<td><%= pd.getName()%></td>
			<td><%= pd.getDescr()%></td>
			<td><%= pd.getNormalPrice()%></td>
			<td><%= pd.getMemberPrice()%></td>
			<td><%= pd.getPdate()%></td>
			<td><%= new ProductManager().getInstance().getCategoryNameById(pd.getCategoryId())%></td>
			<td><a href=productdelete.jsp?id=<%= pd.getId() %> >删除</a></td>
		</tr>
		<%
				}
		    }
		%>
	</table>
	<center>
	<!-- 接下来是 跳转页面的问题  因为跳转后 程序s头还有getparameter的东西 如果不在后面跟上参数 拿不到 空指针错误
		最复杂的东西 莫过这样 要一条一条的跟debug 不过 很有用  至少比他不报错的强
	 -->
		共 <%= totalpage %> 页
		第 <%= pageno %> 页<p/>
		<% 
		if(action != null && action.equals("add")) { 
		%>
		<a href="productsearch.jsp?pageno=1&action=<%= action %>
		&keyword=<%= keyword%>&categoryId=<%= categoryId %>&snormalPrice=<%= snormalPrice%>&enormalPrice=<%= enormalPrice%>
		&smemberPrice=<%= smemberPrice%>&ememberPrice=<%= ememberPrice%>">首页</a>
		
		<a href="productsearch.jsp?pageno=<%= (pageno-1) %>&action=<%= action %>
		&keyword=<%= keyword%>&categoryId=<%= categoryId %>&snormalPrice=<%= snormalPrice%>&enormalPrice=<%= enormalPrice%>
		&smemberPrice=<%= smemberPrice%>&ememberPrice=<%= ememberPrice%>">上一页</a>
		
		<a href="productsearch.jsp?pageno=<%= (pageno+1) %>&action=<%= action %>
		&keyword=<%= keyword%>&categoryId=<%= categoryId %>&snormalPrice=<%= snormalPrice%>&enormalPrice=<%= enormalPrice%>
		&smemberPrice=<%= smemberPrice%>&ememberPrice=<%= ememberPrice%>">下一页</a>
		
		<a href="productsearch.jsp?pageno=<%= totalpage %>&action=<%= action %>
		&keyword=<%= keyword%>&categoryId=<%= categoryId %>&snormalPrice=<%= snormalPrice%>&enormalPrice=<%= enormalPrice%>
		&smemberPrice=<%= smemberPrice%>&ememberPrice=<%= ememberPrice%>">最后一页</a>
		<% 
		} else { 
		%>
		<a href="productsearch.jsp?pageno=1&action=<%= action %>
		&keyword=<%= keyword%><%= postcategoryId %>">首页</a>
		
		<a href="productsearch.jsp?pageno=<%= (pageno-1) %>&action=<%= action %>
		&keyword=<%= keyword%><%= postcategoryId %>">上一页</a>
		
		<a href="productsearch.jsp?pageno=<%= (pageno+1) %>&action=<%= action %>
		&keyword=<%= keyword%><%= postcategoryId %>">下一页</a>
		
		<a href="productsearch.jsp?pageno=<%= totalpage %>&action=<%= action %>
		&keyword=<%= keyword%><%= postcategoryId %>">最后一页</a>
		<% } %>
	</center>
<%		
		  
		}  else{if(action != null && action.equals("add")){
			
%>
搜索结果为空！
<% }
		}
	
		//response.sendRedirect("Productlist.jsp");
%>



<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<!-- 这个很复杂 因为是人为输入 当用户不输入任何东西时 肯定进行处理  最简单的就是在网址后面跟上变量值
		再根据变量的值 进行改变  
	 -->
<script type="text/javascript">
	function checkdata(){
		with(document.forms["form2"]){
			if(snormalPrice.value == null || snormalPrice.value==""){
				snormalPrice.value = -1;
			}
			if(enormalPrice.value == null || enormalPrice.value==""){
				enormalPrice.value = -1;
			}
			if(smemberPrice.value == null || smemberPrice.value==""){
				smemberPrice.value = -1;
			}
			if(ememberPrice.value == null || ememberPrice.value==""){
				ememberPrice.value = -1;
			}
		}
	
	}
	
</script>
</head>
<body>
	
	
	<center>简单搜索</center>
	<form name= "form1" action="productsearch.jsp" method="post" >
		<input type="hidden" name="action" value="add">
		<input type="hidden" name="snormalPrice" value="-1">
		<input type="hidden" name="enormalPrice" value="-1">
		<input type="hidden" name="smemberPrice" value="-1">
		<input type="hidden" name="ememberPrice" value="-1">
		
		<table>
			<tr>
				<td>类别<select name="categoryId">
					<option value=0>全部分类</option>
					<%
						for(Iterator<Category> i = l.iterator(); i.hasNext();){
							Category ca = i.next();
							String pre = "";
							for(int j = 1;j< ca.getGrade();j++){
								pre += "--";
							}
					%>
					<option value=<%= ca.getId() %>><%= pre+ca.getName() %></option>
					<%
						}
					%>
					</select>
				</td>
			</tr>
			<tr>
				<td>关键字</td>
				<td><input type="text" name="keyword"></td>
			</tr>
			<tr><td><input type = "submit" value="搜索" ></td></tr>
			</table>
	</form>
	
	<center>多选搜索</center>
	<form name= "form1" action="productsearch.jsp" method="post" >
		<input type="hidden" name="action" value="simple">
		<table>
			<tr>
				<td>类别</td>
					<%
						for(Iterator<Category> i = l.iterator(); i.hasNext();){
							Category ca = i.next();
							String pre = "";
							for(int j = 1;j< ca.getGrade();j++){
								pre += "---";
							}
							if(ca.isLeaf()){
					%>
					
								<tr><td> <%=  pre %><input type="checkbox" name="categoryId" value=<%= ca.getId() %>><%=ca.getName() %></input></td><tr>
					<%
							} else {
					%>			
								<tr><td><%=ca.getName() %></td><tr>
					<%		}
						}
					%>
				
			</tr>
			<tr>
				<td>关键字</td>
				<td><input type="text" name="keyword"></td>
			</tr>
			<tr><td><input type = "submit" value="搜索" ></td></tr>
			</table>
	</form>
	
	<center>高级搜索</center>
	<form name= "form2" action="productsearch.jsp" method="post" onSubmit=checkdata()>
		<input type="hidden" name="action" value="complex">
		
		<table>
			<tr>
				<td>类别<select name="categoryId">
					<option value=0>全部分类</option>
					<%
						for(Iterator<Category> i = l.iterator(); i.hasNext();){
							Category ca = i.next();
							String pre = "";
							for(int j = 1;j< ca.getGrade();j++){
								pre += "--";
							}
					%>
					<option value=<%= ca.getId() %>><%= pre+ca.getName() %></option>
					<%
						}
					%>
					</select>
				</td>
			</tr>
			<tr>
				<td>关键字</td>
				<td><input type="text" name="keyword"></td>
			</tr>
			<tr>
				<td>普通价格</td>
				<td>从<input type="text" name="snormalPrice">到<input type="text" name="enormalPrice"></td>
			</tr>
			<tr>
				<td>会员价</td>
				<td>从<input type="text" name="smemberPrice">到<input type="text" name="ememberPrice"></td>
			</tr>
			<tr>
				<td>上架时间</td>
				
				<td>从<input type="text" name="spdate">到<input type="text" name="epdate"></td>
				<td>(格式暂时要为 yyyy-mm-dd hh:mm:ss 有待改进)</td>
			</tr>
			<tr><td><input type = "submit" value="搜索" ></td></tr>
		</table>
	</form>
</body>
</html>
<% postcategoryId = "";%>