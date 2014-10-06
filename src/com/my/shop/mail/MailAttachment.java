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

/**
 * 		@author admin  subject  主题
 *  问题还在  datahandler究竟是怎么识别文件类型 个人感觉  通过拿到文件名   再改一下就行了
 *		附件的话还是和 正文当中插入原图一样 只不过关系改了  由related 变成mixed 混杂  就是平行关系
 *\n 换行,将当前位置移到下一行开头  \r 回车,将当前位置移到本行开头
 */
public class MailAttachment{
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
			MimeBodyPart text = new MimeBodyPart();
			text.setContent("asdfasdf<br/>", "text/html");
			
			//图片
			MimeBodyPart image = new MimeBodyPart();
			DataHandler dh = new DataHandler(new FileDataSource("mailimage/Home.mp3"));
			image.setDataHandler(dh);
			image.setFileName(dh.getName());
			image.setContentID("look.jpg");
			
			MimeMultipart mt = new MimeMultipart();
			mt.addBodyPart(text);
			mt.addBodyPart(image);
			mt.setSubType("mixed");
			
			message.setContent(mt);
			message.saveChanges();
			//果然  根本只是写了个邮件  并没有发送 一查 果然有一个send、方法  不过用到transport
			//没想到jmail那么强大   
			Transport.send(message);
			try {
				message.writeTo(new FileOutputStream("D:\\3.eml"));
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
