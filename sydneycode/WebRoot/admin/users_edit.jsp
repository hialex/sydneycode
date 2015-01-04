<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
  <head>
    <meta charset="utf-8">
    <title>编辑用户</title>
    
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
	    		    <div class="well well-sm"><strong>编辑用户</strong></div>
	    		</div>
	    		<div class="col-sm-1"></div>
    		</div>
    		<div class="row">
    			<div class="col-sm-1"></div>
	    		<div class="col-sm-10">
	    		    <form class="form-horizontal" role="form">
	    		      <div class="form-group">
					    <label for="loginname" class="col-sm-4 control-label">登录名</label>
					    <div class="col-sm-4">
							<input type="text" class="form-control" id="loginname" placeholder="请填入包含字母或数字的组合">
					    </div>
					    <div class="col-sm-4"></div>
					  </div>
					  <div class="form-group">
					    <label for="nickname" class="col-sm-4 control-label">姓名</label>
					    <div class="col-sm-4">
					      <input type="text" class="form-control" id="nickname" placeholder="显示名称，可填写中文">
					    </div>
						  <div class="col-sm-4"></div>
					  </div>
						<div class="form-group">
							<label for="role" class="col-sm-4 control-label">角色</label>
							<div class="col-sm-4">
								<select class="form-control" id="role">
									<option value="0">管理员</option>
									<option value="1">超级管理员</option>
								</select>
							</div>
							<div class="col-sm-4"></div>
						</div>
					  <div class="form-group">
					    <div class="col-sm-offset-7 col-sm-2">
					      <button type="submit" id="btn_edit_user" class="btn btn-primary">编辑</button>
					    </div>
					  </div>
					</form>
	    		</div>
	    		<div class="col-sm-1"></div>
    		</div>
    		
    	</div>
    </div>
  	<script type="text/javascript">

		$(document).ready(function(){
			var id = getQueryString("id");

			//查询suburb信息
			$.ajax({
				type:"post",
				url:"User!getUserById.action",
				dataType:"json",
				data:{ "uid": id},
				success:function(json){
					$('#loginname').val(json.user.username);
					$('#nickname').val(json.user.nickname);
					$('#role').val(json.user.role);
				}
			});
			//添加按钮
			$('#btn_edit_user').click(function(){
				var username = $('#loginname').val();
				var nickname = $('#nickname').val();
				var role = $('#role').val();
				if(username==''){
					alert("登录名不能为空,请填写！");
					$('#loginname').focus();
				}else if(nickname==''){
					alert("用户名不能为空,请填写！");
					$('#nickname').focus();
				}else{
					updateUser(username,nickname,role,id);
				}
				return false;
			});
	  	});
	  	function updateUser(username,nickname,role,id){
	  		var t = new Date().getTime();
	  		$.ajax({
                type: "POST",
                dataType: "json",
                //cache:true,
                url: "User!edit.action",
                data: { "user.username": username, "user.nickname": nickname,"user.role": role,"user.id":id,"t":t},
                success: function(json) {
                	if(json.success){
                		//保存成功
                		alert(json.message);
                		window.location.href = "users_list.jsp";
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
