<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.ismart.common.util.StrUtil;"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String type = StrUtil.nullToString(request.getParameter("type"));
	String pid = StrUtil.nullToString(request.getParameter("pid"));
	String level = StrUtil.nullToString(request.getParameter("level"));
	String isSearch = StrUtil.nullToString(request.getParameter("isSearch"));
	//System.out.println(type);
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<link rel="stylesheet" type="text/css" href="js/ztree/zTreeStyle.css" />
		<script type="text/javascript" src="js/jquery-1.4.2.min.js"></script>
		<script type="text/javascript" src="js/ztree/jquery.ztree.core-3.2.min.js"></script>


		<script type="text/javascript">
		var zNodes ="";
		var zTreeObj = "";
		var type ='<%=type%>';
		var pid ='<%=pid%>';
		var level ='<%=level%>';
		var isSearch = '<%=isSearch%>';
		var setting = {
			data: {
				simpleData: {
					enable: true,
					     idKey:"id",
                        pIdKey:"pid"
				}
			},
			
			    view:{
            showIcon:true,
            fontCss: getFontCss,
                    dblClickExpand:false
        },
          callback:{
            onClick:zTreeOnClick
        }
		};
		
         $(document).ready(function(){
			 $.post(
		      "init!queryNode.action?type="+type+"&pid="+pid+"&level="+level,
		      null,
		      function (data)
		      {
			    zNodes=data;
			    zTreeObj=$.fn.zTree.init($("#treeDemo"), setting, zNodes);
		      },
		      "json"
		 );
		  	

		 	
		});

    //鼠标点击事件，需要控制弹出框的位置什么之类。在此函数内设置
    function zTreeOnClick(event, treeId, treeNode) {
        var treeObj = $.fn.zTree.getZTreeObj(treeId);
        window.parent.domain(treeNode.id);
        if (!treeNode.open) {
            treeObj.expandNode(treeNode, false, false, false);
        }
    }
    
    
    
    
    function focusKey(e) {
			if (key.hasClass("empty")) {
				key.removeClass("empty");
			}
		}
		function blurKey(e) {
			if (key.get(0).value === "") {
				key.addClass("empty");
			}
		}
		var lastValue = "", nodeList = [], fontCss = {};
		function clickRadio(e) {
			lastValue = "";
			searchNode(e);
		}
		function searchNode(e) {
			var zTree = $.fn.zTree.getZTreeObj("treeDemo");
				var value = $.trim(key.get(0).value);
				var keyType = "name";
				if (key.hasClass("empty")) {
					value = "";
				}
				if (lastValue === value) return;
				lastValue = value;
				if (value === "") return;
				updateNodes(false);
				nodeList = zTree.getNodesByParamFuzzy(keyType, value);

			updateNodes(true);

		}
		function updateNodes(highlight) {
			var zTree = $.fn.zTree.getZTreeObj("treeDemo");
			for( var i=0, l=nodeList.length; i<l; i++) {
				nodeList[i].highlight = highlight;
				zTree.expandNode(nodeList[i], true, true, true);

				
				zTree.updateNode(nodeList[i]);
			}
		}
		function getFontCss(treeId, treeNode) {
			return (!!treeNode.highlight) ? {color:"#A60000", "font-weight":"bold"} : {color:"#333", "font-weight":"normal"};
		}
		function filter(node) {
			return !node.isParent && node.isFirstNode;
		}

		var key;
		$(document).ready(function(){
			$.fn.zTree.init($("#treeDemo"), setting, zNodes);
			key = $("#key");
			key.bind("focus", focusKey)
			.bind("blur", blurKey)
			.bind("propertychange", searchNode)
			.bind("input", searchNode);
		});
    
    
    
       </script>
	</head>
	<body>
		
		<table>
			<tr>
				<td style="font-size: 12">
					<%if("Y".equals(isSearch)){ %>
					搜索:
					<input type="text" id="key" value="" style="height: 18" size="10"
						class="empty" />
					<%} %>
					<div style="width: 100px;">
						<ul id="treeDemo" class="ztree" style="width: 300px;"></ul>
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
