<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
  <head>
    <meta charset="utf-8">
    <title>用户列表</title>
    
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
		        "ajax": {
		        	"url": "Userlist.action",
		        	"type":"post",
		        	"data":params,
		        	"cache":false
		        },
		        "columns":[
		        	{"data":"id"},
		        	{"data":"username"},
		        	{"data":"nickname"},
		        	{"data":"role"},
		        	{"data":"add_time"},
		        	{"data":"last_login_time"},
		        	{"data":"last_login_ip"}
		        ],
		        "columnDefs":[
		        	{
		        		"data":3,
		        		"render":function(data,type,row){
		        			if(data==1){
		        				return '超级管理员';
		        			}else{
		        				return '管理员';
		        			}
		        		},
		        		"targets":3
		        	},
		        	{
		        		"data":0,
		        		"render":function(data,type,row){
		        			return '<a href="javascript:UserDelete('+data+')">删除</a>&nbsp;&nbsp;' +
		        				   '<a href="users_edit.jsp?id='+data+'">编辑</a>&nbsp;&nbsp;' +
									'<a href="javascript:PasswordReset('+data+')">重置密码</a>';
		        		},
		        		"targets":0
		        	}
		        ]
	        } );
		} );
		
		function UserDelete(id){
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
			  			url:"User!delete.action",
			  			dataType:"json",
			  			data:{ "uid": id},
			  			success:function(json){
			  				if(json.success){
		                		//保存成功
		                		bootbox.alert(json.message, function() {
		                			window.location.href = "users_list.jsp";
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

		function PasswordReset(id){
			bootbox.dialog({
				message: "确认要重置该用户登录密码吗？",
				title: "Confirm",
				buttons: {
					delete: {
						label: "重置",
						className: "btn-primary",
						callback: function() {
							//
							$.ajax({
								type:"post",
								url:"User!reset.action",
								dataType:"json",
								data:{ "uid": id},
								success:function(json){
									if(json.success){
										//保存成功
										bootbox.alert(json.message, function() {
											window.location.href = "users_list.jsp";
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
								<th>ID</th>
								<th>用户名</th>
								<th>姓名</th>
								<th>角色</th>
								<th>添加时间</th>
								<th>上次登录时间</th>
								<th>上次登录IP</th>
							</tr>
						</thead>
					</table>
    		</div>
    		
    	</div>
    </div>  
 </body>
</html>
