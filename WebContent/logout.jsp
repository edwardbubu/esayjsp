<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.ismart.common.util.StrUtil;"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	//System.out.println(type);
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<link rel="stylesheet" type="text/css"
			href="css/EasyUi/themes/default/easyui.css">
		<link rel="stylesheet" type="text/css"
			href="css/EasyUi/themes/icon.css">
		<link rel="stylesheet" type="text/css"
			href="css/EasyUi/themes/demo.css">
		<script type="text/javascript" src="js/jqMsgBox/jquery-1.7.2.min.js"></script>
		<script type="text/javascript" src="js/EasyUi/jquery.easyui.min.js"></script>
		
			

	</head>
	<body>
		
		<table>
			<tr>
				<td style="font-size: 12">
					<div id="w" class="easyui-window"
						data-options="title:'系统信息',iconCls:'icon-save'" 
						style="width: 370px; height: 300px; padding: 5px;">
						
						登陆已经超时,请注销后重新登录!
					</div>


				</td>
			</tr>

		</table>
		
		<!-- 
		<div id="main" style=" overflow:scroll">
			${treeView}
		</div>
		 -->
	</body>

</html>
