<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
  <head>
    <meta charset="utf-8">
    <title>图片上传</title>
    
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    
	<link href="../css/bootstrap.css" rel="stylesheet">
	<link href="../css/style.css" type="text/css" rel="stylesheet" />
	<link href="../css/fileinput.css" type="text/css" rel="stylesheet"/>
   	<script src="../js/jquery.js"></script>
   	<script src="../js/bootstrap.min.js"></script>
    <script type="text/javascript" src="../js/user.js"></script>
	<script type="text/javascript" src="../js/base64.js"></script>
	<script type="text/javascript" src="../js/fileinput.min.js"></script>
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
			var shop_name = getQueryString("name");
			var root_catalog_id = getQueryString("root_catalog_id");
			$("#shop_name").text(new Base64().decode(shop_name));
			$("#detail").attr('href','Showshop.action?id='+id);
			var category_id;
			// 初始化图片上传控件
			$("#input-id").fileinput({
				previewFileType: "image",
				browseClass: "btn btn-success",
				browseLabel: "浏览",
				browseIcon: "<i class=\"glyphicon glyphicon-picture\"></i> ",
				removeClass: "btn btn-danger",
				removeLabel: "删除",
				removeIcon: "<i class=\"glyphicon glyphicon-trash\"></i> ",
				uploadClass: "btn btn-info",
				uploadLabel: "上传",
				uploadIcon: "<i class=\"glyphicon glyphicon-upload\"></i> ",
				uploadUrl:"../PhotoUpload.action",
				dropZoneEnabled:false,
				maxFileCount:1,
				msgFilesTooMany:"一次只允许上传一张图片哦~",
				uploadExtraData: {
					"photo.shop_id": id,
					"photo.source": "web"
				}

			});

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
				}
			});
			$('#input-id').on('fileuploaded', function(event, data, previewId, index) {
				//上传完成
				alert("图片上传成功");
				$('#input-id').fileinput("reset");
				$(':input','#addPicForm')
						.not(':button,:submit,:reset,:hidden,:file')
						.val('')
						.removeAttr('checked');
				$("#photo_category").val(category_id);
			});
			$("#input-id").on('filepreupload',function(event,formdata,previewId,index){
				category_id = $("#photo_category").val();
				var photoname = $("#photo_name").val();
				var intro = $("#photo_comment").val();
				var order_id = ($("#order_id").val()=='')?0:$("#order_id").val();
				formdata.append("photo.order_id",order_id);
				formdata.append("photo.category_id",category_id);
				formdata.append("photo.name",photoname);
				formdata.append("photo.intro",intro);

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
	    		    <div class="well well-sm well-top"><span id="shop_name" class="shop_name"></span>&nbsp;&nbsp;<a id="detail" href="" target="_blank"><span class="glyphicon glyphicon-info-sign"></span></a></div>
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
					</form>
				</div>
				<div class="col-sm-5" style="margin-bottom:20px">
					<input id="input-id" name="file" type="file" accept="image/*" class="file-loading">
				</div>
				<div class="col-sm-1" ></div>
    		</div>
			<div class="row"></div>

    	</div>
    </div>
  </body>
</html>
