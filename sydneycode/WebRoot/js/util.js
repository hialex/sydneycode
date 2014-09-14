function toIntroHTML(id){
	var getValue = $('#'+id).val();
	var endVlaue = (getValue.replace(/ /gi,"&nbsp;")).replace(/\n/gi,"<br>");
	return endVlaue;
}

function toTelHTML(id){
	var getValue = $('#'+id).val();
	var endVlaue = getValue.replace(/,/gi,"<br>");
	return endVlaue;
}