// JavaScript Document
//获取参数
function getUrlParam(name){
	nk="";
	var reg=new RegExp("(^|&)"+name+"=([^&]*)(&|$)");
	var r=window.location.search.substr(1).match(reg);
	if (r!=null) return unescape(r[2]);return nk;
}
var TAGS = getUrlParam("shihui_tag");
var UIDS = getUrlParam("uid");
document.write('<script src="http://www.shihui.cn/js.php?act=cookie&tag=' + TAGS + '&uid='+ UIDS +'"></script>');