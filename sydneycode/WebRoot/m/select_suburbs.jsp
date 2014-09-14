<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>选择地区</title>
	<link rel="shortcut icon" href="../images/favicon.ico">
	<link rel="stylesheet" href="../css/themes/default/jquery.mobile-1.4.3.min.css">
	<link rel="stylesheet" href="_assets/css/jqm-demos.css">
	<link rel="stylesheet" href="_assets/css/autodividers-linkbar.css">
	<script src="../js/jquery.min.js"></script>
	<script src="_assets/js/index.js"></script>
	<script src="../js/jquery.mobile-1.4.3.min.js"></script>
	<script src="_assets/js/autodividers-linkbar.js"></script>
	<script type="text/javascript">
		$(function(){
			$.ajax({
				url:'../admin/Suburblist.action',
				type:"POST",
				datatype:'json',
				success:function(json){
					for(var i=0;i<json.data.length;i++){
						var content = '<li><a href=\"#\">'+json.data[i].name+'</a></li>';
						$('#sortedList').append(content);
					}
					$('#sortedList').listview('refresh');
				}
			});
		});
	</script>
	<style type="text/css">
		.ui-filterable{
			width:90%;
		}
	</style>
</head>
<body>
<div data-role="page" id="demo-page">

	<div data-role="header">
		<h1>选择地区</h1>
		<a href="../" data-rel="back" data-icon="arrow-l" data-iconpos="notext" data-ajax="false">Back</a>
	</div><!-- /header -->

	<div role="main" class="ui-content">

        <div id="sorter">

            <ul data-role="listview">
                <li><span>A</span></li>
                <li><span>B</span></li>
                <li><span>C</span></li>
                <li><span>D</span></li>
                <li><span>E</span></li>
                <li><span>F</span></li>
                <li><span>G</span></li>
                <li><span>H</span></li>
                <li><span>I</span></li>
                <li><span>J</span></li>
                <li><span>K</span></li>
                <li><span>L</span></li>
                <li><span>M</span></li>
                <li><span>N</span></li>
                <li><span>O</span></li>
                <li><span>P</span></li>
                <li><span>Q</span></li>
                <li><span>R</span></li>
                <li><span>S</span></li>
                <li><span>T</span></li>
                <li><span>U</span></li>
                <li><span>V</span></li>
                <li><span>W</span></li>
                <li><span>X</span></li>
                <li><span>Y</span></li>
                <li><span>Z</span></li>
            </ul>
        </div><!-- /sorter -->

        <ul data-role="listview" data-autodividers="true" id="sortedList" data-filter="true" data-inset="">
            
        </ul><!-- /listview -->

    </div><!-- /content -->

    <div data-role="footer">
    	<h4>The End</h4>
    </div><!-- /footer -->

</div><!-- /page -->

</body>
</html>

