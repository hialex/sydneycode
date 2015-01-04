<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
  <head>
    <meta charset="utf-8">
    <title>添加商铺</title>
    
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    
	<link href="../css/bootstrap.css" rel="stylesheet">
	<link href="../css/bootstrap-switch.min.css" rel="stylesheet">
	<link href="../css/bootstrap-multiselect.css" rel="stylesheet">
	<link href="../css/bootstrap-datetimepicker.min.css" rel="stylesheet">
	<link href="../css/style.css" rel="stylesheet">
	<link rel="stylesheet" type="text/css" href="../css/uploadify.css"> 
   	<script src="../js/jquery.js"></script>
   	<script src="../js/bootstrap.min.js"></script>
	<script src="../js/jquery.uploadify.js"></script>
	<script src="../js/jqBootstrapValidation.js"></script>
	<script src="../js/map.js"></script>
	<script src="../js/bussiness_hour.js"></script>
	<script src="../js/bootstrap-switch.min.js"></script>
	<script src="../js/bootstrap-multiselect.js"></script>
	<script src="../js/util.js"></script>
	<script src="../js/bootstrap-datetimepicker.min.js" charset="UTF-8"></script>
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
	<script type="text/javascript">
		
		$(document).ready(function() {
			//外卖处理
			$("#takeout_time_div").hide();
			$("#takeout_route_div").hide();
			var m = new Map(); 
			var arr_catalogs = new Array();　
			var arr_picurls = new Array();
			var arr_bussiness_hour = new Array();
			//--新营业时间start
			//获取原始weekday option
			var weekday_option = $('#select_copy_to').html();
			$('#bh_div_new').hide();
			$('#add_bh_new').click(function(){
				if($('#add_bh_new').is(":checked")){
					$('#bh_div_new').show();
				}else{
					$('#bh_div_new').hide();
				}
			});
			//监听添加营业时间提示按钮
	  		$('#btn_add_bh_info').click(function(){
	  			//重置form
	  			$('#addBHForm')[0].reset();
	  			$('#bhModal').modal('show');
	  		});
			//设置OPEN state switch
			$("[name='checkbox_is_open']").bootstrapSwitch('onText',"Open");
			$("[name='checkbox_is_open']").bootstrapSwitch('offText',"Closed");
			$("[name='checkbox_is_need_book']").bootstrapSwitch('onText',"YES");
			$("[name='checkbox_is_need_book']").bootstrapSwitch('offText',"NO");
			//设置switch closed
			$("[name='checkbox_is_open']").bootstrapSwitch('onSwitchChange',function(event,state){
				$("#bh_start_time").val('');
				$("#bh_end_time").val('');
				if(!state){
					$('#bh_time_div').hide();
				}else{
					$('#bh_time_div').show();
				}
			});
			//设置是否需要预定
			$("[name='checkbox_is_need_book']").bootstrapSwitch('onSwitchChange',function(event,state){
				if(state){
					$('#bh_input_time').hide();
				}else{
					$("#bh_start_time").val('');
					$("#bh_end_time").val('');
					$('#bh_input_time').show();
				}
			});
			
			//初始化多重选择
			$('#select_copy_to').multiselect({
				includeSelectAllOption: true
			});
			//设置weekday select联动
			$("#select_weekday").change(function(){
				var weekday = $("#select_weekday").val();
				if(weekday!=-1){
					//重置select_copy_to
					$('#select_copy_to').html('');
					$('#select_copy_to').append(weekday_option);
					//剔除相同weekday
					$("#select_copy_to option").each(function(){
		  				if($(this).val()==weekday){
		  					$(this).remove();
		  				}
		  				$('#select_copy_to').multiselect('rebuild');
		  			});
				}
			});
			//初始化timepicker
			$('#bh_start_time,#bh_end_time').datetimepicker({
				format: 'HH:ii P',
				startView:'day',
				minView:'hour',
				maxView:'day',
				showMeridian:true,
				initialDate:new Date(),
				autoclose:true
			});
			//监听营业时间添加按钮
			$('#btn_add_bh').click(function(){
				var bh_start_time = $("#bh_start_time").val();
				var bh_end_time = $("#bh_end_time").val();
				var open_status = $('#checkbox_is_open').bootstrapSwitch('state');
				
				var copy_to_weekdays = new Array();
				var weekday = $("#select_weekday").val();
				if(open_status){
					var need_book = $('#checkbox_is_need_book').bootstrapSwitch('state');
					if($("#select_weekday").val()==-1){
						alert("必选项，请选择Weekday！");
						$("#select_weekday").focus();
						return false;
					}
					if(!need_book){
						//不需要预定
						if(bh_start_time==''){
							alert("必选项，请选择开门时间！");
							$("#bh_start_time").focus();
							return false;
						}else if(bh_end_time==''){
							alert("必选项，请选择打烊时间！");
							$("#bh_end_time").focus();
							return false; 
						}else{
							if($('#select_copy_to').val()!=null){
								//复制到其他weekday
								copy_to_weekdays = $('#select_copy_to').val();
								copy_to_weekdays.push($("#select_weekday").val());
								copy_to_weekdays.sort();
								for(var i=0;i<copy_to_weekdays.length;i++){
									for(var j=0;j<arr_bussiness_hour.length;j++){
										if((arr_bussiness_hour[j].weekday==copy_to_weekdays[i])&&(!arr_bussiness_hour[j].is_open)){
											//有相同weekday记录,且为closed
											//alert(copy_to_weekdays[i]+"已为关闭！");
											arr_bussiness_hour.splice(j,1);
										}
										if((arr_bussiness_hour[j].weekday==copy_to_weekdays[i])&&(arr_bussiness_hour[j].is_open)&&(arr_bussiness_hour[j].is_need_book)){
											//有相同weekday记录,且为by appointment
											//alert(copy_to_weekdays[i]+"已为关闭！");
											arr_bussiness_hour.splice(j,1);
										}
									}
									var bh = new Bussiness_hour();
									bh.weekday = copy_to_weekdays[i];
				  					bh.is_open = open_status;
				  					bh.is_need_book = need_book;
			  						bh.start_time = $("#bh_start_time").val();
			  						bh.end_time = $("#bh_end_time").val();
				  					arr_bussiness_hour.push(bh);
								}
							}else{
								//不复制
		  						var bh = new Bussiness_hour();
								bh.weekday = $("#select_weekday").val();
			  					bh.is_open = open_status;
								bh.is_need_book = need_book;
		  						bh.start_time = $("#bh_start_time").val();
		  						bh.end_time = $("#bh_end_time").val();
			  					for(var q=0;q<arr_bussiness_hour.length;q++){
			  						//有相同weekday记录,且为closed
			  						var close_flag = (arr_bussiness_hour[q].weekday==bh.weekday)&&(arr_bussiness_hour[q].is_open==false);
			  						//有相同weekday记录,且为by appointment
			  						var book_flag = (arr_bussiness_hour[q].weekday==bh.weekday)&&(arr_bussiness_hour[q].is_open==true)&&(arr_bussiness_hour[q].is_need_book==true);
			  						if(close_flag){
				  						arr_bussiness_hour.splice(q,1);
			  						}
			  						if(book_flag){
				  						arr_bussiness_hour.splice(q,1);
			  						}
			  						
			  					} 
	  							arr_bussiness_hour.push(bh);
							}
						}
					}else{
						//需要预定
						if($('#select_copy_to').val()!=null){
							//复制到其他weekday
							copy_to_weekdays = $('#select_copy_to').val();
							copy_to_weekdays.push($("#select_weekday").val());
							copy_to_weekdays.sort();
							for(var i=0;i<copy_to_weekdays.length;i++){
								for(var j=0;j<arr_bussiness_hour.length;j++){
									if((arr_bussiness_hour[j].weekday==copy_to_weekdays[i])&&(!arr_bussiness_hour[j].is_open)){
										//有相同weekday记录,且为closed
										//alert(copy_to_weekdays[i]+"已为关闭！");
										arr_bussiness_hour.splice(j,1);
									}
									if((arr_bussiness_hour[j].weekday==copy_to_weekdays[i])&&(arr_bussiness_hour[j].is_open)){
										//有相同weekday记录,且为by appointment
										//alert(copy_to_weekdays[i]+"已为关闭！");
										arr_bussiness_hour.splice(j,1);
									}
								}
								var bh = new Bussiness_hour();
								bh.weekday = copy_to_weekdays[i];
			  					bh.is_open = open_status;
			  					bh.is_need_book = need_book;
			  					arr_bussiness_hour.push(bh);
							}
						}else{
	  						var bh = new Bussiness_hour();
							bh.weekday = $("#select_weekday").val();
		  					bh.is_open = open_status;
							bh.is_need_book = need_book;
		  					for(var q=0;q<arr_bussiness_hour.length;q++){
		  						//有相同weekday记录,且为closed
		  						var close_flag = (arr_bussiness_hour[q].weekday==bh.weekday)&&(arr_bussiness_hour[q].is_open==false);
		  						//有相同weekday记录,且为by appointment
		  						var book_flag = (arr_bussiness_hour[q].weekday==bh.weekday)&&(arr_bussiness_hour[q].is_open==true);
		  						if(close_flag){
			  						arr_bussiness_hour.splice(q,1);
		  						}
		  						if(book_flag){
			  						arr_bussiness_hour.splice(q,1);
		  						}
		  					} 
  							arr_bussiness_hour.push(bh);
						}
					}
				}else{
					//关闭状态，清除原数据
					for(var i=0;i<arr_bussiness_hour.length;i++){
						if(arr_bussiness_hour[i].weekday==weekday){
							arr_bussiness_hour.splice(i,1);
						}
					}
					var bh = new Bussiness_hour();
					bh.weekday = $("#select_weekday").val();
  					bh.is_open = open_status;
  					arr_bussiness_hour.push(bh);
				}
				
				
				//2.提交页面显示
				$("#bh_mon,#bh_tues,#bh_wed,#bh_thur,#bh_fri,#bh_sat,#bh_sun").html('');
				for(var i=0;i<arr_bussiness_hour.length;i++){
					var content = "";
					var w = arr_bussiness_hour[i].weekday;
					var o = arr_bussiness_hour[i].is_open;
					var b = arr_bussiness_hour[i].is_need_book;
					if(o){
						if(!b){
							var s = arr_bussiness_hour[i].start_time;
							var e = arr_bussiness_hour[i].end_time;
							content = "<p class=\"text-center\">"+s+"~"+e+"</p>";
						}else{
							content = "<p class=\"text-center\">By Appointment</p>";
						}
						
					}else{
						content = "<p class=\"text-center\">CLOSED</p>";
					}
					
					
					
					//alert("====>"+content);
					switch(w){
						case '1':
							//alert("case1");
							$("#bh_mon").append(content);
							break;
						case '2':
							$("#bh_tues").append(content);
							break;
						case '3':
							$("#bh_wed").append(content);
							break;
						case '4':
							$("#bh_thur").append(content);
							break;
						case '5':
							$("#bh_fri").append(content);
							break;
						case '6':
							$("#bh_sat").append(content);
							break;
						case '7':
							$("#bh_sun").append(content);
							break;
						default:
							break;
					}
				}
				$('#bhModal').modal('hide');
				
			});
			//--新营业时间end
			
			//添加照片checkbox监听
			$('#pics_div').hide();
			$('#add_pics').click(function(){
				if($('#add_pics').is(":checked")){
					$('#pics_div').show();
				}else{
					$('#pics_div').hide();
				}
			});
	  		//监听顶级分类，获取一级分类并填充
	  		$("#select_top").change(function(){
	  			//重置联动选择框
	  			$("#select_level1 option").each(function(){
	  				if($(this).val()!=-1){
	  					$(this).remove();
	  				}
	  			});
	  			$("#select_level2 option").each(function(){
	  				if($(this).val()!=-1){
	  					$(this).remove();
	  				}
	  			});
	  			//$("#select_level1 option:first").prop("selected",'selected');
	  			if($("#select_top").children('option:selected').val()!=-1){
	  				var paren_id = $(this).children('option:selected').val();
		  			$.ajax({
			  			type:"post",
			  			url:"Catalog!listByParentId.action",
			  			dataType:"json",
			  			data:{ "parent_id": paren_id},
			  			success:function(json){
			  				$.each(json.catalog_list,function(m,catalog){
			  					$("#select_level1").append("<option value="+catalog.id+">"+catalog.name+"</option>");
			  				});
			  			}
			  		});
	  			}
	  			
	  		});
	  		//监听一级分类，获取二级分类并填充
	  		$("#select_level1").change(function(){
	  			$("#select_level2 option").each(function(){
	  				if($(this).val()!=-1){
	  					$(this).remove();
	  				}
	  			});
	  			if($("#select_level1").children('option:selected').val()!=-1){
	  				var paren_id = $(this).children('option:selected').val();
		  			$.ajax({
			  			type:"post",
			  			url:"Catalog!listByParentId.action",
			  			dataType:"json",
			  			data:{ "parent_id": paren_id},
			  			success:function(json){
			  				$.each(json.catalog_list,function(m,catalog){
			  					$("#select_level2").append("<option value="+catalog.id+">"+catalog.name+"</option>");
			  				});
			  			}
			  		});
	  			}
	  			
	  		});
	  		
	  		getSuburbs();
	  		
	  		//监听添加分类提示按钮
	  		$('#btn_add_catalog_info').click(function(){
	  			resetSelect();
	  			getTopCatalog();
	  			$('#myModal').modal('show');
	  		});
	  		//监听添加分类提示按钮
	  		$('#btn_add_catalog').click(function(){
	  			var top = $('#select_top').val();
	  			var select_level1 = $('#select_level1').val();
	  			var select_level2 = $('#select_level2').val();
	  			if(top=='-1'){
	  				alert("请选择顶级分类！");
	  				$('#select_top').focus();
	  			}else if(select_level1=='-1'){
	  				alert("请选择一级分类！");
	  				$('#select_level1').focus();
	  			}else if(select_level2=='-1'){
	  				alert("请选择二级分类！");
	  				$('#select_level2').focus();
	  			}else{
	  				//获取select_level2的值作为parent_id
	  				//拼接名称显示
	  				var top_name = $('#select_top').find("option:selected").text();
	  				var level1_name = $('#select_level1').find("option:selected").text();
	  				var level2_name = $('#select_level2').find("option:selected").text();
	  				var catalog_id =  select_level2;
	  				var catalog_name =  top_name+"\\"+level1_name+"\\"+level2_name;
					m.put(catalog_id,catalog_name);
					arr_catalogs.push(catalog_id);
					var s = "";  
					$('#catalog_div').text("");
					m.each(function(key,value,index){  
						//s += index+":"+ key+"="+value+"/n"; 
						$('#catalog_div').append('\<div class=\"caltalog_label\"><span class=\"label label-default label1\"\>'+value+'\<\/span\><\/div>');
						
					});
	  				$('#myModal').modal('hide');
	  				//送餐时间
	  				if(level1_name=="外卖"){
	  					$("#is_takeout").attr("value",'true');
	  					$("#takeout_time_div").show();
	  					$("#takeout_route_div").show();
	  				}else{
	  					$("#takeout_time_div").hide();
	  					$("#takeout_route_div").hide();
	  					$("#is_takeout").removeAttr("value");
	  				}
		  		}
	  		});
	  		//监听保存信息按钮
	  		function valid(){
	  			//信息验证
	  			if(arr_catalogs.length==null||arr_catalogs.length<1){
	  				alert("请至少选择一个分类！");
	  				$('#btn_add_catalog_info').click();
	  				return false;
	  			}else if($('#select_suburbs').val()=='-1'){
	  				alert("请选择Suburbs！");
	  				$('#select_suburbs').focus();
	  				return false;
	  			}else{
	  				return true;
	  			}
	  			return false;
	  		}
	  		
	  		//初始化验证
	  		$('#addShopForm').jqBootstrapValidation();	
	  		//重置分类选择下拉框
	  		function resetSelect(){
	  			$("#select_top option").each(function(){
	  				if($(this).val()!=-1){
	  					$(this).remove();
	  				}
	  			});
  				$("#select_level1 option").each(function(){
	  				if($(this).val()!=-1){
	  					$(this).remove();
	  				}
	  			});
  				$("#select_level2 option").each(function(){
	  				if($(this).val()!=-1){
	  					$(this).remove();
	  				}
	  			});
	  		}
	  		
	  		function getTopCatalog(){
				//获取顶级分类并填充
		  		$.ajax({
		  			type:"post",
		  			url:"Catalog!listByParentId.action",
		  			dataType:"json",
		  			data:{ "parent_id": 0},
		  			success:function(json){
		  				$.each(json.catalog_list,function(m,catalog){
		  					$("#select_top").append("<option value="+catalog.id+">"+catalog.name+"</option>");
		  				});
		  			}
		  		});
			}
			function getSuburbs(){
				$.ajax({
		  			type:"post",
		  			url:"Suburb!listHot.action",
		  			dataType:"json",
		  			data:{ "parent_id": 1},
		  			success:function(json){
		  				$.each(json.hot_suburb_list,function(m,suburb){
		  					$("#select_suburbs").append("<option value="+suburb.id+">"+suburb.name+"</option>");
		  				});
		  				$("#select_suburbs").append("<option value='' disabled>-------------</option>");
		  				//获取所有地区填充
				  		$.ajax({
				  			type:"post",
				  			url:"Suburb!listByParentId.action",
				  			dataType:"json",
				  			data:{ "parent_id": 1},
				  			success:function(json){
				  				$.each(json.suburb_list,function(m,suburb){
				  					$("#select_suburbs").append("<option value="+suburb.id+">"+suburb.name+"</option>");
				  				});
				  			}
				  		});
		  			}
		  		});
			}
			
			//监听form提交事件
	  		$('#addShopForm').submit(function() {
	  			if(valid()){
	  				$('#btn_save_all').attr("disabled","disabled");
	  				//提交参数
	  				//1.获取分类信息arr_catalogs
	  				var param_catalogs = JSON.stringify(arr_catalogs);
	  				
	  				if($('#add_bh_new').is(":checked")){
	  					var param_bussiness_hours = JSON.stringify(arr_bussiness_hour);
	  				}
	  				//console.log(param_bussiness_hours);
	  				//console.log(param_catalogs);
	  				//console.log(param_picurls);
	  				$.ajax({
			  			type:"post",
			  			url:"Shop!add.action",
			  			dataType:"json",
			  			data:{ "catalogs": param_catalogs,"bussiness_hours":param_bussiness_hours,
	  						"shop.name":$('#name').val(),"shop.suburb_id":$('#select_suburbs').val(),"shop.addr":$('#address').val(),
	  						"shop.tel":toTelHTML('tel'),"shop.mobile":$('#mobile').val(),"shop.email":$('#email').val(),
	  						"shop.website":$('#website').val(),"shop.weibo":$('#weibo').val(),"shop.weibo_link":$('#weibo_link').val(),
	  						"shop.weixin":$('#weixin').val(),"shop.momo":$('#momo').val(),"shop.facebook":$('#facebook').val(),
	  						"shop.facebook_link":$('#facebook_link1').val(),
	  						"shop.instagram":$('#instagram').val(),"shop.instagram_link":$('#instagram_link').val(),"shop.qq":$('#qq').val(),
	  						"shop.twitter":$('#twitter').val(),"shop.twitter_link":$('#twitter_link').val(),"shop.youtube":$('#youtube').val(),"shop.youtube_link":$('#youtube_link').val(),
	  						"shop.intro":toIntroHTML('intro'),"shop.is_takeout":$('#is_takeout').val(),"shop.takeout_time":toIntroHTML('takeout_time'),"shop.takeout_route":toIntroHTML('takeout_route')},
			  			success: function(json) {
		                	if(json.status==1){
		                		//保存成功
		                		alert(json.message);
		                		window.location.href = "shops_list.jsp";
		                	}else{
		                		alert(json.message);
		                	}
		                	
		                },
		                error: function() {
		                    alert("Oops...商户添加失败...\n请联系管理员！");
		                }
			  		});
	  			}
	  			return false;
	  		});
		});
	</script>
  </head>
  
  <body>
    <div class="container">
	  	<!-- 导航菜单 -->
	    <s:include value="nav_bar.jsp" >
	    	<s:param name="title">shops</s:param>
	    </s:include>
    	<div id="content" class="row-fluid">
    		<form class="form-horizontal fill" id="addShopForm" role="form">
    		<div class="row">
    			<div class="col-sm-12 title">商户信息添加</div>
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
						<div class="col-sm-9" id="catalog_div"></div>
						<div class="col-sm-2 column">
							<button type="button" class="btn btn-primary" id="btn_add_catalog_info">添加分类</button>
						</div>
					</div>
					<div class="form-group">
						<label for="name" class="col-sm-1 control-label">店铺名称</label>
						<div class="col-sm-2">
							<input type="text" class="form-control" id="name" name="shop.name" placeholder="输入店名" required>
						</div>
						<label for="suburbs" class="col-sm-1 control-label">地区</label>
						<div class="col-sm-2">
							<select class="form-control selectpicker " name="shop.suburb_id" id="select_suburbs" >
								<option value="-1">请选择</option>
							</select>
						</div>
						<label for="address" class="col-sm-1 control-label">地址</label>
						<div class="col-sm-5">
							<input type="text" class="form-control" id="address" name="shop.addr"  placeholder="输入地址" >
						</div>
					</div>
					<div class="form-group">
						<label for="tel" class="col-sm-1 control-label">电话</label>
						<div class="col-sm-2">
							<input type="text" class="form-control" id="tel" name="shop.tel"  placeholder="输入电话号码" >
						</div>
						<label for="mobile" class="col-sm-1 control-label">手机</label>
						<div class="col-sm-2">
							<input type="text" class="form-control" id="mobile" name="shop.mobile"  placeholder="输入手机号码">
						</div>
						<label for="qq" class="col-sm-1 control-label">QQ</label>
						<div class="col-sm-2">
							<input type="text" class="form-control" id="qq" name="shop.qq"  placeholder="输入QQ号">
						</div>
						<label for="email" class="col-sm-1 control-label">Email</label>
						<div class="col-sm-2">
							<input type="text" class="form-control" id="email" name="shop.email"  placeholder="输入EMAIL">
						</div>
					</div>
					<div class="form-group">
						<label for="weixin" class="col-sm-1 control-label">微信</label>
						<div class="col-sm-2">
							<input type="text" class="form-control" id="weixin" name="shop.weixin"  placeholder="输入微信号">
						</div>
						<label for="momo" class="col-sm-1 control-label">陌陌</label>
						<div class="col-sm-2">
							<input type="text" class="form-control" id="momo" name="shop.momo"  placeholder="输入陌陌号码">
						</div>
						<label for="website" class="col-sm-1 control-label">网站</label>
						<div class="col-sm-5">
							<input type="text" class="form-control" id="website" name="shop.website"  placeholder="输入官网地址">
						</div>
					</div>
					<div class="form-group">
						<label for="facebook" class="col-sm-1 control-label">Facebook</label>
						<div class="col-sm-2">
							<input type="text" class="form-control" id="facebook" name="shop.facebook"  placeholder="Facebook name">
						</div>
						<div class="col-sm-3">
							<input type="text" class="form-control" id="facebook_link1" name="shop.facebook_link"  placeholder="输入Facebook地址">
						</div>
						<label for="instagram" class="col-sm-1 control-label">Instagram</label>
						<div class="col-sm-2">
							<input type="text" class="form-control" id="instagram" name="shop.instagram"  placeholder="@instagram name">
						</div>
						<div class="col-sm-3">
							<input type="text" class="form-control" id="instagram_link" name="shop.instagram_link"  placeholder="输入Instagram地址">
						</div>
						
					</div>
					<div class="form-group">
						<label for="weibo" class="col-sm-1 control-label">Weibo</label>
						<div class="col-sm-2">
							<input type="text" class="form-control" id="weibo" name="shop.weibo"  placeholder="Weibo name">
						</div>
						<div class="col-sm-3">
							<input type="text" class="form-control" id="weibo_link" name="shop.weibo_link"  placeholder="输入Weibo地址">
						</div>
						<label for="twitter" class="col-sm-1 control-label">Twitter</label>
						<div class="col-sm-2">
							<input type="text" class="form-control" id="twitter" name="shop.twitter"  placeholder="Twitter name">
						</div>
						<div class="col-sm-3">
							<input type="text" class="form-control" id="twitter_link" name="shop.twitter_link"  placeholder="输入Twitter地址">
						</div>
						
					</div>
					<div class="form-group">
						<label for="youtube" class="col-sm-1 control-label">Youtube</label>
						<div class="col-sm-2">
							<input type="text" class="form-control" id="youtube" name="shop.youtube"  placeholder="Youtube name">
						</div>
						<div class="col-sm-9">
							<input type="text" class="form-control" id="youtube_link" name="shop.youtube_link"  placeholder="输入Youtube地址">
						</div>
					</div>
					<div class="form-group">
						<label for="info" class="col-sm-1 control-label">简介</label>
						<div class="col-sm-11">
							<textarea class="form-control"  id="intro" name="shop.intro"  rows="3" placeholder="请对商家做个简单介绍吧"></textarea>
						</div>
					</div>
					<div class="form-group" id="takeout_time_div">
						<label for="takeout_time" class="col-sm-1 control-label">送餐时间</label>
						<div class="col-sm-11">
							<textarea class="form-control"  id="takeout_time" name="shop.takeout_time"  rows="3" placeholder="请输入送餐时间"></textarea>
							<input id="is_takeout" type="hidden" name="shop.is_takeout"/>
						</div>
					</div>
					<div class="form-group" id="takeout_route_div">
						<label for="takeout_route" class="col-sm-1 control-label">送餐路线</label>
						<div class="col-sm-11">
							<textarea class="form-control"  id="takeout_route" name="shop.takeout_route"  rows="3" placeholder="请输入送餐路线"></textarea>
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-12">
							<div class="bs-callout bs-callout-warning">
								<h5>注意事项</h5>
								<p>  Website/Weibo/Twitter/Facebook/Instagram/Youtube等需要填入网址的字段请在网之前添加http://或者https://</p>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!--新营业时间start-->
			<div class="row">
	    		<div class="col-sm-12" >
	    		    <div class="well well-sm">
	    		    	<strong>营业时间</strong>&nbsp;&nbsp;&nbsp;&nbsp;
	    		    	<label>
					      <input type="checkbox" id="add_bh_new"> 添加
					    </label>
					</div>
	    		</div>
    		</div>
    		<div id="bh_div_new" class="row">
    			<div  class="col-sm-12 ">
    				<div class="form-group">
						<div class="col-sm-12" >
							<button type="button" class="btn btn-sm btn-primary btn-block" id="btn_add_bh_info">添加营业时间</button>
						</div>
					</div>
					<div class="form-group">
						<label for="weekday" class="col-sm-1  control-label ">星期一</label>
						<div class="col-sm-3 control-label text-center" id="bh_mon"></div>
						<label for="weekday" class="col-sm-1 control-label">星期二</label>
						<div class="col-sm-3 control-label text-center" id="bh_tues"></div>
						<label for="weekday" class="col-sm-1 control-label">星期三</label>
						<div class="col-sm-3 control-label text-center" id="bh_wed"></div>
					</div>
					<div class="form-group">
						<label for="weekday" class="col-sm-1 control-label">星期四</label>
						<div class="col-sm-3 control-label text-center" id="bh_thur"></div>
						<label for="weekday" class="col-sm-1  control-label">星期五</label>
						<div class="col-sm-3 control-label text-center" id="bh_fri"></div>
						<label for="weekday" class="col-sm-1 control-label">星期六</label>
						<div class="col-sm-3 control-label text-center" id="bh_sat"></div>
					</div>
					<div class="form-group">
						<label for="weekday" class="col-sm-1 control-label">星期日</label>
						<div class="col-sm-3 control-label text-center" id="bh_sun"></div>
					</div>
    			</div>
    		</div>
    		<!----新营业时间end-->
    		
    		<div class="row">
	    		<div class="col-md-12">
	    			<div class="form-group">
		    			<div class="center">
		        			<button type="submit" class="btn btn-danger" id="btn_save_all">保存所有信息</button>
		    			</div>
		    		</div>
	    		</div>
    		</div>
    		</form>
    		<!-- Modal -->
			<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			  <div class="modal-dialog">
			    <div class="modal-content">
			      <div class="modal-header">
			        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">关闭</span></button>
			        <h4 class="modal-title">请选择分类</h4>
			      </div>
			      <div class="modal-body center">
			      	<div class="form-group select_box">
				      	<label for="suburbs" class="control-label">顶级分类</label>
						<select class="form-control" id="select_top">
							<option value="-1">请选择</option>
						</select>
						
					</div>
			      	<div class="form-group select_box">
						<label for="suburbs" class="control-label">一级分类</label>
						
							<select class="form-control" id="select_level1">
								<option value="-1">请选择</option>
							</select>
						
					</div>
			      	<div class="form-group select_box">
						<label for="suburbs" class=control-label">二级分类</label>
						
							<select class="form-control" id="select_level2">
								<option value="-1">请选择</option>
							</select>
						
					</div>
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
			        <button type="button" class="btn btn-primary" id="btn_add_catalog">添加分类</button>
			      </div>
			    </div>
			  </div>
			</div>
			
			
			<!-- 营业时间Modal -->
			<div class="modal fade" id="bhModal" tabindex="-1" role="dialog" aria-labelledby="bhModal" aria-hidden="true">
			  
			  <div class="modal-dialog">
			    <div class="modal-content">
			      <div class="modal-header">
			        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">关闭</span></button>
			        <h4 class="modal-title">请添加营业时间</h4>
			      </div>
			      <div class="modal-body ">
				      <form class="form-horizontal" id="addBHForm" role="form">
					      <div class="row-fluid">
					      	<div class="row">
				    			<div class="col-sm-12">
					    			<div class="form-group">
					    				<label for="weekday" class="col-md-offset-1 col-md-3 control-label text-right">Weekday</label>
					    				<div class="col-sm-6">
											<select class="form-control" id="select_weekday">
												<option value="-1">请选择</option>
												<option value="1">Monday</option>
												<option value="2">Tuesday</option>
												<option value="3">Wednesday</option>
												<option value="4">Thursday</option>
												<option value="5">Friday</option>
												<option value="6">Saturday</option>
												<option value="7">Sunday</option>
											</select>
										</div>
									</div>
									<div class="form-group">
					    				<label for="is_open" class="col-md-offset-1 col-md-3 control-label text-right">Status</label>
					    				<div class="col-sm-6">
											<div class="controls">
									            <div class="switch">
									                <input name="checkbox_is_open" type="checkbox" id="checkbox_is_open" checked/>
									            </div>
									        </div>
										</div>
									</div>
									<div id="bh_time_div">
										<div class="form-group">
						    				<label for="is_need_book" class="col-md-offset-1 col-md-3 control-label text-right">By Appointment</label>
						    				<div class="col-sm-6">
												<div class="controls">
										            <div class="switch">
										                <input name="checkbox_is_need_book" type="checkbox" id="checkbox_is_need_book" />
										            </div>
										        </div>
											</div>
										</div>
										<div id="bh_input_time">
											<div class="form-group">
							    				<label for="bh_start_time" class="col-md-offset-1 col-md-3 control-label text-right">Start Time</label>
							    				<div class="col-sm-6">
													<div class="input-group " >
									                    <input class="form-control" id="bh_start_time" type="text" value="" readonly>
														<span class="input-group-addon"><span class="glyphicon glyphicon-time"></span></span>
									                </div>
												</div>
											</div>
											<div class="form-group">
							    				<label for="bh_end_time" class="col-md-offset-1 col-md-3 control-label text-right">End Time</label>
							    				<div class="col-sm-6">
													<div class="input-group " >
									                    <input class="form-control" id="bh_end_time" type="text" value="" readonly>
														<span class="input-group-addon"><span class="glyphicon glyphicon-time"></span></span>
									                </div>
													
												</div>
											</div>
										</div>
										<div class="form-group">
						    				<label for="is_open" class="col-md-offset-1 col-md-3 control-label text-right">Copy To</label>
						    				<div class="col-sm-6">
												<select class="form-control" id="select_copy_to" multiple="multiple">
													<option value="1">Monday</option>
													<option value="2">Tuesday</option>
													<option value="3">Wednesday</option>
													<option value="4">Thursday</option>
													<option value="5">Friday</option>
													<option value="6">Saturday</option>
													<option value="7">Sunday</option>
												</select>
											</div>
										</div>
									</div>
									
								</div>
					  		</div>
						</div>
				  	</form>
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
			        <button type="button" class="btn btn-primary" id="btn_add_bh">添加</button>
			      </div>
			    </div>
			  </div>
			  
			</div>
    	</div>
    </div>
  </body>
</html>
