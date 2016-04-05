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
			$(function(){
				$('#dict').datagrid({
					title:'权限角色',
					//iconCls:'icon-save',
					width:950,
					height:400,
					nowrap: true,
					autoRowHeight: false,
					striped: true,
					collapsible:true,
					url:'role!query.action',
					sortName: 'code',
					loader:myLoader,
					sortOrder: 'desc',
					remoteSort: false,
					idField:'dicts',
					singleSelect:'true',
					loadMsg:'数据加载中...',
					frozenColumns:[[
		                {field:'ck',checkbox:true},
		                {title:'值id',field:'rolenodeid',width:50,sortable:true}
					]],
					columns:[[
						{field:'usertypename',title:'角色名称',width:150,rowspan:2}
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
			
			function getSelected(){
				var selected = $('#dict').datagrid('getSelected');
				if (selected){
					alert(selected.code+":"+selected.name+":"+selected.addr+":"+selected.col4);
				}
			}
			function getSelections(){
				var ids = [];
				var rows = $('#dict').datagrid('getSelections');
				for(var i=0;i<rows.length;i++){
					ids.push(rows[i].code);
				}
				alert(ids.join(':'));
			}
			function clearSelections(){
				$('#dict').datagrid('clearSelections');
			}
			function selectRow(){
				$('#dict').datagrid('selectRow',2);
			}
			function selectRecord(){
				$('#dict').datagrid('selectRecord','002');
			}
			function unselectRow(){
				$('#dict').datagrid('unselectRow',2);
			}
			function mergeCells(){
				$('#dict').datagrid('mergeCells',{
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
			
		//窗口
		function open1(){
				if($("#setid").val()!=''){
					$('#w').window('open');
				}else{
					show1("请先选择想要添加的字典");
				}
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
		function query(setid){
			$('#dict').datagrid('load',{
				setid:setid
			});	
		}
			
		function domain(setid){
			query(setid);
			$("#setid").val(setid);
			
		}
			
			
		</script>
	</head>
	<body>

		<input type="hidden" id="setid" name="setid"></input>
		<div class="easyui-layout" style="width: auto; height: 400px">
		
			<div data-options="region:'west',split:true" title="导航"
				style="width: 170px;">
				<iframe src="treeMain!treeMain.action?isSearch=Y" height="99%"
					width="100%"></iframe>
			</div>
			<div data-options="region:'center'"
				style="background: #fafafa; overflow: hidden">
				<table id="dict"></table>
			</div>
			<div id="w" class="easyui-window"
				data-options="title:'页面授权',iconCls:'icon-save'" closed="true"
				style="width: 370px; height: 300px; padding: 5px;">
				<form id="addForm" method="post" novalidate>
					<table>
						<tr>
							<td>
								<div>
									<label>
										授权角色:
									</label>
									<!-- <input class="easyui-validatebox" type="hidden" id="rolenodeid"
										name="rolenodeid" data-options="required:true"></input> -->
									<input id="usertypename" class="easyui-combobox" name="usertypename"  
    						       data-options="panelHeight:'auto',valueField:'id',textField:'name',url:'cbox!query.action?pid=userType'" /> 
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
		</div>

	</body>
	<script type="text/javascript">
		//新增 修改
		 function dosave() {
		 	var setid = $("#setid").val();
			 		//alert(setid);
		 	$.messager.confirm('系统警告', '确定保存?', function(r){
			 	if (r){
			 		
			 		var usertypename = $("#usertypename").combobox("getValue");
					if(checkForm()){
					//alert(regusertype+";"+regdisabledate);
						$.post(
						      "role!add.action",
						      {"setid":setid,"usertypename":usertypename},
						      function (data)
						      {
						      		addForm.reset();
						      		show1(data);
						      		$("#dict").datagrid('reload');  
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
					var row = $('#dict').datagrid('getSelected');
					if (row){
					    $.post(
						      "role!delete.action",
						      {"rolenodeid":row.rolenodeid},
						      function (data)
						      {
						      		show1(data);
						      		$("#dict").datagrid('reload');  
						      },
						      "text"
						 );
					} 
				}
			});
	 		
		}
	//编辑
		function edit(){
			var row = $('#dict').datagrid('getSelected');
				if (row){
					$("#dictid").val(row.rolenameid);
					$("#dictname").combobox('setValue',row.usertypename);
					open1();
			} 
		}
	
			
	 	function checkForm(){
			var usertypename = $("#usertypename").combobox("getValue");
			//alert(cfloginname+";"+cfusername+""+cfpassword+";"+cfage+""+";"+cfsex);
			if(usertypename==''){
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
