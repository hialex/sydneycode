<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
  <head>
    <meta charset="utf-8">
    <title>编辑地区</title>
    
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
	    	<s:param name="title">catalogs</s:param>
	    </s:include>
    	<div id="content">
    		<!-- 添加地区 -->
    		<div class="row">
    			<div class="col-sm-1"></div>
	    		<div class="col-sm-10 main">
	    		    <div class="well well-sm"><strong>编辑Suburbs</strong></div>
	    		</div>
	    		<div class="col-sm-1"></div>
    		</div>
    		<div class="row">
    			<div class="col-sm-1"></div>
	    		<div class="col-sm-10">
	    		    <form class="form-horizontal" role="form">
	    		      <div class="form-group">
					    <label for="catalog_top" class="col-sm-2 control-label">Suburb归属</label>
					    <div class="col-sm-3">
					      	<select class="form-control" id="select_top">
							</select>
					    </div>
					    <div class="col-sm-7"></div>
					  </div>
					  <div class="form-group">
					    <label for="catalog_top" class="col-sm-2 control-label">Suburb Name</label>
					    <div class="col-sm-8">
					      <input type="text" class="form-control" id="suburb_name" placeholder="请输入Suburb Name">
					    </div>
					  </div>
					  <div class="form-group">
					    <label for="catalog_top" class="col-sm-2 "></label>
					    <div class="col-sm-8">
					      <div class="checkbox">
						    <label>
						      <input type="checkbox" id="hot_suburb"> 设置为常用地区
						    </label>
						  </div>
					    </div>
					  </div>
					  <div class="form-group">
					    <div class="col-sm-offset-2 col-sm-2">
					      <button type="submit" id="btn_edit_suburb" class="btn btn-default">更新</button>
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
	  		var id = getQueryString("id");
	  		//获取顶级地区填充
	  		$.ajax({
	  			type:"post",
	  			url:"Suburb!listByParentId.action",
	  			dataType:"json",
	  			data:{ "parent_id": 0},
	  			success:function(json){
	  				$.each(json.suburb_list,function(m,suburb){
	  					$("#select_top").append("<option value="+suburb.id+">"+suburb.name+"</option>");
	  				});
	  			}
	  		});
	  		//查询suburb信息
	  		$.ajax({
	  			type:"post",
	  			url:"Suburb!getSuburbById.action",
	  			dataType:"json",
	  			data:{ "id": id},
	  			success:function(json){
	  				$('#suburb_name').val(json.suburb.name);
					if(json.suburb.is_hot){
						$('#hot_suburb').attr("checked",true);
					}
	  			}
	  		});
	  		
	  	});
  		$(function(){
  			//顶级分类编辑按钮
	  		$('#btn_edit_suburb').click(function(){
	  			var suburb_name = $('#suburb_name').val();
	  			var parent_id = $('#select_top').val();
	  			var hot_suburb = false;
	  			if($('#hot_suburb').is(':checked')){
	  				hot_suburb = true;
	  			}
	  			if(suburb_name==''){
	  				alert("Suburb Name不能为空,请填写！");
	  				$('#suburb_name').focus();
	  			}else{
	  				var s_id = getQueryString("id");
	  				editSuburb(s_id,suburb_name,parent_id,hot_suburb);
	  			}
	  			return false;
	  		});
	  		
	  	});
	  	function editSuburb(id,suburb_name,parent_id,hot_suburb){
	  		var t = new Date().getTime();
	  		$.ajax({
                type: "POST",
                dataType: "json",
                //cache:true,
                url: "Suburb!edit.action",
                data: { "suburb.id": id,"suburb.name": suburb_name, "suburb.parent_id": parent_id,"suburb.is_hot": hot_suburb,"t":t},                              
                success: function(json) {
                	if(json.status==1){
                		//保存成功
                		alert(json.message);
                		window.location.href = "suburbs_list.jsp";
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
