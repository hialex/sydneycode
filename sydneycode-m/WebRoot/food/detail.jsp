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
	<link rel="stylesheet" href="../css/jquery.bxslider.css">
	<link rel="stylesheet" href="../css/iconfont/iconfont.css">

	<script src="../js/jquery.min.js" ></script>
	<script src="../js/jquery.mobile-1.4.4.min.js" ></script>
	<script src="../js/user.js"></script>
	<script src="../js/mustache.js"></script>
	<script src="../js/jquery.bxslider.js"></script>
	<script>

		$(document).ready(function(){
			var id = getQueryString("id");
			showLoader();
			$.ajax({
				type: "POST",
				dataType: "json",
				//url: "http://202.102.41.153/m/food/data.json",
				url: "http://202.102.41.153/sydneycode/mobile/MShopDetail.action",
				data: { "id": id},
				success: function(json) {
					var shop_data = json.shop;
					var shop_catalog_data = json.catalog_names;
					//var shop_pics = json.pics;
					showShop(shop_data);
					showShopCatalog(json);
					showShopBH(json);
					if(json.pics.length>0){
						showShopPics(json);
					}
					hideLoader();
				}

			});
		});
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
		function hideLoader(){
			//隐藏加载器
			$.mobile.loading('hide');
		}
		function showShop(shop_data){
			/*ICON一行显示
			var source="<li><span id=\"shop_name\" class=\"shop_name\">{{name}}</span></li>"+
					"<li><span id=\"shop_addr\"><i class=\"grey fa fa-map-marker\"></i>&nbsp;&nbsp;{{addr}}</span></li>"+
					"<li><span id=\"shop_tel\"><i class=\"grey fa fa-phone\"></i>&nbsp;&nbsp;<a href=\"tel:{{tel}}\">{{tel}}</a></span></li>"+
					"<li><span id=\"shop_icon\">"+
						"{{#mobile}}<a href=\"javascript:showContact('mobile')\"><i class=\"grey fa fa-mobile fa-2x\"></i>&nbsp;</a>{{/mobile}}"+
						"{{#website}}<i class=\"grey fa fa-home fa-2x\"></i>&nbsp;{{/website}}"+
						"{{#email}}<i class=\"grey fa fa-envelope fa-2x\"></i>&nbsp;{{/email}}"+
						"{{#facebook}}<i class=\"grey fa fa-facebook fa-2x\"></i>&nbsp;{{/facebook}}"+
						"{{#twitter}}<i class=\"grey fa fa-twitter fa-2x\"></i>&nbsp;{{/twitter}}"+
						"{{#weibo}}<i class=\"grey fa fa-weibo fa-2x\"></i>&nbsp;{{/weibo}}"+
						"{{#qq}}<i class=\"grey fa fa-qq fa-2x\"></i>&nbsp;{{/qq}}"+
						"{{#weixin}}<i class=\"grey fa fa-weixin fa-2x\"></i>&nbsp;{{/weixin}}"+
						"{{#instagram}}<i class=\"grey fa fa-instagram fa-2x\"></i>&nbsp;{{/instagram}}"+
						"{{#youtube}}<i class=\"grey fa fa-youtube fa-2x\"></i>&nbsp;{{/youtube}}"+
						"</span>"+
						"</li>"
					;
			*/
			var source="<li><span id=\"shop_name\" class=\"shop_name\">{{name}}</span></li>"+
							"{{#intro}}<li><i class=\"grey fa fa-bullhorn \"></i><span id=\"shop_addr\" class=\"wrap\">{{intro}}</span></li>{{/intro}}"+
							"<li><i class=\"grey fa fa-map-marker\"></i><span id=\"shop_addr\" class=\"wrap\">{{addr}}</span></li>"+
							"<li><i class=\"grey fa fa-phone\"></i><span id=\"shop_icon\" class=\"wrap\"><a href=\"tel:{{tel}}\">{{tel}}</a></span></li>"+
							"{{#mobile}}<li><i class=\"grey fa fa-phone\"></i><span id=\"shop_icon\" class=\"wrap\"><a href=\"tel:{{mobile}}\">{{mobile}}</a></span></li>{{/mobile}}"+
							"{{#website}}<li><i class=\"grey fa fa-home\"></i><span id=\"shop_icon\" class=\"wrap\"><a href=\"{{website}}\">{{website}}</a></span></li>{{/website}}"+
							"{{#email}}<li><i class=\"grey fa fa-envelope\"></i><span id=\"shop_icon\" class=\"wrap\"><a href=\"mailto:{{email}}\">{{email}}</a></span></li>{{/email}}"+
							"{{#facebook}}<li><i class=\"grey fa fa-facebook\"></i><span id=\"shop_icon\" class=\"wrap\"><a href=\"{{facebook_link}}\">{{facebook}}</a></span></li>{{/facebook}}"+
							"{{#twitter}}<li><i class=\"grey fa fa-twitter\"></i><span id=\"shop_icon\" class=\"wrap\"><a href=\"{{twitter_link}}\">{{twitter}}</a></span></li>{{/twitter}}"+
							"{{#weibo}}<li><i class=\"grey fa fa-weibo\"></i><span id=\"shop_icon\" class=\"wrap\"><a href=\"{{weibo_link}}\">{{weibo}}</a></span></li>{{/weibo}}"+
							"{{#qq}}<li><i class=\"grey fa fa-qq\"></i><span id=\"shop_icon\" class=\"wrap\">{{qq}}</span></li>{{/qq}}"+
							"{{#weixin}}<li><i class=\"grey fa fa-weixin\"></i><span id=\"shop_icon\" class=\"wrap\">{{weixin}}</span></li>{{/weixin}}"+
							"{{#momo}}<li><i class=\"grey icon iconfont\">&#xe626;</i><span id=\"shop_icon\" class=\"wrap\">{{momo}}</span></li>{{/momo}}"+
							"{{#instagram}}<li><i class=\"grey fa fa-instagram\"></i><span id=\"shop_icon\" class=\"wrap\"><a href=\"{{instagram_link}}\">{{instagram}}</a></span></li>{{/instagram}}"+
							"{{#youtube}}<li><i class=\"grey fa fa-youtube\"></i><span id=\"shop_icon\" class=\"wrap\"><a href=\"{{youtube_link}}\">{{youtube}}</a></span></li>{{/youtube}}";
			$('#shop_info').append(Mustache.render(source,shop_data));
			$('#shop_info').listview('refresh');
		}


		//显示分类信息
		function showShopCatalog(json){
			var source="<li data-role=\"list-divider\"><span ><strong>Tags</strong></span></li>"+
					"<li>{{#catalog_names}}<span id=\"shop_tag\"><i class=\"grey fa fa-tag\"></i>&nbsp;{{name}}</span>{{/catalog_names}}</li>";
			$('#shop_catalog_info').append(Mustache.render(source,json));
			$('#shop_catalog_info').listview('refresh');
		}

		//显示商铺照片
		function showShopPics(json){
			var source="<ul style=\"margin-bottom: 2em;\" id=\"shop_pics\" class=\"bxslider\">{{#pics}}<li><img src=\"{{name}}\"/> </li>{{/pics}}</ul>";
			$("#detail").append(Mustache.render(source,json));
			$(".bxslider").bxSlider({
				controls:false
			});

		}

		//显示营业时间
		function showShopBH(json){
			bh_data = json.bussiness_hours;
			$(bh_data).each(function(n,bh) {
				if (bh.weekday === 1) {
					if (bh.is_open) {
						if (bh.is_need_book) {
							$("#mon").append('By Appointment');
						} else {
							$("#mon").append(bh.start_time + '~' + bh.end_time +'&nbsp;&nbsp;');
						}
					} else {
						$("#mon").append('CLOSED');
					}
				}
			});
			$(bh_data).each(function(n,bh) {
				if(bh.weekday==2){
					if(bh.is_open){
						if(bh.is_need_book){
							$("#tues").append('By Appointment');
						}else{
							$("#tues").append(bh.start_time+'~'+bh.end_time +'&nbsp;&nbsp;');
						}
					}else{
						$("#tues").append('CLOSED');
					}
				}
			});
			$(bh_data).each(function(n,bh) {
				if(bh.weekday==3){
					if(bh.is_open){
						if(bh.is_need_book){
							$("#wed").append('By Appointment');
						}else{
							$("#wed").append(bh.start_time+'~'+bh.end_time +'&nbsp;&nbsp;');
						}
					}else{
						$("#wed").append('CLOSED');
					}
				}
			});
			$(bh_data).each(function(n,bh) {
				if(bh.weekday==4){
					if(bh.is_open){
						if(bh.is_need_book){
							$("#thur").append('By Appointment');
						}else{
							$("#thur").append(bh.start_time+'~'+bh.end_time +'&nbsp;&nbsp;');
						}
					}else{
						$("#thur").append('CLOSED');
					}
				}
			});
			$(bh_data).each(function(n,bh) {
				if(bh.weekday==5){
					if(bh.is_open){
						if(bh.is_need_book){
							$("#fri").append('By Appointment');
						}else{
							$("#fri").append(bh.start_time+'~'+bh.end_time +'&nbsp;&nbsp;');
						}
					}else{
						$("#fri").append('CLOSED');
					}
				}
			});
			$(bh_data).each(function(n,bh) {
				if(bh.weekday==6){
					if(bh.is_open){
						if(bh.is_need_book){
							$("#sat").append('By Appointment');
						}else{
							$("#sat").append(bh.start_time+'~'+bh.end_time +'&nbsp;&nbsp;');
						}
					}else{
						$("#sat").append('CLOSED');
					}
				}
			});
			$(bh_data).each(function(n,bh) {
				if(bh.weekday==7){
					if(bh.is_open){
						if(bh.is_need_book){
							$("#sun").append('By Appointment');
						}else{
							$("#sun").append(bh.start_time+'~'+bh.end_time +'&nbsp;&nbsp;');
						}
					}else{
						$("#sun").append('CLOSED');
					}
				}

			});
		}


	</script>
</head>

<body>
<div data-role="page">
	<div data-role="header">
		<div align="center"><img src="../images/logo.png"></div>
	</div>
	<div data-role="content" class="detail" id="detail">

		<ul style="margin-bottom: 2em;"  data-role="listview" id="shop_info">
		</ul>
		<ul style="margin-bottom: 2em;"  data-role="listview" id="shop_catalog_info">
		</ul>
		<ul style="margin-bottom: 2em;"  data-role="listview" id="shop_bh_info">
			<li data-role="list-divider"><span ><strong>营业时间</strong></span></li>
			<li><i class="grey fa fa-calendar"></i>&nbsp;星期一：<span id="mon"></span></li>
			<li><i class="grey fa fa-calendar"></i>&nbsp;星期二：<span id="tues"></span></li>
			<li><i class="grey fa fa-calendar"></i>&nbsp;星期三：<span id="wed"></span></li>
			<li><i class="grey fa fa-calendar"></i>&nbsp;星期四：<span id="thur"></span></li>
			<li><i class="grey fa fa-calendar"></i>&nbsp;星期五：<span id="fri"></span></li>
			<li><i class="grey fa fa-calendar"></i>&nbsp;星期六：<span id="sat"></span></li>
			<li><i class="grey fa fa-calendar"></i>&nbsp;星期日：<span id="sun"></span></li>
		</ul>

	</div>
	<div data-role="footer">
		<div id="copyright"> &copy; Sydneycode.com.au 2014</div>
	</div>
</div>
</body>
</html>