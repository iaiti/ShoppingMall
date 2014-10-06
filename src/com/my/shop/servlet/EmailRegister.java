package com.my.shop.servlet;

import java.io.IOException;
import java.sql.Timestamp;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.my.shop.User;
import com.my.shop.mail.SendEmail;

/**
 * Servlet implementation class for Servlet: EmailRegister
 *
 */
 public class EmailRegister extends javax.servlet.http.HttpServlet implements javax.servlet.Servlet {
   static final long serialVersionUID = 1L;
   
   
	public EmailRegister() {
		super();
	}   	
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String action = request.getParameter("action");
		//System.out.println(action);
		if(action != null && action.equals("register")) {
			String username = request.getParameter("username");
			String email = request.getParameter("email");
			String password = request.getParameter("pwd");
			String phone = request.getParameter("phone");
			String addr = request.getParameter("addr");
			//System.out.println(addr);
			User u = new User();
			u.setName(username);
			u.setPw(password);
			u.setPhone(phone);
			u.setAddr(addr);
			u.setEmail(email);
			//System.out.println(u.getEmail());
			u.setRdate(new Timestamp(System.currentTimeMillis()));
			u.savesql();
			try{
				//向数据库注册用户
				/*SendMail send = new SendMail(user);
				send.start();*/
				Thread t = new Thread(new SendEmail(u));
				t.start();
				request.setAttribute("message", "注册成功！！我们已给您发了一封电子邮件，请及时查收！");
			}catch (Exception e) {
				e.printStackTrace();
				request.setAttribute("message", "注册失败！！");
			}
			//response.sendRedirect("registersuccess.jsp");
			request.getRequestDispatcher("/registersuccess.jsp").forward(request, response);
		}
	}  	
	
	/* (non-Java-doc)
	 * @see javax.servlet.http.HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request,response);
	}   	  	    
}