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
					title:'代码信息',
					//iconCls:'icon-save',
					width:950,
					height:400,
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
							add();
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
				
				$('#type').datagrid({
					title:'代码分类',
					//iconCls:'icon-save',
					width:950,
					height:400,
					nowrap: true,
					autoRowHeight: false,
					striped: true,
					collapsible:true,
					url:'code!queryCodeType.action',
					sortName: 'code',
					loader:myLoader,
					sortOrder: 'desc',
					remoteSort: false,
					idField:'codeTypes',
					singleSelect:'true',
					loadMsg:'数据加载中...',
					frozenColumns:[[
		                {field:'ck',checkbox:true},
		                {title:'值id',field:'codetypeid',width:50,sortable:true}
					]],
					columns:[[
						{field:'codetypename',title:'代码类别英文名',width:150,rowspan:2},
						{field:'codetypecname',title:'代码类别中文名',width:150,rowspan:2}
					]],
					pagination:true,
					rownumbers:true,
					toolbar:[{
						id:'btnadd',
						text:'新增',
						iconCls:'icon-add',
						handler:function(){
							$('#btnsave').linkbutton('enable');
							addForm2.reset();
							open2();
						}
					},'-',{
						id:'btncut',
						text:'删除',
						iconCls:'icon-cut',
						handler:function(){
							$('#btnsave').linkbutton('enable');
							del2();
						}
					},'-',{
						id:'btnedit',
						text:'编辑',
						iconCls:'icon-edit',
						handler:function(){
							$('#btnsave').linkbutton('enable');
							edit2();
						}
					}
					]
				});
				$("#type").datagrid({
			        onClickRow : function(index, row){
			        	//alert(index+"+++"+row.rolenodeid); 
			        	$('#dict').datagrid('load',{
			        		codetypename:row.codetypename
						});	
			        }
			     });
				
				//设置分页控件   
			    var p = $('#dict').datagrid('getPager');   
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
			//alert("11");
			    $('#w').window('open');
			}
		//窗口
		function open2(){
			//alert("11");
			    $('#w1').window('open');
			}
		//窗口
		function add(){
			var row = $('#type').datagrid('getSelected');
			if (row){			
				$("#codeid").val("");
				$("#codetypename").val(row.codetypename);
				//$('#codetypename').combobox('setValue',row.codetypename);
				//alert(row.codetypename);
				$("#codename").val("");
				$("#codecname").val("");
				open1();
		   }else{
			show1("请先选择代码类别")
		   } 
		}
		function close1(){
				$('#w').window('close');
			}
		function close2(){
				$('#w1').window('close');
			}
		//消息
		function show1(msg){
				$.messager.show({
					title:'系统消息',
					msg:msg,
					showType:'show'
				});
			}
		/* function query(setid){
			$('#dict').datagrid('load',{
				setid:setid
			});	
		} */
		</script>
	</head>
	<body>
		<div class="easyui-layout" style="width: auto; height: 400px">
			<div data-options="region:'west'" 
				style="width: 450px; background: #fafafa; overflow: hidden">
				<table id="type"></table>
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
								<label for="codetypename">
									代码类别:
								</label>
								<input class="easyui-validatebox" type="hidden" id="codeid"
									name="codeid" data-options="required:true"></input>
	    						<input class="easyui-validatebox" type="text" readonly="readonly" id="codetypename" 
									name="codetypename" data-options="required:true"></input> 
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
			<div id="w1" class="easyui-window"
				data-options="title:'页面授权',iconCls:'icon-save'" closed="true"
				style="width: 370px; height: 300px; padding: 5px;">
				<form id="addForm2" method="post" novalidate>
				<table>
					<tr>
						<td>
							<div>
								<label for="codetypename">
									代码类别英文名:
								</label>
								<input class="easyui-validatebox" type="hidden" id="codetypeid"
									name="codetypeid" data-options="required:true"></input>
	    						<input class="easyui-validatebox" type="text" id="qcodetypename" 
									name="qcodetypename" data-options="required:true"></input> 
							</div>
						</td>
						</tr>
						<tr>
						<td>
							<div>
								<label for="codename">
									代码类别中文名:
								</label>
								<input class="easyui-validatebox" type="text" id="codetypecname"
									name="codetypecname" data-options="required:true"></input>
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div>
								<a class="easyui-linkbutton" data-options="iconCls:'icon-save'"
									onclick="dosave1()">保存</a>
							</div>
						</td>
						</tr>
						<tr>
						<td>
							<div>
								<a class="easyui-linkbutton"
									data-options="iconCls:'icon-cancel'" onclick="close2()">取消</a>
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
	 	$.messager.confirm('系统警告', '确定保存?', function(r){
		 	if (r){
		 		var codeid = $("#codeid").val();
		 		var codetypename = $("#codetypename").val();
		 		var codename = $("#codename").val();
				var codecname = $("#codecname").val();
				if(checkForm()){
				//alert(codeid+";"+codetypename);
					$.post(
					      "code!editCodeInfo.action",
					      {"codeid":codeid,"codetypename":codetypename,"codename":codename,"codecname":codecname},
					      function (data)
					      {
					      		addForm.reset();
					      		show1(data);
					      		$('#dict').datagrid('load');	
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
	//新增 修改
	 function dosave1() {
	 	$.messager.confirm('系统警告', '确定保存?', function(r){
		 	if (r){
		 		var codetypeid = $("#codetypeid").val();
		 		var codetypename = $("#qcodetypename").val();
		 		var codetypecname = $("#codetypecname").val();
		 		//alert(codetypename+";"+codetypecname);

				if(checkForm1()){		
					$.post(
					      "code!editCodeType.action",
					      {"codetypeid":codetypeid,"codetypename":codetypename,"codetypecname":codetypecname},
					      function (data)
					      {
					      		addForm2.reset();
					      		show1(data);
					      		$('#type').datagrid('load');	
					      		close2();
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
				//alert("sysuserid"+row.userid);	
				if (row){
				    $.post(
					      "code!deleteCodeInfo.action",
					      {"codeid":row.codeid},
					      function (data)
					      {
					      		show1(data);
					      		$('#dict').datagrid('load');	  
					      },
					      "text"
					 );
				} 
			}
		});
		
	}
	function del2(){
		$.messager.confirm('系统警告', '是否确定要删除?', function(r){
			if (r){
				var row = $('#type').datagrid('getSelected');
				//alert("sysuserid"+row.userid);	
				if (row){
				    $.post(
					      "code!deleteCodeType.action",
					      {"codetypeid":row.codetypeid,"codetypename":row.codetypename},
					      function (data)
					      {
					      		show1(data);
					      		$('#dict').datagrid('load');
					      		$('#type').datagrid('load');	  
					      },
					      "text"
					 );
				} 
			}
		});
		
	}
//编辑
	function edit(){
		//alert("11");
		var row = $('#dict').datagrid('getSelected');
			if (row){			
				$("#codeid").val(row.codeid);
				//$('#codetypename').combobox('setValue',row.codetypename);
				$("#codetypename").val(row.codetypename);
				//alert(row.codetypename);
				$("#codename").val(row.codename);
				$("#codecname").val(row.codecname);
				open1();
		} 
	}
	function edit2(){
		//alert("11");
		var row = $('#type').datagrid('getSelected');
			if (row){			
				$("#codetypeid").val(row.codetypeid);
				//$('#codetypename').combobox('setValue',row.codetypename);
				$("#qcodetypename").val(row.codetypename);
				//alert(row.codetypename);
				$("#codetypecname").val(row.codetypecname);
				open2();
		} 
	}

		
	function checkForm(){
		var cfcodename = $("#codename").val();
		var cfcodecname = $("#codecname").val();
		
		//alert(cfloginname+";"+cfusername+""+cfpassword+";"+cfage+""+";"+cfsex);
		if(cfcodename==''||cfcodecname==''){
			return false;
		}else{
			return true;
		}
	}
	function checkForm1(){
		var cfcodetypename = $("#qcodetypename").val();
		var cfcodetypecname = $("#codetypecname").val();
		
		//alert(cfloginname+";"+cfusername+""+cfpassword+";"+cfage+""+";"+cfsex);
		if(cfcodetypename==''||cfcodetypecname==''){
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
