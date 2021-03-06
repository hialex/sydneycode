<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
  <head>
    
    <title>服务</title>
    
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1" >
	<link rel="shortcut icon" href="images/favicon.ico">
    <link rel="stylesheet" href="css/jquery.mobile-1.4.4.css" >
	<link rel="stylesheet" href="css/style.css">
	<link rel="stylesheet" href="css/jqm-datebox-1.4.4.css">
	  <link rel="stylesheet" href="css/font-awesome.min.css" >
	  <link rel="stylesheet" href="css/iconfont/iconfont.css">
    <script src="js/jquery.min.js" ></script>
  	<script src="js/jquery.mobile-1.4.4.min.js" ></script>
	<script src="js/jquery.mobile.DateBox.js"></script>
	<script src="js/jqm-datebox.mode.customflip.min.js"></script>
	<script src="js/jquery.cookie.js"></script>
	  <script src="../js/user.js"></script>
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

			//初始化饮食分类
			$.ajax({
				type:"post",
				url:"../admin/Catalog!listByParentId.action",
				dataType:"json",
				data:{ "parent_id": '2'},
				success:function(json){
					$.each(json.catalog_list,function(m,catalog){
						$("#catalog1").append("<option value="+catalog.id+">"+catalog.name+"</option>");
					});
					$("#catalog1").selectmenu('refresh');
					hideLoader();
				}
			});
			//子分类联动
			$("#catalog1").bind("change",function(){
				//特殊处理
				var arr = ['265','268','272','277','281','283','263'];
				var catalog_id = $('#catalog1').val();
				if($.inArray(catalog_id,arr)>-1){
					$('#div_area').hide();
					$('#div_time').hide();
				}else{
					$('#div_area').show();
					$('#div_time').show();
				}
				//重置联动选择框
				$("#catalog2 option").each(function(){
					if($(this).val()!='all'){
						$(this).remove();
						$("#catalog2").selectmenu('refresh');
					}
				});
				if($('#catalog1').children('option:selected').val()!='all'){
					showLoader();
					var paren_id = $(this).children('option:selected').val();
					$.ajax({
						type:"post",
						url:"../admin/Catalog!listByParentId.action",
						dataType:"json",
						data:{ "parent_id": paren_id},
						success:function(json){
							$.each(json.catalog_list,function(m,catalog){
								$("#catalog2").append("<option value="+catalog.id+">"+catalog.name+"</option>");

							});
							if(json.catalog_list.length==1){
								$("#catalog2").val(json.catalog_list[0].id);
							}
							$("#catalog2").selectmenu('refresh');
							hideLoader();
						}
					});
				}
			});
			initBussinessHourFlip();
			//监听按钮事件
			$("#btn_search").click(function(){
				$.cookie('catalog1',$("#catalog1").val(),{expires:1});
				$.cookie('catalog2',$("#catalog2").val(),{expires:1});
				$.cookie('suburb',$("#suburb").val(),{expires:1});
				$.cookie('bh',$("#bussiness_hour").val(),{expires:1});
				$.cookie('rootId',2,{expires:2});
				window.location.href='result.jsp';
			});

		});
		function initBussinessHourFlip(){
			var bh_data = [
				{ "input": true, "name": "", "data": ["不限", "Mon", "Tues", "Wed", "Thur", "Fri", "Sat", "Sun"] },
				{ "input": true, "name": "", "data": ["-","0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23"] },
				{ "input": true, "name": "", "data": ["-","00", "10", "20", "30", "40", "50"] }
			];
			$("#bussiness_hour").datebox({
				mode:"customflip",
				customData:bh_data,
				customHead:"何时抵达",
				overrideCustomSet:"OK",
				customFormat:"%Xa,%Xb:%Xc",
				buttonIcon:"clock",
				popupPosition:"window"
			});
		}

		//监听地区select
		$(document).on("pagebeforecreate", function (){
			showLoader();
			$("#suburb").append("<option value='hot'>---热门区域---</option>");
			$.ajax({
				type:"post",
				url:"../admin/Suburb!listHot.action",
				dataType:"json",
				data:{ "parent_id": 1,"from":"mobile","rootId":2},
				success:function(json){
					$.each(json.hot_suburb_list,function(m,suburb){
						$("#suburb").append("<option value="+suburb.id+">"+suburb.name+"</option>");
					});
					$("#suburb").append("<option value='others'>---其他区域---</option>");
					$.ajax({
						type:"post",
						url:"../admin/Suburb!listByParentId.action",
						dataType:"json",
						data:{ "parent_id": 1,"from":"mobile","rootId":2},
						success:function(json){
							$.each(json.suburb_list,function(m,suburb){
								$("#suburb").append("<option value="+suburb.id+">"+suburb.name+"</option>");
							});
							$("#suburb").selectmenu('refresh');
							hideLoader();
						}
					});
				}
			});

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
			<div id="link_r"><a href="search.jsp?rootId=2" data-ajax="false"><i class="grey fa fa-search "></i></a></div>
			<div class="logo"><img src="images/logo.png" height="50px"></div>
		</div>
		<div data-role="content">
			<form id="filterForm">
				<div class="ui-block-b block-content">
					<label for="catalog1"><strong>分类</strong></label>
					<fieldset data-role="controlgroup"data-mini="true">
						<select name="catalog1" id="catalog1">
							<option value="all">不限</option>
						</select>
						<select name="catalog2" id="catalog2">
							<option value="all">不限</option>
						</select>
					</fieldset>
				</div>
				<div class="ui-block-b block-content" id="div_area">
					<label for="suburb"><strong>区域选择</strong></label>
					<fieldset data-role="controlgroup"data-mini="true">
						<select name="suburb" id="suburb">
							<option value="all">不限</option>
						</select>
					</fieldset>
				</div>
				<div class="ui-block-b block-content" id="div_time">
					<label for="bussiness_hour"><strong>何时抵达</strong></label>
					<fieldset data-role="controlgroup"data-mini="true">
						<input id="bussiness_hour" type="text" style="text-align: center;font-weight: bold" />
					</fieldset>
				</div>
				<div class="ui-block-b block-content">
					<a href="#" id="btn_search" data-ajax="false" data-transition="slidedown" class="ui-btn ui-corner-all">马上搜索</a>
				</div>
			</form>
		</div>
		<div data-role="footer" >
			<div id="copyright"> &copy; Sydneycode.com.au 2015</div>
		</div>
  	</div>
  </body>
</html>
