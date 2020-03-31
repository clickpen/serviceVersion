<%--
  Created by IntelliJ IDEA.
  User: xupanpan
  Date: 2020/3/16
  Time: 16:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>identity</title>
    <link href="../css/element-ui-2.12.0.css" rel="stylesheet"/>
    <style>
        .select-width{
            padding: 15px;
        }
        .container{
            width: auto;
        }
        .left-model{
            text-align: center;
        }
    </style>
</head>
<body>
<div id="app">
    <el-row align="middle" type="flex">
        <p style="height: 5%;">>>关联关系</p>
    </el-row>
    <el-row :gutter="10">
        <el-col :md="4">
            <el-row>
                <el-select class="select-width" @change="selectedValueOne(value1)" v-model="value1" multiple placeholder="请选择类型">
                    <el-option
                            v-for="item in optionOne"
                            :key="item.value"
                            :label="item.label"
                            :value="item.value">
                    </el-option>
                </el-select>
            </el-row>

            <el-row>
                <el-select class="select-width" @change="selectedValueTwo(value2)" v-model="value2" placeholder="请选择关联次数">
                    <el-option
                            v-for="item in optionTwo"
                            :key="item.value"
                            :label="item.label"
                            :value="item.value">
                    </el-option>
                </el-select>
            </el-row>
            <el-button type="primary" id="star" @click="circleTree()">星形图</el-button>
            <el-button type="primary" id="tree" @click="quenceTree()">树状图</el-button>
            <el-button type="primary" id="saveImg" @click="saveImg(event)">保存</el-button>
        </el-col>

        <el-col :md="20">
            <div style="height: 40%;background-color: burlywood">image</div>
        </el-col>
    </el-row>
    <el-row align="middle" type="flex">
        <p style="height: 5%;">>>关联明细</p>
    </el-row>
    <el-row :gutter="10">
        <el-col :md="24">
            <el-table
                    :data="tableData"
                    style="width: 100%"
                    :default-sort = "{prop: 'startDate', order: 'descending'}">
                <el-table-column
                        prop="taskId"
                        label="任务ID"
                        sortable
                        width="180">
                </el-table-column>
                <el-table-column
                        prop="telPhone"
                        label="号码"
                        sortable
                        width="250">
                </el-table-column>
                <el-table-column
                        prop="type"
                        label="身份类型"
                        :formatter="formatter"
                        width="180">
                </el-table-column>
                <el-table-column
                        prop="value"
                        label="身份"
                        sortable
                        width="250">
                </el-table-column>
                <el-table-column
                        prop="startDate"
                        label="关联起始时间"
                        sortable
                        width="250">
                </el-table-column>
                <el-table-column
                        prop="endDate"
                        label="关联最后时间"
                        sortable
                        width="250">
                </el-table-column>
                <el-table-column
                        prop="count"
                        label="关联次数"
                        sortable
                        width="180">
                </el-table-column>
            </el-table>
        </el-col>
    </el-row>
</div>
</body>
<script src="../js/jquery-3.0.0.js"></script>
<script src="../js/vue-2.6.10.min.js" type="text/javascript"></script>
<script src="../js/element-ui-2.12.0.js" type="text/javascript"></script>
<script src="../views/identityModel/js/raphael.js"></script>
<script src="../views/identityModel/js/rgraph2.js"></script>
<script src="../views/identityModel/js/SaveSvgAsPng-es5.js"></script>
<script src="../views/identityModel/js/svg2png.js"></script>
<script src="../js/ajaxUtil.js"></script>
<script>
var Main = {
        data() {
            return {
                optionOne: [{
                    value: '1',
                    label: 'IMEI'
                }, {
                    value: '2',
                    label: 'IMSI'
                }, {
                    value: '3',
                    label: 'MAC地址'
                }, {
                    value: '4',
                    label: '微信ID'
                }],
                optionTwo: [
                {
                    value: '1',
                    label: '大于1'
                }, {
                    value: '2',
                    label: '大于2'
                }, {
                    value: '3',
                    label: '大于3'
                }, {
                    value: '4',
                    label: '大于4'
                }
                ],
                value1: [],
                value2: [],
                tableData: [{
                    startDate: '2020-02-01 00:00:00',
                    endDate: '2020-02-17 00:00:00',
                    name: '王小虎',
                    address: '上海市普陀区金沙江路 1518 弄',
                    taskId: '123456',
                    telPhone: "13455667788[山东 烟台]",
                    type: 'IMEI',
                    value:'8600006666666666[MI 8]',
                    count: '7'

                }, {
                    startDate: '2020-02-01 00:00:00',
                    endDate: '2020-02-17 00:00:00',
                    name: '王小虎',
                    address: '上海市普陀区金沙江路 1518 弄',
                    taskId: '123456',
                    telPhone: "13455667788[山东 烟台]",
                    type: 'IMEI',
                    value:'8600006666666666[MI 8]',
                    count: '7'
                }, {
                    startDate: '2020-02-01 00:00:00',
                    endDate: '2020-02-17 00:00:00',
                    name: '王小虎',
                    address: '上海市普陀区金沙江路 1518 弄',
                    taskId: '123456',
                    telPhone: "13455667788[山东 烟台]",
                    type: 'IMEI',
                    value:'8600006666666666[MI 8]',
                    count: '7'
                }, {
                    startDate: '2020-02-01 00:00:00',
                    endDate: '2020-02-17 00:00:00',
                    name: '王小虎',
                    address: '上海市普陀区金沙江路 1518 弄',
                    taskId: '123456',
                    telPhone: "13455667788[山东 烟台]",
                    type: 'IMEI',
                    value:'8600006666666666[MI 8]',
                    count: '7'
                },{
                    startDate: '2020-02-01 00:00:00',
                    endDate: '2020-02-17 00:00:00',
                    name: '王小虎',
                    address: '上海市普陀区金沙江路 1518 弄',
                    taskId: '123456',
                    telPhone: "13455667788[山东 烟台]",
                    type: 'IMEI',
                    value:'8600006666666666[MI 8]',
                    count: '7'
                },{
                    startDate: '2020-02-01 00:00:00',
                    endDate: '2020-02-17 00:00:00',
                    name: '王小虎',
                    address: '上海市普陀区金沙江路 1518 弄',
                    taskId: '123456',
                    telPhone: "13455667788[山东 烟台]",
                    type: 'IMEI',
                    value:'8600006666666666[MI 8]',
                    count: '7'
                },{
                    startDate: '2020-02-01 00:00:00',
                    endDate: '2020-02-17 00:00:00',
                    name: '王小虎',
                    address: '上海市普陀区金沙江路 1518 弄',
                    taskId: '1234567',
                    telPhone: "13455667788[山东 烟台]",
                    type: 'IMEI',
                    value:'8600006666666666[MI 8]',
                    count: '7'
                }]
            }
        },
        methods: {
            formatter(row, column) {
                return row.type;
            },
            selectedValueOne(value){
                value1 = value;
            },
            selectedValueTwo(value){
                value2 = value;
            },
            circleTree(){
                relationType = "star";
                $("#star").addClass("choose");
                $("#tree").removeClass("choose");
                nodes = "{";
                edges = "[";
                $("#relation_body").empty(); 
                var arraynode = golabData.nodes;
                var arrayedge = golabData.edges;
                for(var i = 0; i<arraynode.length; i++){
                    if(arraynode[i].virtualtype==""||arraynode[i].virtualtype==null){
                        $("#pic").attr("src","picture/sim.png");
                        nodes+="\""+arraynode[i].account+"\":{label:\"\\n\\n\\n"+arraynode[i].name+":"+arraynode[i].account+"("+arraynode[i].mobileArea+")"+"\",rectStyle:{fill:\"url(\'picture/sim.png\')\",stroke:\"#00D3FF\",width:42,height:42,path:\"picture/sim.png\"},textStyle:{fill:\"#00D3FF\",stroke:\"#00D3FF\"}},";;
                    }else{
                        if(arraynode[i].name=="IMEI"){
                            nodes+="\""+arraynode[i].virtualidentity+arraynode[i].virtualtype+"\":{label:\"\\n\\n\\n"+arraynode[i].name+":"+arraynode[i].virtualidentity+"("+arraynode[i].facturer+")"+"\",rectStyle:{fill:\"url(picture/"+arraynode[i].picturepath+")\",stroke:\"#00D3FF\",width:42,height:42,path:\"picture/"+arraynode[i].picturepath+"\"},textStyle:{fill:\"#00D3FF\",stroke:\"#00D3FF\"}},";;
                        }else{
                            nodes+="\""+arraynode[i].virtualidentity+arraynode[i].virtualtype+"\":{label:\"\\n\\n\\n"+arraynode[i].name+":"+arraynode[i].virtualidentity+"\",rectStyle:{fill:\"url(picture/"+arraynode[i].picturepath+")\",stroke:\"#00D3FF\",width:42,height:42,path:\"picture/"+arraynode[i].picturepath+"\"},textStyle:{fill:\"#00D3FF\",stroke:\"#00D3FF\"}},";;
                        }
                    }
                }
                for(var j = 0; j<arrayedge.length;j++){
                    var strcount="";
                    var strtime="";
                    if(arrayedge[j].total==null||arrayedge[j].total<1){
                        strcount="";
                    }else{
                        strcount=arrayedge[j].total+"次";
                    }
                    if(arrayedge[j].updateTime==null||arrayedge[j].updateTime==""){
                        
                    }else{
                        strtime=arrayedge[j].updateTime;
                        strtime=timeFormat(strtime);
                    }
                    edges+="{source:\""+arrayedge[j].form+"\",target:\""+arrayedge[j].to+"\",arrowStyle:{fill:\"#00D3FF\",stroke:\"#00D3FF\",\"stroke-width\":1,\"font-size\":\"8px\"},label:\""+strcount+"\",labeldown:\""+strtime+"\"},"
                }
                nodes=nodes.substring(0,nodes.length-1);//删除后面的,
                edges=edges.substring(0,edges.length-1);
                nodes+="}";
                edges+="]";
                var hh="{nodes:"+nodes+",edges:"+edges+"}";
                var sss=eval("("+hh+")");
                
                graph = new RGraph("relation_body",{
                });
                graph.loadData(sss);
                if(accOrvir=="手机号"||accOrvir=="手机号"){
                    graph.center(account_);
                    graph.highlight(graph.getNode(account_));
                }else{
                    graph.center(account_+startType);
                    graph.highlight(graph.getNode(account_+startType));
                }
            },
            quenceTree(){
                $("#l-wrapper2").hide(); 
                relationType = "tree";
                $("#star").removeClass("choose");
                $("#tree").addClass("choose");
                $("#relation_body").empty();
                var mapTree=golabData.map
                org = "";
                var html = '<div class="innerbox" id="container1" align="center" style="left:20px;position:relative;overflow: auto; width: 97%; height:100%;-webkit-border-radius: 10px;-moz-border-radius: 10px;border-radius: 10px; background: #000;"">'+
                        '</div>';
                $("#relation_body").html(html);
                $.getScript("js/zoom.js",function(){
                    zoom("container1","0");
                })
                org += "<ul id='org' style='display:none'>";	
                if(accOrvir=="手机号"||accOrvir=="手机号"){
                    accountTree(mapTree)
                }else{
                    virTree(mapTree);
                }
                    
                org +="</ul>"
                
                org += "<div id='chart' class='orgChart'></div>";
                $("#container1").html(org);
                //页面点击效果
                $("#org").jOrgChart({
                    chartElement : '#chart',
                    dragAndDrop  : true
                });
                $("#show-list").click(function(e){
                    e.preventDefault();
                    $('#list-html').toggle('fast', function(){
                        if($(this).is(':visible')){
                            $('#show-list').text('Hide underlying list.');
                            $(".topbar").fadeTo('fast',0.9);
                        }else{
                            $('#show-list').text('Show underlying list.');
                            $(".topbar").fadeTo('fast',1);                  
                        }
                    });
                });
                $('#list-html').text($('#org').html());
                $("#org").bind("DOMSubtreeModified", function() {
                    $('#list-html').text('');
                    $('#list-html').text($('#org').html());
                    prettyPrint();                
                });
            },
            updateNode(){
                /**
                *选择展示哪种虚拟身份  只修改关联图
                */
                var nodes;
                var edges;
                var golabData;
                var account_;//存储手机号
                var set_id;
                var graph;//作图类的定义
                var map=new Map();
                var hhjosn;
                var nodeTypeArray=new Array();
                $("#l-wrapper2").show();
                $("#relation_body").empty(); 
                var arrhide=new Array();
                var strparam = $("#checkshow").val();//所有选中的类型
                if(accOrvir!="手机号"&&accOrvir!="手机号"){
                    if(strparam==null||strparam==""){
                        strparam=xuniNode;
                    }else{
                        strparam=strparam+","+xuniNode;
                    }
                }
                var maxlevel=$("#checklevel").val();
                if(maxlevel==null||maxlevel==""){
                    $("#l-wrapper2").hide();
                    return;
                }
                
                if(strparam==null||strparam==""){
                    $("#l-wrapper2").hide();
                    return;
                }
                AjaxUtil.ajaxRequest("Virtual_correlationAnalysis.do?content="+account_+"&type="+accOrvir+"&set_Id="+set_Id+"&strparam="+strparam+"&maxlevel="+maxlevel, "json", function (data) {
                    nodes = "{";
                    edges = "[";
                    golabData = data;
                    var arraynode = golabData.nodes;
                    var arrayedge = golabData.edges;
                    if(arraynode.length<=0&&arrayedge.length<=0){
                        console.log("节点或者边的数量为零");
                        $("#l-wrapper2").hide();
                        return;
                    }

                    if(relationType=="star"){
                        for(var i = 0; i<arraynode.length; i++){
                            if(arraynode[i].virtualtype==""||arraynode[i].virtualtype==null){
                                var str="";
                                if(arraynode[i].mobileArea==null||arraynode[i].mobileArea==""){
                                    
                                }else{
                                    str="("+arraynode[i].mobileArea+")";
                                }
                                $("#pic").attr("src","picture/sim.png");
                                nodes+="\""+arraynode[i].account+"\":{label:\"\\n\\n\\n"+arraynode[i].name+":"+arraynode[i].account+str+"\",rectStyle:{fill:\"url(\'picture/sim.png\')\",stroke:\"#00D3FF\",width:42,height:42,path:\"picture/sim.png\"},textStyle:{fill:\"#00D3FF\",stroke:\"#00D3FF\"}},";;
                            }else{
                                if(arraynode[i].name=="IMEI"){
                                    var strimei="";
                                    if(arraynode[i].facturer==null||arraynode[i].facturer==""){
                                        
                                    }else{
                                        strimei="("+arraynode[i].facturer+")";
                                    }
                                    nodes+="\""+arraynode[i].virtualidentity+arraynode[i].virtualtype+"\":{label:\"\\n\\n\\n"+arraynode[i].name+":"+arraynode[i].virtualidentity+strimei+"\",rectStyle:{fill:\"url(picture/"+arraynode[i].picturepath+")\",stroke:\"##00D3FF\",width:42,height:42,path:\"picture/"+arraynode[i].picturepath+"\"},textStyle:{fill:\"#00D3FF\",stroke:\"#00D3FF\"}},";;
                                }else{
                                    nodes+="\""+arraynode[i].virtualidentity+arraynode[i].virtualtype+"\":{label:\"\\n\\n\\n"+arraynode[i].name+":"+arraynode[i].virtualidentity+"\",rectStyle:{fill:\"url(picture/"+arraynode[i].picturepath+")\",stroke:\"##00D3FF\",width:42,height:42,path:\"picture/"+arraynode[i].picturepath+"\"},textStyle:{fill:\"#00D3FF\",stroke:\"#00D3FF\"}},";;
                                }
                                
                            }
                        }
                        for(var j = 0; j<arrayedge.length;j++){
                            var strcount="";
                            var strtime="";
                            if(arrayedge[j].total==null||arrayedge[j].total<1){
                            }else{
                                strcount=arrayedge[j].total+"次";
                            }
                            if(arrayedge[j].updateTime==null||arrayedge[j].updateTime==""){
                                
                            }else{
                                strtime=arrayedge[j].updateTime;
                                strtime=timeFormat(strtime);
                            }
                            edges+="{source:\""+arrayedge[j].form+"\",target:\""+arrayedge[j].to+"\",arrowStyle:{fill:\"#00D3FF\",stroke:\"#00D3FF\",\"stroke-width\":1,\"font-size\":\"8px\"},label:\""+strcount+"\",labeldown:\""+strtime+"\"},"
                        }
                        nodes=nodes.substring(0,nodes.length-1);
                        if(arrayedge.length<=0){
                            
                        }else{
                            edges=edges.substring(0,edges.length-1);
                        }
                        
                        nodes+="}";
                        edges+="]";
                            //     			console.log("nodes:"+nodes);
                            //     			console.log("edges:"+edges);
                        var hh="{nodes:"+nodes+",edges:"+edges+"}";
                            //     			hhjson=hh;
                        var sss=eval("("+hh+")");
                        graph = new RGraph("relation_body",{
                        });
                        graph.loadData(sss);
                        try {
                            if(accOrvir.toLowerCase()=="手机号"){
                                graph.center(account_);
                                graph.highlight(graph.getNode(account_));
                            }else{
                                graph.center(account_+startType);
                                graph.highlight(graph.getNode(account_+startType));
                            }
                            
                        } catch (e) {
                            $("#l-wrapper2").hide();
                        }
                    }else{
                        quenceTree();
                    }
                    $("#l-wrapper2").hide();
                });
            },
            saveImg(event){
                console.log(event);
                event.preventDefault();		
                if(relationType == 'tree'){
                    //树状图保存
                    var ss=$("#container1");
                    var oldwidth=ss.css("width");
                    //	 		var oldheight=ss.css("height");
                    var newwidth=$(".jOrgChart table").css("width");
                    var newheight=$(".jOrgChart table").css("height");
                    ss.css("width",newwidth);
                    ss.css("height",newheight);	
                    var copyDom=ss.clone();
                    copyDom.width(ss.width+"px");
                    copyDom.height(ss.height+"px");
                    $('body').append(copyDom);
                    html2canvas(copyDom,{
                        allowTaint:true,
                        taintTest:false,
                        onrendered:function(canvas){
                            var imgData =canvas.toDataURL();
                            var filename = '关联图.png';
                            saveFile(imgData,filename);
                            ss.css("width",oldwidth);
                            ss.css("height",'100%');
                        }
                    });
                $(copyDom).remove();
                }else if(relationType == 'star'){
                    var leftnum=$("#relation_body").find('svg')[0].viewBox.animVal.x;
                    var topnum=$("#relation_body").find('svg')[0].viewBox.animVal.y;
                    saveSvgAsPng($("#relation_body").find('svg')[0],"关联图.png",{left:leftnum,top:topnum});
                }
	        },
            //关联图
            relation(obj) {
            var startType;
            var accOrvir;
            var xuniNode = "";//如果根节点是虚拟身份需要在每次查询时带上此虚拟身份作为查询条件

            relationType = "star";
            $("#l-wrapper2").show();
            map.clear();
            nodeTypeArray.splice(0, nodeTypeArray.length);

            nodes = "{";
            edges = "[";
            //通过任务ID查询关联图
            set_Id = obj.set_Id;//任务ID
            startType = obj.startType;
            accOrvir = obj.startType;
            var account = obj.account;//手机号
            account_ = obj.account;
            $("#relation").show();
            $("#hidebg").show();
            AjaxUtil.ajaxRequest("Virtual_correlationAnalysis.do?content=" + account + "&type=" + startType + "&set_Id=" + set_Id + "&maxlevel=" + allData.tabs, "json", function (data) {
                golabData = data;
                var arraynode = golabData.nodes;
                var arrayedge = golabData.edges;
                var tab = allData.tabs;
                var strlevel = "";//最大的层级选项
                for (var i = 1; i <= tab; i++) {
                    strlevel += "<option value=" + i + ">" + i + "层</option>"
                }
                $("#checklevel").html(strlevel);
                $("#checklevel").selectpicker('refresh');
                /*初始化选中最大层  */
                $("#checklevel").selectpicker('val', tab);
                var mapTypes = data.mapTypes;
                startType = mapTypes[startType.toUpperCase()];
                var stroption = "";//关联图下拉列表内容
                for (var item in mapTypes) {
                    if(item==accOrvir.toUpperCase()||item==accOrvir.toLowerCase()){
                        //根节点不出现在下拉选项
                        xuniNode = mapTypes[item];
                    } else {
                        stroption += "<option value=" + mapTypes[item] + ">" + getVirtualMessage(item) + "</option>";
                        nodeTypeArray.push(mapTypes[item]);
                    }
                }
                $("#checkshow").html(stroption);
                $("#checkshow").selectpicker('refresh');
                /*初始化全部选中  */
                $("#checkshow").selectpicker('val',nodeTypeArray);
                //判断是否进行默认筛选-start
                if(flagAi == 0){
                    if(allData.tabs>2&&allData.results>20){
                        BUI.Message.Confirm('展示结果过多，请设置关联次数大于1后筛选，试一下？',function(){
                            $("#checkcount").val("1");
                            shaixuan();
                            return;
                        },'warning');
                    }else{
                        $("#checkcount").val("");
                        shaixuan();
                        return;
                    }
                }
                //判断是否进行默认筛选-end
                for(var i = 0; i<arraynode.length; i++){
                    if(arraynode[i].virtualtype==""||arraynode[i].virtualtype==null){
                        var str="";
                        if(arraynode[i].mobileArea==null||arraynode[i].mobileArea==""){

                        }else{
                            str="("+arraynode[i].mobileArea+")";
                        }
                        $("#pic").attr("src","picture/sim.png");
                        nodes+="\""+arraynode[i].account+"\":{label:\"\\n\\n\\n"+arraynode[i].name+":"+arraynode[i].account+str+"\",rectStyle:{fill:\"url(\'picture/sim.png\')\",stroke:\"#00D3FF\",width:42,height:42,path:\"picture/sim.png\"},textStyle:{fill:\"#00D3FF\",stroke:\"#00D3FF\"}},";;
                    }else{
                        if(arraynode[i].name=="IMEI"){
                            var strimei="";
                            if(arraynode[i].facturer==null||arraynode[i].facturer==""){
                            }else{
                                strimei="("+arraynode[i].facturer+")";
                            }
                            nodes += "\"" + arraynode[i].virtualidentity + arraynode[i].virtualtype + "\":{label:\"\\n\\n\\n" + arraynode[i].name + ":" + arraynode[i].virtualidentity + strimei + "\",rectStyle:{fill:\"url(picture/" + arraynode[i].picturepath + ")\",stroke:\"#00D3FF\",width:42,height:42,path:\"picture/" + arraynode[i].picturepath + "\"},textStyle:{fill:\"#00D3FF\",stroke:\"#00D3FF\"}},";;
                        } else {
                            nodes += "\"" + arraynode[i].virtualidentity + arraynode[i].virtualtype + "\":{label:\"\\n\\n\\n" + arraynode[i].name + ":" + arraynode[i].virtualidentity + "\",rectStyle:{fill:\"url(picture/" + arraynode[i].picturepath + ")\",stroke:\"#00D3FF\",width:42,height:42,path:\"picture/" + arraynode[i].picturepath + "\"},textStyle:{fill:\"#00D3FF\",stroke:\"#00D3FF\"}},";;
                        }
                    }
                }
                for (var j = 0; j < arrayedge.length; j++) {
                    var strcount = "";
                    var strtime = "";
                    if (arrayedge[j].total == null || arrayedge[j].total < 1) {
                        strcount = "";
                    } else {
                        strcount = arrayedge[j].total + "次";
                    }
                    if (arrayedge[j].updateTime == null || arrayedge[j].updateTime == "") {

                    } else {
                        strtime = arrayedge[j].updateTime;
                        strtime = timeFormat(strtime);
                    }
                    edges += "{source:\"" + arrayedge[j].form + "\",target:\"" + arrayedge[j].to + "\",arrowStyle:{fill:\"#00D3FF\",stroke:\"#00D3FF\",\"stroke-width\":1},label:\"" + strcount + "\",labeldown:\"" + strtime + "\"},"
                }
                nodes = nodes.substring(0, nodes.length - 1);
                edges = edges.substring(0, edges.length - 1);
                nodes += "}";
                edges += "]";
                // 			console.log("nodes:"+nodes);
                // 			console.log("edges:"+edges);
                var hh = "{nodes:" + nodes + ",edges:" + edges + "}";
                hhjson = hh;
                var sss = eval("(" + hh + ")");
                graph = new RGraph("relation_body", {
                });
                graph.loadData(sss);
                try {
                    if (accOrvir == "手机号" || accOrvir == "手机号") {
                        graph.center(account_);
                        graph.highlight(graph.getNode(account_));
                    } else {
                        graph.center(account_ + startType);
                        graph.highlight(graph.getNode(account_ + startType));
                    }

                } catch (e) {
                    $("#l-wrapper2").hide();
                }

                $("#l-wrapper2").hide();
            });
            }
        }
    }
var Ctor = Vue.extend(Main)
new Ctor().$mount('#app')
</script>
</html>