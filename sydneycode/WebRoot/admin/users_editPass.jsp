<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
  <head>
    <meta charset="utf-8">
    <title>修改密码</title>
    
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
	    		    <div class="well well-sm"><strong>修改密码</strong></div>
	    		</div>
	    		<div class="col-sm-1"></div>
    		</div>
    		<div class="row">
    			<div class="col-sm-1"></div>
	    		<div class="col-sm-10">
					<form class="form-horizontal" role="form">
						<div class="form-group">
							<label for="currentUsername" class="col-sm-4 control-label">当前用户</label>
							<div class="col-sm-4">
								<label id="currentUsername" class="control-label"></label>
							</div>
							<div class="col-sm-4"></div>
						</div>
						<div class="form-group">
							<label for="oldpass" class="col-sm-4 control-label">原密码</label>
							<div class="col-sm-4">
								<input type="password" class="form-control" id="oldpass" >
							</div>
							<div class="col-sm-4"></div>
						</div>
						<div class="form-group">
							<label for="newpass" class="col-sm-4 control-label">新密码</label>
							<div class="col-sm-4">
								<input type="password" class="form-control" id="newpass" >
							</div>
							<div class="col-sm-4"></div>
						</div>
						<div class="form-group">
							<div class="col-sm-offset-7 col-sm-2">
								<button type="submit" id="btn_edit_pass" class="btn btn-primary">修改</button>
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
			//查询用户信息
			$.ajax({
				type:"post",
				url:"User!getUserById.action",
				dataType:"json",
				data:{ "uid": id},
				success:function(json){
					$('#currentUsername').html(json.user.nickname);
				}
			});
			//添加按钮
			$('#btn_edit_pass').click(function(){
				var oldpass = $('#oldpass').val();
				var newpass = $('#newpass').val()
				if(oldpass==''){
					alert("原密码不能为空,请填写！");
					$('#oldpass').focus();
				}else if(newpass==''){
					alert("新密码不能为空,请填写！");
					$('#newpass').focus();
				}else if(newpass.length<6){
					alert("新密码长度不能小于6位,请修改！");
					$('#newpass').focus();
				}else{
					editUserPass(oldpass,newpass,id);
				}
				return false;
			});
	  	});
	  	function editUserPass(oldpass,newpass,id){
	  		var t = new Date().getTime();
	  		$.ajax({
                type: "POST",
                dataType: "json",
                //cache:true,
                url: "User!editPass.action",
                data: { "oldPass": oldpass, "newPass": newpass,"uid":id,"t":t},
                success: function(json) {
                	if(json.success){
                		//保存成功
                		alert(json.message);
                		window.location.href = "../Logout.action";
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
