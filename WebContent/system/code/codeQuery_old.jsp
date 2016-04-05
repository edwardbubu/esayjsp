<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>小代码维护</title>
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
				title:'小代码信息',
				iconCls:'icon-save',
				width:800,
				height:260,
				nowrap: true,
				autoRowHeight: false,
				striped: true,
				collapsible:true,
				url:'code!queryCodeInfo.action',
				sortName: 'code',
				loader:myLoader,
				sortOrder: 'desc',
				remoteSort: false,
				idField:'codes',
				singleSelect:'true',
				loadMsg:'数据加载中...',
				frozenColumns:[[
	                {field:'ck',checkbox:true},
	                {title:'代码id',field:'codeid',width:40,sortable:true}
				]],
				columns:[[
					{field:'codetypename',title:'代码类别',width:80,sortable:true},
					{field:'codename',title:'代码英文名',width:100,rowspan:2},
					{field:'codecname',title:'代码中文名',width:100,rowspan:2}	
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
		var qcodetypename = $("#qcodetypename").combobox("getValue");
		var qcodename = $("#qcodename").val();
		var qcodecname = $("#qcodecname").val();
		$('#test').datagrid('load',{
			qcodetypename: qcodetypename,
			qcodename: qcodename,
			qcodecname : qcodecname
		});	
	}
	
	
	</script>
	</head>

	<body>

		<table width="100%">
			<tr>
				<td>
				    <div>
						代码类别:
						<input id="qcodetypename" class="easyui-combobox" name="qcodetypename"  
    						data-options="panelHeight:'auto',valueField:'id',textField:'name',url:'cbox!queryType.action'" /> 	
				    </div>				
				</td>
				<td>
					<div>
						代码英文名:
						<input class="easyui-validatebox" type="text" id="qcodename"
							name="qcodename"></input>
					</div>
				</td>
				<td>
					<div>
						代码中文名:
						<input class="easyui-validatebox" type="text" id="qcodecname"
							name="qcodecname"></input>
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


		</table>
		<table id="test"></table>
		<div id="w" class="easyui-window"
			data-options="title:'编辑用户',iconCls:'icon-save'" closed="true"
			style="width: 370px; height: 300px; padding: 5px;">
			<form id="addForm" method="post" novalidate>
				<table>
					<tr>
						<td>
							<div>
								<label for="codetypename">
									代码类别:
								</label>
								<input class="easyui-validatebox" type="hidden" id="codeid"
									name="codeid" data-options="required:true"></input>
								<input id="codetypename" class="easyui-combobox" name="codetypename"  
	    							data-options="panelHeight:'auto',valueField:'id',textField:'name',url:'cbox!queryType.action'" /> 
							</div>
						</td>
						<td>
							<div>
								<label for="codename">
									代码英文名:
								</label>
								<input class="easyui-validatebox" type="text" id="codename"
									name="codename" data-options="required:true"></input>
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div>
								<label for="codecname">
								         代码中文名:
								</label>
								<input class="easyui-validatebox" type="text" id="codecname"
									name="codecname" data-options="required:true"></input>
							</div>
						</td>	
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
			 		var regcodeid = $("#codeid").val();
			 		var regcodetypename = $("#codetypename").combobox("getValue");
					var regcodename = $("#codename").val();
					var regcodecname = $("#codecname").val();
					if(checkForm()){
					//alert(regusertype+";"+regdisabledate);
						$.post(
						      "code!editCodeInfo.action",
						      {"codeid":regcodeid,"regcodetypename":regcodetypename,"regcodename":regcodename,"regcodecname":regcodecname},
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
					//alert("sysuserid"+row.userid);	
					if (row){
					    $.post(
						      "code!deleteCodeInfo.action",
						      {"codeid":row.codeid},
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
					$("#codeid").val(row.codeid);
					$('#codetypename').combobox('setValue',row.codetypename);
					$("#codename").val(row.codename);
					$("#codecname").val(row.codecname);
					open1();
			} 
		}
	
			
	 	function checkForm(){
	 		var cfcodetypename = $("#codetypename").combobox("getValue");
	 		var cfcodename = $("#codename").val();
			var cfcodecname = $("#codecname").val();
			
			//alert(cfloginname+";"+cfusername+""+cfpassword+";"+cfage+""+";"+cfsex);
			if(cfcodetypename==''||cfcodename==''||cfcodecname==''){
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
