<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
  <head>
    <meta charset="utf-8">
    <title>编辑图片分类</title>
    
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    
	<link href="../css/bootstrap.css" rel="stylesheet">
	<link href="../css/style.css" rel="stylesheet">
   	<script src="../js/jquery.js"></script>
   	<script src="../js/bootstrap.min.js"></script>
   	<script src="../js/user.js"></script>
	
	<!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
      <script src="//cdnjs.bootcss.com/ajax/libs/html5shiv/3.6.2/html5shiv.js"></script>
    <![endif]-->
	
	<!-- Fav and touch icons -->
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="../assets/ico/apple-touch-icon-144-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="../assets/ico/apple-touch-icon-114-precomposed.png">
      <link rel="apple-touch-icon-precomposed" sizes="72x72" href="../assets/ico/apple-touch-icon-72-precomposed.png">
                    <link rel="apple-touch-icon-precomposed" href="../assets/ico/apple-touch-icon-57-precomposed.png">
                                   <link rel="shortcut icon" href="../assets/ico/favicon.png">
	
  </head>
  
  <body>
  	<div class="container">
	  	<!-- 导航菜单 -->
	    <s:include value="nav_bar.jsp" >
	    </s:include>
    	<div id="content">
    		<!-- 添加地区 -->
    		<div class="row">
    			<div class="col-sm-1"></div>
	    		<div class="col-sm-10 main">
	    		    <div class="well well-sm"><strong>编辑图片分类</strong></div>
	    		</div>
	    		<div class="col-sm-1"></div>
    		</div>
    		<div class="row">
    			<div class="col-sm-1"></div>
	    		<div class="col-sm-10">
	    		    <form class="form-horizontal" role="form">
	    		      <div class="form-group">
					    <label for="select_top" class="col-sm-2 control-label">归属类别</label>
					    <div class="col-sm-3">
					      	<select class="form-control" id="select_top">
							</select>
					    </div>
					    <div class="col-sm-7"></div>
					  </div>
					  <div class="form-group">
					    <label for="category_name" class="col-sm-2 control-label">分类名称</label>
					    <div class="col-sm-5">
					      <input type="text" class="form-control" id="category_name" placeholder="请输入分类名称">
					    </div>
					    <label for="photo_category_order_id" class="col-sm-2 control-label">分类排序</label>
					    <div class="col-sm-3">
					      <input type="text" class="form-control" id="photo_category_order_id" value="0">
					    </div>
					  </div>
					  <div class="form-group">
					    <div class="col-sm-offset-2 col-sm-2">
					      <button type="submit" id="btn_edit_category" class="btn btn-default">更新</button>
					    </div>
					  </div>
					</form>
	    		</div>
	    		</div>
	    		<div class="col-sm-1"></div>
    		</div>
    		
    	</div>
    </div>
  	<script type="text/javascript">
	  	
  		$(document).ready(function() {
	  		var id = getQueryString("category_id");
	  		//获取顶级分类并填充
	  		$.ajax({
	  			type:"post",
	  			url:"Catalog!listByParentId.action",
	  			dataType:"json",
	  			data:{ "parent_id": 0},
	  			success:function(json){
	  				$.each(json.catalog_list,function(m,catalog){
	  					$("#select_top").append("<option value="+catalog.id+">"+catalog.name+"</option>");
	  				});
	  			},
	  			complete:function(){
	  				$.ajax({
			  			type:"post",
			  			url:"PhotoCategory!getPhotoCategoryById.action",
			  			dataType:"json",
			  			data:{ "id": id},
			  			success:function(json){
			  				$('#category_name').val(json.category.name);
							$('#photo_category_order_id').val(json.category.order_id);
							$("#select_top").val(json.category.catalog_id);
			  			}
			  		});
	  			}
	  		});
	  		//查询图片分类信息
	  		
	  		
	  	});
  		$(function(){
  			//编辑按钮
	  		$('#btn_edit_category').click(function(){
	  			var category_name = $('#category_name').val();
	  			var catalog_id = $('#select_top').val();
	  			var catalog_name = $('#select_top').find("option:selected").text();
	  			var order_id = $('#photo_category_order_id').val();
	  			order_id = (order_id=='')?0:order_id;
	  			if(category_name==''){
	  				alert("分类名称不能为空,请填写！");
	  				$('#category_name').focus();
	  			}else{
	  				var id = getQueryString("category_id");
	  				editPhotoCategory(category_name,catalog_id,catalog_name,order_id,id);
	  			}
	  			return false;
	  		});
	  		
	  	});
	  	function editPhotoCategory(category_name,catalog_id,catalog_name,order_id,id){
	  		var t = new Date().getTime();
	  		$.ajax({
                type: "POST",
                dataType: "json",
                //cache:true,
                url: "PhotoCategory!edit.action",
                data: { "category.id": id,"category.name": category_name, "category.catalog_id": catalog_id,"category.catalog_name": catalog_name,"category.order_id": order_id,"t":t},                              
                success: function(json) {
                	if(json.status==1){
                		//保存成功
                		alert(json.message);
                		window.location.href = "photo_category_list.jsp";
                	}else{
                		alert(json.message);
                	}
                	
                },
                error: function() {
                    alert("Oops...编辑失败...\n请联系管理员！");
                }
            });
	  	}
	  	
  	</script>
  </body>
</html>
