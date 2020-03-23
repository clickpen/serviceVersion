<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML>
<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
	<style type="text/css">
		body,
		html,
		#allmap {
			width: 100%;
			height: 100%;
			overflow: hidden;
			margin: 0;
			font-family: "微软雅黑";
		}
	</style>
	<script type="text/javascript"
		src="http://api.map.baidu.com/api?v=2.0&ak=cfEylnTgGMTSQy6BiWxP0hrVsVRkS8vM"></script>
	<script src="<%=basePath%>js/jquery-3.0.0.js"></script>
	<script src="<%=basePath%>js/bootstrap.js"></script>
	<script src="<%=basePath%>js/bootstrap-table.js"></script>
	<link href="<%=basePath%>css/bootstrap.css" rel="stylesheet" />
	<link href="<%=basePath%>css/bootstrap-table.css" rel="stylesheet" />
	<link href="<%=basePath%>css/all.css" rel="stylesheet" />
	<script src="<%=basePath%>js/bootstrap-table-zh-CN.js"></script>
	<script src="<%=basePath%>js/ajaxUtil.js"></script>
	<title>分析展示</title>
</head>
<style>
	/*定义滚动条高宽及背景 高宽分别对应横竖滚动条的尺寸*/
	::-webkit-scrollbar {
		width: 5px;
		height: 16px;
		background-color: #84e6d8;
	}

	/*定义滚动条轨道 内阴影+圆角*/
	::-webkit-scrollbar-track {
		-webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, 0.3);
		border-radius: 10px;
		background-color: #84e6d8;
	}

	/*定义滑块 内阴影+圆角*/
	::-webkit-scrollbar-thumb {
		border-radius: 10px;
		-webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, .3);
		background-color: #00d3ff;
	}

	* {
		font-family: "微软雅黑";
	}

	.div_title {
		height: 5%;
		width: 100%;
		background-color: black;
		position: absolute;
		top: 0%;
	}

	.div_title>span {
		color: #00d3ff;
		font-size: 20px;
		padding-left: 2%;
		text-align: center;
		line-height: 35px;
	}

	.div_type {
		height: 10%;
		width: 88%;
		position: absolute;
		top: 6%;
	}

	.div_detail {
		float: left;
		width: 22%;
		position: absolute;
		border: solid 1px #00d3ff;
		color: #00d3ff;
		border-radius: 5px;
		top: 100%;
	}

	.app_type {
		float: left;
		width: 22%;
		height: 90%;
		position: relative;
		margin-left: 2%;
		border: solid 1px #00d3ff;
		background-color: black;
		color: #00d3ff;
		border-radius: 5px;
	}

	.app_name {
		margin-left: 5%;
	}

	.app_count {
		margin-left: 5%;
	}

	.rad {
		float: right;
		margin-top: 5%;
		margin-right: 5%;
	}

	tr {
		color: #00d3ef;
	}

	th,
	td {
		background-color: black;
		text-align: center;
	}

	.hide {
		display: none;
		marquee-speed: normal;
	}

	.divstyle {
		background-color: black;
		width: 100%;
		height: 690%;
		opacity: 0.7;
	}

	/*去掉表格竖线*/
	.fixed-table-container tbody td {
		border-left: 0px;
	}

	.fixed-table-container tbody tr:first-child td {
		border-top: hidden;
	}

	/*checkbox和文字说明位置一齐*/
	.inputcheckbox {
		vertical-align: middle;
	}

	.labelsize {
		font-size: 13px;
	}

	.fbmapcolor {
		width: 15px;
		height: 15px;
		background-color: #1784D0;
		display: inline-block;
	}

	.twmapcolor {
		width: 15px;
		height: 15px;
		background-color: #D066B4;
		display: inline-block;
	}

	.whmapcolor {
		width: 15px;
		height: 15px;
		background-color: #51C2D0;
		display: inline-block;
	}

	.temapcolor {
		width: 15px;
		height: 15px;
		background-color: red;
		display: inline-block;
	}

	.div_type_detail {
		width: 88%;
		position: absolute;
		top: 16%;
	}

	.subiao {
		cursor: pointer;
	}

	.rowclass {
		margin-top: 6%;
	}

	.colclass9 {
		padding-left: 29%;
	}

	.colclass2 {
		margin-top: 6%;
	}

	.line {
		border-bottom: #4ADDF2 solid 1px;
	}

	.clickshow {
		display: inline;
		margin-left: 34%;
	}
</style>

<body>
	<!-- 地图 -->
	<div id="allmap"></div>
	<!-- 项目名称 -->
	<div class="div_title"><span>Foreign App Analysis System</span></div>
	<!-- APP分类 -->
	<div class="div_type">
		<div class="app_type">
			<%--<div>
				<span class="app_name">FB</span>
				<div class="fbmapcolor"></div>
			</div>
			<div>
				<span class="app_count" id="fbNum"></span>
			</div>
			<div class="rad">
				<input type="checkbox" name="type" onclick="showWeekData('FB-2-0',this)"  value="fbid">
			</div>--%>
			<div class="row rowclass">
				<div class="col-sm-9 colclass9">
					<div>
						<span class="app_name">FB</span>
						<div class="fbmapcolor"></div>
					</div>
					<div>
						<span class="app_count" id="fbNum"></span>
					</div>
				</div>
				<div class="col-sm-2 colclass2">
					<div class="rad">
						<input type="checkbox" name="type" onclick="showWeekData('FB-2-0',this)" value="fbid">
					</div>
				</div>
			</div>
		</div>
		<div class="app_type">
			<div class="row rowclass">
				<div class="col-sm-9 colclass9">
					<div>
						<span class="app_name">Tw</span>
						<div class="twmapcolor"></div>
					</div>
					<div>
						<span class="app_count" id="twNum"></span>
					</div>
				</div>
				<div class="col-sm-2 colclass2">
					<div class="rad">
						<input type="checkbox" name="type" onclick="showWeekData('TW-2-0',this)" value="twid">
					</div>
				</div>
			</div>
		</div>
		<div class="app_type">
			<div class="row rowclass">
				<div class="col-sm-9 colclass9">
					<div>
						<span class="app_name">Wh</span>
						<div class="whmapcolor"></div>
					</div>
					<div>
						<span class="app_count" id="whNum"></span>
					</div>
				</div>
				<div class="col-sm-2 colclass2">
					<div class="rad">
						<input type="checkbox" name="type" onclick="showWeekData('WH-2-0',this)" value="whid">
					</div>
				</div>
			</div>
		</div>
		<div class="app_type">
			<div class="row rowclass">
				<div class="col-sm-9 colclass9">
					<div>
						<span class="app_name">Te</span>
						<div class="temapcolor"></div>
					</div>
					<div>
						<span class="app_count" id="teNum"></span>
					</div>
				</div>
				<div class="col-sm-2 colclass2">
					<div class="rad">
						<input type="checkbox" name="type" onclick="showWeekData('TE-2-0',this)" value="teid">
					</div>
				</div>
			</div>
		</div>
	</div>
	<%--各个模块的详情展示--%>
	<div class="div_type_detail">
		<!-- 详细数量展示FB Analysis -->
		<div class="div_detail" style="margin-left: 2%" id="fbid">
			<div style="background-color: black">
				<div style="color: #00d3ff;">
					<lable>FB Analysis</lable>
					<%--<label class="radio-inline">
					<input type="radio" name="fbduring" onclick="clickRadioLoaddata('FB-1-0');"  value="day">
					今日
				</label>--%>
					<label class="radio-inline">
						<%--<input type="radio" name="fbduring"  onclick="clickRadioLoaddata('FB-2-0');" value="week">--%>
						本周
					</label>
					<div class="clickshow">
						<label class="subiao line hide" onclick="showOrHide(this,'fbidnext','show')">展开</label>
						<label class="subiao  line" onclick="showOrHide(this,'fbidnext','hide')">收起</label>
					</div>
				</div>
			</div>
			<div id="fbidnext" class="divstyle ">
				<div>
					<table class="table" id="fbtable1"></table>
				</div>
				<div style="margin-top: 12px">
					<table id="fbtable3"></table>
				</div>
				<div style="margin-top: 12px">
					<table id="fbtable2"></table>
				</div>
			</div>
		</div>
		<!-- 详细数量展示FB Analysis -->
		<!-- 详细数量展示TW Analysis -->
		<div class="div_detail " style="margin-left: 26%" id="twid">
			<div style="background-color: black">
				<div style="color: #00d3ff;">
					<lable>TW Analysis</lable>
					<%--<label class="radio-inline">
					<input type="radio" name="twduring" onclick="clickRadioLoaddata('TW-1-0')" value="day">
					今日
				</label>--%>
					<label class="radio-inline">
						<%--<input type="radio" name="twduring" onclick="clickRadioLoaddata('TW-2-0')" value="week">--%>
						本周
					</label>
					<div class="clickshow">
						<label class="subiao line hide" onclick="showOrHide(this,'twidnext','show')">展开</label>
						<label class="subiao  line" onclick="showOrHide(this,'twidnext','hide')">收起</label>
					</div>
				</div>
			</div>
			<div id="twidnext" class="divstyle ">
				<div>
					<table id="twtable1"></table>
				</div>
				<div style="margin-top: 12px">
					<table id="twtable3"></table>
				</div>
				<div style="margin-top: 12px">
					<table id="twtable2"></table>
				</div>
			</div>
		</div>
		<!-- 详细数量展示TW Analysis -->
		<!-- 详细数量展示Wh Analysis -->
		<div class="div_detail " style="margin-left: 50%" id="whid">
			<div style="background-color: black">
				<div style="color: #00d3ff;">
					<lable>Wh Analysis</lable>
					<%--<label class="radio-inline">
					<input type="radio" name="whduring" onclick="clickRadioLoaddata('WH-1-0')" value="day">
					今日
				</label>--%>
					<label class="radio-inline">
						<%--<input type="radio" name="whduring" onclick="clickRadioLoaddata('WH-2-0')" value="week">--%>
						本周
					</label>
					<div class="clickshow">
						<label class="subiao line hide" onclick="showOrHide(this,'whidnext','show')">展开</label>
						<label class="subiao  line" onclick="showOrHide(this,'whidnext','hide')">收起</label>
					</div>
				</div>
			</div>
			<div id="whidnext" class="divstyle ">
				<div>
					<table id="whtable1"></table>
				</div>
				<div style="margin-top: 12px">
					<table id="whtable3"></table>
				</div>
				<div style="margin-top: 12px">
					<table id="whtable2"></table>
				</div>
			</div>
		</div>
		<!-- 详细数量展示Wh Analysis -->
		<!-- 详细数量展示Te Analysis -->
		<div class="div_detail " style="margin-left: 74%" id="teid">
			<div style="background-color: black">
				<div style="color: #00d3ff;">
					<lable>Te Analysis</lable>
					<%--<label class="radio-inline">
					<input type="radio" name="teduring" onclick="clickRadioLoaddata('TE-1-0')" value="day">
					今日
				</label>--%>
					<label class="radio-inline">
						<%--<input type="radio" name="teduring" onclick="clickRadioLoaddata('TE-2-0')" value="week">--%>
						本周
					</label>
					<div class="clickshow">
						<label class="subiao line hide" onclick="showOrHide(this,'teidnext','show')">展开</label>
						<label class="subiao  line" onclick="showOrHide(this,'teidnext','hide')">收起</label>
					</div>
				</div>
			</div>
			<div id="teidnext" class="divstyle ">
				<div>
					<table id="tetable1"></table>
				</div>
				<div style="margin-top: 12px">
					<table id="tetable3"></table>
				</div>
				<div style="margin-top: 12px">
					<table id="tetable2"></table>
				</div>
			</div>
		</div>
		<!-- 详细数量展示Te Analysis -->
	</div>
</body>

</html>
<script type="text/javascript">
	// 百度地图API功能
	var map = new BMap.Map("allmap");    // 创建Map实例
	map.centerAndZoom(new BMap.Point(116.404, 39.915), 6);  // 初始化地图,设置中心点坐标和地图级别
	map.setCurrentCity("北京");          // 设置地图显示的城市 此项是必须设置的
	map.enableScrollWheelZoom(true);     //开启鼠标滚轮缩放
	/*单选框默认显示初始化*/
	$("input[name='type']").prop('checked', true);
    /*$("input[name='fbduring']:first").prop('checked',true);
    $("input[name='twduring']:first").prop('checked',true);
    $("input[name='whduring']:first").prop('checked',true);
    $("input[name='teduring']:first").prop('checked',true);*/
	/* var show=new Map();
	 show.set('oldEle',$("#fbid"));
	 show.get('oldEle').removeClass("hide");
 /!*对展示块的展示和隐藏*!/
 function showOrhide(node){
		 var obj=$("#"+$(node).val());
		 if(show.get('oldEle')==obj){
		 }else {
			 show.get('oldEle').addClass('hide');
			 obj.removeClass('hide');
			 show.set('oldEle',obj);
		 }
	 }
 */
	/*对表格数据的展示和隐藏*/
	function showOrHide(node, id, away) {
		if (away == "show") {
			//$("#"+id).addClass('hide');
			$("#" + id).fadeIn(1000);
			$(node).addClass('hide');
			$(node).siblings().removeClass('hide');
		} else {
			//$("#"+id).addClass('hide');
			$("#" + id).fadeOut(1000);
			$(node).addClass('hide');
			$(node).siblings().removeClass('hide');
		}
	}
	/*点击fb,te,tw,wh时的操作-有今日数据交换版*/
	/*function clickRadio(str){
			var strs=str.split("-");
			var oTable = new TableInit();
			var data=oTable.queryParams("",strs[0],strs[1],strs[2]);
			var tableName;
			switch (strs[0]) {
				case 'FB':
					$("input[name='fbduring']:first").prop('checked',true);
					tableName='fbtable';
					break;
				case 'TE':
					$("input[name='teduring']:first").prop('checked',true);
					tableName='tetable';
					break;
				case 'TW':
					$("input[name='twduring']:first").prop('checked',true);
					tableName='twtable';
					break;
				case 'WH':
					$("input[name='whduring']:first").prop('checked',true);
					tableName='whtable';
					break;
			}
			$.ajax({
				type:"post",
				url:"main/search",
				data:data,
				dataType:"json",
				success:function (data) {
					oTable.Init(data,tableName);
					oTable.Init2(data,tableName);
					oTable.Init3(data,tableName);
				}
			});
		}*/
	/*点击今日，本周时的操作*/
	/*function clickRadioLoaddata(str){
			var strs=str.split("-");
			var oTable = new TableInit();
			var data=oTable.queryParams("",strs[0],strs[1],strs[2]);
			var tableName=changeTotable(strs[0]);
			$.ajax({
				type:"post",
				url:"main/search",
				data:data,
				dataType:"json",
				success:function (data) {
					$('#'+tableName+1).bootstrapTable('removeAll');
					$('#'+tableName+3).bootstrapTable('removeAll');
					$('#'+tableName+1).bootstrapTable('load',data.mcc);
					$('#'+tableName+3).bootstrapTable('load',data.destIp);
					oTable.Init2(data,tableName);
				}
			});
		}*/
	/*是否包含dns请求数据---有今日数据交换版*/
	/*function clickDns(node){
			var check=$(node).is(":checked");
			var id=$("input[name='type']:checked").attr('value');
			var type;
			var searchType;
			switch (id) {
				case 'fbid':
					type="FB";
					if($("input[name='fbduring']:checked").attr('value')=="day"){
						searchType=1;
					}else{
						searchType=2;
					}
					break;
				case 'teid':
					type="TE";
					if($("input[name='teduring']:checked").attr('value')=="day"){
						searchType=1;
					}else{
						searchType=2;
					}
					break;
				case 'whid':
					type="WH";
					if($("input[name='whduring']:checked").attr('value')=="day"){
						searchType=1;
					}else{
						searchType=2;
					}
					break;
				case 'twid':
					type="TW";
					if($("input[name='twduring']:checked").attr('value')=="day"){
						searchType=1;
					}else{
						searchType=2;
					}
					break;
			}
			 var tableName=changeTotable(type);
			if(check==true){
				var oTable = new TableInit();
				var data=oTable.queryParams("",type,searchType,0);
				$.ajax({
					type:"post",
					url:"main/search",
					data:data,
					dataType:"json",
					success:function (data) {
						oTable.Init2check(data,tableName);
					}
				});
			}else{
				var oTable = new TableInit();
				var data=oTable.queryParams("",type,searchType,1);
				$.ajax({
					type:"post",
					url:"main/search",
					data:data,
					dataType:"json",
					success:function (data) {
						oTable.Init2(data,tableName);
					}
				});
			}
		}*/
	/*转换对应table的id名*/
	function changeTotable(str) {
		switch (str) {
			case 'FB':
				return "fbtable";
				break;
			case 'TE':
				return "tetable";
				break;
			case 'TW':
				return "twtable";
				break;
			case 'WH':
				return "whtable";
				break;
		}
	}
	/*-------------------------------------------------------------------------------------------------------------------------------*/
	/*显示本周的数据*/
	function showWeekData(str, node) {
		var bol = $(node).prop('checked');
		var strs = str.split("-");
		var oTable = new TableInit();
		var data = oTable.queryParams("", strs[0], strs[1], strs[2]);
		var tableName;
		switch (strs[0]) {
			case 'FB':
				tableName = 'fbtable';
				break;
			case 'TE':
				tableName = 'tetable';
				break;
			case 'TW':
				tableName = 'twtable';
				break;
			case 'WH':
				tableName = 'whtable';
				break;
		}
		if (bol == false) {
			$("#" + tableName + 1).bootstrapTable('destroy');
			$('#' + tableName + 2).bootstrapTable('destroy');
			$('#' + tableName + 3).bootstrapTable('destroy');
		} else {
			$.ajax({
				type: "post",
				url: "<%=basePath%>main/search",
				data: data,
				dataType: "json",
				success: function(data) {
					oTable.Init(data, tableName);
					oTable.Init2(data, tableName);
					oTable.Init3(data, tableName);
				}
			});
		}
		checkboxClick(node);
	}
	/*点击标题文件 事件*/
	function checkboxClick(node) {
		var bool = $(node).prop('checked');
		if (bool == false) {
			//$("#"+$(node).val()).addClass('hide');
			switch ($(node).val()) {
				case 'fbid':
					fbpointCollection.clear();
					break;
				case 'teid':
					tepointCollection.clear();
					break;
				case 'whid':
					whpointCollection.clear();
					break;
				case 'twid':
					twpointCollection.clear();
					break;
			}
			$("#" + $(node).val()).fadeOut(2000);
		} else {
			//$("#"+$(node).val()).removeClass('hide');
			switch ($(node).val()) {
				case 'fbid':
					$.ajax({
						type: "post",
						url: "<%=basePath%>main/total",
						dataType: "json",
						success: function(data) {
							var fb = data.fb_record;
							// 判断当前浏览器是否支持绘制海量点
							if (document.createElement('canvas').getContext) {
								var fbpoints = [];  // 添加海量点数据
								for (var i = 0; i < fb.length; i++) {
									fbpoints.push(new BMap.Point(fb[i].x, fb[i].y));
								}
								var fboption = {
									size: BMAP_POINT_SIZE_NORMAL,
									shape: BMAP_POINT_SHAPE_SQUARE,
									color: '#1784D0'
								}
								// 初始化PointCollection
								fbpointCollection = new BMap.PointCollection(fbpoints, fboption);
								fbpointCollection.addEventListener('click', function(e) {
									// 循环查出值
									for (var i = 0; i < fb.length; i++) {
										fbpoints.push(new BMap.Point(fb[i].x, fb[i].y));
										if (fb[i].x == e.point.lng && fb[i].y == e.point.lat) {// 经度==点击的,维度
											break;
										}
									}
									var point = new BMap.Point(e.point.lng, e.point.lat);
									var marker = new BMap.Marker(point);
								/*var myIcon = new BMap.Icon("http://lbsyun.baidu.com/jsdemo/img/fox.gif", new BMap.Size(50,25));
                                var marker = new BMap.Marker(point,{icon:myIcon});  // 创建标注
                    */			var opts = {
										width: 200, // 信息窗口宽度
										height: 70, // 信息窗口高度
										//title:"", // 信息窗口标题
										//enableMessage: false,// 设置允许信息窗发送短息
									}
									var Content = "<div>"//自定义的展示内容
										+ "<div><span style='margin:0 0 5px 0;padding:0.2em 0.2em;color:#000'>" + fb[i].dd + "</span></br>"
										+ "<span style='margin:0;line-height:1.5;font-size:8px;text-indent:2em;color:#989898'>位置：" + fb[i].address + "</span>"
										+ "</div>";
									var infoWindow = new BMap.InfoWindow(Content);  // 创建信息窗口对象
									map.openInfoWindow(infoWindow, point); //开启信息窗口
								});
								map.addOverlay(fbpointCollection);  // 添加Overlay
							} else {
								alert('请在chrome、safari、IE8+以上浏览器查看本示例');
							}
						}
					});
					break;
				case 'teid':
					$.ajax({
						type: "post",
						url: "<%=basePath%>main/total",
						dataType: "json",
						success: function(data) {
							var te = data.te_record;
							// 判断当前浏览器是否支持绘制海量点
							if (document.createElement('canvas').getContext) {
								var tepoints = [];
								for (var i = 0; i < te.length; i++) {
									tepoints.push(new BMap.Point(te[i].x, te[i].y));
								}
								var teoption = {
									size: BMAP_POINT_SIZE_NORMAL,
									shape: BMAP_POINT_SHAPE_SQUARE,
									color: 'red'
								}
								tepointCollection = new BMap.PointCollection(tepoints, teoption);
								tepointCollection.addEventListener('click', function(e) {
									// 循环查出值
									for (var i = 0; i < te.length; i++) {
										tepoints.push(new BMap.Point(te[i].x, te[i].y));
										if (te[i].x == e.point.lng && te[i].y == e.point.lat) {// 经度==点击的,维度
											break;
										}
									}
									var point = new BMap.Point(e.point.lng, e.point.lat);
									var marker = new BMap.Marker(point);
								/*var myIcon = new BMap.Icon("http://lbsyun.baidu.com/jsdemo/img/fox.gif", new BMap.Size(50,25));
                                var marker = new BMap.Marker(point,{icon:myIcon});  // 创建标注
                    */			var opts = {
										width: 200, // 信息窗口宽度
										height: 70, // 信息窗口高度
										//title:"", // 信息窗口标题
										//enableMessage: false,// 设置允许信息窗发送短息
									}
									var Content = "<div>"//自定义的展示内容
										+ "<div><span style='margin:0 0 5px 0;padding:0.2em 0.2em;color:#000'>" + te[i].dd + "</span></br>"
										+ "<span style='margin:0;line-height:1.5;font-size:8px;text-indent:2em;color:#989898'>位置：" + te[i].address + "</span>"
										+ "</div>";
									var infoWindow = new BMap.InfoWindow(Content);  // 创建信息窗口对象
									map.openInfoWindow(infoWindow, point); //开启信息窗口
								});
								map.addOverlay(tepointCollection);
							} else {
								alert('请在chrome、safari、IE8+以上浏览器查看本示例');
							}
						}
					});
					break;
				case 'whid':
					$.ajax({
						type: "post",
						url: "<%=basePath%>main/total",
						dataType: "json",
						success: function(data) {
							var wh = data.wh_record;
							if (document.createElement('canvas').getContext) {
								var whpoints = [];
								for (var i = 0; i < wh.length; i++) {
									whpoints.push(new BMap.Point(wh[i].x, wh[i].y));
								}
								var whoption = {
									size: BMAP_POINT_SIZE_NORMAL,
									shape: BMAP_POINT_SHAPE_SQUARE,
									color: '#51C2D0'
								}
								whpointCollection = new BMap.PointCollection(whpoints, whoption);
								whpointCollection.addEventListener('click', function(e) {
									// 循环查出值
									for (var i = 0; i < wh.length; i++) {
										whpoints.push(new BMap.Point(wh[i].x, wh[i].y));
										if (wh[i].x == e.point.lng && wh[i].y == e.point.lat) {// 经度==点击的,维度
											break;
										}
									}
									var point = new BMap.Point(e.point.lng, e.point.lat);
									var marker = new BMap.Marker(point);
								/*var myIcon = new BMap.Icon("http://lbsyun.baidu.com/jsdemo/img/fox.gif", new BMap.Size(50,25));
                                var marker = new BMap.Marker(point,{icon:myIcon});  // 创建标注
                    */			var opts = {
										width: 200, // 信息窗口宽度
										height: 70, // 信息窗口高度
										//title:"", // 信息窗口标题
										//enableMessage: false,// 设置允许信息窗发送短息
									}
									var Content = "<div>"//自定义的展示内容
										+ "<div><span style='margin:0 0 5px 0;padding:0.2em 0.2em;color:#000'>" + wh[i].dd + "</span></br>"
										+ "<span style='margin:0;line-height:1.5;font-size:8px;text-indent:2em;color:#989898'>位置：" + wh[i].address + "</span>"
										+ "</div>";
									var infoWindow = new BMap.InfoWindow(Content);  // 创建信息窗口对象
									map.openInfoWindow(infoWindow, point); //开启信息窗口
								});
								map.addOverlay(whpointCollection);
							} else {
								alert('请在chrome、safari、IE8+以上浏览器查看本示例');
							}
						}
					});
					break;
				case 'twid':
					$.ajax({
						type: "post",
						url: "<%=basePath%>main/total",
						dataType: "json",
						success: function(data) {
							var tw = data.tw_record;
							// 判断当前浏览器是否支持绘制海量点
							if (document.createElement('canvas').getContext) {
								var twpoints = [];
								for (var i = 0; i < tw.length; i++) {
									twpoints.push(new BMap.Point(tw[i].x, tw[i].y));
								}
								var twoption = {
									size: BMAP_POINT_SIZE_NORMAL,
									shape: BMAP_POINT_SHAPE_SQUARE,
									color: '#D066B4'
								}
								twpointCollection = new BMap.PointCollection(twpoints, twoption);
								twpointCollection.addEventListener('click', function(e) {
									// 循环查出值
									for (var i = 0; i < tw.length; i++) {
										twpoints.push(new BMap.Point(tw[i].x, tw[i].y));
										if (tw[i].x == e.point.lng && tw[i].y == e.point.lat) {// 经度==点击的,维度
											break;
										}
									}
									var point = new BMap.Point(e.point.lng, e.point.lat);
									var marker = new BMap.Marker(point);
								/*var myIcon = new BMap.Icon("http://lbsyun.baidu.com/jsdemo/img/fox.gif", new BMap.Size(50,25));
                                var marker = new BMap.Marker(point,{icon:myIcon});  // 创建标注
                    */			var opts = {
										width: 200, // 信息窗口宽度
										height: 70, // 信息窗口高度
										//title:"", // 信息窗口标题
										//enableMessage: false,// 设置允许信息窗发送短息
									}
									var Content = "<div>"//自定义的展示内容
										+ "<div><span style='margin:0 0 5px 0;padding:0.2em 0.2em;color:#000'>" + tw[i].dd + "</span></br>"
										+ "<span style='margin:0;line-height:1.5;font-size:8px;text-indent:2em;color:#989898'>位置：" + tw[i].address + "</span>"
										+ "</div>";
									var infoWindow = new BMap.InfoWindow(Content);  // 创建信息窗口对象
									map.openInfoWindow(infoWindow, point); //开启信息窗口
								});
								map.addOverlay(twpointCollection);
							} else {
								alert('请在chrome、safari、IE8+以上浏览器查看本示例');
							}
						}
					});
					break;
			}
			$("#" + $(node).val()).fadeIn(2000);
		}
	}
	function clickDns(node) {
		var check = $(node).is(":checked");
		var idtable = $(node).attr('id');
		switch (idtable) {
			case 'fbtable':
				type = "FB";
				break;
			case 'tetable':
				type = "TE";
				break;
			case 'whtable':
				type = "WH";
				break;
			case 'twtable':
				type = "TW";
				break;
		}
		if (check == true) {
			var oTable = new TableInit();
			var data = oTable.queryParams("", type, 2, 1);
			$.ajax({
				type: "post",
				url: "main/search",
				data: data,
				dataType: "json",
				success: function(data) {
					oTable.Init2check(data, idtable);
				}
			});
		} else {
			var oTable = new TableInit();
			var data = oTable.queryParams("", type, 2, 0);
			$.ajax({
				type: "post",
				url: "main/search",
				data: data,
				dataType: "json",
				success: function(data) {
					oTable.Init2(data, idtable);
				}
			});
		}
	}
	var tepointCollection = null;
	var twpointCollection = null;
	var fbpointCollection = null;
	var whpointCollection = null;
	/*页面内容初始化*/
	$(function() {
		//1.初始化Table
		showWeekData("FB-2-0");
		showWeekData('TE-2-0');
		showWeekData('WH-2-0');
		showWeekData('TW-2-0');
		/*显示地图点*/
		$.ajax({
			type: "post",
			url: "<%=basePath%>main/total",
			dataType: "json",
			success: function(data) {
				var te = data.te_record;
				var fb = data.fb_record;
				var tw = data.tw_record;
				var wh = data.wh_record;
				$("#fbNum").text(data.fb_num + "/" + data.fb_total);
				$("#teNum").text(data.te_num + "/" + data.te_total);
				$("#twNum").text(data.tw_num + "/" + data.tw_total);
				$("#whNum").text(data.wh_num + "/" + data.wh_total);
				// 判断当前浏览器是否支持绘制海量点
				if (document.createElement('canvas').getContext) {
					var fbpoints = [];  // 添加海量点数据
					var tepoints = [];
					var twpoints = [];
					var whpoints = [];
					for (var i = 0; i < fb.length; i++) {
						fbpoints.push(new BMap.Point(fb[i].x, fb[i].y));
					}
					for (var i = 0; i < te.length; i++) {
						tepoints.push(new BMap.Point(te[i].x, te[i].y));
					}
					for (var i = 0; i < tw.length; i++) {
						twpoints.push(new BMap.Point(tw[i].x, tw[i].y));
					}
					for (var i = 0; i < wh.length; i++) {
						whpoints.push(new BMap.Point(wh[i].x, wh[i].y));
					}
					var fboption = {
						size: BMAP_POINT_SIZE_NORMAL,
						shape: BMAP_POINT_SHAPE_SQUARE,
						color: '#1784D0'
					}
					var teoption = {
						size: BMAP_POINT_SIZE_NORMAL,
						shape: BMAP_POINT_SHAPE_SQUARE,
						color: 'red'
					}
					var twoption = {
						size: BMAP_POINT_SIZE_NORMAL,
						shape: BMAP_POINT_SHAPE_SQUARE,
						color: '#D066B4'
					}
					var whoption = {
						size: BMAP_POINT_SIZE_NORMAL,
						shape: BMAP_POINT_SHAPE_SQUARE,
						color: '#51C2D0'
					}
					// 初始化PointCollection
					fbpointCollection = new BMap.PointCollection(fbpoints, fboption);
					fbpointCollection.addEventListener('click', function(e) {
						// 循环查出值
						for (var i = 0; i < fb.length; i++) {
							fbpoints.push(new BMap.Point(fb[i].x, fb[i].y));
							if (fb[i].x == e.point.lng && fb[i].y == e.point.lat) {// 经度==点击的,维度
								break;
							}
						}
						var point = new BMap.Point(e.point.lng, e.point.lat);
						var marker = new BMap.Marker(point);
					/*var myIcon = new BMap.Icon("http://lbsyun.baidu.com/jsdemo/img/fox.gif", new BMap.Size(50,25));
                    var marker = new BMap.Marker(point,{icon:myIcon});  // 创建标注
        */			var opts = {
							width: 200, // 信息窗口宽度
							height: 70, // 信息窗口高度
							//title:"", // 信息窗口标题
							//enableMessage: false,// 设置允许信息窗发送短息
						}
						var Content = "<div>"//自定义的展示内容
							+ "<div><span style='margin:0 0 5px 0;padding:0.2em 0.2em;color:#000'>" + fb[i].dd + "</span></br>"
							+ "<span style='margin:0;line-height:1.5;font-size:8px;text-indent:2em;color:#989898'>位置：" + fb[i].address + "</span>"
							+ "</div>";
						var infoWindow = new BMap.InfoWindow(Content);  // 创建信息窗口对象
						map.openInfoWindow(infoWindow, point); //开启信息窗口
					});
					tepointCollection = new BMap.PointCollection(tepoints, teoption);
					tepointCollection.addEventListener('click', function(e) {
						// 循环查出值
						for (var i = 0; i < te.length; i++) {
							tepoints.push(new BMap.Point(te[i].x, te[i].y));
							if (te[i].x == e.point.lng && te[i].y == e.point.lat) {// 经度==点击的,维度
								break;
							}
						}
						var point = new BMap.Point(e.point.lng, e.point.lat);
						var marker = new BMap.Marker(point);
					/*var myIcon = new BMap.Icon("http://lbsyun.baidu.com/jsdemo/img/fox.gif", new BMap.Size(50,25));
                    var marker = new BMap.Marker(point,{icon:myIcon});  // 创建标注
        */			var opts = {
							width: 200, // 信息窗口宽度
							height: 70, // 信息窗口高度
							//title:"", // 信息窗口标题
							//enableMessage: false,// 设置允许信息窗发送短息
						}
						var Content = "<div>"//自定义的展示内容
							+ "<div><span style='margin:0 0 5px 0;padding:0.2em 0.2em;color:#000'>" + te[i].dd + "</span></br>"
							+ "<span style='margin:0;line-height:1.5;font-size:8px;text-indent:2em;color:#989898'>位置：" + te[i].address + "</span>"
							+ "</div>";
						var infoWindow = new BMap.InfoWindow(Content);  // 创建信息窗口对象
						map.openInfoWindow(infoWindow, point); //开启信息窗口
					});
					twpointCollection = new BMap.PointCollection(twpoints, twoption);
					twpointCollection.addEventListener('click', function(e) {
						// 循环查出值
						for (var i = 0; i < tw.length; i++) {
							twpoints.push(new BMap.Point(tw[i].x, tw[i].y));
							if (tw[i].x == e.point.lng && tw[i].y == e.point.lat) {// 经度==点击的,维度
								break;
							}
						}
						var point = new BMap.Point(e.point.lng, e.point.lat);
						var marker = new BMap.Marker(point);
					/*var myIcon = new BMap.Icon("http://lbsyun.baidu.com/jsdemo/img/fox.gif", new BMap.Size(50,25));
                    var marker = new BMap.Marker(point,{icon:myIcon});  // 创建标注
        */			var opts = {
							width: 200, // 信息窗口宽度
							height: 70, // 信息窗口高度
							//title:"", // 信息窗口标题
							//enableMessage: false,// 设置允许信息窗发送短息
						}
						var Content = "<div>"//自定义的展示内容
							+ "<div><span style='margin:0 0 5px 0;padding:0.2em 0.2em;color:#000'>" + tw[i].dd + "</span></br>"
							+ "<span style='margin:0;line-height:1.5;font-size:8px;text-indent:2em;color:#989898'>位置：" + tw[i].address + "</span>"
							+ "</div>";
						var infoWindow = new BMap.InfoWindow(Content);  // 创建信息窗口对象
						map.openInfoWindow(infoWindow, point); //开启信息窗口
					});
					whpointCollection = new BMap.PointCollection(whpoints, whoption);
					whpointCollection.addEventListener('click', function(e) {
						// 循环查出值
						for (var i = 0; i < wh.length; i++) {
							whpoints.push(new BMap.Point(wh[i].x, wh[i].y));
							if (wh[i].x == e.point.lng && wh[i].y == e.point.lat) {// 经度==点击的,维度
								break;
							}
						}
						var point = new BMap.Point(e.point.lng, e.point.lat);
						var marker = new BMap.Marker(point);
					/*var myIcon = new BMap.Icon("http://lbsyun.baidu.com/jsdemo/img/fox.gif", new BMap.Size(50,25));
                    var marker = new BMap.Marker(point,{icon:myIcon});  // 创建标注
        */			var opts = {
							width: 200, // 信息窗口宽度
							height: 70, // 信息窗口高度
							//title:"", // 信息窗口标题
							//enableMessage: false,// 设置允许信息窗发送短息
						}
						var Content = "<div>"//自定义的展示内容
							+ "<div><span style='margin:0 0 5px 0;padding:0.2em 0.2em;color:#000'>" + wh[i].dd + "</span></br>"
							+ "<span style='margin:0;line-height:1.5;font-size:8px;text-indent:2em;color:#989898'>位置：" + wh[i].address + "</span>"
							+ "</div>";
						var infoWindow = new BMap.InfoWindow(Content);  // 创建信息窗口对象
						map.openInfoWindow(infoWindow, point); //开启信息窗口
					});
					map.addOverlay(fbpointCollection);  // 添加Overlay
					map.addOverlay(tepointCollection);
					map.addOverlay(twpointCollection);
					map.addOverlay(whpointCollection);
				} else {
					alert('请在chrome、safari、IE8+以上浏览器查看本示例');
				}
			}
		});
	});
	var TableInit = function() {
		var oTableInit = new Object();
		//初始化Table
		oTableInit.Init = function(data, name) {
			$('#' + name + 1).bootstrapTable('destroy');
			$('#' + name + 1).bootstrapTable({
				//url:'main/search',         //请求后台的URL（*）
				data: data.mcc,
				method: 'get',                      //请求方式（*）
				//toolbar: '#toolbar',                //工具按钮用哪个容器
				striped: true,                      //是否显示行间隔色
				cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
				pagination: false,                   //是否显示分页（*）
				sortable: true,                     //是否启用排序
				sortOrder: "asc",                   //排序方式
				//queryParams: oTableInit.queryParams,//传递参数（*）
				//sidePagination: "server",           //分页方式：client客户端分页，server服务端分页（*）
				//	pageNumber:1,                       //初始化加载第一页，默认第一页
				//pageSize: 10,                       //每页的记录行数（*）
				//pageList: [10, 25, 50, 100],        //可供选择的每页的行数（*）
				search: false,                       //是否显示表格搜索，此搜索是客户端搜索，不会进服务端，所以，个人感觉意义不大
				strictSearch: true,
				showColumns: false,                  //是否显示所有的列
				showRefresh: false,                  //是否显示刷新按钮
				minimumCountColumns: 2,             //最少允许的列数
				clickToSelect: true,                //是否启用点击选中行
				height: 160,                        //行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
				uniqueId: "ID",                     //每一行的唯一标识，一般为主键列
				showToggle: false,                    //是否显示详细视图和列表视图的切换按钮
				cardView: false,                    //是否显示详细视图
				detailView: false,                   //是否显示父子表
				columns: [{
					field: 'mcc',
					title: 'MCC',
					sortable: false
				}, {
					field: 'country',
					title: '国家'
				}, {
					field: 'visitCount',
					title: '数量',
					sortable: true,
					sortOrder: "asc",
				},],
				/*responseHandler: function (data) {
					return data.mcc;
				}*/
			});
		};
		oTableInit.Init2 = function(allData, name) {
			$('#' + name + 2).bootstrapTable('destroy');
			$('#' + name + 2).bootstrapTable({
				//url: 'main/search?type=TE&searchType=2&dns=0',         //请求后台的URL（*）
				data: allData.domain,
				method: 'get',                      //请求方式（*）
				//toolbar: '#toolbar',              // 工具按钮用哪个容器
				sortable: true,                     //是否启用排序
				sortOrder: "asc",                   //排序方式
				striped: true,                      //是否显示行间隔色
				/*cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
				pagination: false,                   //是否显示分页（*）
			//	queryParams: oTableInit.queryParams,//传递参数（*）
				sidePagination: "server",           //分页方式：client客户端分页，server服务端分页（*）
				pageNumber:1,                       //初始化加载第一页，默认第一页
				pageSize: 10,                       //每页的记录行数（*）
				pageList: [10, 25, 50, 100],        //可供选择的每页的行数（*）
				search: false,                       //是否显示表格搜索，此搜索是客户端搜索，不会进服务端，所以，个人感觉意义不大
				strictSearch: true,
				showColumns: false,                  //是否显示所有的列
				showRefresh: false,                  //是否显示刷新按钮
				minimumCountColumns: 2,             //最少允许的列数
				clickToSelect: true,                 //是否启用点击选中行
				/*uniqueId: "ID",                     //每一行的唯一标识，一般为主键列
				showToggle:false,                    //是否显示详细视图和列表视图的切换按钮
				cardView: false,                    //是否显示详细视图
				detailView: false, */                 //是否显示父子表
				height: 160,                        //行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
				columns: [{
					field: 'domain',
					title: '域名' +
						'        <label class="labelsize" for="' + name + '"><input class="inputcheckbox" type="checkbox" id="' + name + '"  onclick="clickDns(this)">包含DNS请求\n' +
						'            </label>\n'
				}, {
					field: 'visitCount',
					title: '访问次数',
					sortable: true
				},],
				/*responseHandler: function (allData) {
					return allData.domain;
				}*/
			});
		};
		oTableInit.Init2check = function(allData, name) {
			$('#' + name + 2).bootstrapTable('destroy');
			$('#' + name + 2).bootstrapTable({
				//url: 'main/search?type=TE&searchType=2&dns=0',         //请求后台的URL（*）
				data: allData.domain,
				method: 'get',                      //请求方式（*）
				//toolbar: '#toolbar',                //工具按钮用哪个容器
				striped: true,                      //是否显示行间隔色
				sortable: true,                     //是否启用排序
				sortOrder: "asc",                   //排序方式
				/*cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
				pagination: false,                   //是否显示分页（*）
			//	queryParams: oTableInit.queryParams,//传递参数（*）
				sidePagination: "server",           //分页方式：client客户端分页，server服务端分页（*）
				pageNumber:1,                       //初始化加载第一页，默认第一页
				pageSize: 10,                       //每页的记录行数（*）
				pageList: [10, 25, 50, 100],        //可供选择的每页的行数（*）
				search: false,                       //是否显示表格搜索，此搜索是客户端搜索，不会进服务端，所以，个人感觉意义不大
				strictSearch: true,
				showColumns: false,                  //是否显示所有的列
				showRefresh: false,                  //是否显示刷新按钮
				minimumCountColumns: 2,             //最少允许的列数
				clickToSelect: true,                 //是否启用点击选中行
				/*uniqueId: "ID",                     //每一行的唯一标识，一般为主键列
				showToggle:false,                    //是否显示详细视图和列表视图的切换按钮
				cardView: false,                    //是否显示详细视图
				detailView: false, */                 //是否显示父子表
				height: 160,                        //行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
				columns: [{
					field: 'domain',
					title: '域名' +
						'        <label class="labelsize" for="' + name + '"><input class="inputcheckbox" type="checkbox" id="' + name + '" checked="checked" onclick="clickDns(this)">包含DNS请求\n' +
						'            </label>\n'
				}, {
					field: 'visitCount',
					title: '访问次数',
					sortable: true
				},],
				/*responseHandler: function (allData) {
					return allData.domain;
				}*/
			});
		};
		oTableInit.Init3 = function(data, name) {
			$('#' + name + 3).bootstrapTable('destroy');
			$('#' + name + 3).bootstrapTable({
				// url: 'main/search?type=TE&searchType=2&dns=0',         //请求后台的URL（*）
				data: data.destIp,
				method: 'get',                      //请求方式（*）
				// toolbar: '#toolbar',                //工具按钮用哪个容器
				striped: true,                      //是否显示行间隔色
				cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
				pagination: false,                   //是否显示分页（*）
				sortable: true,                     //是否启用排序
				sortOrder: "asc",                   //排序方式
				//queryParams: oTableInit.queryParams,//传递参数（*）
				/* sidePagination: "server",           //分页方式：client客户端分页，server服务端分页（*）
				 pageNumber:1,                       //初始化加载第一页，默认第一页
				 pageSize: 10,                       //每页的记录行数（*）
				 pageList: [10, 25, 50, 100],        //可供选择的每页的行数（*）
				 search: false,                       //是否显示表格搜索，此搜索是客户端搜索，不会进服务端，所以，个人感觉意义不大
				 strictSearch: true,
				 showColumns: false,                  //是否显示所有的列
				 showRefresh: false,                  //是否显示刷新按钮
				 minimumCountColumns: 2,             //最少允许的列数
				 clickToSelect: true,                //是否启用点击选中行*/
				height: 160,                        //行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
				/* uniqueId: "ID",                     //每一行的唯一标识，一般为主键列
				 showToggle:false,                    //是否显示详细视图和列表视图的切换按钮
				 cardView: false,                    //是否显示详细视图
				 detailView: false,      */             //是否显示父子表
				columns: [{
					field: 'destIp',
					title: 'ip地址'
				}, {
					field: 'visitCount',
					title: '访问次数',
					sortable: true
				}
				],
				/*responseHandler: function (data) {
					return data.destIp;
				}*/
			});
		};
		//得到查询的参数
		oTableInit.queryParams = function(params, type, searchType, dns) {
			var temp = {   //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
				/*limit: params.limit,   //页面大小
				offset: params.offset,  //页码*/
				type: type,
				searchType: searchType,
				dns: dns//type=TE&searchType=2&dns=0'
			};
			return temp;
		};
		return oTableInit;
	};
</script>