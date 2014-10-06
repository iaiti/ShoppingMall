package com.my.shop.tag;

import java.io.IOException;
import java.util.*;

import com.my.shop.*;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.SimpleTagSupport;

public class TestTag extends SimpleTagSupport {
	@Override
	public void doTag() throws JspException, IOException {
		//拿到上下文，拿到输出流 ，输出 简单明了
		this.getJspContext().getOut().write("HelloWorld!");
		List<Product> l = ProductManager.getInstance().getProducts();
		this.getJspContext().getOut().write("<table>");
		for(Iterator<Product> it = l.iterator();it.hasNext();){
			Product p  = it.next();
			this.getJspContext().getOut().write("<tr><td>"+p.getName()+"</td></tr>");
		}
		this.getJspContext().getOut().write("</table>");
	}
}
