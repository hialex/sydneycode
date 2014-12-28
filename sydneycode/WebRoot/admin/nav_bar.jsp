<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<script type="text/javascript">
	$(document).ready(function(){
		var username = '<s:property value="#session.user.nickname"/>';
	});
</script>
<nav class="navbar navbar-default" role="navigation">
<div class="container-fluid">
	<!-- Brand and toggle get grouped for better mobile display -->
	<div class="navbar-header">
		<a class="navbar-brand" href="index.jsp">
	        <img alt="Brand" src="../images/logo.png">
	      </a>
	</div>

	<!-- Collect the nav links, forms, and other content for toggling -->
	<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
		<ul class="nav navbar-nav" id="navId">
			
			<li class="dropdown">
	          <a href="#" class="dropdown-toggle" data-toggle="dropdown">商铺管理 <span class="caret"></span></a>
	          <ul class="dropdown-menu" role="menu">
	            <li><a href="shops_add.jsp">添加商铺</a></li>
	            <li class="divider"></li>
	           	<li><a href="shops_list.jsp">商铺列表</a></li>
	          </ul>
	        </li>
	        
			<li class="dropdown">
	          <a href="#" class="dropdown-toggle" data-toggle="dropdown">分类管理 <span class="caret"></span></a>
	          <ul class="dropdown-menu" role="menu">
	            <li><a href="catalogs_add.jsp">添加分类</a></li>
	            <li class="divider"></li>
	           	<li><a href="catalogs_list.jsp">分类列表</a></li>
	          </ul>
	        </li>
	        
	        <li class="dropdown">
	          <a href="#" class="dropdown-toggle" data-toggle="dropdown">地区管理 <span class="caret"></span></a>
	          <ul class="dropdown-menu" role="menu">
	            <li><a href="suburbs_add.jsp">添加地区</a></li>
	            <li class="divider"></li>
	           	<li><a href="suburbs_list.jsp">地区列表</a></li>
	          </ul>
	        </li>
			<li class="dropdown">
	          <a href="#" class="dropdown-toggle" data-toggle="dropdown">图片管理 <span class="caret"></span></a>
	          <ul class="dropdown-menu" role="menu">
	          <li><a href="photo_category_add.jsp">添加分类</a></li>
	          	<li><a href="photo_category_list.jsp">分类列表</a></li>
	            <li class="divider"></li>
	            <li><a href="photos_lib.jsp">图片库</a></li>
	           	<li><a href="photos_approve.jsp">图片审核(未实现)</a></li>
	          </ul>
	        </li>
			<s:if test="#session.user.role==1">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown">用户管理 <span class="caret"></span></a>
					<ul class="dropdown-menu" role="menu">
						<li><a href="users_add.jsp">添加用户</a></li>
						<li class=\"divider\"></li>
						<li><a href="users_list.jsp">用户列表</a></li>
					</ul>
				</li>
			</s:if>
		</ul>
		<ul class="nav navbar-nav navbar-right">
			<li class="dropdown">
				<a href="#" class="dropdown-toggle" data-toggle="dropdown" id="username"><s:property value="#session.user.nickname"/><span class="caret"></span></a>
				<ul class="dropdown-menu" role="menu">
					<li><a href="users_editPass.jsp?id=<s:property value="#session.user.id"/>">修改密码</a></li>
					<li class="divider"></li>
					<li><a href="../Logout.action">退出</a></li>
				</ul>
			</li>
		</ul>
	</div>
	<!-- /.navbar-collapse -->
</div>
<!-- /.container-fluid -->
</nav>
