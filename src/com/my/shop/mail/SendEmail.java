package com.my.shop.mail;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import com.my.shop.User;
import com.sun.xml.internal.messaging.saaj.packaging.mime.MessagingException;

public class SendEmail extends Thread{

		private  String host = "localhost";
		private  String email = "tttt123@163.com";
		private  String username = "tttt123";
		private  String password = "qwe123";
		private User user;
		public SendEmail(User user) {
			super();
			this.user = user;
		}
		@Override
		public void run() {
			try{
				Thread.sleep(1000*3);
				send(user);
			}catch (Exception e) {
				throw new RuntimeException(e);
			}
		}

		public void send(User user) throws Exception {
			Properties prop = new Properties();
			prop.setProperty("mail.host", host);
			prop.setProperty("mail.transport.protocol", "smtp");
			Session session = Session.getInstance(prop);
			Message message = createmessage(session, user);
			Transport ts = session.getTransport();
			ts.connect(username, password);
			ts.sendMessage(message, message.getAllRecipients());
			ts.close();
		}
		
		public Message createmessage(Session session,User user){
			
			MimeMessage message = new MimeMessage(session);
			try {
				message.setFrom(new InternetAddress(email));
				message.setRecipient(Message.RecipientType.TO, new InternetAddress(user.getEmail()));
				message.setSubject("我买网站用户注册邮件");
				
				String content = "恭喜您，注册成功，用户已激活，感谢你在我网站购买东西，谢谢！";
				message.setContent(content, "text/html;charset=UTF-8");
				message.saveChanges();
			} catch (AddressException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (javax.mail.MessagingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return message;
		}

		
		

}
