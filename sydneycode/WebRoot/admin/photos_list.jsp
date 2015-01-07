<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
  <head>
    <meta charset="utf-8">
    <title>查看图片</title>
    
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    
	<link href="../css/bootstrap.css" rel="stylesheet">
	<link href="../css/style.css" type="text/css" rel="stylesheet" />
	<link href="../css/jquery.fancybox.css" type="text/css" rel="stylesheet" />
   	<script src="../js/jquery.js"></script>
   	<script src="../js/bootstrap.min.js"></script>
    <script type="text/javascript" src="../js/user.js"></script>
	<script type="text/javascript" src="../js/base64.js"></script>
	<script type="text/javascript" src="../js/mustache.js"></script>
	<script type="text/javascript" src="../js/jquery.fancybox.js"></script>
	<script type="text/javascript" src="../js/jquery.nailthumb.min.js"></script>
	<!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
      <script src="../js/html5.js"></script>
    <![endif]-->
	

	<script>

		$(document).ready(function(){
			//截取链接参数并赋值
			var shop_id = getQueryString("id");
			var shop_name = getQueryString("name");
			var root_catalog_id = getQueryString("root_catalog_id");
			$("#shop_name").text(new Base64().decode(shop_name));
			$("#detail").attr('href','Showshop.action?id='+shop_id);
			$("#photoupload").attr('href','photo_upload.jsp?id='+shop_id+'&root_catalog_id='+root_catalog_id+'&name='+shop_name);
			//获取照片分类
			$.ajax({
				type:"post",
				url:"PhotoCategory!getPhotoCategoryByCatalogId.action",
				dataType:"json",
				data:{ "root_catalog_id":root_catalog_id},
				success:function(json){
					var source="{{#allCategories}}<li role=\"presentation\" {{#default_display}} class=\"active\" {{/default_display}}><a href=\"#content-{{id}}\" id=\"tab-{{id}}\" role=\"tab\" data-toggle=\"tab\" aria-controls=\"{{name}}\" aria-expanded=\"true\">{{name}}</a></li>{{/allCategories}}";
					$('#myTab').html(Mustache.render(source,json));
					var content_source = "{{#allCategories}}<div role=\"tabpanel\" class=\"tab-pane fade in {{#default_display}} active {{/default_display}}\" id=\"content-{{id}}\" aria-labelledBy=\"{{name}}\"></div>{{/allCategories}}";
					$('#myTabContent').html(Mustache.render(content_source,json));
					getPhotos(json);
				}
			});
		});
		function getPhotos(json){
			$.each(json.allCategories,function(m,category){
				$.ajax({
					type:"post",
					url:"../Photo!getPhotosByShopIdAndCategoryId.action",
					dataType:"json",
					data:{ "shop_id":getQueryString("id"),"category_id":category.id},
					success:function(json){
						var s = "";
						$.each(json.photos,function(n,photo){
							s+="<a class='fancybox' rel='gallery-"+category.id+"' href='"+getRootPath()+"/upload/"+photo.filename+"' title='"+renderTitle(photo)+"'><img src='"+getRootPath()+"/upload/thumb/"+photo.filename+"' alt=''></a>";
						});
						$("#content-"+category.id).html(s);
						initFancyBox();
					}
				});
			});
		}
		function initFancyBox(){
			$(".fancybox").fancybox({
				caption:{
					type:'outside'
				},
				theme:'light'
			});

			$('#myTabContent img').nailthumb({width:100,height:100});
		}
	</script>
  </head>
  
  <body>
  	<div class="container">
	  	<!-- 导航菜单 -->
	    <s:include value="nav_bar.jsp" >
	    </s:include>
    	<div id="content" class="row-fluid">

			<div class="row">
	    		<div class="col-sm-12 ">
	    		    <div class="well well-sm well-top"><span id="shop_name" class="shop_name"></span>&nbsp;&nbsp;<a id="detail" href="" target="_blank"><span class="glyphicon glyphicon-info-sign">店铺详情</span></a>&nbsp;&nbsp;&nbsp;&nbsp;<a id="photoupload" href="" target="_blank"><span class="glyphicon glyphicon-camera">上传图片</span></a></div>
	    		</div>
    		</div>
    		<div class="row">
				<div class="col-sm-12" >
					<ul id="myTab" class="nav nav-tabs" role="tablist">

					</ul>
					<div id="myTabContent" class="tab-content">

					</div>
				</div>
			</div>

    	</div>
    </div>
  </body>
</html>
