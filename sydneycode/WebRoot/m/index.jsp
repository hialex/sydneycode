<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>

	<title>首页</title>

	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width,initial-scale=1" >
	<link rel="shortcut icon" href="images/favicon.ico">
	<link rel="stylesheet" href="css/jquery.mobile-1.4.4.css" >
	<link rel="stylesheet" href="css/style.css">
	<link rel="stylesheet" href="css/jqm-datebox-1.4.4.css">
	<script src="js/jquery.min.js" ></script>
	<script src="js/jquery.mobile-1.4.4.min.js" ></script>

</head>
<body>
	<div data-role="page">
		<div data-role="header" id="header">
			<div class="logo"><img src="images/logo.png" height="50px"></div>
		</div>
		<div data-role="content">
			<div class="ui-block-b block-content">
				<a href="food.jsp" data-ajax="false" data-transition="slidedown" class="ui-btn ui-corner-all   ui-shadow-icon">饮食</a>
				<a href="services.jsp" data-ajax="false" data-transition="slidedown" class="ui-btn ui-corner-all   ui-shadow-icon">服务</a>
				<a href="shopping.jsp" data-ajax="false" data-transition="slidedown" class="ui-btn ui-corner-all   ui-shadow-icon">购物</a>
				<a href="fun.jsp" data-ajax="false" data-transition="slidedown" class="ui-btn ui-corner-all   ui-shadow-icon">娱乐</a>
				<a href="sport.jsp" data-ajax="false" data-transition="slidedown" class="ui-btn ui-corner-all   ui-shadow-icon">运动</a>
			</div>
		</div>
		<div data-role="footer" >
			<div id="copyright"> &copy; Sydneycode.com.au 2014</div>
		</div>
	</div>
</body>
</html>