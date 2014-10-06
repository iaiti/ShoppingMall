<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,java.util.*,com.my.shop.*" %>
<%
	
	int first = Integer.parseInt(request.getParameter("first"));
	String s = "";
	List<Category> lc = Category.getCList();
	List<Category> children = null;
	StringBuffer bf = new StringBuffer();
	int count = 1;
	Category c = null;
	//insert 是在一定的位置插入，而append只是添加而已
	if(Category.getChildrenList(Category.getById(first)).size()!=0){
		 children = Category.getChildrenList(Category.getById(first));
	}
	//有些主类下面没有子类的  进行判断  我这里不会像视频的一样有一大堆东西
	//bf空的时候根本就拿不到东西  直接给他付个特殊值罢了
	
	//单纯写jsp的  
	//if(children != null ) {
		//for(int i = 0;i<children.size();i++){
		//	c = children.get(i);
		//	bf.append(c.getId()+","+c.getName()+";");
		//}
	//}
	//if(bf.length() == 0 ){
		//bf.append("isnull");
		//System.out.println(bf.length());
	//}
	
	//if(children != null)   bf.deleteCharAt(bf.length()-1);
	//*/
	
	
	//--------用xml-----------
	if(children != null ) {
		for(int i = 0;i<children.size();i++){
			c = children.get(i);
			bf.append("<category> <id>"+c.getId()+"</id> <name>"+c.getName()+"</name></category>");
		}
		bf.insert(0,"<categories>");
		bf.append("</categories>");
		System.out.println(bf);
	}
	if(bf.length() == 0 ){
		bf.append("isnull");
		System.out.println(bf.length());
	}
	response.getWriter().write("<message>"+bf.toString()+"</message>");
	
	
	response.setContentType("text/xml");
	response.setHeader("Cache-Control","no-store");
	response.setHeader("Pragma","no-cache");
	response.setDateHeader("Expires",0);
%>
