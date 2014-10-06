package com.my.shop.mail;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Properties;

import javax.activation.DataHandler;
import javax.activation.FileDataSource;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

public class SimpleMailUseJmail {
	public static void main(String args[]){
	try {
		//创建 邮件 都是api的东西
			Session session = Session.getDefaultInstance(new Properties());
			MimeMessage message = new MimeMessage(session);
			
			message.setFrom(new InternetAddress("tttt123@163.com"));
			// recipient 接受者 
			message.setRecipient(Message.RecipientType.TO,new InternetAddress("aaa@163.com"));
			message.setSubject("test");
			
			//创建正文
			message.setContent("asdfasdf<br/><img src='cid:look.jpg'></img>", "text/html");
			
		
			
			
			message.saveChanges();
			//果然  根本只是写了个邮件  并没有发送 一查 果然有一个send、方法  不过用到transport
			//没想到jmail那么强大   
			Transport.send(message);
			try {
				message.writeTo(new FileOutputStream("D:\\2.eml"));
			} catch (FileNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		} catch (AddressException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (MessagingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
