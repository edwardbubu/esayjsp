<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%@page import="com.ismart.system.node.domain.Node"%>
<%@page import="com.ismart.system.user.domain.SystemUser"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<%@ include file="system/common/lib.jsp"%>
		<title>ismartϵͳ</title>

		<style type="text/css">
body {
	font: 12px/ 20px "΢���ź�", "����", Arial, sans-serif, Verdana, Tahoma;
	padding: 0;
	margin: 0;
}

a:link {
	text-decoration: none;
}

a:visited {
	text-decoration: none;
}

a:hover {
	text-decoration: underline;
}

a:active {
	text-decoration: none;
}

.cs-north {
	height: 60px;
}

.cs-north-bg {
	width: 100%;
	height: 100%;
	background: url(css/EasyUi/themes/gray/images/header_bg.png) repeat-x;
}

.cs-north-logo {
	height: 40px;
	margin: 15px 0px 0px 5px;
	display: inline-block;
	color: #000000;
	font-size: 22px;
	font-weight: bold;
	text-decoration: none
}

.cs-west {
	width: 200px;
	padding: 0px;
}

.cs-south {
	height: 25px;
	background:
		url('css/EasyUi/themes/pepper-grinder/images/ui-bg_fine-grain_15_ffffff_60x60.png')
		repeat-x;
	padding: 0px;
	text-align: center;
}

.cs-navi-tab {
	padding: 5px;
}

.cs-tab-menu {
	width: 120px;
}

.cs-home-remark {
	padding: 10px;
}

.wrapper {
	float: right;
	height: 30px;
	margin-left: 10px;
	
}

.ui-skin-nav {
	float: right;
	padding: 0;
	margin-right: 10px;
	list-style: none outside none;
	height: 30px;
}

.ui-skin-nav .li-skinitem {
	float: left;
	font-size: 12px;
	line-height: 30px;
	margin-left: 10px;
	text-align: center;
}

.ui-skin-nav .li-skinitem span {
	cursor: pointer;
	width: 10px;
	height: 10px;
	display: inline-block;
}

.ui-skin-nav .li-skinitem span.cs-skin-on {
	border: 1px solid #FFFFFF;
}

 .ui-skin-nav .li-skinitem span.gray {
	background-color: gray;
}

.ui-skin-nav .li-skinitem span.pepper-grinder {
	background-color: #BC3604;
}

.ui-skin-nav .li-skinitem span.cupertino {
	background-color: #D7EBF9;
}

</style>
		<script type="text/javascript">
function addTab(title, url){
	if ($('#tabs').tabs('exists', title)){
		$('#tabs').tabs('select', title);//ѡ�в�ˢ��
		var currTab = $('#tabs').tabs('getSelected');
		var url = $(currTab.panel('options').content).attr('src');
		if(url != undefined && currTab.panel('options').title != 'Home') {
			$('#tabs').tabs('update',{
				tab:currTab,
				options:{
					content:createFrame(url)
				}
			})
		}
	} else {
		var content = createFrame(url);
		$('#tabs').tabs('add',{
			title:title,
			content:content,
			closable:true
		});
	}
	tabClose();
}
function createFrame(url) {
	var s = '<iframe scrolling="auto" frameborder="0"  src="'+url+'" style="width:100%;height:100%;"></iframe>';
	return s;
}
		
function tabClose() {
	/*˫���ر�TABѡ�*/
	$(".tabs-inner").dblclick(function(){
		var subtitle = $(this).children(".tabs-closable").text();
		$('#tabs').tabs('close',subtitle);
	})
	/*Ϊѡ����Ҽ�*/
	$(".tabs-inner").bind('contextmenu',function(e){
		$('#mm').menu('show', {
			left: e.pageX,
			top: e.pageY
		});

		var subtitle =$(this).children(".tabs-closable").text();

		$('#mm').data("currtab",subtitle);
		$('#tabs').tabs('select',subtitle);
		return false;
	});
}		
//���Ҽ��˵��¼�
function tabCloseEven() {
	//ˢ��
	$('#mm-tabupdate').click(function(){
		var currTab = $('#tabs').tabs('getSelected');
		var url = $(currTab.panel('options').content).attr('src');
		if(url != undefined && currTab.panel('options').title != 'Home') {
			$('#tabs').tabs('update',{
				tab:currTab,
				options:{
					content:createFrame(url)
				}
			})
		}
	})
	//�رյ�ǰ
	$('#mm-tabclose').click(function(){
		var currtab_title = $('#mm').data("currtab");
		$('#tabs').tabs('close',currtab_title);
	})
	//ȫ���ر�
	$('#mm-tabcloseall').click(function(){
		$('.tabs-inner span').each(function(i,n){
			var t = $(n).text();
			if(t != 'Home') {
				$('#tabs').tabs('close',t);
			}
		});
	});
	//�رճ���ǰ֮���TAB
	$('#mm-tabcloseother').click(function(){
		var prevall = $('.tabs-selected').prevAll();
		var nextall = $('.tabs-selected').nextAll();		
		if(prevall.length>0){
			prevall.each(function(i,n){
				var t=$('a:eq(0) span',$(n)).text();
				if(t != 'Home') {
					$('#tabs').tabs('close',t);
				}
			});
		}
		if(nextall.length>0) {
			nextall.each(function(i,n){
				var t=$('a:eq(0) span',$(n)).text();
				if(t != 'Home') {
					$('#tabs').tabs('close',t);
				}
			});
		}
		return false;
	});
	//�رյ�ǰ�Ҳ��TAB
	$('#mm-tabcloseright').click(function(){
		var nextall = $('.tabs-selected').nextAll();
		if(nextall.length==0){
			//msgShow('ϵͳ��ʾ','���û����~~','error');
			alert('���û����~~');
			return false;
		}
		nextall.each(function(i,n){
			var t=$('a:eq(0) span',$(n)).text();
			$('#tabs').tabs('close',t);
		});
		return false;
	});
	//�رյ�ǰ����TAB
	$('#mm-tabcloseleft').click(function(){
		var prevall = $('.tabs-selected').prevAll();
		if(prevall.length==0){
			alert('��ͷ�ˣ�ǰ��û����~~');
			return false;
		}
		prevall.each(function(i,n){
			var t=$('a:eq(0) span',$(n)).text();
			$('#tabs').tabs('close',t);
		});
		return false;
	});

	//�˳�
	$("#mm-exit").click(function(){
		$('#mm').menu('hide');
	})
}

$(function() {
	tabCloseEven();

	$('.cs-navi-tab').click(function() {
		var $this = $(this);
		var href = $this.attr('src');
		var title = $this.text();
		addTab(title, href);
	});

	var themes = {
		'gray' : 'css/EasyUi/themes/gray/easyui.css',
		'pepper-grinder' : 'css/EasyUi/themes/pepper-grinder/easyui.css',
		'cupertino' : 'css/EasyUi/themes/cupertino/easyui.css',
	};

	var skins = $('.li-skinitem span').click(function() {
		var $this = $(this);
		if($this.hasClass('cs-skin-on')) return;
		skins.removeClass('cs-skin-on');
		$this.addClass('cs-skin-on');
		var skin = $this.attr('rel');
		$('#swicth-style').attr('href', themes[skin]);
		setCookie('cs-skin', 'cupertino');
		skin == 'dark-hive' ? $('.cs-north-logo').css('color', '#FFFFFF') : $('.cs-north-logo').css('color', '#000000');
	});

	if(getCookie('cs-skin')) {
		var skin = getCookie('cs-skin');
		$('#swicth-style').attr('href', themes[skin]);
		$this = $('.li-skinitem span[rel='+skin+']');
		$this.addClass('cs-skin-on');
		skin == 'dark-hive' ? $('.cs-north-logo').css('color', '#FFFFFF') : $('.cs-north-logo').css('color', '#000000');
	}
});


function setCookie(name,value) {//����������һ����cookie�����ӣ�һ����ֵ
    var Days = 30; //�� cookie �������� 30 ��
    var exp = new Date();    //new Date("December 31, 9998");
    exp.setTime(exp.getTime() + Days*24*60*60*1000);
    document.cookie = name + "="+ escape (value) + ";expires=" + exp.toGMTString();
}

function getCookie(name) {//ȡcookies����        
    var arr = document.cookie.match(new RegExp("(^| )"+name+"=([^;]*)(;|$)"));
     if(arr != null) return unescape(arr[2]); return null;
}


</script>
	<%
		Map mp = (Map)request.getAttribute("map");
		ArrayList set1 = (ArrayList)mp.get("set1");
		ArrayList set2 = (ArrayList)mp.get("set2");
	 %>
	</head>
	<body class="easyui-layout">
		<div region="north" border="true" class="cs-north">
			<div class="cs-north-bg">
				<!-- style="background-image:url('css/EasyUi/themes/icons/back.png');" -->
				<div class="cs-north-logo">
					ismart������Ϣ����ϵͳ
				</div>
				<ul class="ui-skin-nav">
				    <li class="li-skinitem" title="gray">
						<span class="gray" rel="gray"></span>
					</li>
					<li class="li-skinitem" title="pepper-grinder">
						<span class="pepper-grinder" rel="pepper-grinder"></span>
					</li> 
					<li class="li-skinitem" title="cupertino">
						<span class="cupertino" rel="cupertino"></span>
					</li> 
					<li>
						<span><a href="login.jsp" class="easyui-linkbutton">ע��</a>
						</span>
					</li>
				</ul>

			</div>
		</div>
		<div region="west" border="true" split="true" title="����"
			class="cs-west">
			<div class="easyui-accordion" fit="true" border="false"
				id="navigation">
				<%
					for (int i = 0; i < set1.size(); i++) {
						Node rs1 = (Node)set1.get(i);
				%>
						<div title="<%=rs1.getNodename() %>">
				<%
						for (int j = 0;j <set2.size(); j++){
							Node rs2 = (Node)set2.get(j);
							if(rs1.getNodeid().equals(rs2.getPid())){
								%>
									<p><a href='javascript:void(0);' src='<%=rs2.getSpurl() %>'class='cs-navi-tab'><%=rs2.getNodename() %></a></p>
								<%
							}
						}
						%>
						</div>
						<%
					}
				%>

			</div>
		</div>
		<div id="mainPanle" region="center" border="true" border="false">
			<div id="tabs" class="easyui-tabs" fit="true" border="false">
				<div title="Home">
				
		          <%
				      SystemUser user = (SystemUser)session.getAttribute("user");
	              %>
		          <div>��ã�<%=user.getUsername()%></div>
	             <div id="w" class="easyui-window" title="վ����Ϣ" data-options="iconCls:'icon-save'" style="width:500px;height:200px;padding:10px;">
		        <%
				      SystemUser user1 = (SystemUser)session.getAttribute("user");
	              %>
		          <div>��ã�<%=user1.getUsername()%></div>
	            </div>
			</div>
			 
		</div>

		<div region="south" border="false" class="cs-south">
			
		</div>


	</body>
</html>