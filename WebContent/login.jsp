<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8" />
		<title>login</title>
		<%@ include file="system/common/lib.jsp"%>
		<script type="text/javascript" src="js/jqMsgBox/jquery.msgbox.js"></script>
    	<%
			String path = request.getContextPath();
			String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
		%>
		<base href="<%=basePath%>">
	</head>
	<body>
		<!-- Header -->
		<header id="top">
		<div class="wrapper-login">
			<!-- Title/Logo - can use text instead of image -->
			<div id="title">
				<img SRC="img/logo.png" alt="iSmart" />
				<!--<span>Administry</span> demo-->
			</div>
			<!-- Main navigation -->
			<nav id="menu">
			<ul class="sf-menu">
				<li id="logtag" class="current">
					<a href="javascript:login()">登陆</a>
				</li>
				<!-- 
				<li id="regtag">
					<a href="javascript:register()">注册</a>
				</li>
				 -->
			</ul>
			</nav>
			
		</div>
		</header>
		<!-- End of Header -->
		<!-- Page title -->
		<div id="pagetitle">
			<div class="wrapper-login"></div>
		</div>
		<!-- End of Page title -->

		<!-- Page content -->
		<div id="page">
			<!-- login -->
			<div id="loginDiv" class="wrapper-login" style="display: block">
				<!-- Login form -->
				<section class="full">

				<h3>
					登陆
				</h3>

				<div class="box box-info">
					输入用户名密码以登陆
				</div>

				<form id="loginform" method="post" action="Home!home.action">

					<p>
						<label class="required" for="">
							用户名:
						</label>
						<br />
						<input type="text" id="loginname" class="full" value=""
							name="loginname" />
					</p>

					<p>
						<label class="required" for="">
							密码:
						</label>
						<br />
						<input type="password" id="password" class="full" value=""
							name="password" />
					</p>

					<p>
						<input type="checkbox" id="remember" class="" value="1"
							name="remember" />
						<label class="choice" for="remember">
							记住密码
						</label>
					</p>

					<p>
						<input id="loginBtn" type="button" class="btn btn-green big"
							value="登陆" />
						<input type="button" id="resetLBtn" class="btn btn-green big"
							value="重置" />
						&nbsp;
						<!-- <a href="javascript: //;"
							onClick="$('#emailform').slideDown(); return false;">Forgot
							password?</a> or
						<a href="#">Need help?</a> -->
					</p>
					<div class="clear">
						&nbsp;
					</div>

				</form>


				</section>
				<!-- End of login form -->

			</div>
			<!-- End login -->

			<!-- Register -->
			<div id="registerDiv" class="wrapper-login" style="display: none">
				<!-- Login form -->
				<section class="full">

				<h3>
					注册
				</h3>

				<div class="box box-info">
					输入用户名密码以注册
				</div>

				<form id="registerform" method="post" action="">
					<p>
						<label class="required" for="">
							登陆名:
						</label>
						<br />
						<input type="text" id="regloginname" class="full" value=""
							name="regloginname" />
					</p>
					<p>
						<label class="required" for="">
							真实姓名:
						</label>
						<br />
						<input type="text" id="regusername" class="full" value=""
							name="regusername" />
					</p>

					<p>
						<label class="regrequired" for="">
							密码:
						</label>
						<br />
						<input type="password" id="regpassword" class="full" value=""
							name="regpassword" />
					</p>
					<p>
						<label for="">
							年龄:
						</label>
						<br />
						<select id="regage" class="half" name="regage">
							<%for(int i =15;i<120;i++){ %>
								<option value="<%=i %>"><%=i %></option>
							<%} %>					
						</select>
					</p>

					<p>
						<label class="required" for="">
							性别:
						</label>
						<br />
						<select id="regsex" class="half" name="regsex">
							<option value="男">男(male)</option>
							<option value="女">女(female)</option>
						</select>
					</p>
					<p>
						<label class="required" for="">
							地址:
						</label>
						<br />
						<input type="text" id="regaddress" class="full" value=""
							name="regaddress" />
					</p>
					
					<p>

						<input type="button" id="registBtn" class="btn btn-green big"
							value="注册" />
						<input type="button" id="resetRBtn" class="btn btn-green big"
							value="重置" />
					</p>
					<div class="clear">
						&nbsp;
					</div>

				</form>


				</section>
				<!-- End of Register form -->

			</div>
		</div>
		<!-- End of Page content -->

		<!-- Page footer -->
		<footer id="bottom">
		<div class="wrapper-login">
			<p>
			
				<b>
			</p>
		</div>
		</footer>
		<!-- End of Page footer -->

		<!-- User interface javascript load -->

	</body>
	<script type="text/javascript">


function login(){
	$("#logtag").attr("class","current");
	$("#regtag").attr("class","");
	$("#loginDiv").attr("style","display:block");
	$("#registerDiv").attr("style","display:none");
	
}
function register(){
	$("#logtag").attr("class","");
	$("#regtag").attr("class","current");
	$("#loginDiv").attr("style","display:none");
	$("#registerDiv").attr("style","display:block");
	
}
 $("#registBtn").click(function() {
 		regloginname = $("#regloginname").val();
		regusername = $("#regusername").val();
		regpassword = $("#regpassword").val();
		regage = $("#regage").val();
		regsex = $("#regsex").val();
		regaddress = $("#regaddress").val();
		$.post(
		      "Regist!regist.action",
		      {"regloginname":regloginname,"regusername":regusername,"regpassword":regpassword,"regage":regage,"regsex":regsex,"regaddress":regaddress},
		      function (data)
		      {
		      	login();
		      	$("#loginBtn").jalert(data,{ title : '注册消息', width : 300, height : 250, mask : false });
		      },
		      "text"
		 );
 });
 $("#loginBtn").click(function() {
 		loginname = $("#loginname").val();
		password = $("#password").val();
		$.post(
		      "Login!login.action",
		      {"loginname":loginname,"password":password},
		      function (data)
		      {
		      	if(data=='SUCCESS'){
		      		loginform.submit();
		      	}else{
		      		$("#loginBtn").jalert('登录失败,用户名密码错误!',{ title : '登陆消息', width : 300, height : 250, mask : false });
		      	}
		      },
		      "text"
		 );
 });
 $("#resetLBtn").click(function() {
 	loginform.reset();
 });
 $("#resetRBtn").click(function(){
 	registerform.reset();
 });
 $(function(){
		document.onkeydown = function(e){ 
    	var ev = document.all ? window.event : e;
    	if(ev.keyCode==13) {
    		loginname = $("#loginname").val();
			password = $("#password").val();
			$.post(
			      "Login!login.action",
			      {"loginname":loginname,"password":password},
			      function (data)
			      {
			      	if(data=='SUCCESS'){
			      		loginform.submit();
			      	}else{
			      		$("#loginBtn").jalert('登录失败,用户名密码错误或已失效!',{ title : '登陆消息', width : 300, height : 250, mask : false });
			      	}
			      },
			      "text"
			 );
     	}
		}
	});

</script>
</html>