<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,java.util.*,com.my.shop.*,com.my.shop.DAO.*" %>
<jsp:useBean id="cart" class="com.my.shop.Cart" scope="session"></jsp:useBean>
<%
	String s = "";
	List<CartItem> li  = new ArrayList<CartItem>();
	User u = (User)session.getAttribute("u");
	li = cart.getItems();
	//注释部分为 为使用ajax时 的方法和未封装好 从category中拿到父类链表的方法    
	//List<Category> lc = Category.getCList();
	List<Category> first = Category.getParentList();
	//for (Iterator<Category> it = lc.iterator();it.hasNext();){
	//	Category c = it.next();
	//	if(c.getPid()==0){
	//		first.add(c);
	//System.out.println(secondCategory(lc,c));
	//调试结果  没有加上全部的字符串
	//s +=secondCategory(lc,c);
	//	}
	//}
	
%>
<!--  同理  这个也是非ajax 要写的方法 复杂  没办法  要在同一个页面
	private String secondCategory(List<Category> l,Category first){
		StringBuffer bf = new StringBuffer();
		int count = 1;
		//insert 是在一定的位置插入，而append只是添加而已
		Category c = null;
		for (Iterator<Category> it = l.iterator();it.hasNext();){
			c = it.next();
			if(c.getPid()== first.getId()){
				bf.append("document.searchform.detailclass.options["+count+"].text = '"+c.getName()+"';\n");
				bf.append("document.searchform.detailclass.options["+count+"].value = '"+c.getId()+"';\n");
				count++;
			}
			
		}
			bf.insert(0,"document.searchform.detailclass.options[0].value = '0';\n");
			bf.insert(0,"document.searchform.detailclass.options[0].text = '分类';\n");
			bf.insert(0,"document.searchform.detailclass.selectedIndex = 0;\n");
			bf.insert(0,"document.searchform.detailclass.length ="+count+";\n");
			//selectedIndex] + value 不行   index不用加value  所以错了
			//直接不用options也不行 因为数组的关系 所以才会那样
			bf.insert(0,"if(document.searchform.mainclass.options[document.searchform.mainclass.selectedIndex].value =="+first.getId()+"){\n");
			bf.append("}\n");
		return bf.toString();
	}
-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">
<HTML xmlns="http://www.w3.org/1999/xhtml">
	<HEAD>
		<META content="IE=7.0000" http-equiv="X-UA-Compatible">
		<TITLE>实惠商城</TITLE>
		<META content="text/html; charset=utf-8" http-equiv=Content-Type>
		<META name=Keywords
			content=实惠商城，网络购物,手机,数码DV,车载GPS,导航仪,数码相机,增高鞋,凡布鞋,美容护肤,倒车后视,,祛痘,丰胸,减肥,护扶>
		<META name=Description
			content=实惠商城-专业的综合类网上购物商城,产品包括鞋类,美容护肤,gps,数码相机,手机,数码DV等数万种商品直销,实惠的产品,便捷,诚信的服务,为您提供愉悦的网上购物体验!>
		<LINK rel=stylesheet type=text/css href="images/global.css">
		<LINK rel=stylesheet type=text/css href="images/index.css">
		<SCRIPT type=text/javascript src="images/j.js"></SCRIPT>

		<SCRIPT type=text/javascript src="images/shihui.js"></SCRIPT>

		<SCRIPT type=text/javascript src="images/change.js"></SCRIPT>

		<SCRIPT type=text/javascript src="images/msclass.js"></SCRIPT>

		<META name=GENERATOR content="MSHTML 8.00.7600.16766">
	    <style type="text/css">
<!--
.STYLE1 {color: #000000}
-->
        </style>
</HEAD>
	<BODY>
		<A name=top></A>
		<DIV id=white>
			<DIV id=header>
			<DIV id=logo>
					<img src="images/zhuye.jpg" style="MARGIN-TOP: -20px" height=100
						align=left width=190>
				</DIV>
				<DIV id=menubox>
				  <DIV class=topmenu>
                      <div>
                        <form action="admin/userlogin.jsp" method="post">
                          <input name="image" type="image" src="images/gif-0766.gif">&nbsp&nbsp&nbsp&nbsp&nbsp
                          <input name="image2" type="image" src="images/gif-0785.gif">&nbsp&nbsp&nbsp&nbsp&nbsp
                          <a href="quit.jsp">退出</a>
                        </form>
                      </div>
					 <div>
                        <form action="register.jsp" method="post">
                        </form><br>
                        <INPUT type="text" value="输入宝贝名称">
                        <INPUT  type="submit" value="搜全站">
		            </div>
				  </DIV>
					<DIV class=mainmenu>
						<A title=首页 href="http://www.shihui.cn/"><SPAN
							class=mainmenu_cur>首页</SPAN>
						</A>
						<A title=手机通讯 href="http://www.shihui.cn/channel-13.html">手机通讯</A>
						<A title=新酷数码 href="http://www.shihui.cn/channel-8.html">新酷数码</A>
						<A title=美容美体 href="http://www.shihui.cn/channel-6.html">美容美体</A>
						<A title=鞋帽箱包 href="http://www.shihui.cn/channel-7.html">鞋帽箱包</A>
						<A title=生活电器 href="http://www.shihui.cn/channel-10.html"><FONT
							style="FONT-WEIGHT: normal">生活电器</FONT>
						</A>
					</DIV>
				</DIV>
				<DIV id=numberbox>
				<DIV id=telnumber>
				</DIV>
				<%
						String login = (String)session.getAttribute("login");
						if(login != null && login.equals("true")) {
				%>
					<DIV id=cartIdbox class=top_cats>
						<DIV id=cartIdtext class=cart_text>
							您的
							<A class=reds title=查看购物车 href="cart.jsp">购物车</A>有
							<A class=reds href="cart.jsp"><SPAN
								id=CARTCOUNT><%= li.size()%></SPAN>
							</A>件宝贝
						</DIV>
						<DIV class=tocart>
							<A title=去结算 href="http://www.shihui.cn/flow.html?step=checkout"><IMG
									border=0 align=absBottom src="images/tocart.gif">
							</A>
						</DIV>
						<DIV id=minicart class=mini-cart></DIV>
					</DIV>
				</DIV>
				<%
						}
				%>
			</DIV>
		</DIV>
		<DIV id=menulist>
			<DIV class=nav_list>
				<A href="http://www.shihui.cn/new.html" class="STYLE1">新品上架</A><A
					href="http://www.shihui.cn/exchange/index.html" class="STYLE1">积分换购</A><A href="http://www.shihui.cn/hot.html">火爆推荐</A><A href="http://www.shihui.cn/best.html">精品展示</A><A
					href="http://www.shihui.cn/search.html?min_price=0&amp;max_price=100&amp;sort=goods_id&amp;order=DESC">百元热卖</A><A href="http://www.shihui.cn/themes.html">促销活动</A><A href="http://www.shihui.cn/brands.html">品牌专区</A><A href="http://bbs.shihui.cn/" target=_blank>用户社区</A>			</DIV>
		</DIV>
		<script type="text/javascript">
			var req;
			function select(){
				var first = document.searchform.mainclass.options[document.searchform.mainclass.selectedIndex];
				var url = "ajaxgetsecondcategory.jsp?first="+escape(first.value);
				//alert(url);
				 if(window.ActiveXObject) {
					req = new ActiveXObject("Microsoft.XMLHTTP");
				} else if(window.XMLHttpRequest){
					req = new XMLHttpRequest();
				}
				req.open("GET",url,true);
				req.onreadystatechange = callback;
				req.send(null);
			}
			
			function callback(){
				//alert(req.readyState);
				// 1 连上 2 loading 3 loaded 4
				if(req.readyState == 4){
				//alert(req.status)  
				//404错误  有得玩了
					if(req.status==200){
						var msg = req.responseXML.getElementsByTagName("message")[0];
						//alert(msg.childNodes[0].nodeValue);
						sendmsg(msg.childNodes[0].nodeValue);
					}
				}
			}
			
			function sendmsg(msg){
				var list = msg.split(";");
				//alert(list.length);
				//msg = msg.replace(/(^\s*)|(\s*$)/g, "");   去除大堆的未知东西 转化成空格  
				//但是我这个没有这种问题  所以  直接判断isnull'  new String 是个好办法  佩服老师！
				//alert(msg);
				if(msg == "isnull"){
					document.searchform.detailclass.length = 1;
					document.searchform.detailclass.selectedIndex = 0;
					document.searchform.detailclass.options[0].value = '0';
					document.searchform.detailclass.options[0].text = '分类';
					//或者不用else 直接用return 也行
				} else{
					document.searchform.detailclass.length = list.length+1;
					document.searchform.detailclass.selectedIndex = 0;
					document.searchform.detailclass.options[0].value = '0';
					document.searchform.detailclass.options[0].text = '分类';
					for(var i = 0;i<= list.length;i++){
						var child = list[i].split(",");
						document.searchform.detailclass.options[i+1].text = child[1];
						document.searchform.detailclass.options[i+1].value = child[0];
					}
		
				}
			}
		</script>
		
		<DIV id=search>
			<DIV class=searchform>
				<FORM id=searchform onSubmit="return checkSearchForm()" method=post
					name=searchform action=/search.html>
					<select name=mainclass onChange="select()">
						<option value=0>总类</option>
					<%	
						for (Iterator<Category> it = first.iterator();it.hasNext();){
							Category c = it.next();
					%>
						<option value=<%= c.getId() %>><%= c.getName() %></option>
					<%      
						}
					%>
						
					</select>
					<select name=detailclass >
						<option value=0>分类</option>
					</select>
					<INPUT id=keyword class=inputs type="submit" value="搜索">
					<div align="right">
					<B>热门搜索：</B>
					<A title=中兴
						href="http://www.shihui.cn/search.html?keywords=%E5%A1%91%E5%8F%AF%E5%84%BF">塑可儿</A>
					<A title=小米
						href="http://www.shihui.cn/search.html?keywords=%E7%98%A6%E8%84%B8">瘦脸</A>
					<A title=华为
						href="http://www.shihui.cn/search.html?keywords=%E5%AF%BC%E8%88%AA%E4%BB%AA">导航仪</A>
					</div>
					<DIV style="DISPLAY: none">
						<IMG border=0 src="images/cate_on_bg.gif">
						<IMG border=0 src="images/childs_bg.gif">
					</DIV>
				</FORM>
				<UL id=topHotScroll class=scroll>
					<LI>
						<A href="http://www.shihui.cn/special/83.html" target=_blank>塑可儿联手湖南卫视打造2011年瘦脸风潮</A>
					</LI>
					<LI>
						<A href="http://www.shihui.cn/special/172.html" target=_blank>时尚个性
							DIY洞洞鞋绚丽登场！</A>
					</LI>
					<LI>
						<A href="http://www.shihui.cn/special/160.html" target=_blank>全球首创植物精华烟膏，火爆热销中！</A>
					</LI>
				</UL>
			</DIV>
		</DIV>
		<SCRIPT language=javascript type=text/javascript>
			ShiHui.PageInfo.ShowMemberInfo();
			ShiHui.MiniCart.Show();
			setInterval("ShiHui.topHotScroll('#topHotScroll')", 5000);
			$(function(){
				ShiHui.MiniCart.Load();
			});
		</SCRIPT>
		<DIV id=bodys>
			<DIV class=MainLeft>
				<DIV class=category_title>
					<SPAN id=categorys class=category_bt_cur onclick=ChangCategory(0)>商品分类</SPAN>
					<SPAN id=brands class=category_bt onclick=ChangCategory(1)>品牌专区</SPAN>
					<SPAN class=nav_bt><A id=alls
						href="http://www.shihui.cn/allcate.html" target=_blank>全<BR>部</A>
					</SPAN>
				</DIV>
				<div style="HEIGHT: 610px" class=category_box>
					<div id=categorylist>
						<div
							style="PADDING-BOTTOM: 5px; TEXT-INDENT: 10px; PADDING-LEFT: 0px; PADDING-RIGHT: 0px; BACKGROUND: url(http://static.shihui.cn/images/theme/cate_54.gif) no-repeat left center; PADDING-TOP: 5px"
							class=parentCat>
							<a href="http://www.shihui.cn/channel-8.html">新酷数码&gt;&gt;&gt;</a>
						</div>
						<div class=childCat>
							<dl>
								<dt id=dt115 class=dtborder
									onMouseOver=show_child_category(this,115)>
									<span></span><a title=电脑产品
										href="http://www.shihui.cn/category-115-b0.html">电脑产品</a> -
									笔记本 鼠标/键...
								</dt>
								<dd id=dt115_dd>
									<ul>
										<li>
											<a title=笔记本 href="http://www.shihui.cn/category-210-b0.html">笔记本</a>										</li>
										<li>
											<a title=鼠标/键盘
												href="http://www.shihui.cn/category-211-b0.html">鼠标/键盘</a>										</li>
										<li>
											<a title=数据分线器
												href="http://www.shihui.cn/category-212-b0.html">数据分线器</a>										</li>
										<li>
									</ul>
									<p></p>
								</dd>
						</div>
						<div
							style="PADDING-BOTTOM: 5px; TEXT-INDENT: 10px; PADDING-LEFT: 0px; PADDING-RIGHT: 0px; BACKGROUND: url(http://static.shihui.cn/images/theme/cate_19.gif) no-repeat left center; PADDING-TOP: 5px"
							class=parentCat>
							<a href="http://www.shihui.cn/channel-7.html">鞋帽箱包&gt;&gt;&gt;</a>
						</div>
						<div class=childCat>
							<dl>
								<dt id=dt110 class=dtborder
									onMouseOver=show_child_category(this,110)>
									<span></span><a title=鞋子
										href="http://www.shihui.cn/category-110-b0.html">鞋子</a> - 紧身鞋
									登山鞋 ...
								</dt>
								<dd id=dt110_dd>
									<ul>
										<li>
											<a title=紧身鞋 href="">紧身鞋</a>										</li>
										<li>
											<a title=登山鞋 href="">登山鞋</a>										</li>
									</ul>
									<p></p>
								</dd>
						</div>
						<div
							style="PADDING-BOTTOM: 5px; TEXT-INDENT: 10px; PADDING-LEFT: 0px; PADDING-RIGHT: 0px; BACKGROUND: url(http://static.shihui.cn/images/theme/cate_55.gif) no-repeat left center; PADDING-TOP: 5px"
							class=parentCat>
							<a href="http://www.shihui.cn/channel-6.html">美容美体&gt;&gt;&gt;</a>
						</div>
						<div class=childCat>
							<dl>
								<dt id=dt250 class=dtborder
									onMouseOver=show_child_category(this,250)>
									<span></span><a title=护肤系列
										href="http://www.shihui.cn/category-250-b0.html">护肤系列</a> - 控油
									眼部护理 ...
								</dt>
								<dd id=dt250_dd>
									<ul>
										<li>
											<a title=控油 href="http://www.shihui.cn/category-259-b0.html">控油</a>										</li>
										<li>
											<a title=眼部护理 href="">眼部护理</a>										</li>
										<li>
											<a title=磨砂/去角质 href="">磨砂/去角质</a>										</li>
									</ul>
									<p></p>
								</dd>
						</div>
						<div
							style="PADDING-BOTTOM: 5px; TEXT-INDENT: 10px; PADDING-LEFT: 0px; PADDING-RIGHT: 0px; BACKGROUND: url(http://static.shihui.cn/images/theme/cate_57.gif) no-repeat left center; PADDING-TOP: 5px"
							class=parentCat>
							<a href="http://www.shihui.cn/category-57-b0.html">家居日用&gt;&gt;&gt;</a>
						</div>
						<div
							style="PADDING-BOTTOM: 5px; TEXT-INDENT: 10px; PADDING-LEFT: 0px; PADDING-RIGHT: 0px; BACKGROUND: url(http://static.shihui.cn/images/theme/cate_58.gif) no-repeat left center; PADDING-TOP: 5px"
							class=parentCat>
							<a href="http://www.shihui.cn/channel-10.html">生活电器&gt;&gt;&gt;</a>
						</div>
						<div
							style="PADDING-BOTTOM: 5px; TEXT-INDENT: 10px; PADDING-LEFT: 0px; PADDING-RIGHT: 0px; BACKGROUND: url(http://static.shihui.cn/images/theme/cate_79.gif) no-repeat left center; PADDING-TOP: 5px"
							class=parentCat>
							<a href="http://www.shihui.cn/category-79-b0.html">时尚精品&gt;&gt;&gt;</a>
						</div>
					</div>
					<div id=brandlist>
						<div id=btop class=brands_top></div>
						<div style="HEIGHT: 570px; OVERFLOW: hidden" id=blist>
							<ul
								style="TEXT-ALIGN: center; PADDING-BOTTOM: 0px; MARGIN: 0px auto; PADDING-LEFT: 0px; PADDING-RIGHT: 0px; PADDING-TOP: 15px"
								class=list_mar>
								<li class=brands_td>
									<a href="http://www.shihui.cn/brand-190-c0.html" target=_blank><img
											alt=露华浓 align=absMiddle src="images/1294855354212418270.jpg">
									</a>
								</li>
								<li class=brands_td>
									<a href="http://www.shihui.cn/brand-192-c0.html" target=_blank><img
											alt=赫升 align=absMiddle src="images/1298594244027083928.jpg">
									</a>
								</li>
								<li class=brands_td>
									<a href="http://www.shihui.cn/brand-191-c0.html" target=_blank><img
											alt=美鳄缘 align=absMiddle src="images/1297731150867623853.jpg">
									</a>
								</li>
								<li class=brands_td>
									<a href="http://www.shihui.cn/brand-22-c0.html" target=_blank><img
											alt="欧达 ORDRO" align=absMiddle
											src="images/1246571227297862892.jpg">
									</a>
								</li>
								<li class=brands_td>
									<a href="http://www.shihui.cn/brand-38-c0.html" target=_blank><img
											alt=欧莱雅 align=absMiddle src="images/1246571453017737600.jpg">
									</a>
								</li>
								<li class=brands_td>
									<a href="http://www.shihui.cn/brand-8-c0.html" target=_blank><img
											alt=高秀 align=absMiddle src="images/1246570384388101653.jpg">
									</a>
								</li>
								<li class=brands_td>
									<a href="http://www.shihui.cn/brand-51-c0.html" target=_blank><img
											alt=高贝克 align=absMiddle src="images/1247091549225747242.jpg">
									</a>
								</li>
								<li class=brands_td>
									<a href="http://www.shihui.cn/brand-70-c0.html" target=_blank><img
											alt=何金昌 align=absMiddle src="images/1247102998877215516.jpg">
									</a>
								</li>
								<li class=brands_td>
									<a href="http://www.shihui.cn/brand-86-c0.html" target=_blank><img
											alt=攀能 align=absMiddle src="images/1247105479496544085.jpg">
									</a>
								</li>
								<li class=brands_td>
									<a href="http://www.shihui.cn/brand-21-c0.html" target=_blank><img
											alt="PLAYBOY 花花公子" align=absMiddle
											src="images/1246571186819510060.jpg">
									</a>
								</li>
								<li class=brands_td>
									<a href="http://www.shihui.cn/brand-46-c0.html" target=_blank><img
											alt=三星 align=absMiddle src="images/1246829773989036883.jpg">
									</a>
								</li>
								<li class=brands_td>
									<a href="http://www.shihui.cn/brand-85-c0.html" target=_blank><img
											alt=子谷川 align=absMiddle src="images/1247105393856674974.jpg">
									</a>
								</li>
								<li class=brands_td>
									<a href="http://www.shihui.cn/brand-19-c0.html" target=_blank><img
											alt=松下 align=absMiddle src="images/1246571031805098844.jpg">
									</a>
								</li>
							</ul>
						</div>
						<div id=bfoot class=brands_buttom></div>
					</div>
				</div>
				<SCRIPT language=javascript type=text/javascript>
var is_index = 1;
</SCRIPT>

				<SCRIPT language=javascript type=text/javascript
					src="images/category.js"></SCRIPT>
			</DIV>
			<DIV class=MainMid>

				<DIV id=ifocus2>
					<img src="images/zhuye.jpg" height="300" width="600">
				</DIV>
				<SCRIPT language=javascript type=text/javascript>
var data = [{"url": "data/afficheimg/20110412ojwgok.JPG", "href": "/special/160.html", "title": ""},{"url": "data/afficheimg/20110308ufxuhq.jpg", "href": "/special/83.html", "title": ""},{"url": "data/afficheimg/20110416qhrfqf.jpg", "href": "/special/172.html", "title": ""},{"url": "data/afficheimg/20110113tmgyea.jpg", "href": "/special/21.html", "title": ""},{"url": "data/afficheimg/20110228nzmcuc.jpg", "href": "/special/53.html", "title": ""},{"url": "data/afficheimg/20110428wfrqqw.jpg", "href": "/special/143.html", "title": ""},{"url": "data/afficheimg/20110428lbjmmn.jpg", "href": "/special/176.html", "title": ""},{"url": "data/afficheimg/20110226svdlpf.jpg", "href": "/special/155.html", "title": ""}];
$("#ifocus2").shihuiSlide({width:575, height:300, photo: data, timeout: 8000});
</SCRIPT>

			<DIV class=huobaoDIV>
			<%@ include file = "latestproduct.jsp" %>
			</DIV>
			<DIV class=huobaoDIV>
					<DIV  class=huobao_box>
						<DIV class=goods>
							<DIV class=img>
								<P>
									<A title="铁甲兵K6汽车定位器  GPS车辆智能管理终端"
										href="http://www.shihui.cn/goods-2110.html" target=_blank><IMG
											border=0 alt="铁甲兵K6汽车定位器  GPS车辆智能管理终端"
											src="images/1288113183816178324.jpg">
									</A>
								</P>
								<P class=c>
									人气指数：12590
								</P>
							</DIV>
							<DIV class=text>
								<P>
									<A title="铁甲兵K6汽车定位器  GPS车辆智能管理终端"
										href="http://www.shihui.cn/goods-2110.html" target=_blank>铁甲兵K6汽车定位器</A>
								</P>
								<P>
									<FONT color=#fe0000>远程控制 安装简单</FONT>
								</P>
								<P style="COLOR: #ff0000; FONT-WEIGHT: bold">
									￥1180元
								</P>
								<P>
									<A title=查看商品详情 href="http://www.shihui.cn/goods-2110.html"
										target=_blank><IMG border=0 src="images/hot_gO1.gif">
									</A>
								</P>
							</DIV>
						</DIV>
						<DIV class=goods>
							<DIV class=img>
								<P>
									<A title=E路航LH900S一体机GPS导航仪（单机+雷达X7升级版）
										href="http://www.shihui.cn/goods-2355.html" target=_blank><IMG
											border=0 alt=E路航LH900S一体机GPS导航仪（单机+雷达X7升级版）
											src="images/1298844113465386195.jpg">
									</A>
								</P>
								<P class=c>
									人气指数：11127
								</P>
							</DIV>
							<DIV class=text>
								<P>
									<A title=E路航LH900S一体机GPS导航仪（单机+雷达X7升级版）
										href="http://www.shihui.cn/goods-2355.html" target=_blank>E路航LH900S一体机</A>
								</P>
								<P>
									<FONT color=#fe0000>固定测速、流动测速功能</FONT>
								</P>
								<P style="COLOR: #ff0000; FONT-WEIGHT: bold">
									￥1128元
								</P>
								<P>
									<A title=查看商品详情 href="http://www.shihui.cn/goods-2355.html"
										target=_blank><IMG border=0 src="images/hot_gO1.gif">
									</A>
								</P>
							</DIV>
						</DIV>
						<DIV style="BORDER-RIGHT-STYLE: none" class=goods>
							<DIV class=img>
								<P>
									<A title="小霸王倚天80 GPS导航仪"
										href="http://www.shihui.cn/goods-2409.html" target=_blank><IMG
											border=0 alt="小霸王倚天80 GPS导航仪"
											src="images/1299622321426785554.jpg">
									</A>
								</P>
								<P class=c>
									人气指数：10814
								</P>
							</DIV>
							<DIV class=text>
								<P>
									<A title="小霸王倚天80 GPS导航仪"
										href="http://www.shihui.cn/goods-2409.html" target=_blank>小霸王倚天80</A>
								</P>
								<P>
									<FONT color=#fe0000>4G内存 快速定位</FONT>
								</P>
								<P style="COLOR: #ff0000; FONT-WEIGHT: bold">
									￥598元
								</P>
								<P>
									<A title=查看商品详情 href="http://www.shihui.cn/goods-2409.html"
										target=_blank><IMG border=0 src="images/hot_gO1.gif">
									</A>
								</P>
							</DIV>
						</DIV>
						<DIV class=goods>
							<DIV class=img>
								<P>
									<A title="E路航导航仪LH950N  配4G内存"
										href="http://www.shihui.cn/goods-2405.html" target=_blank><IMG
											border=0 alt="E路航导航仪LH950N  配4G内存"
											src="images/1299613022657646830.jpg">
									</A>
								</P>
								<P class=c>
									人气指数：10484
								</P>
							</DIV>
							<DIV class=text>
								<P>
									<A title="E路航导航仪LH950N  配4G内存"
										href="http://www.shihui.cn/goods-2405.html" target=_blank>E路航导航仪LH950N</A>
								</P>
								<P>
									<FONT color=#fe0000>4G内存 导航/娱乐/电子书</FONT>
								</P>
								<P style="COLOR: #ff0000; FONT-WEIGHT: bold">
									￥890元
								</P>
								<P>
									<A title=查看商品详情 href="http://www.shihui.cn/goods-2405.html"
										target=_blank><IMG border=0 src="images/hot_gO1.gif">
									</A>
								</P>
							</DIV>
						</DIV>
						<DIV class=goods>
							<DIV class=img>
								<P>
									<A title=E路航3D地图GPS导航仪X8一体机（单机+X9雷达）
										href="http://www.shihui.cn/goods-2357.html" target=_blank><IMG
											border=0 alt=E路航3D地图GPS导航仪X8一体机（单机+X9雷达）
											src="images/1298845523911845150.jpg">
									</A>
								</P>
								<P class=c>
									人气指数：11375
								</P>
							</DIV>
							<DIV class=text>
								<P>
									<A title=E路航3D地图GPS导航仪X8一体机（单机+X9雷达）
										href="http://www.shihui.cn/goods-2357.html" target=_blank>E路航导航仪X8一体机</A>
								</P>
								<P>
									<FONT color=#fe0000>高灵敏度，高稳定性</FONT>
								</P>
								<P style="COLOR: #ff0000; FONT-WEIGHT: bold">
									￥998元
								</P>
								<P>
									<A title=查看商品详情 href="http://www.shihui.cn/goods-2357.html"
										target=_blank><IMG border=0 src="images/hot_gO1.gif">
									</A>
								</P>
							</DIV>
						</DIV>
						<DIV style="BORDER-RIGHT-STYLE: none" class=goods>
							<DIV class=img>
								<P>
									<A title=E路航导航仪LH980N至尊版
										href="http://www.shihui.cn/goods-2410.html" target=_blank><IMG
											border=0 alt=E路航导航仪LH980N至尊版
											src="images/1299634752330483564.jpg">
									</A>
								</P>
								<P class=c>
									人气指数：10633
								</P>
							</DIV>
							<DIV class=text>
								<P>
									<A title=E路航导航仪LH980N至尊版
										href="http://www.shihui.cn/goods-2410.html" target=_blank>E路航导航仪LH980N</A>
								</P>
								<P>
									<FONT color=#fe0000>双核动力 正版地图</FONT>
								</P>
								<P style="COLOR: #ff0000; FONT-WEIGHT: bold">
									￥890元
								</P>
								<P>
									<A title=查看商品详情 href="http://www.shihui.cn/goods-2410.html"
										target=_blank><IMG border=0 src="images/hot_gO1.gif">
									</A>
								</P>
							</DIV>
						</DIV>
					</DIV>
				</DIV>
					
					
					
			<DIV class=huobaoDIV>
					<DIV  class=huobao_box>
						<DIV class=goods>
							<DIV class=img>
								<P>
									<A title=TCL奢华版时尚女人手机Q3
										href="http://www.shihui.cn/goods-2418.html" target=_blank><IMG
											border=0 alt=TCL奢华版时尚女人手机Q3
											src="images/1299799557638626475.jpg">
									</A>
								</P>
								<P class=c>
									人气指数：10955
								</P>
							</DIV>
							<DIV class=text>
								<P>
									<A title=TCL奢华版时尚女人手机Q3
										href="http://www.shihui.cn/goods-2418.html" target=_blank>TCL奢华版时尚女人手机</A>
								</P>
								<P>
									<FONT color=#fe0000>高清双屏 200万像素</FONT>
								</P>
								<P style="COLOR: #ff0000; FONT-WEIGHT: bold">
									￥999元
								</P>
								<P>
									<A title=查看商品详情 href="http://www.shihui.cn/goods-2418.html"
										target=_blank><IMG border=0 src="images/hot_gO1.gif">
									</A>
								</P>
							</DIV>
						</DIV>
						<DIV class=goods>
							<DIV class=img>
								<P>
									<A title="科诺双卡双待手机T25 内带模拟电视"
										href="http://www.shihui.cn/goods-2466.html" target=_blank><IMG
											border=0 alt="科诺双卡双待手机T25 内带模拟电视"
											src="images/1302720721463724218.jpg">
									</A>
								</P>
								<P class=c>
									人气指数：10227
								</P>
							</DIV>
							<DIV class=text>
								<P>
									<A title="科诺双卡双待手机T25 内带模拟电视"
										href="http://www.shihui.cn/goods-2466.html" target=_blank>科诺双卡双待手机</A>
								</P>
								<P>
									<FONT color=#fe0000>内置130万像素摄像头</FONT>
								</P>
								<P style="COLOR: #ff0000; FONT-WEIGHT: bold">
									￥450元
								</P>
								<P>
									<A title=查看商品详情 href="http://www.shihui.cn/goods-2466.html"
										target=_blank><IMG border=0 src="images/hot_gO1.gif">
									</A>
								</P>
							</DIV>
						</DIV>
						<DIV style="BORDER-RIGHT-STYLE: none" class=goods>
							<DIV class=img>
								<P>
									<A title="新款手表手机MQ006 全钢纯平触摸 "
										href="http://www.shihui.cn/goods-2406.html" target=_blank><IMG
											border=0 alt="新款手表手机MQ006 全钢纯平触摸 "
											src="images/1299616020040489092.jpg">
									</A>
								</P>
								<P class=c>
									人气指数：13345
								</P>
							</DIV>
							<DIV class=text>
								<P>
									<A title="新款手表手机MQ006 全钢纯平触摸 "
										href="http://www.shihui.cn/goods-2406.html" target=_blank>新款手表手机MQ006</A>
								</P>
								<P>
									<FONT color=#fe0000>五一抢实惠立省130元</FONT>
								</P>
								<P style="COLOR: #ff0000; FONT-WEIGHT: bold">
									￥798元
								</P>
								<P>
									<A title=查看商品详情 href="http://www.shihui.cn/goods-2406.html"
										target=_blank><IMG border=0 src="images/hot_gO1.gif">
									</A>
								</P>
							</DIV>
						</DIV>
						<DIV class=goods>
							<DIV class=img>
								<P>
									<A title=新款UMO优摩双卡双待老年人手机L901
										href="http://www.shihui.cn/goods-2448.html" target=_blank><IMG
											border=0 alt=新款UMO优摩双卡双待老年人手机L901
											src="images/1301592624302420066.jpg">
									</A>
								</P>
								<P class=c>
									人气指数：10444
								</P>
							</DIV>
							<DIV class=text>
								<P>
									<A title=新款UMO优摩双卡双待老年人手机L901
										href="http://www.shihui.cn/goods-2448.html" target=_blank>双卡双待老年人手机</A>
								</P>
								<P>
									<FONT color=#fe0000>爱盾定位功能</FONT>
								</P>
								<P style="COLOR: #ff0000; FONT-WEIGHT: bold">
									￥450元
								</P>
								<P>
									<A title=查看商品详情 href="http://www.shihui.cn/goods-2448.html"
										target=_blank><IMG border=0 src="images/hot_gO1.gif">
									</A>
								</P>
							</DIV>
						</DIV>
						<DIV class=goods>
							<DIV class=img>
								<P>
									<A title=POLO平板触控笔记本手机
										href="http://www.shihui.cn/goods-2449.html" target=_blank><IMG
											border=0 alt=POLO平板触控笔记本手机
											src="images/1301874815027409897.jpg">
									</A>
								</P>
								<P class=c>
									人气指数：11627
								</P>
							</DIV>
							<DIV class=text>
								<P>
									<A title=POLO平板触控笔记本手机
										href="http://www.shihui.cn/goods-2449.html" target=_blank>POLO平板触控笔记本手...</A>
								</P>
								<P>
									<FONT color=#fe0000>合金机身、磨砂工艺，超薄机身</FONT>
								</P>
								<P style="COLOR: #ff0000; FONT-WEIGHT: bold">
									￥599元
								</P>
								<P>
									<A title=查看商品详情 href="http://www.shihui.cn/goods-2449.html"
										target=_blank><IMG border=0 src="images/hot_gO1.gif">
									</A>
								</P>
							</DIV>
						</DIV>
						<DIV style="BORDER-RIGHT-STYLE: none" class=goods>
							<DIV class=img>
								<P>
									<A title=易话通四代超薄手机 href="http://www.shihui.cn/goods-2316.html"
										target=_blank><IMG border=0 alt=易话通四代超薄手机
											src="images/1298327123491696800.jpg">
									</A>
								</P>
								<P class=c>
									人气指数：14461
								</P>
							</DIV>
							<DIV class=text>
								<P>
									<A title=易话通四代超薄手机 href="http://www.shihui.cn/goods-2316.html"
										target=_blank>易话通四代超薄手机</A>
								</P>
								<P>
									<FONT color=#fe0000>打遍全国只要一分钱/分钟</FONT>
								</P>
								<P style="COLOR: #ff0000; FONT-WEIGHT: bold">
									￥599元
								</P>
								<P>
									<A title=查看商品详情 href="http://www.shihui.cn/goods-2316.html"
										target=_blank><IMG border=0 src="images/hot_gO1.gif">
									</A>
								</P>
							</DIV>
						</DIV>
					</DIV>
					</DIV>
					
					
			<DIV class=huobaoDIV>
					<DIV  class=huobao_box>
						<DIV class=goods>
							<DIV class=img>
								<P>
									<A title=牛筋底木珠磁铁宝石健身鞋
										href="http://www.shihui.cn/goods-2362.html" target=_blank><IMG
											border=0 alt=牛筋底木珠磁铁宝石健身鞋
											src="images/1298920607619064721.jpg">
									</A>
								</P>
								<P class=c>
									人气指数：10672
								</P>
							</DIV>
							<DIV class=text>
								<P>
									<A title=牛筋底木珠磁铁宝石健身鞋
										href="http://www.shihui.cn/goods-2362.html" target=_blank>牛筋底木珠磁铁宝石健身鞋</A>
								</P>
								<P>
									<FONT color=#fe0000>促进体内新陈代谢</FONT>
								</P>
								<P style="COLOR: #ff0000; FONT-WEIGHT: bold">
									￥238元
								</P>
								<P>
									<A title=查看商品详情 href="http://www.shihui.cn/goods-2362.html"
										target=_blank><IMG border=0 src="images/hot_gO1.gif">
									</A>
								</P>
							</DIV>
						</DIV>
						<DIV class=goods>
							<DIV class=img>
								<P>
									<A title=高贝克（绚丽夏花）DIY洞洞鞋YA-226-1
										href="http://www.shihui.cn/goods-2444.html" target=_blank><IMG
											border=0 alt=高贝克（绚丽夏花）DIY洞洞鞋YA-226-1
											src="images/1301444531587292159.jpg">
									</A>
								</P>
								<P class=c>
									人气指数：10548
								</P>
							</DIV>
							<DIV class=text>
								<P>
									<A title=高贝克（绚丽夏花）DIY洞洞鞋YA-226-1
										href="http://www.shihui.cn/goods-2444.html" target=_blank>高贝克洞洞鞋YA-226...</A>
								</P>
								<P>
									<FONT color=#fe0000>个性+增高+舒适</FONT>
								</P>
								<P style="COLOR: #ff0000; FONT-WEIGHT: bold">
									￥59元
								</P>
								<P>
									<A title=查看商品详情 href="http://www.shihui.cn/goods-2444.html"
										target=_blank><IMG border=0 src="images/hot_gO1.gif">
									</A>
								</P>
							</DIV>
						</DIV>
						<DIV style="BORDER-RIGHT-STYLE: none" class=goods>
							<DIV class=img>
								<P>
									<A title="高秀紧身鞋GW-208C女款 可爱粉红底色"
										href="http://www.shihui.cn/goods-2174.html" target=_blank><IMG
											border=0 alt="高秀紧身鞋GW-208C女款 可爱粉红底色"
											src="images/1292634482584719657.jpg">
									</A>
								</P>
								<P class=c>
									人气指数：11996
								</P>
							</DIV>
							<DIV class=text>
								<P>
									<A title="高秀紧身鞋GW-208C女款 可爱粉红底色"
										href="http://www.shihui.cn/goods-2174.html" target=_blank>高秀紧身鞋208D女款</A>
								</P>
								<P>
									<FONT color=#fe0000>五一抢实惠直降270元</FONT>
								</P>
								<P style="COLOR: #ff0000; FONT-WEIGHT: bold">
									￥128元
								</P>
								<P>
									<A title=查看商品详情 href="http://www.shihui.cn/goods-2174.html"
										target=_blank><IMG border=0 src="images/hot_gO1.gif">
									</A>
								</P>
							</DIV>
						</DIV>
						<DIV class=goods>
							<DIV class=img>
								<P>
									<A title=赫升女士内增高鞋W40F02D
										href="http://www.shihui.cn/goods-2349.html" target=_blank><IMG
											border=0 alt=赫升女士内增高鞋W40F02D
											src="images/1298832383041241923.jpg">
									</A>
								</P>
								<P class=c>
									人气指数：10348
								</P>
							</DIV>
							<DIV class=text>
								<P>
									<A title=赫升女士内增高鞋W40F02D
										href="http://www.shihui.cn/goods-2349.html" target=_blank>赫升女士内增高鞋</A>
								</P>
								<P>
									<FONT color=#fe0000>物理加高、垫高效果</FONT>
								</P>
								<P style="COLOR: #ff0000; FONT-WEIGHT: bold">
									￥296元
								</P>
								<P>
									<A title=查看商品详情 href="http://www.shihui.cn/goods-2349.html"
										target=_blank><IMG border=0 src="images/hot_gO1.gif">
									</A>
								</P>
							</DIV>
						</DIV>
						<DIV class=goods>
							<DIV class=img>
								<P>
									<A title=高贝克帆布休闲增高鞋（迷幻怀旧字母）隐形增高清爽透气
										href="http://www.shihui.cn/goods-296.html" target=_blank><IMG
											border=0 alt=高贝克帆布休闲增高鞋（迷幻怀旧字母）隐形增高清爽透气
											src="images/1245347649276020916.jpg">
									</A>
								</P>
								<P class=c>
									人气指数：19510
								</P>
							</DIV>
							<DIV class=text>
								<P>
									<A title=高贝克帆布休闲增高鞋（迷幻怀旧字母）隐形增高清爽透气
										href="http://www.shihui.cn/goods-296.html" target=_blank>高贝克帆布休闲增高鞋</A>
								</P>
								<P>
									<FONT color=#fe0000>穿着舒适柔软</FONT>
								</P>
								<P style="COLOR: #ff0000; FONT-WEIGHT: bold">
									￥88元
								</P>
								<P>
									<A title=查看商品详情 href="http://www.shihui.cn/goods-296.html"
										target=_blank><IMG border=0 src="images/hot_gO1.gif">
									</A>
								</P>
							</DIV>
						</DIV>
						<DIV style="BORDER-RIGHT-STYLE: none" class=goods>
							<DIV class=img>
								<P>
									<A title=何金昌隐形增高牛皮休闲鞋V3211
										href="http://www.shihui.cn/goods-415.html" target=_blank><IMG
											border=0 alt=何金昌隐形增高牛皮休闲鞋V3211
											src="images/1245347612617521451.jpg">
									</A>
								</P>
								<P class=c>
									人气指数：23885
								</P>
							</DIV>
							<DIV class=text>
								<P>
									<A title=何金昌隐形增高牛皮休闲鞋V3211
										href="http://www.shihui.cn/goods-415.html" target=_blank>何金昌隐形增高牛皮休闲鞋</A>
								</P>
								<P>
									<FONT color=#fe0000>真皮制作，舒适高档</FONT>
								</P>
								<P style="COLOR: #ff0000; FONT-WEIGHT: bold">
									￥638元
								</P>
								<P>
									<A title=查看商品详情 href="http://www.shihui.cn/goods-415.html"
										target=_blank><IMG border=0 src="images/hot_gO1.gif">
									</A>
								</P>
							</DIV>
						</DIV>
					</DIV>
					
					</DIV>
			<DIV class=huobaoDIV>
					<DIV  class=huobao_box>
						<DIV class=goods>
							<DIV class=img>
								<P>
									<A title=美E贴纯天然生食溶解面膜
										href="http://www.shihui.cn/goods-2431.html" target=_blank><IMG
											border=0 alt=美E贴纯天然生食溶解面膜
											src="images/1301005307369243372.jpg">
									</A>
								</P>
								<P class=c>
									人气指数：10360
								</P>
							</DIV>
							<DIV class=text>
								<P>
									<A title=美E贴纯天然生食溶解面膜
										href="http://www.shihui.cn/goods-2431.html" target=_blank>美E贴纯天然面膜</A>
								</P>
								<P>
									<FONT color=#fe0000>美白保湿 皮肤年轻有弹性</FONT>
								</P>
								<P style="COLOR: #ff0000; FONT-WEIGHT: bold">
									￥199元
								</P>
								<P>
									<A title=查看商品详情 href="http://www.shihui.cn/goods-2431.html"
										target=_blank><IMG border=0 src="images/hot_gO1.gif">
									</A>
								</P>
							</DIV>
						</DIV>
						<DIV class=goods>
							<DIV class=img>
								<P>
									<A title=纳米喷雾美颜仪FF0301
										href="http://www.shihui.cn/goods-2364.html" target=_blank><IMG
											border=0 alt=纳米喷雾美颜仪FF0301
											src="images/1298933487726545427.jpg">
									</A>
								</P>
								<P class=c>
									人气指数：10393
								</P>
							</DIV>
							<DIV class=text>
								<P>
									<A title=纳米喷雾美颜仪FF0301
										href="http://www.shihui.cn/goods-2364.html" target=_blank>纳米喷雾美颜仪</A>
								</P>
								<P>
									<FONT color=#fe0000>改善青春痘，缓和肌肤</FONT>
								</P>
								<P style="COLOR: #ff0000; FONT-WEIGHT: bold">
									￥278元
								</P>
								<P>
									<A title=查看商品详情 href="http://www.shihui.cn/goods-2364.html"
										target=_blank><IMG border=0 src="images/hot_gO1.gif">
									</A>
								</P>
							</DIV>
						</DIV>
						<DIV style="BORDER-RIGHT-STYLE: none" class=goods>
							<DIV class=img>
								<P>
									<A title=白天使疤痕贴片 href="http://www.shihui.cn/goods-2437.html"
										target=_blank><IMG border=0 alt=白天使疤痕贴片
											src="images/1301361007082729513.jpg">
									</A>
								</P>
								<P class=c>
									人气指数：10426
								</P>
							</DIV>
							<DIV class=text>
								<P>
									<A title=白天使疤痕贴片 href="http://www.shihui.cn/goods-2437.html"
										target=_blank>白天使疤痕贴片</A>
								</P>
								<P>
									<FONT color=#fe0000>“软化、平复、再生”三部曲</FONT>
								</P>
								<P style="COLOR: #ff0000; FONT-WEIGHT: bold">
									￥158元
								</P>
								<P>
									<A title=查看商品详情 href="http://www.shihui.cn/goods-2437.html"
										target=_blank><IMG border=0 src="images/hot_gO1.gif">
									</A>
								</P>
							</DIV>
						</DIV>
						<DIV class=goods>
							<DIV class=img>
								<P>
									<A title="腹无纹 白天使美腹之星"
										href="http://www.shihui.cn/goods-2438.html" target=_blank><IMG
											border=0 alt="腹无纹 白天使美腹之星"
											src="images/1301362960950221399.jpg">
									</A>
								</P>
								<P class=c>
									人气指数：10542
								</P>
							</DIV>
							<DIV class=text>
								<P>
									<A title="腹无纹 白天使美腹之星"
										href="http://www.shihui.cn/goods-2438.html" target=_blank>腹无纹
										白天使美腹之星</A>
								</P>
								<P>
									<FONT color=#fe0000>既瘦身又消去肚纹</FONT>
								</P>
								<P style="COLOR: #ff0000; FONT-WEIGHT: bold">
									￥158元
								</P>
								<P>
									<A title=查看商品详情 href="http://www.shihui.cn/goods-2438.html"
										target=_blank><IMG border=0 src="images/hot_gO1.gif">
									</A>
								</P>
							</DIV>
						</DIV>
						<DIV class=goods>
							<DIV class=img>
								<P>
									<A title="美白小灵通单机FF8353 "
										href="http://www.shihui.cn/goods-2370.html" target=_blank><IMG
											border=0 alt="美白小灵通单机FF8353 "
											src="images/1298940271146002700.jpg">
									</A>
								</P>
								<P class=c>
									人气指数：10259
								</P>
							</DIV>
							<DIV class=text>
								<P>
									<A title="美白小灵通单机FF8353 "
										href="http://www.shihui.cn/goods-2370.html" target=_blank>美白小灵通单机</A>
								</P>
								<P>
									<FONT color=#fe0000>美白、保湿、抗皱</FONT>
								</P>
								<P style="COLOR: #ff0000; FONT-WEIGHT: bold">
									￥208元
								</P>
								<P>
									<A title=查看商品详情 href="http://www.shihui.cn/goods-2370.html"
										target=_blank><IMG border=0 src="images/hot_gO1.gif">
									</A>
								</P>
							</DIV>
						</DIV>
						<DIV style="BORDER-RIGHT-STYLE: none" class=goods>
							<DIV class=img>
								<P>
									<A title="大麦若叶青汁 排毒养颜祛痘"
										href="http://www.shihui.cn/goods-2429.html" target=_blank><IMG
											border=0 alt="大麦若叶青汁 排毒养颜祛痘"
											src="images/1300996542750298001.jpg">
									</A>
								</P>
								<P class=c>
									人气指数：10431
								</P>
							</DIV>
							<DIV class=text>
								<P>
									<A title="大麦若叶青汁 排毒养颜祛痘"
										href="http://www.shihui.cn/goods-2429.html" target=_blank>大麦若叶青汁</A>
								</P>
								<P>
									<FONT color=#fe0000>显著排毒功效 男女老少皆宜</FONT>
								</P>
								<P style="COLOR: #ff0000; FONT-WEIGHT: bold">
									￥298元
								</P>
								<P>
									<A title=查看商品详情 href="http://www.shihui.cn/goods-2429.html"
										target=_blank><IMG border=0 src="images/hot_gO1.gif">
									</A>
								</P>
							</DIV>
						</DIV>
					</DIV>
					</DIV>
			<DIV class=huobaoDIV>
			
					<DIV  class=huobao_box>
						<DIV class=goods>
							<DIV class=img>
								<P>
									<A title=超声波加湿雾化器 href="http://www.shihui.cn/goods-2436.html"
										target=_blank><IMG border=0 alt=超声波加湿雾化器
											src="images/1301360220230081924.jpg">
									</A>
								</P>
								<P class=c>
									人气指数：10394
								</P>
							</DIV>
							<DIV class=text>
								<P>
									<A title=超声波加湿雾化器 href="http://www.shihui.cn/goods-2436.html"
										target=_blank>超声波加湿雾化器</A>
								</P>
								<P>
									<FONT color=#fe0000>迷你体积，精致时尚</FONT>
								</P>
								<P style="COLOR: #ff0000; FONT-WEIGHT: bold">
									￥139元
								</P>
								<P>
									<A title=查看商品详情 href="http://www.shihui.cn/goods-2436.html"
										target=_blank><IMG border=0 src="images/hot_gO1.gif">
									</A>
								</P>
							</DIV>
						</DIV>
						<DIV class=goods>
							<DIV class=img>
								<P>
									<A title="真味如烟电子烟 有效戒除烟瘾 多种口味 单品"
										href="http://www.shihui.cn/goods-2047.html" target=_blank><IMG
											border=0 alt="真味如烟电子烟 有效戒除烟瘾 多种口味 单品"
											src="images/1286222445774345977.jpg">
									</A>
								</P>
								<P class=c>
									人气指数：15079
								</P>
							</DIV>
							<DIV class=text>
								<P>
									<A title="真味如烟电子烟 有效戒除烟瘾 多种口味 单品"
										href="http://www.shihui.cn/goods-2047.html" target=_blank>真味如烟电子烟
										单品</A>
								</P>
								<P>
									<FONT color=#fe0000>8种口味任选 轻松戒烟</FONT>
								</P>
								<P style="COLOR: #ff0000; FONT-WEIGHT: bold">
									￥99元
								</P>
								<P>
									<A title=查看商品详情 href="http://www.shihui.cn/goods-2047.html"
										target=_blank><IMG border=0 src="images/hot_gO1.gif">
									</A>
								</P>
							</DIV>
						</DIV>
						<DIV style="BORDER-RIGHT-STYLE: none" class=goods>
							<DIV class=img>
								<P>
									<A title=九耀多功能营养料理机 href="http://www.shihui.cn/goods-1000.html"
										target=_blank><IMG border=0 alt=九耀多功能营养料理机
											src="images/1249673969944360851.jpg">
									</A>
								</P>
								<P class=c>
									人气指数：27912
								</P>
							</DIV>
							<DIV class=text>
								<P>
									<A title=九耀多功能营养料理机 href="http://www.shihui.cn/goods-1000.html"
										target=_blank>九耀多功能营养料理机</A>
								</P>
								<P>
									<FONT color=#fe0000>现在订购即赠送价值128元的保鲜盒三件套+果汁杯三件套</FONT>
								</P>
								<P style="COLOR: #ff0000; FONT-WEIGHT: bold">
									￥398元
								</P>
								<P>
									<A title=查看商品详情 href="http://www.shihui.cn/goods-1000.html"
										target=_blank><IMG border=0 src="images/hot_gO1.gif">
									</A>
								</P>
							</DIV>
						</DIV>
						<DIV class=goods>
							<DIV class=img>
								<P>
									<A title="KV8吉祥三宝车载空气净化器（车载型） 高效除菌 预防流感"
										href="http://www.shihui.cn/goods-11.html" target=_blank><IMG
											border=0 alt="KV8吉祥三宝车载空气净化器（车载型） 高效除菌 预防流感"
											src="images/1245347929327362965.jpg">
									</A>
								</P>
								<P class=c>
									人气指数：18321
								</P>
							</DIV>
							<DIV class=text>
								<P>
									<A title="KV8吉祥三宝车载空气净化器（车载型） 高效除菌 预防流感"
										href="http://www.shihui.cn/goods-11.html" target=_blank>吉祥三宝车载空气净化器</A>
								</P>
								<P>
									<FONT color=#fe0000>强大空气净化功能</FONT>
								</P>
								<P style="COLOR: #ff0000; FONT-WEIGHT: bold">
									￥69元
								</P>
								<P>
									<A title=查看商品详情 href="http://www.shihui.cn/goods-11.html"
										target=_blank><IMG border=0 src="images/hot_gO1.gif">
									</A>
								</P>
							</DIV>
						</DIV>
						<DIV class=goods>
							<DIV class=img>
								<P>
									<A title=唏哈蓝光电子烟膏 href="http://www.shihui.cn/goods-2425.html"
										target=_blank><IMG border=0 alt=唏哈蓝光电子烟膏
											src="images/1300672620119363920.jpg">
									</A>
								</P>
								<P class=c>
									人气指数：11988
								</P>
							</DIV>
							<DIV class=text>
								<P>
									<A title=唏哈蓝光电子烟膏 href="http://www.shihui.cn/goods-2425.html"
										target=_blank>唏哈蓝光电子烟膏</A>
								</P>
								<P>
									<FONT color=#fe0000>提神、清肺之功效</FONT>
								</P>
								<P style="COLOR: #ff0000; FONT-WEIGHT: bold">
									￥396元
								</P>
								<P>
									<A title=查看商品详情 href="http://www.shihui.cn/goods-2425.html"
										target=_blank><IMG border=0 src="images/hot_gO1.gif">
									</A>
								</P>
							</DIV>
						</DIV>
						<DIV style="BORDER-RIGHT-STYLE: none" class=goods>
							<DIV class=img>
								<P>
									<A title="九耀膝关节理疗仪 有效缓解风湿关节病痛"
										href="http://www.shihui.cn/goods-1530.html" target=_blank><IMG
											border=0 alt="九耀膝关节理疗仪 有效缓解风湿关节病痛"
											src="images/1259715385268254048.jpg">
									</A>
								</P>
								<P class=c>
									人气指数：13205
								</P>
							</DIV>
							<DIV class=text>
								<P>
									<A title="九耀膝关节理疗仪 有效缓解风湿关节病痛"
										href="http://www.shihui.cn/goods-1530.html" target=_blank>九耀膝关节理疗仪</A>
								</P>
								<P>
									<FONT color=#fe0000>给力！10分钟缓解膝关节疼痛</FONT>
								</P>
								<P style="COLOR: #ff0000; FONT-WEIGHT: bold">
									￥498元
								</P>
								<P>
									<A title=查看商品详情 href="http://www.shihui.cn/goods-1530.html"
										target=_blank><IMG border=0 src="images/hot_gO1.gif">
									</A>
								</P>
							</DIV>
						</DIV>
					</DIV>
				</DIV>
				<SCRIPT language=javascript type=text/javascript>$(".huobao_box").shihuiTab({thumbObj: '.huobao_span span', slideTime: 300, changeType: 'slide', thumbNowClass: 'cur'});</SCRIPT>
			</DIV>
			<DIV class=MainRight>
				<DIV class=index_maket_area>
					<EMBED height=163 type=application/x-shockwave-flash width=192
						src=http://static.shihui.cn/flash/all.swf wmode="transparent"
						quality="high"></EMBED>
				</DIV>
				<DIV id=index_sh_gonggao>
					<DIV id=index_sh_gonggao_top>
						<SPAN
							style="POSITION: absolute; MARGIN-TOP: 7px; MARGIN-LEFT: 155px"><A
							title=更多实惠公告 href="http://www.shihui.cn/article_cat-11.html"
							target=_blank><IMG border=0 src="images/gg_more.gif">
						</A>
						</SPAN>
						<A title=实惠公告，了解实惠通道最新动态
							href="http://www.shihui.cn/article_cat-11.html" target=_blank><IMG
								alt=实惠公告，点击查看所有实惠通道公告 align=absBottom
								src="images/shihuiggao_bg_top.gif"> </A>
					</DIV>
					<DIV id=index_sh_gonggao_mid>
						<DIV id=sh_affiche class=sh_affiche_marquee>
							<DIV style="MARGIN-TOP: 5px" id=sh_affiche_demo
								class=sh_affiche_demo>
								<DIV class=new_activity_list>
									<A title="厦门电视台重力推荐塑可儿 "
										href="http://bbs.shihui.cn/thread-87928-1-1.html"
										target=_blank>厦门电视台重力推荐塑可儿</A>
								</DIV>
								<DIV class=new_activity_list>
									<A title="五一大放价 爆款2折疯抢"
										href="http://www.shihui.cn/article-1946.html" target=_blank>五一大放价
										爆款2折疯抢</A>
								</DIV>
								<DIV class=new_activity_list>
									<A title=最后一波:99元抢增高鞋
										href="http://www.shihui.cn/article-1934.html" target=_blank>最后一波:99元抢增高鞋</A>
								</DIV>
								<DIV class=new_activity_list>
									<A title=赢健康福利唏哈烟膏免费送！
										href="http://www.shihui.cn/huodong/siihaa/" target=_blank>赢健康福利唏哈烟膏免费送！</A>
								</DIV>
								<DIV class=new_activity_list>
									<A title=99元，高秀增高鞋疯抢中！
										href="http://www.shihui.cn/special/23.html?in_source=Hshoe00"
										target=_blank>99元，高秀增高鞋疯抢中！</A>
								</DIV>
							</DIV>
						</DIV>
					</DIV>
					<DIV id=index_sh_gonggao_bottom></DIV>
				</DIV>
				<DIV id=index_spread_bar_right>
					<IMG alt=实惠通道热销排行榜 src="images/index_top_title.gif">
					<A title=实惠通道热销排行NO.1，高秀魔力增高鞋
						href="http://www.shihui.cn/goods-114.html" target=_blank><IMG
							alt=实惠通道热销排行NO.1，高秀魔力增高鞋 src="images/12920338980BIF4DW.jpg">
					</A><A title="实惠通道热销排行NO.2 微型摄像录音U盘笔"
						href="http://www.shihui.cn/special/100.html" target=_blank><IMG
							alt="实惠通道热销排行NO.2 微型摄像录音U盘笔" src="images/12920339589ITAWZ1.jpg">
					</A><A title=实惠通道热销排行NO.3，打火机摄像DV
						href="http://www.shihui.cn/goods-1479.html" target=_blank><IMG
							alt=实惠通道热销排行NO.3，打火机摄像DV src="images/1292033988IXC3GE0.jpg">
					</A><A title=实惠通道热销排行NO.4，E路航LH900s
						href="http://www.shihui.cn/goods-1194.html" target=_blank><IMG
							alt=实惠通道热销排行NO.4，E路航LH900s src="images/1295603213PHGDSB7.jpg">
					</A><A title="实惠通道热销排行NO.5， 塑可儿美颜风火轮"
						href="http://www.shihui.cn/special/83.html" target=_blank><IMG
							alt="实惠通道热销排行NO.5， 塑可儿美颜风火轮" src="images/12995953313HG26AD.jpg">
					</A><A title=热销排行NO.6，电影游戏投影手机
						href="http://www.shihui.cn/special/53.html" target=_blank><IMG
							alt=热销排行NO.6，电影游戏投影手机 src="images/1292034077XUU9SHH.jpg">
					</A><A title=实惠通道热销排行NO.7，小霸王倚天70导航仪
						href="http://www.shihui.cn/goods-1915.html" target=_blank><IMG
							alt=实惠通道热销排行NO.7，小霸王倚天70导航仪 src="images/1292034104QMOATOJ.jpg">
					</A>
				</DIV>
			</DIV>
		<SCRIPT>var onchat=0;  var hidekf = 0;</SCRIPT>

		<SCRIPT language=javascript type=text/javascript src="images/kf.js"></SCRIPT>

		<SCRIPT language=JavaScript>function killErrors() {return true;} window.onerror = function(){killErrors();}</SCRIPT>

		<DIV></DIV>
		<SCRIPT type=text/javascript src="images/javascript.htm"></SCRIPT>
		<!-- create at 2011-04-29 11:04:14 -->
	</BODY>
</HTML>