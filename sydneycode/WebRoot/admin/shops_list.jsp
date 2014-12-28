<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
  <head>
    <meta charset="utf-8">
    <title>商铺列表</title>
    
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
	<script type="text/javascript" src="../js/base64.js"></script>
	<!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
      <script src="../js/html5.js"></script>
    <![endif]-->
	<style>
		.table > tbody > tr > td{
			vertical-align:middle;
		}
	</style>
	<!-- Fav and touch icons -->
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="../assets/ico/apple-touch-icon-144-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="../assets/ico/apple-touch-icon-114-precomposed.png">
      <link rel="apple-touch-icon-precomposed" sizes="72x72" href="../assets/ico/apple-touch-icon-72-precomposed.png">
                    <link rel="apple-touch-icon-precomposed" href="../assets/ico/apple-touch-icon-57-precomposed.png">
                                   <link rel="shortcut icon" href="../assets/ico/favicon.png">
	<script type="text/javascript" charset="utf-8">
		var shop_id;
		$(document).ready(function() {
			var t = new Date().getTime();
			var params = {t:t};
			//alert(t);
			$('#example').dataTable( {
	            "language": {
	                "url": "../css/Chinese.json"
	            },
	            "processing": true,
		        "serverSide": false,
		        "scrollX":true,
		        "order":[[6,"desc"]],
		        "pageLength":50,
		        "ajax": {
		        	"url": "Shoplist.action",
		        	"type":"post",
		        	"data":params,
		        	"cache":false
		        },
		        "columns":[
		        	{"data":"shop_id"},
		        	{"data":"root_catalog_id"},
		        	{"data":"root_catalog_name","className":"cellcenter"},
		        	{"data":"shop_name"},
		        	{"data":"suburb_name"},
		        	{"data":"catalog_names","className":"cellleft"},
		        	{"data":"add_time"}
		        	
		        ],
		        "columnDefs":[
		        	{
		        		"data":3,
		        		"render":function(data,type,row){
		        			return '<a href="Showshop.action?id='+row["shop_id"]+'">'+data+'</a>';
		        		},
		        		"targets":3
		        	},
		        	{
		        		"data":5,
		        		"render":function(data,type,row){
		        			var s = '';
		        			for(var c in data){
		        				if(c%3==0)s+='<p></p>';
		        				s+='\<span class=\"caltalog_name\"><span class=\"label label-info label1\"\>'+data[c]+'\<\/span\><\/span>';
		        				
		        			}
		        			return s;
		        		},
		        		"targets":5
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
									+"    <li role=\"presentation\"><a role=\"menuitem\" tabindex=\"-1\" href=\"photo_upload.jsp?id="+data+"&root_catalog_id="+row["root_catalog_id"]+"&name="+getEncodeName(row["shop_name"])+"\">上传图片</a></li>"
									+"    <li role=\"presentation\"><a role=\"menuitem\" tabindex=\"-1\" href=\"photos_list.jsp?id="+data+"&root_catalog_id="+row["root_catalog_id"]+"&name="+getEncodeName(row["shop_name"])+"\">查看图片</a></li>"
									+"    <li role=\"presentation\" class=\"divider\"></li>"
									+"    <li role=\"presentation\"><a role=\"menuitem\" tabindex=\"-1\" href=\"javascript:SetRootCatalog('"+data+"')\">设置归属</a></li>"
									+"    <li role=\"presentation\" class=\"divider\"></li>"
									+"    <li role=\"presentation\"><a role=\"menuitem\" tabindex=\"-1\" href=\"javascript:SetTop('"+data+"')\">置顶</a></li>"
									+"    <li role=\"presentation\"><a role=\"menuitem\" tabindex=\"-1\" href=\"shops_edit.jsp?id="+data+"\">编辑</a></li>"
									+"    <li role=\"presentation\"><a role=\"menuitem\" tabindex=\"-1\" href=\"javascript:ShopDelete('"+data+"')\">删除</a></li>"
									+"  </ul>"
									+"</div>";
		        		},
		        		"targets":0
		        	},
		        	{
		        		"visible":false,
		        		"targets":1
		        	}
		        ]
	        } );
		} );
		function getEncodeName(str){
			var b = new Base64();
			return b.encode(str);
		}
		function ShopDelete(id){
			bootbox.dialog({
			  message: "删除之后不能恢复，图片等关联数据也将被删除，确认要删除这条数据吗？",
			  title: "Confirm",
			  buttons: {
			    delete: {
			      label: "删除",
			      className: "btn-danger",
			      callback: function() {
			        //
			        $.ajax({
			  			type:"post",
			  			url:"Shop!delete.action",
			  			dataType:"json",
			  			data:{ "id": id},
			  			success:function(json){
			  				if(json.status==1){
		                		//保存成功
		                		bootbox.alert(json.message, function() {
		                			window.location.href = "shops_list.jsp";
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
		function SetTop(id){
			bootbox.prompt("请输入置顶序号，数字越大排序越前",function(result){
				if(result === null||result==""){
					alert("置顶操作取消，请输入有效数字！");
				}else{
					$.ajax({
			  			type:"post",
			  			url:"Shop!top.action",
			  			dataType:"json",
			  			data:{ "id": id,"top_id":result},
			  			success:function(json){
			  				if(json.status==1){
		                		//保存成功
		                		bootbox.alert(json.message, function() {
		                			window.location.href = "shops_list.jsp";
								});
		                		
		                	}else{
		                		bootbox.alert(json.message, function() {
								});
		                	}
			  			}
			  		});
				}
			});
		}
		function SetRootCatalog(id){
			shop_id = id;
			//获取顶级分类并填充
	  		$.ajax({
	  			type:"post",
	  			url:"Catalog!listByParentId.action",
	  			dataType:"json",
	  			data:{ "parent_id": 0},
	  			success:function(json){
	  				$.each(json.catalog_list,function(m,catalog){
	  					$("#select_catalog").append("<option value="+catalog.id+">"+catalog.name+"</option>");
	  				});
	  			},
	  			complete:function(){
	  				$('#myModal').modal('show');
	  			}
	  		});
		}
		$(document).ready(function() {
			$("#btn_set_root_catalog").click(function(){
				var root_catalog_id = $("#select_catalog").val();
				var t = new Date().getTime();
				$.ajax({
		  			type:"post",
		  			url:"Shop!setRootCatalog.action",
		  			dataType:"json",
		  			data:{ "root_catalog_id": root_catalog_id,"id":shop_id,"t":t},
		  			success: function(json) {
	                	if(json.status==1){
	                		$('#myModal').modal('hide');
	                		//保存成功
	                		bootbox.alert(json.message, function() {
	                			window.location.href = "shops_list.jsp";
							});
	                	}else{
	                		alert(json.message);
	                	}
	                	
	                },
	                error: function() {
	                    alert("Oops...设置失败...\n请联系管理员！");
	                }
		  		});
			});
			
		});
		
	</script>
  </head>
  
  <body>
  	<div class="container">
	  	<!-- 导航菜单 -->
	    <s:include value="nav_bar.jsp" >
	    	<s:param name="title">catalogs</s:param>
	    </s:include>
    	<div id="content">
    		<div class="tb">
    				<table id="example" class="table table-striped table-bordered" cellspacing="0" width="100%">
						<thead>
							<tr>
								<th> </th>
								<th>归属编号</th>
								<th>归属</th>
								<th>商铺名称</th>
								<th>Suburbs</th>
								<th>分类</th>
								<th>添加时间</th>
							</tr>
						</thead>
						
					</table>
    		</div>
    		<!-- Modal -->
			<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			  <div class="modal-dialog">
			    <div class="modal-content">
			      <div class="modal-header">
			        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">关闭</span></button>
			        <h4 class="modal-title">请选择归属分类</h4>
			      </div>
			      <div class="modal-body center">
			      	<div class="form-group select_box">
						<select class="form-control" id="select_catalog">
						</select>
					</div>
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
			        <button type="button" class="btn btn-primary" id="btn_set_root_catalog">设置</button>
			      </div>
			    </div>
			  </div>
			</div>
    	</div>
    </div>  
 </body>
</html>
