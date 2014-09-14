<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
  <head>
    <meta charset="utf-8">
    <title>编辑分类</title>
    
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
	    		    <div class="well well-sm"><strong>编辑分类</strong></div>
	    		</div>
	    		<div class="col-sm-1"></div>
    		</div>
    		<form class="form-horizontal" role="form">
    		<div class="row">
    			<div class="col-sm-1"></div>
	    		<div class="col-sm-10">
					  <div class="form-group">
					    <label for="catalog_top" class="col-sm-2 control-label">分类名称</label>
					    <div class="col-sm-8">
					      <input type="text" class="form-control" id="catalog_name" placeholder="请输入分类名称">
					    </div>
					    <div class="col-sm-1"></div>
					  </div>
					
	    		</div>
	    		<div class="col-sm-1"></div>
    		</div>
    		<!-- 全部分类 -->
    		<div  class="row">
    			<div class="col-sm-1"></div>
	    		<div class="col-sm-10">
	    			<div class="form-group">
	    				<label for="catalog_parent" class="col-sm-2 control-label">上级分类</label>
		    			<div class="col-sm-2">
							<span id="parentName" class="detail"></span>
						</div>
		    			<div class="col-sm-2 checkbox">
		    				<label>
						    	<input type="checkbox" id="change_catalogs"> 更改上级分类
						    </label>
		    			</div>
		    			<div class="col-sm-1"></div>
	    		    </div>
	    		</div>
	    		<div class="col-sm-1"></div>
    		</div>
    		<div id="catalog_div" class="row">
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
					</form>
	    		</div>
	    		<div class="col-sm-1"></div>
    		</div>
    		<div class="row"></div>
    		<div class="row">
	    		<div class="col-sm-12 ">
	    			<div class="form-group">
		    			<div class="center">
		        			<button type="submit" class="btn btn-danger" id="btn_edit">保存所有信息</button>
		    			</div>
		    		</div>
	    		</div>
    		</div>
    		</form>
    	</div>
    </div>
  	<script type="text/javascript">
	  	function getQueryString(name) {
		    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
		    var r = window.location.search.substr(1).match(reg);
		    if (r != null) return unescape(r[2]); return null;
   		}
  		$(document).ready(function(){
  			//获取id
	  		var id = getQueryString("id");
	  		var parent_id = getQueryString("parent_id");
	  		$.ajax({
	  			type:"post",
	  			url:"Catalog!getCatalogById.action",
	  			dataType:"json",
	  			data:{ "id": id},
	  			success:function(json){
	  				$('#catalog_name').val(json.catalog.name);
	  				$('#parentName').text(json.catalog.parentName);
	  			}
	  		});
	  		//编辑按钮
	  		$('#btn_edit').click(function(){
	  			var catalog_name = $('#catalog_name').val();
	  			if(catalog_name==''){
	  				alert("分类名称不能为空,请填写！");
	  				$('#catalog_name').focus();
	  				return false;
	  			}else if(!$('#change_catalogs').is(":checked")){
	  				//没有更改上级分类
	  				SubmitEditCatalog(id,catalog_name,parent_id);
	  			}else{
	  				//修改上级分类
	  				var select_top = $('#select_top2').val();
	  				var select_level1 = $('#select_level1').val();
	  				if(select_top==-1){
	  					alert("顶级分类必须选择！");
	  					$('#select_top2').focus();
	  					return false;
	  				}else if(select_level1==-1){
	  					//修改的是一级分类
	  					parent_id = select_top;
	  				}else{
	  					//修改的是二级分类
	  					parent_id = select_level1;
	  				}
	  				SubmitEditCatalog(id,catalog_name,parent_id);
	  			}
	  			return false;
	  		});
	  		//监听更改分类checkbox
	  		$('#catalog_div').hide();
	  		$('#change_catalogs').click(function(){
				if($('#change_catalogs').is(":checked")){
					//获取顶级分类并填充
			  		$.ajax({
			  			type:"post",
			  			url:"Catalog!listByParentId.action",
			  			dataType:"json",
			  			data:{ "parent_id": 0},
			  			success:function(json){
			  				$.each(json.catalog_list,function(m,catalog){
			  					$("#select_top2").append("<option value="+catalog.id+">"+catalog.name+"</option>");
			  				});
			  			}
			  		});
					$('#catalog_div').show();
				}else{
					$("#select_top2 option").each(function(){
		  				if($(this).val()!=-1){
		  					$(this).remove();
		  				}
		  			});
					$("#select_level1 option").each(function(){
		  				if($(this).val()!=-1){
		  					$(this).remove();
		  				}
		  			});
					$('#catalog_div').hide();
					//重置parent_id
					parent_id = getQueryString("parent_id");
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
	  			if($('#select_top2').children('option:selected').val()!=-1){
	  				//$("#select_level1 option:first").prop("selected",'selected');
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
	  		function SubmitEditCatalog(id,name,parent_id){
	  			var t = new Date().getTime();
		  		$.ajax({
	                type: "POST",
	                dataType: "json",
	                //cache:true,
	                url: "Catalog!edit.action",
	                data: { "catalog.id": id, "catalog.name": name, "catalog.parent_id": parent_id ,"t":t},                              
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
  		});
	  	
  	</script>
  </body>
</html>
