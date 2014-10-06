//cnzz统计
document.writeln('<script src="http://s13.cnzz.com/stat.php?id=1451602&web_id=1451602&show=pic" language="JavaScript"></script>');
//google统计
var _gaq = _gaq || [];
_gaq.push(['_setAccount', 'UA-15948162-1']);
_gaq.push(['_trackPageview']);
(function() {
	var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
	ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
	var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
})();
//百度统计
var _bdhmProtocol = (("https:" == document.location.protocol) ? " https://" : " http://");
document.write(unescape("%3Cscript src='" + _bdhmProtocol + "hm.baidu.com/h.js%3Faabf45dfe055989743fbec9020c799ed' type='text/javascript'%3E%3C/script%3E"));
//CNZZ专题统计
var bottom_this_url = location.href;
if(bottom_this_url.indexOf("/special/") > -1){ //仅跟踪专题页面
	if(bottom_this_url.indexOf("shihui_tag=uusee") > -1 || bottom_this_url.indexOf("shihui_tag=xunlei") > -1 || bottom_this_url.indexOf("shihui_tag=yitian") > -1){
	document.write("<scr"+"ipt src=\"http://s11.cnzz.com/stat.php?id=2101614&web_id=2101614&show=pic\" language=\"JavaScript\"></scr"+"ipt>");
	}
}
//站内受访页面统计
document.writeln('<script language="javascript" type="text/javascript" src="/shtd_stat.php"></script>');