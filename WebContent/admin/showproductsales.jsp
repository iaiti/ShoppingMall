<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<!--  由于用了forward的关系  跳转的不是showproductsales。jsp所在目录的images  而是servlet所在的images

	你奈何? 所以直接使用contextpath 拿到整个东西的跟路径 即我所写项目的shopping0.1
 -->
 <center>
	<img src="<%= request.getContextPath() %>/images/productsales/sales.jpg">
 </center>

</body>
</html>