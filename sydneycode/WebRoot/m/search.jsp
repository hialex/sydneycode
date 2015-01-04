<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
  <head>
    
    <title>搜索</title>
    
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1" >
	<link rel="shortcut icon" href="images/favicon.ico">
    <link rel="stylesheet" href="css/jquery.mobile-1.4.4.css" >
	<link rel="stylesheet" href="css/style.css">
	<link rel="stylesheet" href="css/jqm-datebox-1.4.4.css">

	<link rel="stylesheet" href="css/font-awesome.min.css" >
	<link rel="stylesheet" href="css/iconfont/iconfont.css">

    <script src="js/jquery.min.js" ></script>
  	<script src="js/jquery.mobile-1.4.4.min.js" ></script>
	<script src="js/jquery.mobile.DateBox.js"></script>
	<script src="js/jqm-datebox.mode.customflip.min.js"></script>
	<script src="js/jquery.cookie.js"></script>

	<script src="../js/user.js"></script>
	<script>
		$(document).ready(function(){
			$("#noresult").hide();
		});
		function showLoader() {
			$.mobile.loading('show', {
				text: '加载中...', //加载器中显示的文字
				textVisible: true, //是否显示文字
				theme: 'b',        //加载器主题样式a-e
				textonly: false,   //是否只显示文字
				html: ""           //要显示的html内容，如图片等
			});
		}
		function hideLoader()
		{
			$.mobile.loading('hide');
		}

		$(document).on("pagecreate","#myPage",function(){
			var rootId = getQueryString("rootId");
			$("#autocomplete").on("filterablebeforefilter",function(e,data){
				var $ul = $(this),
					$input = $(data.input),
					value = $input.val(),
					html = "";
				$ul.html("");
				if(value && value.length>1){
					$("#noresult").show();
					$("#noresult").html('<i class="fa fa-spinner fa-spin"></i>&nbsp;正在搜索，请耐心等待...');
					$.ajax({
						type: "POST",
						dataType: "json",
						url: "../mobile/MShopNameSearch.action",
						data: { "rootId": rootId,"q":$input.val()}
					})
					.then(function(response){
						if(response.all.length==0){
							$("#noresult").html('<i class="fa fa-frown-o"></i>&nbsp;Oops..没有结果，可能是漏了空格哦~');
						}else{
							$("#noresult").hide();
							$.each(response.all,function(i,val){
								html += "<li><a data-ajax='false' href='detail.jsp?id="+val.id+"'>"+val.name+"</a></li>";
							});

						}
						$ul.html(html);
						$ul.listview("refresh");
						$ul.trigger("updatelayout");
					});
				}
			});
		});
	</script>
  </head>
  
  <body>
    <div data-role="page" id="myPage">
		<div data-role="header" id="header">
			<div id="link_l"><a href="#" onclick="history.back();" data-ajax="false"><i class="grey fa fa-arrow-circle-left "></i></a> </div>
			<div class="logo"><img src="images/logo.png" height="50px"></div>
		</div>
		<div data-role="content">
			<form class="ui-filterable"  data-filter-reveal="false">
				<input id="autocomplete-input" data-type="search" placeholder="输入商铺名称,至少2个字符">
			</form>
			<ul id="autocomplete" data-role="listview" data-inset="true" data-filter="true" data-input="#autocomplete-input"></ul>
			<div id="noresult" class="grey"></div>
		</div>
		<div data-role="footer" >
			<div id="copyright"> &copy; Sydneycode.com.au 2014</div>
		</div>
  	</div>
  </body>
</html>
