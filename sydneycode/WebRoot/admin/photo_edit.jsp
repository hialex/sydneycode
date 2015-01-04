<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
  <head>
    <meta charset="utf-8">
    <title>图片编辑</title>
    
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    
	<link href="../css/bootstrap.css" rel="stylesheet">
	<link href="../css/style.css" type="text/css" rel="stylesheet" />
   	<script src="../js/jquery.js"></script>
   	<script src="../js/bootstrap.min.js"></script>
    <script type="text/javascript" src="../js/user.js"></script>
	<script type="text/javascript" src="../js/base64.js"></script>
	<!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
      <script src="../js/html5.js"></script>
    <![endif]-->
	
	<!-- Fav and touch icons -->
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="../assets/ico/apple-touch-icon-144-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="../assets/ico/apple-touch-icon-114-precomposed.png">
      <link rel="apple-touch-icon-precomposed" sizes="72x72" href="../assets/ico/apple-touch-icon-72-precomposed.png">
                    <link rel="apple-touch-icon-precomposed" href="../assets/ico/apple-touch-icon-57-precomposed.png">
                                   <link rel="shortcut icon" href="../assets/ico/favicon.png">
	<script>
		$(document).ready(function(){
			//截取链接参数并赋值
			var id = getQueryString("id");
			var root_catalog_id = getQueryString("root_catalog_id");
			//查询图片信息
			$.ajax({
				type:"post",
				url:"../Photo!getPhotoById.action",
				dataType:"json",
				data:{ "id": id},
				success:function(json_photo){
					//$('#suburb_name').val(json.suburb.name);
					//初始化图片分类select
					$.ajax({
						type:"post",
						url:"PhotoCategory!getPhotoCategoryByCatalogId.action",
						dataType:"json",
						data:{ "root_catalog_id":root_catalog_id},
						success:function(json){
							$.each(json.allCategories,function(m,category){
								$("#photo_category").append("<option value="+category.id+">"+category.name+"</option>");
							});
							$("#photo_category").val(json_photo.photo.category_id);
						}
					});

					$("#order_id").val(json_photo.photo.order_id);
					$("#photo_name").val(json_photo.photo.name);
					$("#photo_comment").val(json_photo.photo.intro);
					$("#img").attr('src',getRootPath()+'/upload/'+json_photo.photo.filename);
				}
			});

			//顶级分类编辑按钮
			$('#btn_edit_photo').click(function(){

				var photoname = $("#photo_name").val();
				var intro = $("#photo_comment").val();
				var order_id = ($("#order_id").val()=='')?0:$("#order_id").val();
				var category_id = $("#photo_category").val();
				console.log(photoname);
				console.log(intro);
				console.log(order_id);
				console.log(category_id);
				var t = new Date().getTime();
				$.ajax({
					type: "POST",
					dataType: "json",
					//cache:true,
					url: "../Photo!editPhoto.action",
					data: { "photo.id": id,"photo.category_id":category_id,"photo.name": photoname,"photo.intro": intro,"photo.order_id": order_id,"t":t},
					success: function(json) {
						if(json.status==1){
							//保存成功
							alert(json.message);
							window.location.href = "photos_lib.jsp";
						}else{
							alert(json.message);
						}

					},
					error: function(xhr) {
						alert("Oops...编辑失败...\n请联系管理员！");
					}
				});
				return false;
			});

		});
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
	    		    <div class="well well-sm well-top"><span id="shop_name" class="shop_name">编辑图片</span></div>
	    		</div>
    		</div>
    		<div class="row">
				<div class="col-sm-1" ></div>
				<div class="col-sm-5">
					<form class="form-horizontal" role="form" id="addPicForm">
						<div class="form-group">
							<label for="photo_category" class="col-sm-3 control-label">图片分类</label>
							<div class="col-sm-9">
								<select class="form-control" id="photo_category">
								</select>
							</div>
						</div>
						<div class="form-group">
							<label for="order_id" class="col-sm-3 control-label">排序序号</label>
							<div class="col-sm-9">
								<input type="text" class="form-control" id="order_id" value="0">
							</div>
						</div>
						<div class="form-group">
							<label for="photo_name" class="col-sm-3 control-label">图片名称</label>
							<div class="col-sm-9">
								<input type="text" class="form-control" id="photo_name" placeholder="请输入图片名称（可选）">
							</div>
						</div>

						<div class="form-group">
							<label for="photo_comment" class="col-sm-3  control-label">图片说明</label>
							<div class="col-sm-9">
								<textarea class="form-control"  id="photo_comment" name="photo_comment"  rows="3" placeholder="请输入照片说明（可选）"></textarea>
							</div>
						</div>
						<div class="form-group">
							<div class="col-sm-offset-10 col-sm-2">
								<button type="submit" id="btn_edit_photo" class="btn btn-primary">更新</button>
							</div>
						</div>
					</form>
				</div>
				<div class="col-sm-5" style="margin-bottom:20px">
					<img src="" id="img" width="350">
				</div>
				<div class="col-sm-1" ></div>
    		</div>
			<div class="row"></div>

    	</div>
    </div>
  </body>
</html>
