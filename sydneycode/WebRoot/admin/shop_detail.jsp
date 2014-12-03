<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
  <head>
    <meta charset="utf-8">
    <title>商户详情</title>
    
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    
	<link href="../css/bootstrap.css" rel="stylesheet">
	<link href="../css/style.css" rel="stylesheet">
	<link href="../css/shadowbox.css" type="text/css" rel="stylesheet" />
	<link href="../css/jquery.nailthumb.min.css" type="text/css" rel="stylesheet" />
	<link href="../css/style.css" type="text/css" rel="stylesheet" />
   	<script src="../js/jquery.js"></script>
   	<script src="../js/bootstrap.min.js"></script>
    <script type="text/javascript" src="../js/jquery.nailthumb.min.js"></script>
    <script type="text/javascript" src="../js/shadowbox.js"></script>
	
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
	
  </head>
  
  <body>
  	<div class="container">
	  	<!-- 导航菜单 -->
	    <s:include value="nav_bar.jsp" >
	    	<s:param name="title">catalogs</s:param>
	    </s:include>
    	<div id="content" class="row-fluid">
    		<form class="form-horizontal fill" id="addShopForm" role="form">
    		<div class="row">
    			<div class="col-sm-12 title">商户信息查看</div>
    		</div>
    		<div class="row">
	    		<div class="col-sm-12 ">
	    		    <div class="well well-sm"><strong>基本信息</strong></div>
	    		</div>
    		</div>
    		<div class="row">
    			<div class="col-sm-12">
	    			<div class="form-group">
						<label for="catalog" class="col-sm-1 control-label">店铺分类</label>
						<div class="col-sm-11" id="catalog_div">
							<s:iterator value="catalog_names_list" var="catalog">
								<div class="caltalog_label"><span class="label label-info label1"><s:property value="#catalog.name"/></span></div>
							</s:iterator>
						</div>
					</div>
					<div class="form-group">
						<label for="name" class="col-sm-1 control-label">店铺名称</label>
						<div class="col-sm-2">
							<span class="detail"><s:property value="shop.name"/></span>
						</div>
						<label for="suburbs" class="col-sm-1 control-label">地区</label>
						<div class="col-sm-3">
							<span class="detail"><s:property value="shop.suburb_name"/></span>
						</div>
						<label for="address" class="col-sm-1 control-label">地址</label>
						<div class="col-sm-4">
							<span class="detail"><s:property value="shop.addr"/></span>
						</div>
					</div>
					<div class="form-group">
						<label for="tel" class="col-sm-1 control-label">电话</label>
						<div class="col-sm-2">
							<span class="detail"><s:property value="shop.tel"  escape="false"/></span>
						</div>
						<label for="mobile" class="col-sm-1 control-label">手机</label>
						<div class="col-sm-3">
							<span class="detail"><s:property value="shop.mobile"/></span>
						</div>
						<label for="email" class="col-sm-1 control-label">Email</label>
						<div class="col-sm-4">
							<span class="detail"><a href='mailto:<s:property value="shop.email"/>'><s:property value="shop.email"/></a></span>
						</div>
					</div>
					<div class="form-group">
						<label for="weibo" class="col-sm-1 control-label">微博</label>
						<div class="col-sm-2">
							<span class="detail"><a href='<s:property value="shop.weibo_link"/>#'><s:property value="shop.weibo"/></a></span>
						</div>
						<label for="weixin" class="col-sm-1 control-label">微信</label>
						<div class="col-sm-3">
							<span class="detail"><s:property value="shop.weixin"/></span>
						</div>
						<label for="website" class="col-sm-1 control-label">网站</label>
						<div class="col-sm-4">
							<span class="detail"><a href='<s:property value="shop.website"/>'><s:property value="shop.website"/></a></span>
						</div>
						
					</div>
					<div class="form-group">
						<label for="momo" class="col-sm-1 control-label">陌陌</label>
						<div class="col-sm-2">
							<span class="detail"><s:property value="shop.momo"/></span>
						</div>
						<label for="instagram" class="col-sm-1 control-label">Instagram</label>
						<div class="col-sm-3">
							<span class="detail"><a href='<s:property value="shop.instagram_link"/>'><s:property value="shop.instagram"/></a></span>
						</div>
						<label for="facebook" class="col-sm-1 control-label">Facebook</label>
						<div class="col-sm-4">
							<span class="detail"><a href='<s:property value="shop.facebook_link"/>'><s:property value="shop.facebook"/></a></span>
						</div>
					</div>
					
					<div class="form-group">
						<label for="qq" class="col-sm-1 control-label">QQ</label>
						<div class="col-sm-2">
							<span class="detail"><s:property value="shop.qq"/></span>
						</div>
						<label for="twitter" class="col-sm-1 control-label">Twitter</label>
						<div class="col-sm-3">
							<span class="detail"><a href='<s:property value="shop.twitter_link"/>'><s:property value="shop.twitter"/></a></span>
						</div>
						<label for="youtube" class="col-sm-1 control-label">Youtube</label>
						<div class="col-sm-4">
							<span class="detail"><a href='<s:property value="shop.youtube_link"/>'><s:property value="shop.youtube"/></a></span>
						</div>
					</div>
					<div class="form-group">
						<label for="info" class="col-sm-1 control-label">简介</label>
						<div class="col-sm-11">
							<span class="detail">
								<s:property value="shop.intro" escape="false"/>
							</span>
						</div>
					</div>
					<s:if test="shop.is_takeout">
						<div class="form-group">
							<label for="takeout_time" class="col-sm-1 control-label">送餐时间</label>
							<div class="col-sm-11">
								<span class="detail">
									<s:property value="shop.takeout_time" escape="false"/>
								</span>
							</div>
						</div>
					
						<div class="form-group">
							<label for="takeout_route" class="col-sm-1 control-label">送餐路线</label>
							<div class="col-sm-11">
								<span class="detail">
									<s:property value="shop.takeout_route" escape="false"/>
								</span>
							</div>
						</div>
					</s:if>
			</div>
    		
    		
    		<div class="row">
	    		<div class="col-sm-12">
	    		    <div class="well well-sm"><strong>营业时间</strong></div>
	    		</div>
    		</div>
    		<div id="bh_div_new" class="row">
    			<div  class="col-sm-12 ">
					<div class="form-group">
						<label for="weekday" class="col-sm-1  control-label ">星期一</label>
						<div class="col-sm-3 control-label text-center" id="bh_mon">
							<s:iterator value="bussiness_hours_list" var="bh">
								<s:if test="#bh.weekday==1">
									<s:if test="#bh.is_open==true">
										<s:if test="#bh.is_need_book==true">
											<p class="text-center">By Appointment</p>
										</s:if>
										<s:else>
											<p class="text-center"><s:date name="#bh.start_time" format="HH:mm"/>~<s:date name="#bh.end_time" format="HH:mm"/></p>
										</s:else>
										
									</s:if>
									<s:else>
										<p class="text-center">CLOSED</p>
									</s:else>
								</s:if>
							</s:iterator>
						</div>
						<label for="weekday" class="col-sm-1 control-label">星期二</label>
						<div class="col-sm-3 control-label text-center" id="bh_tues">
							<s:iterator value="bussiness_hours_list" var="bh">
								<s:if test="#bh.weekday==2">
									<s:if test="#bh.is_open==true">
										<s:if test="#bh.is_need_book==true">
											<p class="text-center">By Appointment</p>
										</s:if>
										<s:else>
											<p class="text-center"><s:date name="#bh.start_time" format="HH:mm"/>~<s:date name="#bh.end_time" format="HH:mm"/></p>
										</s:else>
										
									</s:if>
									<s:else>
										<p class="text-center">CLOSED</p>
									</s:else>
								</s:if>
							</s:iterator>
						</div>
						<label for="weekday" class="col-sm-1 control-label">星期三</label>
						<div class="col-sm-3 control-label text-center" id="bh_wed">
							<s:iterator value="bussiness_hours_list" var="bh">
								<s:if test="#bh.weekday==3">
									<s:if test="#bh.is_open==true">
										<s:if test="#bh.is_need_book==true">
											<p class="text-center">By Appointment</p>
										</s:if>
										<s:else>
											<p class="text-center"><s:date name="#bh.start_time" format="HH:mm"/>~<s:date name="#bh.end_time" format="HH:mm"/></p>
										</s:else>
										
									</s:if>
									<s:else>
										<p class="text-center">CLOSED</p>
									</s:else>
								</s:if>
							</s:iterator>
						</div>
					</div>
					<div class="form-group">
						<label for="weekday" class="col-sm-1 control-label">星期四</label>
						<div class="col-sm-3 control-label text-center" id="bh_thur">
							<s:iterator value="bussiness_hours_list" var="bh">
								<s:if test="#bh.weekday==4">
									<s:if test="#bh.is_open==true">
										<s:if test="#bh.is_need_book==true">
											<p class="text-center">By Appointment</p>
										</s:if>
										<s:else>
											<p class="text-center"><s:date name="#bh.start_time" format="HH:mm"/>~<s:date name="#bh.end_time" format="HH:mm"/></p>
										</s:else>
										
									</s:if>
									<s:else>
										<p class="text-center">CLOSED</p>
									</s:else>
								</s:if>
							</s:iterator>
						</div>
						<label for="weekday" class="col-sm-1  control-label">星期五</label>
						<div class="col-sm-3 control-label text-center" id="bh_fri">
							<s:iterator value="bussiness_hours_list" var="bh">
								<s:if test="#bh.weekday==5">
									<s:if test="#bh.is_open==true">
										<s:if test="#bh.is_need_book==true">
											<p class="text-center">By Appointment</p>
										</s:if>
										<s:else>
											<p class="text-center"><s:date name="#bh.start_time" format="HH:mm"/>~<s:date name="#bh.end_time" format="HH:mm"/></p>
										</s:else>
										
									</s:if>
									<s:else>
										<p class="text-center">CLOSED</p>
									</s:else>
								</s:if>
							</s:iterator>
						</div>
						<label for="weekday" class="col-sm-1 control-label">星期六</label>
						<div class="col-sm-3 control-label text-center" id="bh_sat">
							<s:iterator value="bussiness_hours_list" var="bh">
								<s:if test="#bh.weekday==6">
									<s:if test="#bh.is_open==true">
										<s:if test="#bh.is_need_book==true">
											<p class="text-center">By Appointment</p>
										</s:if>
										<s:else>
											<p class="text-center"><s:date name="#bh.start_time" format="HH:mm"/>~<s:date name="#bh.end_time" format="HH:mm"/></p>
										</s:else>
										
									</s:if>
									<s:else>
										<p class="text-center">CLOSED</p>
									</s:else>
								</s:if>
							</s:iterator>
						</div>
					</div>
					<div class="form-group">
						<label for="weekday" class="col-sm-1 control-label">星期日</label>
						<div class="col-sm-3 control-label text-center" id="bh_sun">
							<s:iterator value="bussiness_hours_list" var="bh">
								<s:if test="#bh.weekday==7">
									<s:if test="#bh.is_open==true">
										<s:if test="#bh.is_need_book==true">
											<p class="text-center">By Appointment</p>
										</s:if>
										<s:else>
											<p class="text-center"><s:date name="#bh.start_time" format="HH:mm"/>~<s:date name="#bh.end_time" format="HH:mm"/></p>
										</s:else>
										
									</s:if>
									<s:else>
										<p class="text-center">CLOSED</p>
									</s:else>
								</s:if>
							</s:iterator>
						</div>
					</div>
    			</div>
    		</div>
    		<div class="row">
	    		<div class="col-sm-12">
	    		    <div class="well well-sm"><strong>Gallery</strong></div>
	    		</div>
    		</div>
    		<div class="row gallery">
	    		<div class="span12 ">
	    			<s:iterator value="pics" var="pic">
   		    			<a class="square-thumb " rel="shadowbox[gallery]" href='<s:property value="#pic.name"/>'></a>
   		    		</s:iterator>
	    		</div>
    		</div>
    		
    		</form>
    	</div>
    </div>
  	<script type="text/javascript">
	  	jQuery(document).ready(function() {
           jQuery('.square-thumb').nailthumb({
               imageFromWrappingLink:true
           });
           Shadowbox.init();
       });
	  	
  	</script>
  </body>
</html>
