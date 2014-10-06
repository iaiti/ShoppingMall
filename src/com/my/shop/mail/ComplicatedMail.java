package com.my.shop.mail;


import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
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
import javax.mail.internet.MimeUtility;

/**
 * 这里的session 叫做邮件的规划？ 其实是整个jmail运行的环境信息 和client和server之间的连接会话信息
 * 		@author admin  subject  主题
 *		老师那普通话 邮件发送夹带照片 
 *\n 换行,将当前位置移到下一行开头  \r 回车,将当前位置移到本行开头
 *mime协议 的主要东西  和html差不多  content-type
 *content-disposition      content-id
 *
 *
 *
 */
public class ComplicatedMail {
	public static void main(String args[]){
		try {
		//创建 邮件 都是api的东西
			Session session = Session.getDefaultInstance(new Properties());
			MimeMessage message = new MimeMessage(session);
			message.setFrom(new InternetAddress("tttt123@163.com"));
			// recipient 接受者 
			message.setRecipient(Message.RecipientType.TO,new InternetAddress("aaa@163.com"));
			message.setSubject("test");
			//主题   
			
			//创建正文
			MimeBodyPart text = new MimeBodyPart();
			// 其实没他说 真不知道 写了那么久的 text/html 今天才知道这是mime的东西
			//乱码问题解决   setcontent中指定charset
			text.setContent("asdfasdf<br/><img src='cid:look.jpg'></img>", "text/html;charset=utf-8");
			
			//图片
			MimeBodyPart image = new MimeBodyPart();
			DataHandler dh = new DataHandler(new FileDataSource("mailimage/look.jpg"));
			image.setDataHandler(dh);
			image.setContentID("look.jpg");
			//附件
			MimeBodyPart att = new MimeBodyPart();
			DataHandler atdh = new DataHandler(new FileDataSource("mailimage/Home.mp3"));
			try {
				//中文文件名获取没有错  传送中有乱码  
				//Decode "unstructured" headers, that is, headers that are defined as '*text' as per RFC 822.
				//设计的真好  
				
				//setfilename 已经为 文件 设置了contenttype
				att.setFileName(MimeUtility.encodeText(atdh.getName()));
			} catch (UnsupportedEncodingException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			//怪不得 要把它的名字改为这样  之前大小是在的  但是名字没有在c
			att.setDataHandler(atdh);
			//att.setContentID("1.txt");
			
			//很妙的方法  把相关的先加到multiprt中  然后再用bodypart的setcontent把它传进去 变成bodypart
			//接着又可以和另外一个bodypart 组成mimemultiplypart
			MimeMultipart mt1  = new MimeMultipart();
			mt1.addBodyPart(text);
			mt1.addBodyPart(image);
			mt1.setSubType("related");
			MimeBodyPart textandimage = new MimeBodyPart();
			textandimage.setContent(mt1);
			
			MimeMultipart mt = new MimeMultipart();
			mt.addBodyPart(textandimage);
			mt.addBodyPart(att);
			mt.setSubType("mixed");
			
			message.setContent(mt);
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
