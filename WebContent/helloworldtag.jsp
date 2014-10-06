<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/hello" prefix="mytag" %>
<!-- uri use uri to get the same uri of tld   file whose uri it is,and find the same short name,
	a tag has many tag name
-->

<!--e e e @里面的东西不用标点符号  加了一个逗号导致整个类无法加载  这个配置真麻烦 shortname什么的 -->
 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<!--  get shortname and tag name -->
<mytag:helloworld></mytag:helloworld>
</body>
</html>