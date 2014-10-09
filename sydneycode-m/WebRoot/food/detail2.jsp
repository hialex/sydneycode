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
	<link rel="stylesheet" href="../css/scrollbar.css">
	<script src="../js/jquery.min.js" ></script>
	<script src="../js/jquery.mobile-1.4.4.min.js" ></script>
	<script src="../js/user.js"></script>
	<script>
		$(document).ready(function(){
			var id = getQueryString("id");
			$.ajax({
				type: "POST",
				dataType: "json",
				url: "http://202.102.41.153/sydneycode/mobile/MShopDetail.action",
				data: { "id": id},
				success: function(json) {
					$("#shop_name").html(json.shop.name);
					$("#shop_addr").html('<i class=\"grey fa fa-map-marker\"></i>&nbsp;&nbsp;'+json.shop.addr);
					$("#shop_tel").html('<i class=\"grey fa fa-phone\"></i>&nbsp;&nbsp;<a href=\"tel:'+json.shop.tel+'\">'+json.shop.tel+'</a>');
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
	<div data-role="content" class="detail">
		<ul style="margin-bottom: 2em;"  data-role="listview">
			<li><span id="shop_name" class="shop_name"></span></li>
			<li><span id="shop_addr"></span></li>
			<li><span id="shop_tel"></span></li>
			<li><span id="shop_icon">
					<i class="grey fa fa-qq fa-2x"></i>&nbsp;
					<i class="grey fa fa-twitter fa-2x"></i>&nbsp;
					<i class="grey fa fa-instagram fa-2x"></i>&nbsp;
					<i class="grey fa fa-youtube fa-2x"></i>&nbsp;
					<i class="grey fa fa-facebook fa-2x"></i>&nbsp;
					<i class="grey fa fa-weibo fa-2x"></i>&nbsp;
					<i class="grey fa fa-weixin fa-2x"></i>&nbsp;
				</span>
			</li>
		</ul>
		<ul style="margin-bottom: 2em;"  data-role="listview">
			<li>基础信息</li>
			<li>基础信息</li>
		</ul>
		<ul style="margin-bottom: 2em;"  data-role="listview">
			<li>基础信息</li>
			<li>基础信息</li>
		</ul>
		<ul style="margin-bottom: 2em;"  data-role="listview">
			<li>基础信息</li>
			<li>基础信息</li>
		</ul>

	</div>
	<div data-role="footer">
		<div id="copyright"> &copy; Sydneycode.com.au 2014</div>
	</div>
</div>
</body>
</html>