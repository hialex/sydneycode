<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
  <head>
    
    <title>饮食</title>
    
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1" >
	<link rel="shortcut icon" href="../images/favicon.ico">
    <link rel="stylesheet" href="../css/jquery.mobile-1.4.4.css" >
	<link rel="stylesheet" href="../css/style.css">
    <script src="../js/jquery.min.js" ></script>
  	<script src="../js/jquery.mobile-1.4.4.min.js" ></script>
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
				url:"http://202.102.41.153/sydneycode/admin/Catalog!listByParentId.action",
				dataType:"json",
				data:{ "parent_id": '1'},
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
				console.log("catalog1==="+$("#catalog1").val());
				console.log("catalog2==="+$("#catalog2").val());
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
						url:"http://202.102.41.153/sydneycode/admin/Catalog!listByParentId.action",
						dataType:"json",
						data:{ "parent_id": paren_id},
						success:function(json){
							$.each(json.catalog_list,function(m,catalog){
								$("#catalog2").append("<option value="+catalog.id+">"+catalog.name+"</option>");
							});
							//$("#catalog1").selectmenu('refresh');
							$("#catalog2").selectmenu('refresh');
							hideLoader();
						}
					});
				}
			});
			//监听按钮事件
			$("#btn_search").click(function(){
				//alert("提交搜索！");
				console.log("提交搜索");
				console.log("catalog1==="+$("#catalog1").val());
				console.log("catalog2==="+$("#catalog2").val());
			});

		});
		//监听地区select
		$(document).on("pagebeforecreate", function (event){
			showLoader();
			$("#suburb").append("<option value='hot'>---热门区域---</option>");
			$.ajax({
				type:"post",
				url:"http://202.102.41.153/sydneycode/admin/Suburb!listHot.action",
				dataType:"json",
				data:{ "parent_id": 1},
				success:function(json){
					$.each(json.hot_suburb_list,function(m,suburb){
						$("#suburb").append("<option value="+suburb.id+">"+suburb.name+"</option>");
					});
					$("#suburb").append("<option value='others'>---其他区域---</option>");
					$.ajax({
						type:"post",
						url:"http://202.102.41.153/sydneycode/admin/Suburb!listByParentId.action",
						dataType:"json",
						data:{ "parent_id": 1},
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
  </head>
  
  <body>
    <div data-role="page">
		<div data-role="header">
			<div align="center"><img src="../images/logo.png"></div>
		</div>
		<div data-role="content">
			<form id="filterForm">
				<div class="ui-block-b block-content">
					<label for="catalog"><strong>饮食分类</strong></label>
					<fieldset data-role="controlgroup"data-mini="true">
						<select name="catalog1" id="catalog1">
							<option value="all">不限</option>
						</select>
						<select name="catalog2" id="catalog2">
							<option value="all">不限</option>
						</select>
					</fieldset>
				</div>
				<div class="ui-block-b block-content">
					<label for="suburb"><strong>区域选择</strong></label>
					<fieldset data-role="controlgroup"data-mini="true">
						<select name="suburb" id="suburb">
							<option value="all">不限</option>
						</select>
					</fieldset>
				</div>
				<div class="ui-block-b block-content">
					<label for="bussiness_hour"><strong>营业时间</strong></label>
					<fieldset data-role="controlgroup"data-mini="true">
						<select name="bussiness_hour" id="bussiness_hour">
							<option value="all">不限</option>
						</select>
					</fieldset>
				</div>
				<div class="ui-block-b block-content">
					<button id="btn_search" class="ui-btn ui-btn-b ui-corner-all ui-icon-search ui-btn-icon-left ui-shadow-icon">马上搜索</button>
				</div>
			</form>
		</div>
		<div data-role="footer" >
			<div id="footer"> &copy; Sydneycode.com.au 2014</div>
		</div>
  	</div>
  </body>
</html>
