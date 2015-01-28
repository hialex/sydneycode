<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>

	<title>图片上传</title>

	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width,initial-scale=1" >
	<link rel="shortcut icon" href="images/favicon.ico">
	<link rel="stylesheet" href="css/jquery.mobile-1.4.4.css" >
	<link rel="stylesheet" href="css/style.css">
	<link href="../css/jquery.fancybox.css" type="text/css" rel="stylesheet" />

	<link rel="stylesheet" href="css/font-awesome.min.css" >
	<script src="js/jquery.min.js" ></script>
	<script src="js/jquery.mobile-1.4.4.min.js" ></script>
	<script src="../js/user.js"></script>
	<script src="../js/base64.js"></script>
	<script type="text/javascript" src="../js/jquery.fancybox.js"></script>
	<script type="text/javascript" src="../js/jquery.nailthumb.min.js"></script>
	<script>

		$(document).on("pagecreate","#page1",function(){
			var shop_id = getQueryString("id");
			var shop_name = new Base64().decode(getQueryString("name"));
			var root_catalog_id = getQueryString("root_catalog_id");
			$('#shop_name').html(shop_name);
			$('#shop_id').val(shop_id);
			showLoader();
			$.ajax({
				type:"post",
				url:"../admin/PhotoCategory!getPhotoCategoryByCatalogId.action",
				dataType:"json",
				data:{ "root_catalog_id":root_catalog_id},
				success:function(json){
					$.each(json.allCategories,function(m,category){
						$("#category").append("<option value="+category.id+">"+category.name+"</option>");
					});
					$("#category").selectmenu('refresh');
					hideLoader();
				}
			});

			$("#btn_upload").click(function(){
				var data = new FormData($("#uploadPhotoForm")[0]);
				showLoader();
				$.ajax({
					url:'../PhotoUpload.action',
					type:'POST',
					data:data,
					processData:false,
					contentType:false
				}).done(function(ret){
					hideLoader();
					if(ret.status==1){
						alert("图片上传成功，审核后就能看到了哦~");
						window.location.href="detail.jsp?id="+shop_id;
					}else{
						alert("Oops~上传失败，请稍后再试");
					}
				});
				return false;
			});
		});
		//显示加载器
		function showLoader() {
			//显示加载器.for jQuery Mobile 1.2.0
			$.mobile.loading('show', {
				text: '上传中，请稍候...', //加载器中显示的文字
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


	</script>
	<script>
		var fileElem,fileListm,count;
		$(document).ready(function(){
			window.URL = window.URL || window.webkitURL;
			fileElem = document.getElementById("fileElem");
			fileList = document.getElementById("fileList");
		});

		function handleFiles(obj) {
			var files = obj.files,
					img = new Image();
			if($("#fileList img").length<1){
				if(window.URL){
					//alert("1==="+count);

					img.src = window.URL.createObjectURL(files[0]);
					img.width = 200;
					img.onload = function(e) {
						window.URL.revokeObjectURL(this.src);
					};
					fileList.appendChild(img);
				}else if(window.FileReader){
					var reader = new FileReader();
					reader.readAsDataURL(files[0]);
					reader.onload = function(e){
						img.src = this.result;
						img.width = 200;
						fileList.appendChild(img);
					}
				}else{
					//ie
					obj.select();
					obj.blur();
					var nfile = document.selection.createRange().text;
					document.selection.empty();
					img.src = nfile;
					img.width = 200;

					fileList.appendChild(img);
					//count = $("#fileList img").length;
				}
			}else{
				$("#btn_alert").trigger("click");
			}


		}
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
<div data-role="page" id="page1">
	<div data-role="header" id="header">
		<div id="link_l"><a href="#" onclick="history.back();" data-ajax="false"><i class="grey fa fa-arrow-circle-left "></i></a> </div>
		<div id="link_r"><a href="index.jsp" data-ajax="false"><i class="grey fa fa-home "></i></a></div>
		<div class="logo"><img src="images/logo.png" height="50px"></div>
	</div>
	<div data-role="content"  id="detail">
		<h4 class="ui-bar ui-bar-a ui-corner-all header" id="shop_name"></h4>
		<form id="uploadPhotoForm" name="uploadPhotoForm" target="post_frame" action="../PhotoUpload.action" method="post" enctype="multipart/form-data" data-ajax="false">
			<iframe name="post_frame" id="post_frame" style="display: none" ></iframe>
			<div id="fans_share">
				<div id="fileList" style="width:200px;height:auto;"></div>
				<span class="ui-btn ui-corner-all ui-block-b block-content fileinput-button">
					<i class="grey fa fa-photo"></i> 选择照片
					<input data-role="none" name="file"  type="file" id="fileElem" accept="image/*"  onchange="handleFiles(this);return false;">
				</span>
			</div>
			<div class="ui-block-b block-content" id="div_category">
				<label for="category"><strong>照片分类</strong></label>
				<fieldset data-role="controlgroup"data-mini="true">
					<select name="photo.category_id" id="category">

					</select>
				</fieldset>
			</div>
			<div class="ui-block-b block-content" id="div_info">
				<label for="author_name"><strong>摄影师</strong></label>
				<fieldset data-role="controlgroup"data-mini="true">
					<input id="author_name" type="text" name="photo.author_name" placeholder="您的名字（可选）" />
				</fieldset>
				<label for="photoname"><strong>标题</strong></label>
				<fieldset data-role="controlgroup"data-mini="true">
					<input id="photoname" type="text" name="photo.name" placeholder="请输入图片标题（可选）" />
				</fieldset>
				<label for="intro"><strong>说明</strong></label>
				<fieldset data-role="controlgroup"data-mini="true">
					<textarea cols="40" rows="8" id="intro"  name="photo.intro" placeholder="请输入图片说明（可选）"></textarea>
				</fieldset>

			</div>
			<div class="ui-block-b block-content">
				<a href="#" id="btn_upload" data-ajax="false" data-transition="slidedown" class="ui-btn ui-corner-all"><i class="grey fa fa-send"></i> 立即上传</a>
				<input type="hidden" name="photo.source" value="mobile">
				<input type="hidden" id="shop_id" name="photo.shop_id" value="">
			</div>
		</form>
	</div>
	<div style="display: none">
		<a id="btn_alert" href="#popupDialog" data-rel="popup" data-position-to="window" data-transition="pop" class="ui-btn ui-corner-all ui-shadow ui-btn-inline ui-icon-delete ui-btn-icon-left ui-btn-b" data-ajax="false"></a>
		<div data-role="popup" id="popupDialog" data-overlay-theme="a" data-theme="a" data-dismissible="false" style="max-width:400px;">
			<div data-role="header" data-theme="a">
				<h1>Oops...</h1>
			</div>
			<div role="main" class="ui-content header">
				<p>一次只能添加一张图片哦~</p>
				<a href="#" class="ui-btn ui-corner-all ui-shadow ui-btn-inline ui-btn-a " data-rel="back">知道了</a>
			</div>
		</div>
	</div>
	<div data-role="footer">
		<div id="copyright"> &copy; Sydneycode.com.au 2015s</div>
	</div>

</div>
</body>
</html>