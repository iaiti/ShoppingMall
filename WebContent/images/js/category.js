// JavaScript Document
<!--
function show_child_category(obj, id){
	var show_id = document.getElementById("dt"+id+"_dd");
	
	if (show_child_category.timer) clearTimeout(show_child_category.timer);
	hideCur();
    obj.className = "h2cur";
	show_id.style.display="block";
	show_child_category.cur = show_id;
	show_child_category.objs = obj;
	show_id.onmouseout = hide;
	obj.onmouseout=hide;
	
	//判断鼠标是否停留在层上



	if(!show_id.isCreate){
		show_id.isCreate = true;
		show_id.onmouseover = function () {
            if (show_child_category.timer) clearTimeout(show_child_category.timer);
			hideCur();
			obj.className = "h2cur";
            show_id.style.display = 'block';
        };
	}
	//失去焦点一秒后关闭菜单
	function hide () {
            show_child_category.timer = setTimeout(function () {obj.className = "h2on"; show_id.style.display = 'none';}, 0);
    	}
	//切换时直接关闭上一菜单
	function hideCur () {
		show_child_category.cur && (show_child_category.cur.style.display = 'none') && (show_child_category.objs.className="h2on");
	}
}

/* 新版左侧导航切换 */
function ChangCategory(id){
	if(id == 1){
		$$_("categorys").className = "category_bt";
		$$_("brands").className = "category_bt_cur";
		$$_("categorylist").style.display = "none";
		$$_("brandlist").style.display = "block";
		$$_("alls").href = '/brands.html';
	}else{
		$$_("categorys").className = "category_bt_cur";
		$$_("brands").className = "category_bt";
		$$_("categorylist").style.display = "block";
		$$_("brandlist").style.display = "none";	
		$$_("alls").href = '/allcate.html';
	}
}
function $$_(id){

	return document.getElementById(id);

}
//function AutoScroll(obj) {
//		$(obj).find("ul:first").animate({
//		marginTop: "-100px"
//		}, 1000, function() {
//		$(this).css({ marginTop: "14px" }).find("li:first").appendTo(this);
//		});	
//}
$(document).ready(function() {
	var page = 1;
	var i = 5;
	var len = $('#blist li').size();
	if(is_index){
		var pageCount = Math.ceil(len / 5);
		var none_unit_height = 570;	
	}else{
		var pageCount = Math.ceil(len / 8);
		var none_unit_height = 908;	
	}
	//var blistTime;
	var $parent = $('#blist ul');
	//$("#brands").click(function(){
//		clearInterval(blistTime);
//		blistTime = setInterval("AutoScroll('#blist')", 2000);
//	});
	$('#btop').click(function() {
		//clearInterval(blistTime);
		if (!$parent.is(':animated')) {
			if (page == pageCount) {
				$parent.animate({marginTop:'0px'},500);
				page=1;
			}else {
				$parent.animate({marginTop:'-=' + 

none_unit_height+'px'},500);
				page++;
			}
		}
	});
	$('#bfoot').click(function() {
		//clearInterval(blistTime);					   
		if (!$parent.is(':animated')) {
			if (page == 1) {
				$parent.animate({marginTop:'-=' + none_unit_height * 

(pageCount - 1)},800);
				page=pageCount;
			}else {
				$parent.animate({marginTop:'+=' + none_unit_height },800);
				page--;
			}
		}
		//blistTime = setInterval("AutoScroll('#blist')", 2000);
	});	
});
//-->
