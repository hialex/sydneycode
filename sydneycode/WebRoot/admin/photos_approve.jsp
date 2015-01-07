<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
  <head>
    <meta charset="utf-8">
    <title>图片审核</title>
    
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    
	<link href="../css/bootstrap.css" rel="stylesheet">
	<link href="../css/style.css" rel="stylesheet">
	<link href="../css/dataTables.bootstrap.css" rel="stylesheet" >
   	<script src="../js/jquery.js"></script>
   	<script src="../js/bootstrap.min.js"></script>
   	<script type="text/javascript" src="../js/jquery.dataTables.js"></script>
	<script type="text/javascript" src="../js/dataTables.bootstrap.js"></script>
	<script type="text/javascript" src="../js/bootbox.min.js"></script>
	<script type="text/javascript" src="../js/user.js"></script>

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
	<script type="text/javascript" charset="utf-8">
		var category_id;
		var photo_id;
		var status;
		var root_catalog_id;
		$(document).ready(function() {
			var t = new Date().getTime();
			var params = {t:t,needCheck:true};
			//alert(t);
			$('#example').dataTable( {
	            "language": {
	                "url": "../css/Chinese.json"
	            },
	            "processing": true,
		        "serverSide": false,
				"scrollX":true,
				"order":[[8,"desc"]],
		        "ajax": {
		        	"url": "../Photolist.action",
		        	"type":"post",
		        	"data":params,
		        	"cache":false
		        },
		        "columns":[
		        	{"data":"id"},
		        	{"data":"filename","className":"cellcenter"},
					{"data":"type"},
		        	{"data":"shop_id"},
		        	{"data":"shop_name","className":"cellcenter"},
		        	{"data":"catalog_name","className":"cellcenter"},
		        	{"data":"category_name","className":"cellcenter"},
		        	{"data":"source","className":"cellcenter"},
		        	{"data":"status","className":"cellcenter"},
		        	{"data":"add_time","className":"cellcenter"},
		        	{"data":"author_name","className":"cellcenter"},
					{"data":"catalog_id"}
		        ],
		        "columnDefs":[
					{
						"data":1,
						"render":function(data,type,row){
							return '<a href="'+getRootPath()+'/upload/'+data+'" target="_blank"><img src="'+getRootPath()+'/upload/thumb/'+data+'"></a>';
						},
						"targets":1
					},
					{
						"data":4,
						"render":function(data,type,row){
							return data+'&nbsp;&nbsp;<a id="detail" href="Showshop.action?id='+row['shop_id']+'" target="_blank"><span class="glyphicon glyphicon-info-sign">';
						},
						"targets":4
					},
					{
		        		"data":7,
		        		"render":function(data,type,row){
		        			if(data=='web'){
		        				return '后台上传';
		        			}else{
		        				return '用户上传';
		        			}
		        		},
		        		"targets":7
		        	},
					{
						"data":8,
						"render":function(data,type,row){
							if(data==1){
								return '已审核';
							}else{
								return '未审核';
							}
						},
						"targets":8
					},
		        	{
		        		"data":0,
		        		"render":function(data,type,row){
		        			return "<div class=\"dropdown\">"
									+"  <button class=\"btn btn-default dropdown-toggle\" type=\"button\" id=\"dropdownMenu1\" data-toggle=\"dropdown\">"
									+"    操作"
									+"    <span class=\"caret\"></span>"
									+"  </button>"
									+"  <ul class=\"dropdown-menu\" role=\"menu\" aria-labelledby=\"dropdownMenu1\">"
									+"    <li role=\"presentation\"><a role=\"menuitem\" tabindex=\"-1\" href=\"javascript:PhotoApprove("+data+","+row['catalog_id']+")\">审核</a></li>"
									+"    <li role=\"presentation\" class=\"divider\"></li>"
									+"    <li role=\"presentation\"><a role=\"menuitem\" tabindex=\"-1\" href=\"photo_edit.jsp?id="+data+"&root_catalog_id="+row['catalog_id']+"\">编辑</a></li>"
									+"    <li role=\"presentation\"><a role=\"menuitem\" tabindex=\"-1\" href=\"javascript:DeletePhoto('"+data+"','"+row['filename']+"')\">删除</a></li>"
									+"  </ul>"
									+"</div>";
		        		},
		        		"targets":0
		        	},
					{
						"visible":false,
						"targets":3
					},
					{
						"visible":false,
						"targets":11
					}
		        ]
	        } );

			$('#btn_approve').click(function () {
				var type = $('#type').val();
				var category_id = $('#select_category').val();
				var t = new Date().getTime();
				$.ajax({
					type: "POST",
					dataType: "json",
					//cache:true,
					url: "../Photo!approve.action",
					data: { "id": photo_id,"type":type,"category_id":category_id,"t":t},
					success: function(json) {
						alert(json.message);
						$('#myModal').modal('hide');
						window.location.href = "photos_approve.jsp";

					},
					error: function() {
						alert("Oops...审核失败...\n请联系管理员！");
					}
				});
			});
		} );

		function PhotoApprove(id,catalog_id){
			photo_id = id;
			root_catalog_id = catalog_id;
			$.ajax({
				type:"post",
				url:"PhotoCategory!getPhotoCategoryByCatalogId.action",
				dataType:"json",
				data:{ "root_catalog_id":root_catalog_id},
				success:function(json){
					$.each(json.allCategories,function(m,category){
						$("#select_category").append("<option value="+category.id+">"+category.name+"</option>");
					});
				}
			});
			$('#myModal').modal('show');
		}

		function DeletePhoto(id,filename){
			bootbox.dialog({
			  message: "删除之后不能恢复，确认要删除吗？",
			  title: "Confirm",
			  buttons: {
			    delete: {
			      label: "删除",
			      className: "btn-danger",
			      callback: function() {
			        //
			        $.ajax({
			  			type:"post",
			  			url:"../Photo!delete.action",
			  			dataType:"json",
			  			data:{ "id": id,"filename":filename},
			  			success:function(json){
			  				if(json.status==1){
		                		//保存成功
		                		bootbox.alert(json.message, function() {
									window.location.href = "photos_approve.jsp";
								});
		                		
		                	}else{
		                		bootbox.alert(json.message, function() {
								});
		                	}
			  			}
			  		});
			      }
			    },
			    cancel: {
			      label: "取消",
			      className: "btn-default",
			      callback: function() {
			      }
			    }
			  }
			});
		}
	</script>
  </head>
  
  <body>
  	<div class="container">
	  	<!-- 导航菜单 -->
	    <s:include value="nav_bar.jsp" >
	    </s:include>
    	<div id="content">
    		<div class="tb">
    				<table id="example" class="table table-striped table-bordered" cellspacing="0" width="100%">
						<thead>
							<tr>
								<th></th>
								<th>图片</th>
								<th>类别</th>
								<th>商户ID</th>
								<th>商户名称</th>
								<th>商户分类</th>
								<th>图片分类</th>
								<th>来源</th>
								<th>审核状态</th>
								<th>上传日期</th>
								<th>上传者</th>
								<th>分类ID</th>
							</tr>
						</thead>
					</table>
    		</div>
    		
    	</div>
    </div>
	<!-- Modal -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">关闭</span></button>
					<h4 class="modal-title">图片审核</h4>
				</div>
				<div class="modal-body center">
					<div class="form-group select_box">
						<label for="select_category" class="control-label">图片分类</label>
						<select class="form-control" id="select_category">
						</select>

					</div>
					<div class="form-group select_box">
						<label for="type" class="control-label">照片专辑</label>
						<select class="form-control" id="type">
							<option>小编精选</option>
							<option>网友晒图</option>
						</select>

					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="btn_approve">审核</button>
				</div>
			</div>
		</div>
	</div>
 </body>
</html>
