package com.my.shop.mail;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.Socket;
import java.net.UnknownHostException;

/** 调了很久 最后发现 nsubject:test\r\n\r\n 需要换行  不知道是什么东西   两次换  谁知道？  但是现在可以发邮件了
 * @author admin
 *	单纯的邮件发送  不用jmail 用最原始的方法
 */
public class SimpleMail {
	public static void main(String args[]){
		try {
			Socket socket = new Socket("localhost",25);
			BufferedReader bf = new BufferedReader(new InputStreamReader(socket.getInputStream()));
			OutputStream os = socket.getOutputStream();
			
			System.out.println(bf.readLine());
			os.write("ehlo\r\n".getBytes());
			
			System.out.println(bf.readLine());
			System.out.println(bf.readLine());
			
			//os.write("auth login\r\n".getBytes());
			//System.out.println(bf.readLine());
			//os.write("cG9zdG1hc3Rlcg==\r\n".getBytes());
			//System.out.println(bf.readLine());
			//os.write("cXdlMTIz\r\n".getBytes());
			//System.out.println(bf.readLine());
			
			os.write("mail from: <tttt123@163.com>\r\n".getBytes());
			System.out.println(bf.readLine());
			
			os.write("rcpt to: <aaa@163.com>\r\n".getBytes());
			System.out.println(bf.readLine());
			
			os.write("data\r\n".getBytes());
			System.out.println(bf.readLine());
			
			os.write("from:<tttt123@163.com>\r\nto:<aaa@163.com>\r\nsubject:test\r\n\r\n咱们分手吧!\r\n".getBytes());
			os.write(".\r\n".getBytes());
			System.out.println(bf.readLine());
			os.write("quit\r\n".getBytes());
			System.out.println(bf.readLine());

			
			os.close();
			bf.close();
			socket.close();
			
			
		} catch (UnknownHostException e) {
			// TODO Auto-generated catch blockXc
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
}
