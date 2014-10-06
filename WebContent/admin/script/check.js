	var leafArray = new Array();
	function checkleaf(){
		if(form.name.value==""){
			document.form.name.focus();	
			document.getElementById("wrongname").innerHTML = "<font color = 'red'>不能为空</font>";
			return false;
		}
		if(leafArray[document.form.categoryId.selectedIndex] == "no"){
			//alert("请添加在子类里面！");
		//视频有问题 id 怎么不用写成Id
			document.form.categoryId.focus();	
			document.getElementById("wrongcategory").innerHTML = "<font color = 'red'>请添加在子类里面</font>";
			return false;
		}
		if(form.normalPrice.value==""){
			document.form.normalPrice.focus();	
			document.getElementById("wrongnormalPrice").innerHTML = "<font color = 'red'>不能为空</font>";
			return false;
		}
		if(form.memberPrice.value==""){
			document.form.memberPrice.focus();	
			document.getElementById("wrongmemberPrice").innerHTML = "<font color = 'red'>不能为空</font>";
			return false;
		}
		return true;
	}