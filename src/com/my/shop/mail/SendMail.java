package com.my.shop.mail;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.NoSuchProviderException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;

public class SendMail {
	public static void main(String args[]){
		Properties p = new Properties();
		p.setProperty("mail.smtp.host","localhost");
		p.setProperty("mail.transport.protocol","smtp");
		p.setProperty("mail.smtp.auth","true");
		Session s = Session.getInstance(p);
		Message m = createMessage(s);
		s.setDebug(true);
		//可以将整个的流程打印出来！
		try {
			Transport t = s.getTransport();
			t.connect("aaa", "qwe123");
			t.sendMessage(m, m.getAllRecipients());
			t.close();
		} catch (NoSuchProviderException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (MessagingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	
		
	}

	private static Message createMessage(Session s) {
		// TODO Auto-generated method stub
		MimeMessage mm = new MimeMessage(s);
		try {
			mm.setRecipient(Message.RecipientType.TO,new InternetAddress("aaa@163.com"));
			mm.setSubject("test");
			//主题   
			
			//创建正文
			mm.setContent("asdfasdf", "text/html;charset=utf-8");
			mm.setFrom(new InternetAddress("tttt123@163.com"));
			mm.saveChanges();
		} catch (AddressException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (MessagingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		// recipient 接受者 
		
		return mm;
	}
}
