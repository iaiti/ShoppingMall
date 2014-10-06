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

<%
// 程序的不足之处 日期怎么可能手工大的  肯定按一下日期会有一个阅历跑出来然你选择
	request.setCharacterEncoding("utf-8");
	action = request.getParameter("action");
	strpageno = request.getParameter("pageno");
		//当用户 不输入任何东西时 将所有的变量设成 特殊值 因为getproductlist方法里面需要传参
		 keyword = request.getParameter("keyword");
		//还有这个方法 怪不得我想不到  拿到字符串数组
		 categoryarray = request.getParameterValues("categoryId");
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
		%>
	</table>
	<center>
	<!-- 接下来是 跳转页面的问题  因为跳转后 程序s头还有getparameter的东西 如果不在后面跟上参数 拿不到 空指针错误
		最复杂的东西 莫过这样 要一条一条的跟debug 不过 很有用  至少比他不报错的强
	 -->
		共 <%= totalpage %> 页
		第 <%= pageno %> 页<p/>
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
	</center>
<%		
		}  else{
			
%>
搜索结果为空！
<% 
		}
	
		//response.sendRedirect("Productlist.jsp");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>