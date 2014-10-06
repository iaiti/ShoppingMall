//实惠商城公共JS类库，基于jQuery插件
//@author richie
//加载CSS背景图片
if($.browser.msie){try { document.execCommand("BackgroundImageCache", false, true);  } catch(err) {}}
//shihuiTab 
;(function($){$.fn.extend({"shihuiTab":function(o){o=$.extend({thumbObj:null,botPrev:null,botNext:null,changeType:'fade',thumbNowClass:'now',thumbOverEvent:true,slideTime:1000,autoChange:true,clickFalse:true,overStop:true,changeTime:5000,delayTime:1},o||{});var _self=$(this);var thumbObj;var size=_self.size();var nowIndex=0;var index;var startRun;var delayRun;function fadeAB(){if(nowIndex!=index){if(o.thumbObj!=null){$(o.thumbObj).removeClass(o.thumbNowClass).eq(index).addClass(o.thumbNowClass)}if(o.slideTime<=0){_self.eq(nowIndex).hide();_self.eq(index).show()}else if(o.changeType=='fade'){_self.eq(nowIndex).fadeOut(o.slideTime);_self.eq(index).fadeIn(o.slideTime)}else{_self.eq(nowIndex).slideUp(o.slideTime);_self.eq(index).slideDown(o.slideTime)}nowIndex=index;if(o.autoChange==true){clearInterval(startRun);startRun=setInterval(runNext,o.changeTime)}}}function runNext(){index=(nowIndex+1)%size;fadeAB()}_self.hide().eq(0).show();if(o.thumbObj!=null){thumbObj=$(o.thumbObj);thumbObj.removeClass(o.thumbNowClass).eq(0).addClass(o.thumbNowClass);thumbObj.click(function(){index=thumbObj.index($(this));fadeAB();if(o.clickFalse==true){return false}});if(o.thumbOverEvent==true){thumbObj.mouseenter(function(){index=thumbObj.index($(this));delayRun=setTimeout(fadeAB,o.delayTime)});thumbObj.mouseleave(function(){clearTimeout(delayRun)})}}if(o.botNext!=null){$(o.botNext).click(function(){if(_self.queue().length<1){runNext()}return false})}if(o.botPrev!=null){$(o.botPrev).click(function(){if(_self.queue().length<1){index=(nowIndex+size-1)%size;fadeAB()}return false})}if(o.autoChange==true){startRun=setInterval(runNext,o.changeTime);if(o.overStop==true){_self.mouseenter(function(){clearInterval(startRun)});_self.mouseleave(function(){startRun=setInterval(runNext,o.changeTime)})}}}})})(jQuery);
//Tip插件
(function(e){var a=[],d=/^url\(["']?([^"'\)]*)["']?\);?$/i,c=/\.png$/i,b=e.browser.msie&&e.browser.version==6;function f(){e.each(a,function(){this.refresh(true)})}e(window).resize(f);e.Poshytip=function(h,g){this.$elm=e(h);this.opts=e.extend({},e.fn.poshytip.defaults,g);this.$tip=e(['<div class="',this.opts.className,'">','<div class="tip-inner tip-bg-image"></div>','<div class="tip-arrow tip-arrow-top tip-arrow-right tip-arrow-bottom tip-arrow-left"></div>',"</div>"].join(""));this.$arrow=this.$tip.find("div.tip-arrow");this.$inner=this.$tip.find("div.tip-inner");this.disabled=false;this.init()};e.Poshytip.prototype={init:function(){a.push(this);this.$elm.data("title.poshytip",this.$elm.attr("title")).data("poshytip",this);switch(this.opts.showOn){case"hover":this.$elm.bind({"mouseenter.poshytip":e.proxy(this.mouseenter,this),"mouseleave.poshytip":e.proxy(this.mouseleave,this)});if(this.opts.alignTo=="cursor"){this.$elm.bind("mousemove.poshytip",e.proxy(this.mousemove,this))}if(this.opts.allowTipHover){this.$tip.hover(e.proxy(this.clearTimeouts,this),e.proxy(this.hide,this))}break;case"focus":this.$elm.bind({"focus.poshytip":e.proxy(this.show,this),"blur.poshytip":e.proxy(this.hide,this)});break}},mouseenter:function(g){if(this.disabled){return true}this.clearTimeouts();this.$elm.attr("title","");this.showTimeout=setTimeout(e.proxy(this.show,this),this.opts.showTimeout)},mouseleave:function(){if(this.disabled){return true}this.clearTimeouts();this.$elm.attr("title",this.$elm.data("title.poshytip"));this.hideTimeout=setTimeout(e.proxy(this.hide,this),this.opts.hideTimeout)},mousemove:function(g){if(this.disabled){return true}this.eventX=g.pageX;this.eventY=g.pageY;if(this.opts.followCursor&&this.$tip.data("active")){this.calcPos();this.$tip.css({left:this.pos.l,top:this.pos.t});if(this.pos.arrow){this.$arrow[0].className="tip-arrow tip-arrow-"+this.pos.arrow}}},show:function(){if(this.disabled||this.$tip.data("active")){return}this.reset();this.update();this.display()},hide:function(){if(this.disabled||!this.$tip.data("active")){return}this.display(true)},reset:function(){this.$tip.queue([]).detach().css("visibility","hidden").data("active",false);this.$inner.find("*").poshytip("hide");if(this.opts.fade){this.$tip.css("opacity",this.opacity)}this.$arrow[0].className="tip-arrow tip-arrow-top tip-arrow-right tip-arrow-bottom tip-arrow-left"},update:function(i){if(this.disabled){return}var h=i!==undefined;if(h){if(!this.$tip.data("active")){return}}else{i=this.opts.content}this.$inner.contents().detach();var g=this;this.$inner.append(typeof i=="function"?i.call(this.$elm[0],function(j){g.update(j)}):i=="[title]"?this.$elm.data("title.poshytip"):i);this.refresh(h)},refresh:function(h){if(this.disabled){return}if(h){if(!this.$tip.data("active")){return}var k={left:this.$tip.css("left"),top:this.$tip.css("top")}}this.$tip.css({left:0,top:0}).appendTo(document.body);if(this.opacity===undefined){this.opacity=this.$tip.css("opacity")}var l=this.$tip.css("background-image").match(d),m=this.$arrow.css("background-image").match(d);if(l){var i=c.test(l[1]);if(b&&i){this.$tip.css("background-image","none");this.$inner.css({margin:0,border:0,padding:0});l=i=false}else{this.$tip.prepend('<table border="0" cellpadding="0" cellspacing="0"><tr><td class="tip-top tip-bg-image" colspan="2"><span></span></td><td class="tip-right tip-bg-image" rowspan="2"><span></span></td></tr><tr><td class="tip-left tip-bg-image" rowspan="2"><span></span></td><td></td></tr><tr><td class="tip-bottom tip-bg-image" colspan="2"><span></span></td></tr></table>').css({border:0,padding:0,"background-image":"none","background-color":"transparent"}).find(".tip-bg-image").css("background-image",'url("'+l[1]+'")').end().find("td").eq(3).append(this.$inner)}if(i&&!e.support.opacity){this.opts.fade=false}}if(m&&!e.support.opacity){if(b&&c.test(m[1])){m=false;this.$arrow.css("background-image","none")}this.opts.fade=false}var o=this.$tip.find("table");if(b){this.$tip[0].style.width="";o.width("auto").find("td").eq(3).width("auto");var n=this.$tip.width(),j=parseInt(this.$tip.css("min-width")),g=parseInt(this.$tip.css("max-width"));if(!isNaN(j)&&n<j){n=j}else{if(!isNaN(g)&&n>g){n=g}}this.$tip.add(o).width(n).eq(0).find("td").eq(3).width("100%")}else{if(o[0]){o.width("auto").find("td").eq(3).width("auto").end().end().width(this.$tip.width()).find("td").eq(3).width("100%")}}this.tipOuterW=this.$tip.outerWidth();this.tipOuterH=this.$tip.outerHeight();this.calcPos();if(m&&this.pos.arrow){this.$arrow[0].className="tip-arrow tip-arrow-"+this.pos.arrow;this.$arrow.css("visibility","inherit")}if(h){this.$tip.css(k).animate({left:this.pos.l,top:this.pos.t},200)}else{this.$tip.css({left:this.pos.l,top:this.pos.t})}},display:function(h){var i=this.$tip.data("active");if(i&&!h||!i&&h){return}this.$tip.stop();if((this.opts.slide&&this.pos.arrow||this.opts.fade)&&(h&&this.opts.hideAniDuration||!h&&this.opts.showAniDuration)){var m={},l={};if(this.opts.slide&&this.pos.arrow){var k,g;if(this.pos.arrow=="bottom"||this.pos.arrow=="top"){k="top";g="bottom"}else{k="left";g="right"}var j=parseInt(this.$tip.css(k));m[k]=j+(h?0:this.opts.slideOffset*(this.pos.arrow==g?-1:1));l[k]=j+(h?this.opts.slideOffset*(this.pos.arrow==g?1:-1):0)}if(this.opts.fade){m.opacity=h?this.$tip.css("opacity"):0;l.opacity=h?0:this.opacity}this.$tip.css(m).animate(l,this.opts[h?"hideAniDuration":"showAniDuration"])}h?this.$tip.queue(e.proxy(this.reset,this)):this.$tip.css("visibility","inherit");this.$tip.data("active",!i)},disable:function(){this.reset();this.disabled=true},enable:function(){this.disabled=false},destroy:function(){this.reset();this.$tip.remove();this.$elm.unbind("poshytip").removeData("title.poshytip").removeData("poshytip");a.splice(e.inArray(this,a),1)},clearTimeouts:function(){if(this.showTimeout){clearTimeout(this.showTimeout);this.showTimeout=0}if(this.hideTimeout){clearTimeout(this.hideTimeout);this.hideTimeout=0}},calcPos:function(){var n={l:0,t:0,arrow:""},h=e(window),k={l:h.scrollLeft(),t:h.scrollTop(),w:h.width(),h:h.height()},p,j,m,i,q,g;if(this.opts.alignTo=="cursor"){p=j=m=this.eventX;i=q=g=this.eventY}else{var o=this.$elm.offset(),l={l:o.left,t:o.top,w:this.$elm.outerWidth(),h:this.$elm.outerHeight()};p=l.l+(this.opts.alignX!="inner-right"?0:l.w);j=p+Math.floor(l.w/2);m=p+(this.opts.alignX!="inner-left"?l.w:0);i=l.t+(this.opts.alignY!="inner-bottom"?0:l.h);q=i+Math.floor(l.h/2);g=i+(this.opts.alignY!="inner-top"?l.h:0)}switch(this.opts.alignX){case"right":case"inner-left":n.l=m+this.opts.offsetX;if(n.l+this.tipOuterW>k.l+k.w){n.l=k.l+k.w-this.tipOuterW}if(this.opts.alignX=="right"||this.opts.alignY=="center"){n.arrow="left"}break;case"center":n.l=j-Math.floor(this.tipOuterW/2);if(n.l+this.tipOuterW>k.l+k.w){n.l=k.l+k.w-this.tipOuterW}else{if(n.l<k.l){n.l=k.l}}break;default:n.l=p-this.tipOuterW-this.opts.offsetX;if(n.l<k.l){n.l=k.l}if(this.opts.alignX=="left"||this.opts.alignY=="center"){n.arrow="right"}}switch(this.opts.alignY){case"bottom":case"inner-top":n.t=g+this.opts.offsetY;if(!n.arrow||this.opts.alignTo=="cursor"){n.arrow="top"}if(n.t+this.tipOuterH>k.t+k.h){n.t=i-this.tipOuterH-this.opts.offsetY;if(n.arrow=="top"){n.arrow="bottom"}}break;case"center":n.t=q-Math.floor(this.tipOuterH/2);if(n.t+this.tipOuterH>k.t+k.h){n.t=k.t+k.h-this.tipOuterH}else{if(n.t<k.t){n.t=k.t}}break;default:n.t=i-this.tipOuterH-this.opts.offsetY;if(!n.arrow||this.opts.alignTo=="cursor"){n.arrow="bottom"}if(n.t<k.t){n.t=g+this.opts.offsetY;if(n.arrow=="bottom"){n.arrow="top"}}}this.pos=n}};e.fn.poshytip=function(g){if(typeof g=="string"){return this.each(function(){var i=e(this).data("poshytip");if(i&&i[g]){i[g]()}})}var h=e.extend({},e.fn.poshytip.defaults,g);if(!e("#poshytip-css-"+h.className)[0]){e(['<style id="poshytip-css-',h.className,'" type="text/css">',"div.",h.className,"{visibility:hidden;position:absolute;top:0;left:0;}","div.",h.className," table, div.",h.className," td{margin:0;font-family:inherit;font-size:inherit;font-weight:inherit;font-style:inherit;font-variant:inherit;}","div.",h.className," td.tip-bg-image span{display:block;font:1px/1px sans-serif;height:",h.bgImageFrameSize,"px;width:",h.bgImageFrameSize,"px;overflow:hidden;}","div.",h.className," td.tip-right{background-position:100% 0;}","div.",h.className," td.tip-bottom{background-position:100% 100%;}","div.",h.className," td.tip-left{background-position:0 100%;}","div.",h.className," div.tip-inner{background-position:-",h.bgImageFrameSize,"px -",h.bgImageFrameSize,"px;}","div.",h.className," div.tip-arrow{visibility:hidden;position:absolute;overflow:hidden;font:1px/1px sans-serif;}","</style>"].join("")).appendTo("head")}return this.each(function(){new e.Poshytip(this,h)})};e.fn.poshytip.defaults={content:"[title]",className:"tip-yellow",bgImageFrameSize:10,showTimeout:500,hideTimeout:100,showOn:"hover",alignTo:"cursor",alignX:"right",alignY:"top",offsetX:-22,offsetY:18,allowTipHover:true,followCursor:false,fade:true,slide:true,slideOffset:8,showAniDuration:300,hideAniDuration:300}})(jQuery);

if (typeof ShiHui == "undefined" || !ShiHui) {
    var ShiHui = {version : '1.0', tipTimer: null, tipID: ''};
}
(function(){
	
	//变量
	ShiHui.Var = {
		StaticDomain : 'http://static.shihui.cn/',
		ImgDomain : 'http://img.shihui.cn/'
	};
	
	//公共方法
	ShiHui.Common = {
		trim:function (A){
			return A.replace(/(^\s*)|(\s*$)/g,"");
		},
		escapeHTML:function (B){
			var C=document.createElement("div");
			var A=document.createTextNode(B);
			C.appendChild(A);
			return C.innerHTML;
		},
		unescapeHTML:function (A){
			var B=document.createElement("div");
			B.innerHTML=A.replace(/<\/?[^>]+>/gi,"");
			return B.childNodes[0]?B.childNodes[0].nodeValue:"";
		},
		stripTags:function (A){
			return A.replace(/<\/?[^>]+>/gi,"");
		},
		toArray:function (B,D){
			var C=[];
			for(var A=D||0;A<B.length;A++){
				C[C.length]=B[A];
			}return C;
		},
		apply:function (C,A){
			if(C&&A&&typeof A=="object"){
				for(var B in A){
					C[B]=A[B];
				}
			}return C;
		},
		dateFormat:function(t){
			if(t < 10){
				t = '0' + t;	
			}
			return t;
		}
	};
	
	//工具方法
	ShiHui.Tools = {
		getCookie : function (name){
			var cookie=document.cookie.match("(?:^|;)\\s*" + name + "=([^;]*)");
			return cookie ? decodeURI(cookie[1]) : "";
		},
		setCookie : function (name,value,expires,domain,path){
			value = encodeURI(value);
			value += (domain) ? "; domain=" + domain : "";
			value += (path) ? "; path=" + path : "";
			if(expires){
				var expire=new Date();
				expire.setTime( expire.getTime() + (expires*1000) );
				value += "; expires="+expire.toGMTString();
			}
			document.cookie = name + "=" + value;
		},
		removeCookie : function (name){
			this.setCookie(name,"",-1);
		},
		isEmail : function(email){
			if (email.search(/[_a-zA-Z\d\-\.]+@[_a-zA-Z\d\-]+(\.[_a-zA-Z\d\-]+)+$/) != -1){
				return true;
			}else{
				return false;
			}
		},
		isHttp: function(s){
		    try{
		        return /(http:\/\/)?([\w-]+\.)+[\w-]+(\/[\w-\.\/?%&=]*)?/.test(s);
		    }catch(e){
		        return false;
		    }
		},
		isNumber : function(s){
		    try{
		        return /^\d+$/.test(s);
		    }catch(e){
		        return false;
		    }
		},
		Flash : function(url,width,height,var1) {
			document.write('<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=8,0,24,0" width="'+width+'" height="'+height+'">');
			document.write('<param name="movie" value="'+url+'" />');
			document.write('<param name="quality" value="high" />');
			document.write('<param name="flashVars" value="id='+var1+'" />');
			document.write('<param name="wmode" value="transparent" />');
			document.write('<param name="menu" value="false" />');
			document.write('<embed flashvars="id='+var1+'" src="'+url+'" wmode="transparent" quality="high" menu="false" pluginspage="http://www.macromedia.com/go/getflashplayer" type="application/x-shockwave-flash" width="'+width+'" height="'+height+'"></embed>');
			document.write('</object>');
		},
		AddFavorite : function(){
			try{
				window.external.addFavorite(window.location.href, document.title);
			}catch (e){
				try{
					window.sidebar.addPanel(document.title, window.location.href, "");
				}catch (e){
					alert("加入收藏失败，请使用Ctrl+D进行添加");
				}
			}
		}
	};
	//倒计时程序
	ShiHui.Timer = function(id, time){
		var leave = time * 1000;  
		var day = Math.floor(leave / (1000 * 60 * 60 * 24));
		var hour = Math.floor(leave / (1000 * 3600)) - (day * 24);
		var totHour =  Math.floor(leave / (1000 * 3600));
		var minute = Math.floor(leave / (1000 * 60)) - (day * 24 *60) - (hour * 60); 
		var second = Math.floor(leave / (1000)) - (day * 24 *60*60) - (hour * 60 * 60) - (minute * 60);
		day = ShiHui.Common.dateFormat(day);
		hour = ShiHui.Common.dateFormat(hour);
		totHour = ShiHui.Common.dateFormat(totHour);
		minute = ShiHui.Common.dateFormat(minute);
		second = ShiHui.Common.dateFormat(second);
		var timehtml = "<span>"+day+"</span>天<span>"+hour+"</span>时<span>"+minute+"</span>分<span>"+second+"</span>秒";
		time--;
		if(time>=0){setTimeout(function(){ShiHui.Timer(id, time); }, 1000);}
		$("#"+id).html(timehtml);
	};
	//miniajax显示内容
	ShiHui.MiniAjax = function(Control, Url, Data){
		if(typeof(Data) == undefined){
			var Data = '';	
		}
		$.ajax({url: Url, type: 'post', data: Data, dataType: 'json', success: function(){ }});
	};
	
	//页面部分动态元素
	ShiHui.PageInfo = {
		//购物车数量显示信息.
		CommonAjax : function(){
			var config = {
				url: '/ajax/common.php?is_ajax=1&t='+Date(),
				dataType: 'json',
				success: function(data){
					$("#CARTCOUNT").html(data.cart_count);
				}
			}
			$.ajax(config);
		},
		//通过cookie显示登录信息内容,以加快显示速度
		ShowMemberInfo : function(){
			var username = ShiHui.Tools.getCookie('sh_username');
			var userid = ShiHui.Tools.getCookie('sh_user_id');
			if(username && userid){
				$("#MEMBERINFO").html('您好&nbsp;<img src="'+ShiHui.Var.StaticDomain+'images/theme/smile.gif" border="0" align="absmiddle" />&nbsp;！<span style="color:#FF0000">'+username+'</span>，欢迎来到实惠商城购物<a href="/user.html?act=logout" title="退出商城"><img src="'+ShiHui.Var.StaticDomain+'images/theme/exit_login.gif" border="0" align="absmiddle" style="margin-left:5px;"/></a>');
			}else{
				$("#MEMBERINFO").html('<a href="/user.html?act=login" title="登录"><img src="'+ShiHui.Var.StaticDomain+'images/theme/to_login.gif" border="0" align="absmiddle" style="margin-right:20px;"/></a><a href="/user.html?act=register" target="_blank" title="注册实惠商城会员"><img src="'+ShiHui.Var.StaticDomain+'images/theme/to_reg.gif" border="0" align="absmiddle" style="margin-right:20px;"/></a>立即注册赠送300积分,享受积分换购！');
			}
			$("#MEMBERINFO").addClass('top_info_bd');
		}	
	};
	//迷你购物车
	ShiHui.MiniCart = {
		//加载数据
		Load : function(){
			$.getJSON('/ajax/minicart.php?d='+Date(), '', function(data){ $("#minicart").html(data.content); });
		},
		//显示购物车信息
		Show : function(){
			$("#cartIdbox").hover(
				function(){
					$("#cartIdtext").addClass('cart_text_on').removeClass('cart_text');
					if($("#minicart").html() != ""){
						$("#minicart").show();
					}
				},
				function(){
					$("#cartIdtext").addClass('cart_text').removeClass('cart_text_on');	
					$("#minicart").hide();
					ShiHui.hiddenTip();
				}
			);	
		},
		//删除提示
		Drop : function(rec_id){
			//ShiHui.tipShow({id: '#recid_'+rec_id, content: '确定要删除吗？', errorClass: 'tip-waring', alignX: 'left', alignY: 'center', offsetX: 5, timeout: 5000});
			$.ajax({
				url : '/ajax/minicart.php?action=drop_cart',
				data : 'id='+rec_id,
				type : 'post',
				dataType : 'json',
				success: function(data){
					$("#CARTCOUNT").html(data.count);
					$("#minicart").html(data.content); 
					//如果是购物车页面操作，刷新购物车
					if($("#pageCart").size() > 0){
						ShiHui.Cart.UpDataCart(0, 0);
					}
					//如果是订单信息填写页面，直接刷新页面
					if($("#pageFlow").size() > 0){
						window.location.href = '/flow.html?step=checkout';
					}
				}
			});
		}
	};
	
	//历史记录的商品
	ShiHui.HistoryShop = function(){
		
	};
	
	//添加商品到购物车
	ShiHui.AddToCart = function(goods_id, id, type){
		var attribute = ShiHui.checkAttribute();
		if(attribute[0] == false){
			 ShiHui.tipShow({id: id, content: '请选择'+attribute[1]+'！', errorClass: 'tip-error', alignX: 'center', alignY: 'top', offsetY: 5, timeout: 2000});
			 return false;
		}
		var g = new Object();
		g.goods = new Object();
		g.goods.goods_id = goods_id;
		g.goods.spec = ($("#goods_attr").val()).split(",");
		g.goods.number   = parseInt($("#goods_number").val());
		g.goods.parent   = (typeof(parentId) == "undefined") ? 0 : parseInt(parentId); //配件时.暂未定义
		ShiHui.tipShow({id: id, content: '正在加入购物车，请稍后...', alignY: 'bottom', errorClass: 'tip-waring', offsetY: 5, timeout:10000});
		$.ajax({
			url: '/flow.php?step=add_to_cart&t='+Date(),
			data: g,
			type: 'post',
			dataType: 'json',
			success: function(data){
				if(data.error > 0){
					alert(data.message);
					//ShiHui.tipShow({id: id, content: data.message, alignY: 'top', offsetY: 5, timeout: 2000});
					return;
				}else{
					if(typeof(type) != undefined && type == 'fast'){
						window.location.href = "/flow.html?step=checkout";
						return;	
					}else{
						$("#CARTCOUNT").html(data.number);//刷新头部购物车数量
						$("#cart-Total").html(data.number);
						$("#cart-Amount").html(data.amount);
						ShiHui.tipShow({id: id, content: $("#cart-buy-info-div").html(), alignY: 'bottom', offsetY: 5});
						ShiHui.MiniCart.Load();
						return;
					}
				}
			}
		});
	};
	//公共-添加到购物车
	ShiHui.toCart = function(goods_id, collect, tipId, is_miniattr, jump){
		var g = new Object();
		var tipID = (!tipId) ? '#buy-'+goods_id : tipId;
		var jp = (jump != 'undefined' && jump == true) ? true : false;
		g.goods = new Object();
		g.goods.goods_id = goods_id;
		g.goods.spec = new Array();
		g.goods.number   = 1;
		g.goods.parent   = 0; //配件时.暂未定义
		g.goods.tipid = tipID;
		g.goods.collect = collect;
		if(is_miniattr){
			var attribute = ShiHui.getAttributes();
			g.goods.spec = attribute.split(",");
		}else{
			ShiHui.tipShow({id: tipID, content: '正在加入购物车，请稍后...', errorClass: 'tip-waring', alignY: 'top', offsetY: 5, timeout: 5000});
		}
		$.ajax({
			url: '/flow.php?step=add_to_cart&t='+Date(),
			data: g,
			type: 'post',
			dataType: 'json',
			success: function(data){
				if(data.error > 0){
					if(data.select_spec){
						ShiHui.tipShow({id: tipID, content: data.message, alignY: 'top', offsetY: 5});
					}else{
						ShiHui.tipShow({id: tipID, errorClass: 'red', content: data.message, alignY: 'top', offsetY: 5, timeout: 5000});	
					}
					return;
				}else{
					if(jp == true){
						window.location.href = '/flow.html';	
					}
					$("#CARTCOUNT").html(data.number);//刷新头部购物车数量
					if(collect == true){ 
						ShiHui.Cart.UpDataCart(0, 0); 
						ShiHui.tipShow({id: tipID, content: '商品已成功添加到购物车。', errorClass: 'tip-success', alignY: 'top', offsetY: 5, timeout: 5000});
					}else{
						ShiHui.tipShow({id: tipID, content: data.message, errorClass: 'green', alignY: 'top', offsetY: 5, timeout: 5000});	
					}
					ShiHui.MiniCart.Load();
					return;
				}
			}
		});
	};
	//商品属性选择
	ShiHui.miniChooseAttribute = function($this, id, goods_id){
		$this.parent().addClass("selected").siblings().removeClass('selected');
		$("#spec_value_"+id).val($this.attr('id'));
		ShiHui.miniChangePrice(goods_id);
	};
	//取得所选属性
	ShiHui.getAttributes = function(){
		var attribute = [];
		$("input[id^=spec_value_]").each(function(){
			var val = $(this).val();
			if(val) attribute.push(val);
		});
		return attribute.join(",");
	};
	//更新商品价格
	ShiHui.miniChangePrice = function(goods_id){
		var attribute = ShiHui.getAttributes();
		$.ajax({
			url: '/goods.php',
			data: 'act=price&id='+goods_id+'&attr='+attribute+'&number=1',
			dataType: 'json',
			success: function(data){
				$("#min-price").html(data.result);
			}
		});
	};
	//快速订购
	ShiHui.FastBuy = function(goods_id, id){
		return ShiHui.AddToCart(goods_id, id, 'fast');
	};
	//收藏商品
	ShiHui.Collect = function(goods_id, id){
		var userid = ShiHui.Tools.getCookie('sh_user_id');
		if(!userid){ ShiHui.Tools.AddFavorite(); return; }
		$.ajax({
			url: '/user.php?act=collect&t='+Date(),
			data: 'id=' + goods_id,
			dataType: 'json',
			success: function(data){
				var er = '';
				if(data.error){
					data.message = data.message;
					er = 'tip-error';
				}else{
					data.message = data.message;
					er = 'tip-success';
				}
				ShiHui.tipShow({id: id, timeout: 2000, content: data.message, alignY: 'top', errorClass: er});
			}
		});
	};
	//首页友情链接
	ShiHui.friendLinkAutoScroll = function(obj) {
		$(obj).find("ul:first").animate({
			marginTop: "-22px"
		}, 500, function() {
			$(this).css({ marginTop: "0px" }).find("li:first").appendTo(this);
		});
	};
	//顶部滚动
	ShiHui.topHotScroll = function($this) {
		var $thisli = $($this).find("li:first");
		$thisli.animate({
			marginTop: "-30px"
		}, 500, function() {
			$thisli.css({ marginTop: "0px" }).appendTo($($this));
		});
	};
	//提示信息
	ShiHui.tipShow = function tipShow(option){
		if(!option.id){
			return false;
		}
		ShiHui.hiddenTip(ShiHui.tipID);
		option.className = (typeof(option.className) == 'undefined') ? 'tip-yellowsimple' : option.className;
		option.showOn = (typeof(option.showOn) == 'undefined') ? 'none' : option.showOn;
		option.alignTo = (typeof(option.alignTo) == 'undefined') ? 'target' : option.alignTo;
		option.alignX = (typeof(option.alignX) == 'undefined') ? 'center' : option.alignX;
		option.content = (typeof(option.errorClass) == 'undefined') ? option.content : '<div class="'+option.errorClass+'">'+option.content+'</div>';
		$(option.id).poshytip('destroy');
		$(option.id).poshytip(option);
		$(option.id).poshytip('show');
		ShiHui.tipID = option.id;
		if(option.timeout != undefined){
			clearInterval(ShiHui.tipTimer);
			ShiHui.tipTimer = setTimeout(function(){$(option.id).poshytip('hide'); }, option.timeout);
		}
	};
	//关闭提示信息
	ShiHui.hiddenTip = function(id){
		if(id == undefined || id == 'undefined'){
			id = ShiHui.tipID;	
		}
		$(id).poshytip('hide');
		$(id).poshytip('destroy');
		if(ShiHui.tipTimer){
			clearInterval(ShiHui.tipTimer);
		}
	};
})();

//自动加载
$(function(){
	ShiHui.PageInfo.CommonAjax();
});