<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<meta charset="utf-8">
	<title>管理登录</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta name="author" content="Joychao <joy@joychao.cc>">

	<!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
	<!--[if lt IE 9]>
	<script src="./js/html5.js"></script>
	<![endif]-->
	<link rel="stylesheet" type="text/css" href="./css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="./css/style.css">
	<script src="./js/jquery.min.js" type="text/javascript"></script>
	<script src="./js/bootstrap.min.js" type="text/javascript"></script>
	<style>
		* {margin: 0;padding: 0;}
	</style>
	<script>
		$(document).ready(function(){
			$("#login").click(function(){
				var username = $("#username").val();
				var password = $("#password").val();
				if(username==''){
					alert("请输入用户名！");
					$("#username").focus();
				}else if(password==''){
					alert("请输入密码！");
					$("#password").focus();
				}else{
					$.ajax({
						type:'POST',
						url:"Logon.action",
						dataType:"json",
						data:{ "user.username":username,"user.password":password},
						success:function(json){
							if(json.result.status==1){
								window.location.href="./admin";
							}else{
								alert(json.result.message);
								window.location.href="./index.jsp";
							}

						}
					});
				}
			});
		});
	</script>
</head>
<body class="loginContainer">
	<div>
		<div class="loginBox row-fluid">
			<div class="col-sm-7">
				<h2>请登录</h2>

				<p><input type="text" id="username" name="username" placeholder="用户名" class="form-control"/></p>
				<p><input type="password" id="password" name="password" placeholder="密码" class="form-control"/></p>
				<div class="row-fluid">
					<div class="col-sm-8"></div>
					<div class="col-sm-2" style="margin-left: -5px"><input type="button" value=" 登录 " class="btn btn-primary" id="login"></div>
				</div>
			</div>
			<div class="col-sm-5">
				<div class="loginLogo"><img src="./images/logo_big.png"></div>
			</div>
			<!-- /loginBox -->
		</div>
	<!-- /container -->
	</div>
</body>
</html>
