<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>页面维护</title>
		<%
			String path = request.getContextPath();
			String basePath = request.getScheme() + "://"
					+ request.getServerName() + ":" + request.getServerPort()
					+ path + "/";
		%>
		<base href="<%=basePath%>">
		<style type="text/css">
label {
	width: 120px;
	display: block;
}
</style>

		<link rel="stylesheet" type="text/css"
			href="css/EasyUi/themes/default/easyui.css">
		<link rel="stylesheet" type="text/css"
			href="css/EasyUi/themes/icon.css">
		<link rel="stylesheet" type="text/css"
			href="css/EasyUi/themes/demo.css">
		<script type="text/javascript" src="js/jqMsgBox/jquery-1.7.2.min.js"></script>
		<script type="text/javascript" src="js/EasyUi/jquery.easyui.min.js"></script>



		<script type="text/javascript">
		$(function(){
			$('#test').datagrid({
				title:'页面信息',
				iconCls:'icon-save',
				width:800,
				height:260,
				nowrap: true,
				autoRowHeight: false,
				striped: true,
				collapsible:true,
				url:'node!query.action',
				sortName: 'node',
				loader:myLoader,
				sortOrder: 'desc',
				remoteSort: false,
				nodenameField:'resource',
				singleSelect:'true',
				loadMsg:'数据加载中...',
				frozenColumns:[[
	                {field:'ck',checkbox:true},
	                {title:'页面id',field:'nodeid',width:80,sortable:true}
				]],
				columns:[[
					{field:'pid',title:'父页面id',width:80,sortable:true},
					{field:'nodename',title:'页面名称',width:100,rowspan:2,sortable:true},
					{field:'level',title:'页面级别',width:100,rowspan:2,sortable:true},
					{field:'spurl',title:'URL',width:250,rowspan:2},
					{field:'sporder',title:'排序ID',width:100,rowspan:2}
					
				]],
				pagination:true,
				rownumbers:true,
				toolbar:[{
					id:'btnadd',
					text:'新增',
					iconCls:'icon-add',
					handler:function(){
						$('#btnsave').linkbutton('enable');
						addForm.reset();
						open1();
					}
				},'-',{
					id:'btncut',
					text:'删除',
					iconCls:'icon-cut',
					handler:function(){
						$('#btnsave').linkbutton('enable');
						del();
					}
				},'-',{
					id:'btnedit',
					text:'编辑',
					iconCls:'icon-edit',
					handler:function(){
						$('#btnsave').linkbutton('enable');
						edit();
					}
				}
				]
			});
			//设置分页控件   
		    var p = $('#test').datagrid('getPager');   
		    $(p).pagination({   
		        pageSize: 10,//每页显示的记录条数，默认为10   
		        pageList: [10,20,50],//可以设置每页记录条数的列表   
		        beforePageText: '第',//页数文本框前显示的汉字   
		        afterPageText: '页    共 {pages} 页',   
		        displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录',   
		        /*onBeforeRefresh:function(){  
		            $(this).pagination('loading');  
		            alert('before refresh');  
		            $(this).pagination('loaded');  
		        }*/  
		    }); 

		});
		
		function resize(){
			$('#test').datagrid('resize', {
				width:700,
				height:400
			});
		}
		function getSelected(){
			var selected = $('#test').datagrid('getSelected');
			if (selected){
				alert(selected.code+":"+selected.name+":"+selected.addr+":"+selected.col4);
			}
		}
		function getSelections(){
			var ids = [];
			var rows = $('#test').datagrid('getSelections');
			for(var i=0;i<rows.length;i++){
				ids.push(rows[i].code);
			}
			alert(ids.join(':'));
		}
		function clearSelections(){
			$('#test').datagrid('clearSelections');
		}
		function selectRow(){
			$('#test').datagrid('selectRow',2);
		}
		function selectRecord(){
			$('#test').datagrid('selectRecord','002');
		}
		function unselectRow(){
			$('#test').datagrid('unselectRow',2);
		}
		function mergeCells(){
			$('#test').datagrid('mergeCells',{
				index:2,
				field:'addr',
				rowspan:2,
				colspan:2
			});
		}
		
		
		//页面翻页
		function myLoader(param, success, error) {
			var that = $(this);
			var opts = that.datagrid("options");
			if (!opts.url) {
				return false;
			}
			if (true) {
				$.ajax({
					type : opts.method,
					url : opts.url,
					data : param,
					dataType : "json",
					success : function(data) {
						that.data().datagrid['cache'] = data;
						success(bulidData(data));
					},
					error : function() {
						error.apply(this, arguments);
					}
				});
			} else {
				success(bulidData(cache));
		}
	
		function bulidData(data) {
			var temp = $.extend({}, data);
			var tempRows = [];
			var start = (param.page - 1) * parseInt(param.rows);
			var end = start + parseInt(param.rows);
			var rows = data.rows;
			for (var i = start; i < end; i++) {
				if (rows[i]) {
					tempRows.push(rows[i]);
				} else {
					break;
				}
			}
			temp.rows = tempRows;
			return temp;
		}
	}
		
	/**
	 * JQuery扩展方法，用户对JQuery EasyUI的DataGrid控件进行操作。
	 */
	$.fn.extend({
	 /**
	  * 修改DataGrid对象的默认大小，以适应页面宽度。
	  * 
	  * @param heightMargin
	  *            高度对页内边距的距离。
	  * @param widthMargin
	  *            宽度对页内边距的距离。
	  * @param minHeight
	  *            最小高度。
	  * @param minWidth
	  *            最小宽度。
	  * 
	  */
	 resizeDataGrid : function(heightMargin, widthMargin, minHeight, minWidth) {
	  //var height = $(document.body).height() - heightMargin;
	  var width = $(document.body).width() - widthMargin;
	
	  //height = height < minHeight ? minHeight : height;
	  width = width < minWidth ? minWidth : width;
	
	  $(this).datagrid('resize', {
	   height : 350,
	   width : width
	  });
	 }
	});
	
	$(function() {
	 // datagrid数据表格ID
	 var datagridId = 'test';
	
	 // 第一次加载时自动变化大小
	 $('#' + datagridId).resizeDataGrid(0, 0, 0, 0);
	
	 // 当窗口大小发生变化时，调整DataGrid的大小
	 $(window).resize(function() {
	  $('#' + datagridId).resizeDataGrid(0, 0, 0, 0);
	 });
	});
	
	//窗口
	function resize(){
			$('#w').window('resize',{
				width: 450,
				height: 400
			});
		}
	function open1(){
			$('#w').window('open');
		}
	function close1(){
			$('#w').window('close');
		}
	//消息
	function show1(msg){
			$.messager.show({
				title:'系统消息',
				msg:msg,
				showType:'show'
			});
		}
	function query(){	
		var nodeid = $("#qnodeid").val();	
		var pid = $("#qpid").val();
		var nodename = $("#qnodename").val();
		var level = $("#qlevel").combobox("getValue");
		var spurl = $("#qspurl").val();
		var sporder = $("#qsporder").val();
		$('#test').datagrid('load',{
			nodeid: nodeid,
			pid: pid,
			nodename: nodename,
			level: level,
			spurl : spurl,
			sporder : sporder
		});	
	}
	</script>
	</head>

	<body>

		<table width="100%">
			<tr>
				<td>
					<div>
						页面id:
						<input class="easyui-validatebox" type="text" id="qnodeid" name="qnodeid"></input>
				</td>
				<td>
					<div>
						父页id:
						<input class="easyui-validatebox" type="text" id="qpid"
							name="qpid"></input>
					</div>
				</td>
				<td>
					<div>
						页面名称:
						<input class="easyui-validatebox" type="text" id="qnodename"
							name="qnodename"></input>
					</div>
				</td>
				
				<td width="20%">
				</td>
				<td>
					<div>
						<a class="easyui-linkbutton" data-options="iconCls:'icon-search'"
							onclick="query();">查询</a>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div>
						页面级别:
                         <input id="qlevel" class="easyui-combobox" name="qlevel"  
    					data-options="panelHeight:'auto',valueField:'id',textField:'name',url:'cbox!query.action?pid=NAVIGATION'" />
					</div>
				</td>
				<td>
					<div>
						URL:
						<input class="easyui-validatebox" type="text" id="qspurl"
							name="qspurl"></input>
					</div>
				</td>
				<td>
					<div>
						排序:
						<input class="easyui-validatebox" type="text" id="qsporder"
							name="qsporder"></input>
					</div>
				</td>

				<td>
				</td>

				<td>
					<div>
						<a class="easyui-linkbutton" data-options="iconCls:'icon-save'">导出</a>
					</div>
				</td>
			</tr>


		</table>
		<table id="test"></table>
		<div id="w" class="easyui-window"
			data-options="title:'编辑资源',iconCls:'icon-save'" closed="true"
			style="width: 370px; height: 300px; padding: 5px;">
			<form id="addForm" method="post" novalidate>
				<table>
					<tr>
						<td>
							<div>
								<label>
									页面名称:
								</label>
								<input class="easyui-validatebox" type="text" id="nodename"
									name="nodename" data-options="required:true"></input>
								<input class="easyui-validatebox" type="hidden" id="nodeid"
									name="nodeid" data-options="required:true"></input>
							</div>
						</td>
						<td>
							<div>
								<label>
									父页面id:
								</label>
								<input class="easyui-validatebox" type="text" id="pid"
									name="pid" data-options="required:true"></input>
							</div>
						</td>
					</tr>
					<tr>

						<td>
							<div>
								<label>
									页面级别:
								</label>
								 <input id="level" class="easyui-combobox" name="level"  
    					         data-options="panelHeight:'auto',valueField:'id',textField:'name',url:'cbox!query.action?pid=NAVIGATION'" />
							</div>
						</td>
					</tr>
					<tr>

						<td>
							<div>
								<label>
									URL:
								</label>
								<input id="spurl" name="spurl" class="easyui-validatebox"
									required="required"></input>
							</div>
						</td>
						<td>
							<div>
								<label>
									排序:
								</label>
								<input id="sporder" name="sporder" class="easyui-validatebox"
									required="required"></input>
							</div>
						</td>
					</tr>
					<tr>


						
					</tr>
					<tr>
						<td>
							<div>
								<a class="easyui-linkbutton" data-options="iconCls:'icon-save'"
									onclick="dosave()">保存</a>
							</div>
						</td>
						<td>
							<div>
								<a class="easyui-linkbutton"
									data-options="iconCls:'icon-cancel'" onclick="close1()">取消</a>
							</div>
						</td>
					</tr>
				</table>
			</form>

		</div>
	</body>
	<script type="text/javascript">
		//新增 修改
		 function dosave() {
		 	$.messager.confirm('系统警告', '确定保存?', function(r){
			 	if (r){
			 		var nodeid = $("#nodeid").val();
					var pid = $("#pid").val();
					var nodename = $("#nodename").val();
					//alert(pid+";"+nodename+";");
					var level = $("#level").combobox("getValue");
					//alert(pid+";"+nodename+";"+level+";");
					var spurl = $("#spurl").val();
					var sporder = $("#sporder").val();
					if(checkForm()){
						
						$.post(
						      "node!edit.action",
						      {"nodeid":nodeid,"pid":pid,"nodename":nodename,"level":level,"spurl":spurl,"sporder":sporder},
						      function (data)
						      {
						      		addForm.reset();
						      		show1(data);
						      		$("#test").datagrid('reload');  
						      		close1();
						      },
						      "text"
						 );
					}else{
					     show1('上有数据未填写完全,请填写完成后再保存');
					}
				}
			});
			 
		 }
	 //删除
		function del(){
			$.messager.confirm('系统警告', '是否确定要删除?', function(r){
				if (r){
					var row = $('#test').datagrid('getSelected');
					if (row){
					    $.post(
						      "node!delete.action",
						      {"nodeid":row.nodeid},
						      function (data)
						      {
						      		show1(data);
						      		$("#test").datagrid('reload');  
						      },
						      "text"
						 );
					} 
				}
			});
	 		
		}
	//编辑
		function edit(){
			var row = $('#test').datagrid('getSelected');
				if (row){
					$("#nodeid").val(row.nodeid);
					$("#pid").val(row.pid);
					$("#nodename").val(row.nodename);
					$('#level').combobox('setValue',row.level);
					$("#spurl").val(row.spurl);
					$("#sporder").val(row.sporder);
					open1();
			} 
		}
	
			
	 	function checkForm(){
			var pid = $("#pid").val();
			var nodename = $("#nodename").val();
			var level = $("#level").combobox("getValue");
			//alert(pid+";"+nodename+";"+level+";");
			if(pid==''||nodename==''||level==''){
				return false;
			}else{
				return true;
			}
	 	}
	 	function castDate(date){
	 		var castdate = '';
	 		if(date!=''){
	 			var dl = date.split("/");
	 			if (dl.length>1){
	 				castdate= dl[2]+"-"+dl[0]+"-"+dl[1]
	 			}else{
		 			castdate=date;
		 		}
	 		}
	 		return castdate;
	 	}
	</script>
</html>
