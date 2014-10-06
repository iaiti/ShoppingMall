<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.sql.*,java.util.*,com.my.shop.*,com.my.shop.DAO.*" %>
<%
	List<Product> l  = new ArrayList<Product>();
	l = ProductManager.getInstance().lastproduct(10);
%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<a ><font size=6>最新上架</font></a>
	<DIV class=huobao_box>
		
		<% 
			for(Iterator<Product> it = l.iterator(); it.hasNext();){ 
				 Product p = it.next();
				
		%>
							<DIV class=goods>
							<DIV class=img>
								<P>
									<A title=<%=p.getName() %> href="http://www.shihui.cn/goods-2432.html"
										target=_blank><IMG border=0 alt=<%=p.getName() %>
											src="images/product/<%= p.getId() %>.jpg">
									</A>
								</P>
							</DIV>
							<DIV class=text>
								<P>
									<A title=<%=p.getName() %> href="http://www.shihui.cn/goods-2432.html"
										target=_blank><%=p.getName() %></A>
								</P>
								<P style="COLOR: #ff0000; FONT-WEIGHT: bold">
									价格：<%=p.getNormalPrice() %>
								</P>
								<P>
									<A title=查看商品详情 href="productdetail.jsp?id=<%= p.getId() %>"
										><IMG border=0 src="images/hot_gO1.gif">
									</A>
								</P>
							</DIV>
						</DIV>
						
					<% } %>	
						
						
						
	
						<DIV class=goods>
							<DIV class=img>
								<P>
									<A title=家有儿女纽飞轮雷达笔 href="http://www.shihui.cn/goods-2432.html"
										target=_blank><IMG border=0 alt=家有儿女纽飞轮雷达笔
											src="images/1301271287820935171.jpg">
									</A>
								</P>
								<P class=c>
									人气指数：16901
								</P>
							</DIV>
							<DIV class=text>
								<P>
									<A title=家有儿女纽飞轮雷达笔 href="http://www.shihui.cn/goods-2432.html"
										target=_blank>家有儿女纽飞轮雷达笔</A>
								</P>
								<P>
									<FONT color=#fe0000>自主预防、强制纠错</FONT>
								</P>
								<P style="COLOR: #ff0000; FONT-WEIGHT: bold">
									￥288元
								</P>
								<P>
									<A title=查看商品详情 href="http://www.shihui.cn/goods-2432.html"
										target=_blank><IMG border=0 src="images/hot_gO1.gif">
									</A>
								</P>
							</DIV>
						</DIV>
						<DIV class=goods>
							<DIV class=img>
								<P>
									<A title=GPS个人定位器G100
										href="http://www.shihui.cn/goods-2447.html" target=_blank><IMG
											border=0 alt=GPS个人定位器G100
											src="images/1301593819187223948.jpg">
									</A>
								</P>
								<P class=c>
									人气指数：10588
								</P>
							</DIV>
							<DIV class=text>
								<P>
									<A title=GPS个人定位器G100
										href="http://www.shihui.cn/goods-2447.html" target=_blank>GPS个人定位器G100</A>
								</P>
								<P>
									<FONT color=#fe0000>野外旅行探险最佳协助伴侣</FONT>
								</P>
								<P style="COLOR: #ff0000; FONT-WEIGHT: bold">
									￥368元
								</P>
								<P>
									<A title=查看商品详情 href="http://www.shihui.cn/goods-2447.html"
										target=_blank><IMG border=0 src="images/hot_gO1.gif">
									</A>
								</P>
							</DIV>
						</DIV>
						<DIV style="BORDER-RIGHT-STYLE: none" class=goods>
							<DIV class=img>
								<P>
									<A title="超薄触摸屏MID平板电脑10寸 带GPS功能"
										href="http://www.shihui.cn/goods-2468.html" target=_blank><IMG
											border=0 alt="超薄触摸屏MID平板电脑10寸 带GPS功能"
											src="images/1302722505909240013.jpg">
									</A>
								</P>
								<P class=c>
									人气指数：11529
								</P>
							</DIV>
							<DIV class=text>
								<P>
									<A title="超薄触摸屏MID平板电脑10寸 带GPS功能"
										href="http://www.shihui.cn/goods-2468.html" target=_blank>超薄触摸屏MID平板电脑</A>
								</P>
								<P>
									<FONT color=#fe0000>支持WIFI 无线上网</FONT>
								</P>
								<P style="COLOR: #ff0000; FONT-WEIGHT: bold">
									￥1580元
								</P>
								<P>
									<A title=查看商品详情 href="http://www.shihui.cn/goods-2468.html"
										target=_blank><IMG border=0 src="images/hot_gO1.gif">
									</A>
								</P>
							</DIV>
						</DIV>
						<DIV class=goods>
							<DIV class=img>
								<P>
									<A title=高清3D水晶版电视棒 href="http://www.shihui.cn/goods-2464.html"
										target=_blank><IMG border=0 alt=高清3D水晶版电视棒
											src="images/1302658591260844194.jpg">
									</A>
								</P>
								<P class=c>
									人气指数：12019
								</P>
							</DIV>
							<DIV class=text>
								<P>
									<A title=高清3D水晶版电视棒 href="http://www.shihui.cn/goods-2464.html"
										target=_blank>高清3D水晶版TV棒</A>
								</P>
								<P>
									<FONT color=#fe0000>免费看电视 3D高清电影</FONT>
								</P>
								<P style="COLOR: #ff0000; FONT-WEIGHT: bold">
									￥188元
								</P>
								<P>
									<A title=查看商品详情 href="http://www.shihui.cn/goods-2464.html"
										target=_blank><IMG border=0 src="images/hot_gO1.gif">
									</A>
								</P>
							</DIV>
						</DIV>
						<DIV class=goods>
							<DIV class=img>
								<P>
									<A title="多功能U盘录像手表TH-B14 隐蔽摄像 高清图片　内置4G卡"
										href="http://www.shihui.cn/goods-2105.html" target=_blank><IMG
											border=0 alt="多功能U盘录像手表TH-B14 隐蔽摄像 高清图片　内置4G卡"
											src="images/1294697302530173656.jpg">
									</A>
								</P>
								<P class=c>
									人气指数：11955
								</P>
							</DIV>
							<DIV class=text>
								<P>
									<A title="多功能U盘录像手表TH-B14 隐蔽摄像 高清图片　内置4G卡"
										href="http://www.shihui.cn/goods-2105.html" target=_blank>多功能U盘录像手表</A>
								</P>
								<P>
									<FONT color=#fe0000>五一抢购优惠50元</FONT>
								</P>
								<P style="COLOR: #ff0000; FONT-WEIGHT: bold">
									￥248元
								</P>
								<P>
									<A title=查看商品详情 href="http://www.shihui.cn/goods-2105.html"
										target=_blank><IMG border=0 src="images/hot_gO1.gif">
									</A>
								</P>
							</DIV>
						</DIV>
						<DIV style="BORDER-RIGHT-STYLE: none" class=goods>
							<DIV class=img>
								<P>
									<A title="最新款GPS导航行车记录仪 导航+摄像"
										href="http://www.shihui.cn/goods-2469.html" target=_blank><IMG
											border=0 alt="最新款GPS导航行车记录仪 导航+摄像"
											src="images/1302718848512082109.jpg">
									</A>
								</P>
								<P class=c>
									人气指数：10424
								</P>
							</DIV>
							<DIV class=text>
								<P>
									<A title="最新款GPS导航行车记录仪 导航+摄像"
										href="http://www.shihui.cn/goods-2469.html" target=_blank>新款GPS导航行车记录仪</A>
								</P>
								<P>
									<FONT color=#fe0000>汽车黑匣子</FONT>
								</P>
								<P style="COLOR: #ff0000; FONT-WEIGHT: bold">
									￥1380元
								</P>
								<P>
									<A title=查看商品详情 href="http://www.shihui.cn/goods-2469.html"
										target=_blank><IMG border=0 src="images/hot_gO1.gif">
									</A>
								</P>
							</DIV>
						</DIV>
					</DIV>
</body>
</html>