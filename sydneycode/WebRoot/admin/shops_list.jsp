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
		        "order":[[4,"desc"]],
		        "ajax": {
		        	"url": "Shoplist.action",
		        	"type":"post",
		        	"data":params,
		        	"cache":false
		        },
		        "columns":[
		        	{"data":"shop_id"},
		        	{"data":"shop_name"},
		        	{"data":"suburb_name"},
		        	{"data":"catalog_names"},
		        	{"data":"add_time"},
		        	{"data":"shop_id"}
		        ],
		        "columnDefs":[
		        	{
		        		"data":1,
		        		"render":function(data,type,row){
		        			return '<a href="Showshop.action?id='+row["shop_id"]+'">'+data+'</a>';
		        		},
		        		"targets":1
		        	},
		        	{
		        		"data":3,
		        		"render":function(data,type,row){
		        			var s = '';
		        			for(var c in data){
		        				s+='\<span class=\"caltalog_name\"><span class=\"label label-info label1\"\>'+data[c]+'\<\/span\><\/span>'
		        			}
		        			return s;
		        		},
		        		"targets":3
		        	},
		        	{
		        		"data":5,
		        		"render":function(data,type,row){
		        			return '<a href="javascript:ShopDelete('+data+')">删除</a>&nbsp;&nbsp;&nbsp;&nbsp;' +
		        				   '<a href="shops_edit.jsp?id='+data+'">编辑</a>';
		        		},
		        		"targets":5
		        	},
		        	{
		        		"visible":false,
		        		"targets":0
		        	}
		        ]
	        } );
		} );
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
								<th>ID</th>
								<th>商铺名称</th>
								<th>Suburbs</th>
								<th>分类</th>
								<th>添加时间</th>
								<th>选项</th>
							</tr>
						</thead>
						
					</table>
    		</div>
    		
    	</div>
    </div>  
 </body>
</html>
