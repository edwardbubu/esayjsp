<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	
	Integer pageNum = (Integer)request.getAttribute("pageNum");
	Integer allPages = (Integer)request.getAttribute("allPages");
	Integer allCounts = (Integer)request.getAttribute("allCounts");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<base href="<%=basePath%>">

		<title>My JSP 'clientsList.jsp' starting page</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
		<title>无标题文档</title>
		<style type="text/css">
<!--
.STYLE1 {
	font-size: x-large;
	font-weight: bold;
}
-->
</style>
	</head>
	<form action="Remove.action" method="post">
	<body>
		<div align="center">
			<table width="416" height="141" border="1">
				<tr>
					<td height="42" colspan="5">
						<div align="center">
							<span class="STYLE1">客户信息列别</span>
						</div>
					</td>
				</tr>
				<tr>
					<td width="73">
						<div align="center">
							<strong>登录名</strong>
						</div>
					</td>
					<td width="73">
						<div align="center">
							<strong>姓名</strong>
						</div>
					</td>
					<td width="73">
						<div align="center">
							<strong>年龄</strong>
						</div>
					</td>
					<td width="85">
						<div align="center">
							<strong>电话</strong>
						</div>
					</td>
					<td width="78">
						<div align="center">
							<strong>操作</strong>
						</div>
					</td>
				</tr>
				<s:iterator value="clients">
					<tr>
						<td>
							<s:property value="user_id"/>
						</td>
						<td>
							<s:property value="username"/>
						</td>
						<td>
							<s:property value="age"/>
						</td>
						<td>
							<s:property value="telephone"/>
						</td>
						<td>
							<a href='<s:url action="Remove.action"><s:param name="clientId" value="clientId" /></s:url>'>
                                  删除
                            </a>
						</td>
					</tr>
				</s:iterator>
			</table>
			<!-- <table width="416" height="1" border="1">
				<tr>
					<td width="208">
						<f:fenye pageNum="<%=pageNum %>" allPages="<%=allPages %>" />
					</td>
					<td width="208">
						总共<%=allCounts %>条  第<%=pageNum %>/<%=allPages %>页
					</td>
				</tr>
			</table> -->
			<table width="416" height="1" border="1">
				<tr>
					<td>
						<center><a href="index.jsp">返回首页</a></center>
					</td>
				</tr>
			</table>
			<p class="STYLE1">
				&nbsp;
			</p>
		</div>
	</body>
	</form>
</html>
