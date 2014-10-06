var show_float_window = (ShiHui.Tools.getCookie("SHFLOATWINDOW") == true) ? false : true;
if(show_float_window){
	(function(){
		var d = art.dialog.defaults;
		d.skin = ['shihui'];
	})();
	var thefloatWindow;
	var oWid = 1;
	var tWid = 0;
	var WP = ["1", "2", "3", "4"];
	var oWtime = null;
	var show_text = '<div class="floatWindow">'
		+'<div class="close"><a onclick="javascript:closeFloatWindow();" style="cursor:pointer;">'
		+'<img src="http://static.shihui.cn/images/floatWindow/close.jpg" border="0" /></a></div>'
		+'<div><img src="http://static.shihui.cn/images/floatWindow/top.jpg" /></div>'
		+'<ul class="ibg">'
		+'<li id="lis1" onMouseOver="MPlay(0)" class="cur">唏哈烟膏</li>'
		+'<li id="lis2" onMouseOver="MPlay(1)">平板电脑</li>'
		+'<li id="lis3" onMouseOver="MPlay(2)">51放价</li>'
		+'<li id="lis4" onMouseOver="MPlay(3)">洞洞鞋</li>'
		+'</ul>'
		+'<ul class="tu">'
		+'<li id="tu1"><a href="/huodong/siihaa/?shihui_tag=floatwindow" target="_blank">'
		+'<img src="http://static.shihui.cn/images/floatWindow/a1.jpg?" /></a></li>'
		+'<li id="tu2" style="display:none;"><a href="/special/143.html?shihui_tag=floatwindow" target="_blank">'
		+'<img src="http://static.shihui.cn/images/floatWindow/a2.jpg" /></a></li>'
		+'<li id="tu3" style="display:none;"><a href="/special/175.html?shihui_tag=floatwindow" target="_blank">'
		+'<img src="http://static.shihui.cn/images/floatWindow/a3.jpg?v" /></a></li>'
		+'<li id="tu4" style="display:none;"><a href="/special/172.html?shihui_tag=index_tc" target="_blank">'
		+'<img src="http://static.shihui.cn/images/floatWindow/a4.jpg" /></a></li>'	
		+'</ul>'
		+'</div>';
}
//关闭弹窗
function closeFloatWindow(){
	thefloatWindow.close();
	return false;
}
//打开弹出窗
function dialogWindow(){
	ShiHui.Tools.setCookie("SHFLOATWINDOW", true, 4800);
	thefloatWindow = art.dialog({
		lock: false,
		time: 300,
		fixed: true,
		title: false,
		width:	310,
		height: 243,
		left: "right",
		top: "bottom",
		content: show_text
	});
	setTimeout("APlay()", 3000);
}
function addLoadEvents(){
	 var oldonload = window.onload;
	 if(typeof window.onload != 'function'){
		window.onload = function(){
			setTimeout("dialogWindow()", 30000);
	 	}
	 }else{
		window.onload = function(){
			oldonload(); 
			setTimeout("dialogWindow()", 30000);
		}
	 }
}
//播放广告
function Wplay(id){
	if(oWid == id){
		return false;
	}
	if(oWid == undefined || oWid == 'undefined' || oWid =='' ){
		oWid = 1;	
	}
	IDd("lis"+oWid).className = "";
	IDd("lis"+id).className = "cur";
	IDd("tu"+oWid).style.display = "none";
	IDd("tu"+id).style.display = "block";
	oWid = id;
}

//自动播放
function APlay(){
	if(WP.length <= 0){
		return false;
	}
	Wplay(WP[tWid]);
	if(tWid < (WP.length - 1)){
		tWid++;
	}else{
		tWid = 0;
	}
	oWtime = setTimeout('APlay()', 5000);
}
//手动播放
function MPlay(id){
	window.clearInterval(oWtime);
	tWid = id;
	APlay();
}

function IDd(id){
	return document.getElementById(id);
}
$(function(){
	if(!ShiHui.Tools.getCookie("SHFLOATWINDOW")){
		addLoadEvents();
	}	   
});