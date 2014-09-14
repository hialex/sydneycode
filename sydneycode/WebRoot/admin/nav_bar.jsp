<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<script type="text/javascript">
	/*
	$(document).ready(function() {
		var title = '${param.title}';
		if(title=="catalogs"){
			$('#catalogs').addClass("active");
		}
		if(title=="shops"){
			$('#shops').addClass("active");
		}
		if(title=="suburbs"){
			$('#suburbs').addClass("active");
		}
	});
	*/
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
		<ul class="nav navbar-nav">
			
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

		</ul>
	</div>
	<!-- /.navbar-collapse -->
</div>
<!-- /.container-fluid -->
</nav>
