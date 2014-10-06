package com.my.shop.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 
import org.apache.commons.fileupload.*;
import java.util.*;
import java.util.regex.*;
import java.io.*;
import org.apache.commons.fileupload.servlet.*;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;

public class FileUpload extends HttpServlet { 
	//BLOB

	private ServletConfig config = null;
	public void init(ServletConfig config) throws ServletException {
		this.config = config;
	}

	private File tempPath = new File("D:\\upload"); 
	// 用于存放临时文件的目录
	


	public void destroy() {
		config = null;
		super.destroy();
	}

	
	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		int id = -1;
		//String uploadPath ="F:\\werwer\\Shopping0.1\\WebContent\\images\\product\\";
		//新方法 学到 直接在xml配置文件中initparam  到时随时可以更改  config拿到配置的参数
		String uploadPath = config.getInitParameter("uploadPath"); // 用于存放上传文件的目录
		System.out.println(uploadPath);
		tempPath.mkdirs();
		res.setContentType("text/html; charset=utf-8");
		PrintWriter out = res.getWriter();
		System.out.println(req.getContentLength());
		System.out.println(req.getContentType());
		DiskFileItemFactory factory = new DiskFileItemFactory();
		// maximum size that will be stored in memory
		factory.setSizeThreshold(4096);
		// the location for saving data that is larger than getSizeThreshold()
		factory.setRepository(tempPath);

		ServletFileUpload upload = new ServletFileUpload(factory);
		// maximum size before a FileUploadException will be thrown
		upload.setSizeMax(10000000);
		try {
			List fileItems = upload.parseRequest(req);
			// assume we know there are two files. The first file is a small
			// text file, the second is unknown and is written to a file on
			// the server
			Iterator iter = fileItems.iterator();

			// 正则匹配，过滤路径取文件名
			String regExp = ".+\\\\(.+)$";

			// 过滤掉的文件类型
			String[] errorType = { ".exe", ".com", ".cgi", ".jsp" };
			Pattern p = Pattern.compile(regExp);
			while (iter.hasNext()) {
				FileItem item = (FileItem) iter.next();
				if(item.isFormField()) {
					if(item.getFieldName().equals("id")) {
						id = Integer.parseInt(item.getString());
					}
				}
//			    Determines whether or not a FileItem instance represents a simple form field.
//
//			    Specified by:
//			        isFormField in interface FileItem
//
//			    Returns:
//			        true if the instance represents a simple form field; false if it represents an uploaded file.
				// 忽略其他不是文件域的所有表单信息  因为如果是文件的话 会返回false 现在要的就是文件
				if (!item.isFormField()) {
					String name = item.getName();
					long size = item.getSize();
					if ((name == null || name.equals("")) && size == 0)
						continue;
					Matcher m = p.matcher(name);
					boolean result = m.find();
					if (result) {
						for (int temp = 0; temp < errorType.length; temp++) {
							if (m.group(1).endsWith(errorType[temp])) {
								throw new IOException(name + ": wrong type");
							}
						}
						try {

							// 保存上传的文件到指定的目录

							// 在下文中上传文件至数据库时，将对这里改写
							item.write(new File(uploadPath + id + ".jpg"));

							out.print(name + "&nbsp;&nbsp;" + size + "<br>");
						} catch (Exception e) {
							out.println(e);
						}

					} else {
						throw new IOException("fail to upload");
					}
				}
			}
		} catch (IOException e) {
			out.println(e);
		} catch (FileUploadException e) {
			out.println(e);
		}

	}

	

}
