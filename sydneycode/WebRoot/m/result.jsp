<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>

	<title>搜索结果</title>

	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width,initial-scale=1" >
	<link rel="shortcut icon" href="images/favicon.ico">
	<link rel="stylesheet" href="css/jquery.mobile-1.4.4.css" >
	<link rel="stylesheet" href="css/style.css">
	<link rel="stylesheet" href="css/font-awesome.min.css" >
	<link rel="stylesheet" href="css/scrollbar.css">
	<script src="js/jquery.min.js" ></script>
	<script src="js/jquery.mobile-1.4.4.min.js" ></script>
	<script src="js/handlebars-v2.0.0.js"></script>
	<script src="js/iscroll.js"></script>
	<script>
		var pageNum = 1;
		var myScroll,
				pullDownEl, pullDownOffset,
				pullUpEl, pullUpOffset;
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
		function hideLoader(){
			//隐藏加载器
			$.mobile.loading('hide');
		}

		$(document).ready(function(){
			getData(pageNum);
			loaded();


		});



		/**
		 * 滚动翻页 （自定义实现此方法）
		 * myScroll.refresh();		// 数据加载完成后，调用界面更新方法
		 */
		function pullUpAction () {
			getData(++pageNum);
		}

		/**
		 * 初始化iScroll控件
		 */

		function loaded() {
			pullUpEl = document.getElementById('pullup');
			pullUpOffset = pullUpEl.offsetHeight;
			myScroll = new iScroll('wrapper', {
				useTransition: false,
				topOffset:pullDownOffset,
				onScrollMove: function () {
					if (this.y < (this.maxScrollY - 5) && !pullUpEl.className.match('flip')) {
						pullUpEl.className = 'flip';
						pullUpEl.querySelector('.pullUpLabel').innerHTML = '<i class="fa fa-arrow-circle-o-down"></i>&nbsp;松手开始更新...';
						this.maxScrollY = this.maxScrollY;
					} else if (this.y > (this.maxScrollY + 5) && pullUpEl.className.match('flip')) {
						pullUpEl.className = '';
						pullUpEl.querySelector('.pullUpLabel').innerHTML = '<i class="fa fa-arrow-circle-o-up"></i>&nbsp;上拉加载更多...';
						this.maxScrollY = pullUpOffset;
					}
				},
				onScrollEnd: function () {
					if (pullUpEl.className.match('flip')) {
						pullUpEl.className = 'loading';
						pullUpEl.querySelector('.pullUpLabel').innerHTML = '<i class="fa fa-spinner fa-spin"></i>&nbsp;加载中...';
						pullUpAction();	// Execute custom function (ajax call?)
					}else{
						pullUpEl.querySelector('.pullUpLabel').innerHTML = '<i class="fa fa-arrow-circle-o-up"></i>&nbsp;上拉加载更多...';
					}
				}
			});

		}

		//初始化绑定iScroll控件
		document.addEventListener('touchmove', function (e) { e.preventDefault(); }, false);
		//document.addEventListener('DOMContentLoaded', loaded, false);

		function getData(pageNum){
			showLoader();
			var catalog1 = window.sessionStorage.getItem("catalog1");
			var catalog2 = window.sessionStorage.getItem("catalog2");
			var suburb = window.sessionStorage.getItem("suburb");
			var bh = window.sessionStorage.getItem("bh");
			var rootId = window.sessionStorage.getItem("rootId");
			var t = new Date().getTime();
			//初始化饮食分类
			$.ajax({
				type: "POST",
				dataType: "json",
				url: "../mobile/MSearch.action",
				data: { "catalog1": catalog1, "catalog2": catalog2 ,"suburb":suburb,"bh":bh,"rootId":rootId,"t":t,"pageNum":pageNum},
				success: function(json) {
					if(json.all.length==0){
						var nomore = '<i class="fa fa-frown-o"></i>&nbsp;抱歉，没有更多的数据！';
						$(".pullUpLabel").html(nomore);
					}else{
						var source="{{#all}}<li><a href=\"detail.jsp?id={{shop_id}}\"  data-ajax=\"false\"><h4>{{shop_name}}</h4>" +
								"{{^is_takeout}}<p>" +
								"<i class=\"fa fa-location-arrow grey\"></i>&nbsp;{{suburb_name}}&nbsp;" +
								"</p>{{/is_takeout}}" +
								"<p>" +
								"{{#catalogs}}<i class=\"fa fa-tag grey\"></i>&nbsp;{{name}}&nbsp;&nbsp;{{/catalogs}}" +
								"</p>" +
								"</a>" +
								"</li>{{/all}}";
						var templete = Handlebars.compile(source);
						var data = json;
						$("#result").append(templete(data));
						$("#result").listview('refresh');
					}


				},
				complete:function(){
					hideLoader();
					setTimeout(function(){
						myScroll.refresh();
					},0);
				}
			});
		}

	</script>
</head>

<body>
<div data-role="page">
	<div data-role="header" id="header">
		<div id="link_l"><a href="#" onclick="history.back();" data-ajax="false"><i class="grey fa fa-arrow-circle-left "></i></a> </div>
		<div id="link_r"><a href="index.jsp" data-ajax="false"><i class="grey fa fa-home "></i></a></div>
		<div class="logo"><img src="images/logo.png" height="50px"></div>
	</div>
	<div id="wrapper" data-role="content">
		<div id="scroller">
			<ul style="margin: 0em 0em .5em 0em;" data-role="listview" data-inset="true" id="result">
			</ul>
			<div id="pullup">
				<span class="pullUpLabel"></span>
			</div>
		</div>
	</div>
	<div data-role="footer" data-position="fixed" >
		<div id="copyright"> &copy; Sydneycode.com.au 2014</div>
	</div>
</div>
</body>
</html>