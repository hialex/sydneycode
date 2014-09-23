<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>

	<title>饮食</title>

	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width,initial-scale=1" >
	<link rel="shortcut icon" href="../images/favicon.ico">
	<link rel="stylesheet" href="../css/jquery.mobile-1.4.4.css" >
	<link rel="stylesheet" href="../css/style.css">
	<link rel="stylesheet" href="../css/font-awesome.min.css" >
	<script src="../js/jquery.min.js" ></script>
	<script src="../js/jquery.mobile-1.4.4.min.js" ></script>
	<script src="../js/handlebars-v2.0.0.js"></script>
	<script>

		//显示加载器
		function showLoader() {
			//显示加载器.for jQuery Mobile 1.2.0
			$.mobile.loading('show', {
				text: '加载中...', //加载器中显示的文字
				textVisible: true, //是否显示文字
				theme: 'b',        //加载器主题样式a-e
				textonly: false,   //是否只显示文字
				html: ""           //要显示的html内容，如图片等
			});
		}

		//隐藏加载器.for jQuery Mobile 1.2.0
		function hideLoader()
		{
			//隐藏加载器
			$.mobile.loading('hide');
		}
		$(document).ready(function(){
			showLoader();
			var catalog1 = window.sessionStorage.getItem("catalog1");
			var catalog2 = window.sessionStorage.getItem("catalog2");
			var suburb = window.sessionStorage.getItem("suburb");
			var bh = window.sessionStorage.getItem("bh");
			var t = new Date().getTime();
			//初始化饮食分类
			$.ajax({
				type: "POST",
				dataType: "json",
				url: "http://202.102.41.153/sydneycode/mobile/MSearch.action",
				data: { "catalog1": catalog1, "catalog2": catalog2 ,"suburb":suburb,"bh":bh,"t":t},
				success: function(json) {
					var source="{{#all}}<li><a href=\"#\"><h4>{{shop_name}}</h4>" +
										"<p>" +
											"<i class=\"fa fa-location-arrow\"></i>&nbsp;{{suburb_name}}&nbsp;" +
										"</p>" +
										"<p>" +
											"{{#catalogs}}<i class=\"fa fa-tag\"></i>&nbsp;{{name}}&nbsp;&nbsp;{{/catalogs}}" +
										"</p>" +
									"</a>" +
								"</li>{{/all}}";
					var templete = Handlebars.compile(source);
					var data = json;
					console.log(data);
					$("#result").append(templete(data));

					$("#result").listview('refresh');
					hideLoader();

				}
			});
		});
	</script>
</head>

<body>
<div data-role="page">
	<div data-role="header">
		<div align="center"><img src="../images/logo.png"></div>
	</div>
	<div data-role="content">
		<ul style="margin: 0em 0em .5em 0em;" data-role="listview" data-inset="true" id="result">
		</ul>
	</div>
	<div data-role="footer" >
		<div id="footer"> &copy; Sydneycode.com.au 2014</div>
	</div>
</div>
</body>
</html>