function scrollDoor1(){ 
} 
scrollDoor1.prototype = { 
    sd1 : function(menus,divs,openClass,closeClass, _type){ 
        var _this = this;
        if(menus.length != divs.length) 
        { 
            alert("菜单层数量和内容层数量不一样!"); 
            return false; 
        }                 
        for(var i = 0 ; i < menus.length ; i++) 
        {     
            _this._$(menus[i]).value = i;
			if(_type == 1){
				_this._$(menus[i]).onmouseover= function(){ 
                     
                	for(var j = 0 ; j < menus.length ; j++) 
                	{                         
                    	_this._$(menus[j]).className = closeClass; 
                    	_this._$(divs[j]).style.display = "none"; 
                	} 
               		_this._$(menus[this.value]).className = openClass;     
               		_this._$(divs[this.value]).style.display = "block";                 
           
				}
			}else{
				_this._$(menus[i]).onclick= function(){ 
                     
                	for(var j = 0 ; j < menus.length ; j++) 
                	{                         
                    	_this._$(menus[j]).className = closeClass; 
                    	_this._$(divs[j]).style.display = "none"; 
                	} 
               		_this._$(menus[this.value]).className = openClass;     
               		_this._$(divs[this.value]).style.display = "block";                 
           
				}	
			}
        } 
        }, 
    _$ : function(oid){ 
        if(typeof(oid) == "string") 
        return document.getElementById(oid); 
        return oid; 
    } 
	
} 