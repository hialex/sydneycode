<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<html>
  <head>
    
    <title>最新汇率</title>
    
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1" >
	<link rel="shortcut icon" href="images/favicon.ico">
    <link rel="stylesheet" href="css/jquery.mobile-1.4.4.css" >
	<link rel="stylesheet" href="css/style.css">
	  <link rel="stylesheet" href="css/font-awesome.min.css" >
    <script src="js/jquery.min.js" ></script>
  	<script src="js/jquery.mobile-1.4.4.min.js" ></script>
	  <script src="../js/user.js"></script>
	  <script src="js/jsonrates.min.js"></script>
	<script>
		//显示加载器
		function showLoader() {
			//显示加载器.for jQuery Mobile 1.2.0
			$.mobile.loading('show', {
				text: '加载中...', //加载器中显示的文字
				textVisible: true, //是否显示文字
				theme: 'b',        //加载器主题样式a-e
				textonly: false,   //是否只显示文字
				html: ""           //要显示的html内容，如图片等
			});
		}

		//隐藏加载器.for jQuery Mobile 1.2.0
		function hideLoader()
		{
			//隐藏加载器
			$.mobile.loading('hide');
		}
		$(document).ready(function(){
			showLoader();
			JR.from('AUD').to('CNY').get(function(result){
				$("#rmb").html((result.rate).match(/\d*(\.\d{0,4})?/)[0]);
				$("#update").html(result.utctime);
			});
			JR.from('CNY').to('AUD').get(function(result){
				$("#aud").html((result.rate).match(/\d*(\.\d{0,4})?/)[0]);
			});
			hideLoader();
		});
	</script>
	  <script>
		  var _hmt = _hmt || [];
		  (function() {
			  var hm = document.createElement("script");
			  hm.src = "//hm.baidu.com/hm.js?f480371228f8df00343e783f935450a0";
			  var s = document.getElementsByTagName("script")[0];
			  s.parentNode.insertBefore(hm, s);
		  })();
	  </script>

  </head>
  
  <body>
    <div data-role="page">
		<div data-role="header" id="header">

			<div class="logo"><img src="images/logo.png" height="50px"></div>
		</div>
		<div data-role="content">
			<div class="ui-block-b block-content">
				<label><strong>澳元->人民币</strong></label>
				<div class="latestCurrency">
					<img src="images/aud.png" height="50px"> <span class="base"><i class="fa fa-dollar"></i> 1 </span> = <span class="symbol"><span id="rmb"></span> <i class="fa fa-cny"></i></span> <img src="images/cny.png"  height="50px">
				</div>
			</div>
			<div class="ui-block-b block-content">
				<label><strong>人民币->澳元</strong></label>
				<div class="latestCurrency">
					<img src="images/cny.png"  height="50px"> <span class="base"><i class="fa fa-cny"></i> 1 </span> = <span class="symbol"><span id="aud"></span> <i class="fa fa-dollar"></i></span> <img src="images/aud.png"  height="50px">
				</div>
			</div>
			<div class="ui-block-b block-content">
				<div class="update">
					Update：<span id="update"></span>
				</div>
			</div>
		</div>
		<div data-role="footer" >
			<div id="copyright"> &copy; Sydneycode.com.au 2015</div>
		</div>
  	</div>
  </body>
</html>
