<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>

	<title>查看图片</title>

	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width,initial-scale=1" >
	<link rel="shortcut icon" href="images/favicon.ico">
	<link rel="stylesheet" href="css/jquery.mobile-1.4.4.css" >
	<link rel="stylesheet" href="css/style.css">
	<link href="../css/jquery.fancybox.css" type="text/css" rel="stylesheet" />

	<link rel="stylesheet" href="css/font-awesome.min.css" >
	<script src="js/jquery.min.js" ></script>
	<script src="js/jquery.mobile-1.4.4.min.js" ></script>
	<script src="../js/user.js"></script>
	<script src="../js/base64.js"></script>
	<script type="text/javascript" src="../js/jquery.fancybox.js"></script>
	<script type="text/javascript" src="../js/jquery.nailthumb.min.js"></script>
	<script>

		$(document).on("pagecreate","#page1",function(){
			var shop_id = getQueryString("shop_id");
			var shop_name = new Base64().decode(getQueryString("shop_name"));
			var root_catalog_id = getQueryString("root_catalog_id");
			$('#shop_name').html(shop_name);
			showLoader();
			$.ajax({
				type: "POST",
				dataType: "json",
				url: "../mobile/MPhoto!list.action",
				data: { "shop_id": shop_id,"root_catalog_id":root_catalog_id},
				success: function(json) {
					var s = ['<div data-role="navbar"><ul>'];
					var i = -1;
					var btn_id = "";
					$.each(json.category,function(index,category){
						if(category.default_display){
							i = index;
							btn_id = "btn-"+category.id;
						}
						s.push('<li><a id="btn-'+category.id+'" href="#category-'+category.id+'" data-ajax="false" data-theme="a">'+category.name+'</a></li>');
					});
					s.push('</ul></div>');
					$.each(json.category,function(index,category){
						s.push('<div id="category-'+category.id+'" class="ui-body-d ui-content photoarea"></div>');
					});
					$('#tabs').html(s.join('')).trigger('create');

					$('#tabs').tabs("refresh");
					$('#tabs').tabs("option","active",i);
					$('#'+btn_id+'').addClass("ui-btn-active");
					//显示图片
					showPhotos(json);
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

		function showPhotos(json){
			$.each(json.category,function(index,category){
				$('#category-'+category.id).append('<div id="official-category-'+category.id+'" class="ui-body ui-body-a ui-corner-all header"></div><div id="fans_share" class="ui-corner-all custom-corners "><div class="ui-bar ui-bar-a"><h4>网友晒图</h4></div><div id="fans-category-'+category.id+'" class="ui-body ui-body-a header"></div></div>');
				var json_fans = "fans_"+category.id;
				var json_official = "official_"+category.id;
				if(json[json_official].length>0){
					var s = "";
					$.each(json[json_official],function(index_official,photo_official){
						//s += '<img src="'+getRootPath()+'/upload/thumb/'+photo_official.filename+'">';
						s += '<a class="fancybox" rel="official-gallery-'+category.id+'" href="'+getRootPath()+'/upload/'+photo_official.filename+'"><img src="'+getRootPath()+'/upload/thumb/'+photo_official.filename+'" alt="" /></a>';
					});
					$('#official-category-'+category.id).html(s);
				}else{
					$('#official-category-'+category.id).html('<img src="images/nophoto.png">');
				}
				if(json[json_fans].length>0){
					var s = "";
					$.each(json[json_fans],function(index_fans,photo_fans){
						s += '<a class="fancybox" rel="fans-gallery-'+category.id+'" href="'+getRootPath()+'/upload/'+photo_fans.filename+'" title="'+renderTitle(photo_fans)+'"><img src="'+getRootPath()+'/upload/thumb/'+photo_fans.filename+'" alt="" /></a>';

					});
					$('#fans-category-'+category.id).html(s);
				}else{
					$('#fans-category-'+category.id).html('<img src="images/nophoto.png">');
				}


			});
			$('#tabs').tabs("refresh");
			$(".fancybox").fancybox({
				caption:{
					type:'inside'
				},
				arrows:false,
				theme:'light'
			});
			$('.ui-body-a img').nailthumb({width:100,height:100});
		}

	</script>
</head>

<body>
<div data-role="page" id="page1">
	<div data-role="header" id="header">
		<div id="link_l"><a href="#" onclick="history.back();" data-ajax="false"><i class="grey fa fa-arrow-circle-left "></i></a> </div>
		<div id="link_r"><a href="index.jsp" data-ajax="false"><i class="grey fa fa-home "></i></a></div>
		<div class="logo"><img src="images/logo.png" height="50px"></div>
	</div>
	<div data-role="content"  id="detail">
		<h4 class="ui-bar ui-bar-a ui-corner-all header" id="shop_name"></h4>
		<div data-role="tabs" id="tabs">



		</div>
	</div>
	<div data-role="footer">
		<div id="copyright"> &copy; Sydneycode.com.au 2014</div>
	</div>
</div>
</body>
</html>