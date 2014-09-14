<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>悉游纪</title>
		<link rel="shortcut icon" href="../images/favicon.ico">
		<link rel="stylesheet" href="../css/themes/default/jquery.mobile-1.4.3.min.css">
		<link rel="stylesheet" href="_assets/css/jqm-demos.css">
	    <link rel="stylesheet" href="../css/fonts/googlefonts.css">
	    <link rel="stylesheet" href="../css/m.css">
		<script src="../js/jquery.min.js"></script>
		<script src="_assets/js/index.js"></script>
		<script src="../js/jquery.mobile-1.4.3.min.js"></script>
		
		<script type="text/javascript">
			$(function(){
				$.ajax({
					url:'../admin/Suburblist.action',
					type:"POST",
					datatype:'json',
					success:function(json){
						for(var i=0;i<json.data.length;i++){
							var content = '<option>'+json.data[i].name+'</option>';
							$('#select-suburb').append(content);
						}
						$('#select-suburb').selectmenu();
					}
				});
				
				
			});
		</script>
	</head>>
  
  <body>
    <div data-role="page" class="jqm-demos jqm-home">

		<div data-role="header" class="jqm-header">
			<h2><img src="../images/m_logo.png" alt="Sydneycode"></h2>
			<a href="#" class="jqm-navmenu-link ui-btn ui-btn-icon-notext ui-corner-all ui-icon-bars ui-nodisc-icon ui-alt-icon ui-btn-left">Menu</a>
			<!--  <a href="#" class="jqm-search-link ui-btn ui-btn-icon-notext ui-corner-all ui-icon-search ui-nodisc-icon ui-alt-icon ui-btn-right">Search</a>-->
		</div><!-- /header -->
	
		<div role="main" class="ui-content jqm-content">
			  <form>
			    <ul data-role="listview" data-inset="true">
			        <li class="ui-field-contain">
			            <label for="suburb">地区：</label>
			            <select name="suburb" id="select-suburb" attr="1" data-native-menu="false">
			            	<option>Choose Suburb</option>
					    </select>
			        </li>
			        <li class="ui-field-contain">
			            <label for="catalog">分类：</label>
			            <fieldset data-role="controlgroup" data-type="horizontal">
			        	<select name="catalog" id="select-catalog">
					        <option value="#">One</option>
					        <option value="#">Two</option>
					        <option value="#">Three</option>
					    </select>
					    <select name="catalog" id="select-catalog">
					        <option value="#">One</option>
					        <option value="#">Two</option>
					        <option value="#">Three</option>
					    </select>
					    </fieldset>
			        </li>
			        <li class="ui-field-contain">
			            <label for="flip2">营业时间：</label>
			            <select name="flip2" id="flip2" data-role="slider">
			                <option value="off">Off</option>
			                <option value="on">On</option>
			            </select>
			        </li>
			        <li class="ui-body ui-body-b">
			            <fieldset class="ui-grid">
			                    <div class="ui-block"><button type="submit" class="ui-btn ui-corner-all">马上搜索</button></div>
			            </fieldset>
			        </li>
			    </ul>
			</form>
		</div>
		<div data-role="panel" class="jqm-navmenu-panel" data-position="left" data-display="overlay" data-theme="a">
	    	<ul class="jqm-list ui-alt-icon ui-nodisc-icon">
				<li data-filtertext="homepage" data-icon="home"><a href="index.jsp">首页</a></li>
				<li data-filtertext="search food"><a href="/s_food.jsp" data-ajax="false">美食</a></li>
				<li data-filtertext="search service"><a href="/s_service.jsp" data-ajax="false">服务</a></li>
				<li data-filtertext="search shopping"><a href="/s_shopping.jsp" data-ajax="false">购物</a></li>
				<li data-filtertext="search entertainment"><a href="/s_fun.jsp" data-ajax="false">娱乐</a></li>
				<li data-filtertext="search sports"><a href="/s_sport.jsp" data-ajax="false">运动</a></li>
			</ul>
		</div><!-- /panel -->
		
		<div data-role="footer" data-position="fixed" data-tap-toggle="false" class="jqm-footer">
			<p>悉游纪</p>
			<p>Copyright 2014 SydneyCode.com</p>
		</div><!-- /footer -->
		
	</div><!-- /page -->
  </body>
</html>
