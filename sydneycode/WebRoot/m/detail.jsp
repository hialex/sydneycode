<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>

	<title>店铺详情</title>

	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width,initial-scale=1" >
	<link rel="shortcut icon" href="images/favicon.ico">
	<link rel="stylesheet" href="css/jquery.mobile-1.4.4.css" >
	<link rel="stylesheet" href="css/style.css">
	<link rel="stylesheet" href="css/font-awesome.min.css" >
	<link rel="stylesheet" href="css/jquery.bxslider.css">
	<link rel="stylesheet" href="css/iconfont/iconfont.css">

	<script src="js/jquery.min.js" ></script>
	<script src="js/jquery.mobile-1.4.4.min.js" ></script>
	<script src="../js/user.js"></script>
	<script src="js/mustache.js"></script>
	<script src="js/jquery.bxslider.js"></script>
	<script src="../js/base64.js"></script>
	<script src="../js/jquery.nailthumb.min.js"></script>
	<script>

		$(document).ready(function(){
			var id = getQueryString("id");
			var shop_name;
			var root_catalog_id;
			$('#shop_photos').hide();
			showLoader();
			$.ajax({
				type: "POST",
				dataType: "json",
				url: "../mobile/MShopDetail.action",
				data: { "id": id},
				success: function(json) {
					var shop_data = json.shop;
					//var shop_catalog_data = json.catalog_names;
					shop_name = shop_data.name;
					root_catalog_id = shop_data.root_catalog_id;
					showShop(shop_data);
					if(shop_data.is_takeout){
						$("#shop_bh_info").hide();
					}else{
						showShopBH(json);
					}
					if(json.photos.length>0){
						$('#shop_photos').show();
						showShopPhotos(json);
					}else{
						$('#shop_photos').hide();
					}
					hideLoader();
				}

			});

			$("#btn_fans_share").click(function(){
				window.location.href ="upload.jsp?id="+id+"&root_catalog_id="+root_catalog_id+"&name="+new Base64().encode(shop_name);
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
		//GoogleMap搜索地址
		function googlemap(){
			var addr = $("#shop_addr").text();
			window.location.href='https://www.google.com/maps/search/'+addr;
		}

		function showShop(shop_data){
			//console.log(shop_data);
			$("#shop_info").append();
			var s = "";
			if(shop_data.hasOwnProperty("name")){
				s+="<li><span id=\"shop_name\" class=\"shop_name\">"+shop_data.name+"</span></li>";
			}
			if(shop_data.hasOwnProperty("intro")&&shop_data.intro){
				s+="<li><i class=\"grey fa fa-bullhorn \"></i><span id=\"shop_intro\" class=\"wrap\">"+shop_data.intro+"</span></li>";
			}
			if(shop_data.hasOwnProperty("takeout_time")&&shop_data.takeout_time){
				s+="<li><i class=\"grey fa fa-clock-o \"></i><span id=\"shop_takeout_time\" class=\"wrap\">"+shop_data.takeout_time+"</span></li>";
			}
			if(shop_data.hasOwnProperty("takeout_route")&&shop_data.takeout_route){
				s+="<li><i class=\"grey fa fa-bicycle \"></i><span id=\"shop_takeout_route\" class=\"wrap\">"+shop_data.takeout_route+"</span></li>";
			}
			if(shop_data.hasOwnProperty("addr")&&shop_data.addr){
				s+="<li><i class=\"grey fa fa-map-marker\"></i><span id=\"shop_addr\" class=\"wrap\">"+shop_data.addr+"<a href=\"javascript:googlemap();\" data-ajax=\"false\">&nbsp;&nbsp;<i class=\"grey fa fa-search \"></i></a></span></li>";
			}
			if(shop_data.hasOwnProperty("tel")&&shop_data.tel){
				var tels = shop_data.tel;
				tels = tels.replace(/\ +/g,"");
				var arr_tel = tels.split("/");
				$.each(arr_tel,function(index,tel){
					s+="<li><i class=\"grey fa fa-phone\"></i><span id=\"shop_icon\" class=\"wrap\"><a href=\"tel:"+tel+"\">"+tel+"</a></span></li>";
				});
			}
			if(shop_data.hasOwnProperty("mobile")&&shop_data.mobile){
				s+="<li><i class=\"grey fa fa-mobile fa-2x\"></i><span id=\"shop_icon\" class=\"wrap\"><a href=\"tel:"+shop_data.mobile+"\">"+shop_data.mobile+"</a></span></li>";
			}
			if(shop_data.hasOwnProperty("website")&&shop_data.website){
				s+="<li><i class=\"grey fa fa-home\"></i><span id=\"shop_icon\" class=\"wrap\"><a href=\""+shop_data.website+"\">"+shop_data.website+"</a></span></li>";
			}
			if(shop_data.hasOwnProperty("email")&&shop_data.email){
				s+="<li><i class=\"grey fa fa-envelope\"></i><span id=\"shop_icon\" class=\"wrap\"><a href=\"mailto:"+shop_data.email+"\">"+shop_data.email+"</a></span></li>";
			}
			if(shop_data.hasOwnProperty("facebook")&&shop_data.facebook){
				s+="<li><i class=\"grey fa fa-facebook\"></i><span id=\"shop_icon\" class=\"wrap\"><a href=\""+shop_data.facebook_link+"\">"+shop_data.facebook+"</a></span></li>";
			}
			if(shop_data.hasOwnProperty("twitter")&&shop_data.twitter){
				s+="<li><i class=\"grey fa fa-twitter\"></i><span id=\"shop_icon\" class=\"wrap\"><a href=\""+shop_data.twitter_link+"\">"+shop_data.twitter+"</a></span></li>";
			}
			if(shop_data.hasOwnProperty("weibo")&&shop_data.weibo){
				s+="<li><i class=\"grey fa fa-weibo\"></i><span id=\"shop_icon\" class=\"wrap\"><a href=\""+shop_data.weibo_link+"\">"+shop_data.weibo+"</a></span></li>";
			}
			if(shop_data.hasOwnProperty("qq")&&shop_data.qq){
				s+="<li><i class=\"grey fa fa-qq\"></i><span id=\"shop_icon\" class=\"wrap\">"+shop_data.qq+"</span></li>";
			}
			if(shop_data.hasOwnProperty("weixin")&&shop_data.weixin){
				s+="<li><i class=\"grey fa fa-weixin\"></i><span id=\"shop_icon\" class=\"wrap\">"+shop_data.weixin+"</span></li>";
			}
			if(shop_data.hasOwnProperty("momo")&&shop_data.momo){
				s+="<li><i class=\"grey icon iconfont\">&#xe626;</i><span id=\"shop_icon\" class=\"wrap\">"+shop_data.momo+"</span></li>";
			}
			if(shop_data.hasOwnProperty("instagram")&&shop_data.instagram){
				s+="<li><i class=\"grey fa fa-instagram\"></i><span id=\"shop_icon\" class=\"wrap\"><a href=\""+shop_data.instagram_link+"\">"+shop_data.instagram+"</a></span></li>";
			}
			if(shop_data.hasOwnProperty("youtube")&&shop_data.youtube){
				s+="<li><i class=\"grey fa fa-youtube\"></i><span id=\"shop_icon\" class=\"wrap\"><a href=\""+shop_data.youtube_link+"\">"+shop_data.youtube+"</a></span></li>";
			}

			$('#shop_info').append(s);
			$('#shop_info').listview('refresh');
		}

		
		//显示商铺照片
		function showShopPhotos(json){
			var s = "";
			var root_catalog_id = json.shop.root_catalog_id;
			var shop_name = new Base64().encode(json.shop.name);
			//alert(root_catalog_id);
			$.each(json.photos,function(index,photo){
				s+="<div class=\"slide\"><a data-ajax='false' href=\"gallery.jsp?shop_id="+photo.shop_id+"&root_catalog_id="+root_catalog_id+"&shop_name="+shop_name+"\"><img src=\""+getRootPath()+"/upload/thumb/"+photo.filename +"\"   title=\""+photo.name+"\"></a></div>"
			});
			s+="";
			$("#shop_photos").html(s);
			$(".slide img").nailthumb({height:100});
			$(".bxslider").bxSlider({
				slideWidth:100,
				minSlides:2,
				maxSlides:10,
				slideMargin:5,
				captions:true,
				infiniteLoop:false,
				hideControlOnEnd:true
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
	<style>
		.slide img{
			left:0px !important;
		}
	</style>
</head>

<body>
<div data-role="page">
	<div data-role="header" id="header">
		<div id="link_l"><a href="#" onclick="history.back();" data-ajax="false"><i class="grey fa fa-arrow-circle-left "></i></a> </div>
		<div id="link_r"><a href="index.jsp" data-ajax="false"><i class="grey fa fa-home "></i></a></div>
		<div class="logo"><img src="images/logo.png" height="50px"></div>
	</div>
	<div data-role="content"  id="detail">

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
		<div id="div_photos" style="margin: .5em;">
			<div  id="shop_photos" class="bxslider">

			</div>
			<button class="ui-btn ui-corner-all" id="btn_fans_share"><i class="grey fa fa-photo"></i> 我来晒图</button>
		</div>
	</div>
	<div data-role="footer">
		<div id="copyright"> &copy; Sydneycode.com.au 2014</div>
	</div>
</div>
</body>
</html>