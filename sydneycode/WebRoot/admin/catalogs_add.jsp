<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
  <head>
    <meta charset="utf-8">
    <title>添加分类</title>
    
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    
	<link href="../css/bootstrap.css" rel="stylesheet">
	<link href="../css/style.css" rel="stylesheet">
   	<script src="../js/jquery.js"></script>
   	<script src="../js/bootstrap.min.js"></script>
	
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
	    	<s:param name="title">catalogs</s:param>
	    </s:include>
    	<div id="content">
    		<!-- 顶级分类 -->
    		<div class="row">
    			<div class="col-sm-1"></div>
	    		<div class="col-sm-10 main">
	    		    <div class="well well-sm"><strong>添加顶级分类【饮食、服务、运动……】</strong></div>
	    		</div>
	    		<div class="col-sm-1"></div>
    		</div>
    		<div class="row">
    			<div class="col-sm-1"></div>
	    		<div class="col-sm-10">
	    		    <form class="form-horizontal" role="form">
	    		    	
					  <div class="form-group">
					    <label for="catalog_top" class="col-sm-2 control-label">分类名称</label>
					    <div class="col-sm-8">
					      <input type="text" class="form-control" id="catalog_top" placeholder="请输入顶级分类名称">
					    </div>
					    <div class="col-sm-1">
					      <button type="submit" id="btn_add_top_catalog" class="btn btn-default">添加</button>
					    </div>
					  </div>
					</form>
	    		</div>
	    		<div class="col-sm-1"></div>
    		</div>
    		
    		
    		<!-- 一级分类 -->
    		<div class="row">
    			<div class="col-sm-1"></div>
	    		<div class="col-sm-10 main">
	    		    <div class="well well-sm"><strong>添加一级分类【饮食-中餐、服务-RTA……】</strong></div>
	    		</div>
	    		<div class="col-sm-1"></div>
    		</div>
    		<div class="row">
    			<div class="col-sm-1"></div>
	    		<div class="col-sm-10">
	    		    <form class="form-horizontal" role="form">
	    		      <div class="form-group">
					    <label for="catalog_top" class="col-sm-2 control-label">上级分类</label>
					    <div class="col-sm-3">
					      	<select class="form-control" id="select_top1">
							  <option value="-1">请选择顶级分类</option>
							</select>
					    </div>
					    <div class="col-sm-7"></div>
					  </div>
					  <div class="form-group">
					    <label for="catalog_top" class="col-sm-2 control-label">分类名称</label>
					    <div class="col-sm-8">
					      <input type="text" class="form-control" id="catalog_level1" placeholder="请输入一级分类名称">
					    </div>
					    <div class="col-sm-1">
					      <button type="submit" id="btn_add_level1_catalog" class="btn btn-default">添加</button>
					    </div>
					  </div>
					</form>
	    		</div>
	    		<div class="col-sm-1"></div>
    		</div>
    		
    		
    		<!-- 二级分类 -->
    		<div class="row">
    			<div class="col-sm-1"></div>
	    		<div class="col-sm-10 main">
	    		    <div class="well well-sm"><strong>添加二级分类【饮食-中餐-北京菜、服务-医疗-中医……】</strong></div>
	    		</div>
	    		<div class="col-sm-1"></div>
    		</div>
    		<div class="row">
    			<div class="col-sm-1"></div>
	    		<div class="col-sm-10">
	    		    <form class="form-horizontal" role="form">
					  <div class="form-group">
					    <label for="catalog_top" class="col-sm-2 control-label">分类名称</label>
					    <div class="col-sm-3">
					      	<select class="form-control" id="select_top2">
							  <option value="-1">请选择顶级分类</option>
							</select>
					    </div>
					    <div class="col-sm-1"></div>
					     <div class="col-sm-3">
					      	<select class="form-control" id="select_level1">
							  <option value="-1">请选择一级分类</option>
							</select>
					    </div>
					    <div class="col-sm-3"></div>
					  </div>
					  <div class="form-group">
					    <label for="catalog_top" class="col-sm-2 control-label">分类名称</label>
					    <div class="col-sm-8">
					      <input type="text" class="form-control" id="catalog_level2" placeholder="请输入二级分类名称">
					    </div>
					    <div class="col-sm-1">
					      <button type="submit" id="btn_add_level2_catalog" class="btn btn-default">添加</button>
					    </div>
					  </div>
					</form>
	    		</div>
	    		<div class="col-sm-1"></div>
    		</div>
    	</div>
    </div>
  	<script type="text/javascript">
	  	$(document).ready(function() {
	  		//获取顶级分类并填充
	  		$.ajax({
	  			type:"post",
	  			url:"Catalog!listByParentId.action",
	  			dataType:"json",
	  			data:{ "parent_id": 0},
	  			success:function(json){
	  				$.each(json.catalog_list,function(m,catalog){
	  					$("#select_top1").append("<option value="+catalog.id+">"+catalog.name+"</option>");
	  					$("#select_top2").append("<option value="+catalog.id+">"+catalog.name+"</option>");
	  				});
	  			}
	  		});
	  		
	  		//监听顶级分类，获取一级分类并填充
	  		$("#select_top2").change(function(){
	  			//重置联动选择框
	  			$("#select_level1 option").each(function(){
	  				if($(this).val()!=-1){
	  					$(this).remove();
	  				}
	  			});
	  			//$("#select_level1 option:first").prop("selected",'selected');
	  			if($('#select_top2').children('option:selected').val()!=-1){
		  			var paren_id = $(this).children('option:selected').val();
		  			$.ajax({
			  			type:"post",
			  			url:"Catalog!listByParentId.action",
			  			dataType:"json",
			  			data:{ "parent_id": paren_id},
			  			success:function(json){
			  				$.each(json.catalog_list,function(m,catalog){
			  					$("#select_level1").append("<option value="+catalog.id+">"+catalog.name+"</option>");
			  				});
			  			}
			  		});
	  			}
	  		});
	  	});
  		$(function(){
  			//顶级分类添加按钮
	  		$('#btn_add_top_catalog').click(function(){
	  			var catalog_name = $('#catalog_top').val();
	  			if(catalog_name==''){
	  				alert("顶级分类名称不能为空,请填写！");
	  				$('#catalog_top').focus();
	  			}else{
	  				submitCatalog(catalog_name,0);
	  			}
	  			return false;
	  		});
  			
	  		//一级分类添加按钮
	  		$('#btn_add_level1_catalog').click(function(){
	  			var parent_id = $('#select_top1').val();
	  			var catalog_name = $('#catalog_level1').val();
	  			if(parent_id=='-1'){
	  				alert("请选择顶级分类！");
	  				$('#select_top1').focus();
	  			}else if(catalog_name==''){
	  				alert("一级分类名称不能为空,请填写！");
	  				$('#catalog_level1').focus();
	  			}else{
	  				submitCatalog(catalog_name,parent_id);
	  			}
	  			return false;
	  		});
	  		
	  		//二级分类添加按钮
	  		$('#btn_add_level2_catalog').click(function(){
	  			var top = $('#select_top2').val();
	  			var parent_id = $('#select_level1').val();
	  			var catalog_name = $('#catalog_level2').val();
	  			if(top=='-1'){
	  				alert("请选择顶级分类！");
	  				$('#select_top2').focus();
	  			}else if(parent_id=='-1'){
	  				alert("请选择一级分类！");
	  				$('#select_level1').focus();
	  			}else if(catalog_name==''){
	  				alert("二级分类名称不能为空,请填写！");
	  				$('#catalog_level2').focus();
	  			}else{
	  				submitCatalog(catalog_name,parent_id);
	  			}
	  			return false;
	  		});
	  	});
	  	function submitCatalog(catalog_name,parent_id){
	  		var t = new Date().getTime();
	  		$.ajax({
                type: "POST",
                dataType: "json",
                //cache:true,
                url: "Catalog!add.action",
                data: { "catalog.name": catalog_name, "catalog.parent_id": parent_id ,"t":t},                              
                success: function(json) {
                	if(json.status==1){
                		//保存成功
                		alert(json.message);
                		window.location.href = "catalogs_list.jsp";
                	}else{
                		alert(json.message);
                	}
                	
                },
                error: function() {
                    alert("Oops...添加失败...\n请联系管理员！");
                }
            });
	  	}
	  	
  	</script>
  </body>
</html>
