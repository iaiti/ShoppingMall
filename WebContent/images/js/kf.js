var url = window.location.href;
var u1 = url.substr(0,10);
var u2 = url.substr(0,3);
var u3 = url.substr(0, 9);
var u4 = url.substr(0, 2);
if(u1 != "http://cps" && u2 != "cps" && u3 != "http://un" && u4 != "un"){
	if(!hidekf || hidekf == undefined || hidekf == 'undefined'){
	document.write("<scr"+"ipt language=\"javascript\" src=\"http://www.53kf.com/kf.php?arg=kabaosun&style=1&keyword="+escape(document.referrer)+"\"></scr"+"ipt>");
	}
	 var onchat=1;
	document.write("<scr"+"ipt language=\"javascript\" src=\""+ShiHui.Var.StaticDomain+"js/float_online_chat.js\"></scr"+"ipt>");
}