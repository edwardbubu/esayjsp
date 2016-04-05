<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
	<head>

		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>导航</title>
		<%
			String path = request.getContextPath();
			String basePath = request.getScheme() + "://"
					+ request.getServerName() + ":" + request.getServerPort()
					+ path + "/";
		%>
		<base href="<%=basePath%>">
		<link rel="stylesheet" type="text/css"
			href="css/EasyUi/themes/default/easyui.css">
		<link rel="stylesheet" type="text/css"
			href="css/EasyUi/themes/icon.css">
		<link rel="stylesheet" type="text/css"
			href="css/EasyUi/themes/demo.css">
		<script type="text/javascript" src="js/jqMsgBox/jquery-1.7.2.min.js"></script>
		<script type="text/javascript" src="js/EasyUi/jquery.easyui.min.js"></script>
		<script type="text/javascript">
		
		</script>
	</head>
	<body>
	<div class="demo-info" style="margin-bottom:10px">
		<div class="demo-tip icon-tip"></div>
		<div>测试版本</div>
	</div>
	<div id="tt" class="easyui-tabs" style="width:700px;height:450px;">
		<div title="分时图" style="padding:40px;">
			<img src="http://image.sinajs.cn/newchart/min/n/sh000001.gif">
		</div>
		<div title="日K线" style="padding:40px;">
			<img src="http://image.sinajs.cn/newchart/daily/n/sh000001.gif">
		</div>
		<div title="周K线" style="padding:40px;">
			<img src="http://image.sinajs.cn/newchart/weekly/n/sh000001.gif">
		</div>
		<div title="月K线" style="padding:40px;">
			<img src="http://image.sinajs.cn/newchart/monthly/n/sh000001.gif">
		</div>
	</div> 

	</body>
</html>
