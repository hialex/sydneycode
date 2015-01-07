function getQueryString(name) {
	var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
	var r = window.location.search.substr(1).match(reg);
	if (r != null) return unescape(r[2]); return null;
}

//js获取项目根路径，如： http://localhost:8083/uimcardprj
function getRootPath(){
	//获取当前网址，如： http://localhost:8083/uimcardprj/share/meun.jsp
	var curWwwPath=window.document.location.href;
	//获取主机地址之后的目录，如： uimcardprj/share/meun.jsp
	var pathName=window.document.location.pathname;
	var pos=curWwwPath.indexOf(pathName);
	//获取主机地址，如： http://localhost:8083
	var localhostPaht=curWwwPath.substring(0,pos);
	//获取带"/"的项目名，如：/uimcardprj
	var projectName=pathName.substring(0,pathName.substr(1).indexOf('/')+1);
	if(localhostPaht.indexOf("com")>0){
		return(localhostPaht);
	}else{
		return(localhostPaht+projectName);
	}

}

function renderTitle(photo){
	var name = photo.name;
	var intro = photo.intro;
	var add_time = photo.add_time;
	var author_name = photo.author_name;
	var s = "";
	if(name!=''){
		s += "<strong>"+name+"</strong> ";
	}
	if(author_name!=''){
		s += " By";
		s += author_name+" ";
	}
	s += "On ";
	s += add_time;
	if(intro!=''){
		s += "<br/>";
		s += intro;
	}
	return s;


}



