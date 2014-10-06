<%@ page language="java" contentType="text/html
; charset=UTF-8"
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
	
	//--------1.单纯写jsp的 ----------- 
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
	
	
	//--------2.用xml-----------

	/*if(children != null ) {
		for(int i = 0;i<children.size();i++){
			c = children.get(i);
			bf.append("<category> <id>"+c.getId()+"</id> <name>"+c.getName()+"</name></category>");
		}
		bf.insert(0,"<categories>");
		bf.append("</categories>");
		//System.out.println(bf);
	}
	if(bf.length() == 0 ){
		bf.insert(0,"<categories>");
		bf.append("</categories>");
		//System.out.println(bf.length());
	}
	*/
	
	//--------3.将js处理的代码直接传到xml中来  再传回客户端-----------
		//insert 是在一定的位置插入，而append只是添加而已
		if(children != null ){
			for (Iterator<Category> it = children.iterator();it.hasNext();){
				c = it.next();
					bf.append("document.searchform.detailclass.options["+count+"].text = '"+c.getName()+"';\n");
					bf.append("document.searchform.detailclass.options["+count+"].value = '"+c.getId()+"';\n");
					count++;
				
			}
			bf.insert(0,"document.searchform.detailclass.options[0].value = '0';\n");
			bf.insert(0,"document.searchform.detailclass.options[0].text = '分类';\n");
			bf.insert(0,"document.searchform.detailclass.selectedIndex = 0;\n");
			bf.insert(0,"document.searchform.detailclass.length ="+count+";\n");
		}
			//System.out.println(bf.length());
		if(bf.length() == 0 ){
			bf.insert(0,"document.searchform.detailclass.length ='1';\n");
			bf.insert(0,"document.searchform.detailclass.options[0].value = '0';\n");
			bf.insert(0,"document.searchform.detailclass.options[0].text = '分类';\n");
			//System.out.println(bf.length());
		}
			//selectedIndex] + value 不行   index不用加value  所以错了
			//直接不用options也不行 因为数组的关系 所以才会那样
//	response.getWriter().write("<message>"+bf.toString()+"</message>");

	
	
	response.getWriter().write(bf.toString());
	response.setContentType("text/html");
	//xml 和 html 明显很大的不同  xml很特别嘞
	response.setHeader("Cache-Control","no-store");
	response.setHeader("Pragma","no-cache");
	response.setDateHeader("Expires",0);
%>
