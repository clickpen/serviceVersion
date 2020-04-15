<%@ page import="java.net.URLDecoder" %><%--
  Created by IntelliJ IDEA.
  User: xupanpan
  Date: 2020/3/16
  Time: 16:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>identity</title>
    <link href="../css/element-ui-2.12.0.css" rel="stylesheet"/>
    <style>
        .app_div .select-width{
            padding: 15px;
        }
        .app_div .container{
            width: auto;
        }
        .app_div .left-model{
            text-align: center;
        }
        .app_div .row_center{
            text-align: center;
        }
        .app_div .button_width{
            width: 215px;
        }
    </style>
</head>
<body>
<div id="app" class="app_div">
    <el-row align="middle" type="flex">
        <input type= "hidden" id = "taskId" value ="${param.id}"/>
        <div hidden id = "taskVirtual">
            ${param.virtual}
        </div>
        <p style="height: 5%;">>>关联关系</p>
    </el-row>
    <el-row :gutter="10">
        <el-col :md="4">
            <el-row class="row_center">
                <el-select class="select-width" @change="updateNode()" v-model="typeValue" multiple placeholder="请选择类型">
                    <el-option
                            v-for="item in optionOne"
                            :key="item.value"
                            :label="item.label"
                            :value="item.value">
                    </el-option>
                </el-select>
            </el-row>
            <el-row class="row_center">
                <el-select class="select-width" @change="updateNode()" v-model="numValue" placeholder="请选择关联次数">
                    <el-option
                            v-for="item in optionTwo"
                            :key="item.value"
                            :label="item.label"
                            :value="item.value">
                    </el-option>
                </el-select>
            </el-row>
            <el-row class="row_center">
                <%--<el-button type="primary" id="star" @click="circleTree()">星形图</el-button>--%>
                <el-button class="button_width" type="primary" id="saveImg" @click="saveImg(event)">保存</el-button>
            </el-row>
        </el-col>
        <el-col :md="20">
            <div id="relation_body" style="height: 450px;background-color: #565654"></div>
        </el-col>
    </el-row>
    <el-row align="middle" type="flex">
        <p style="height: 5%;">>>关联明细</p>
    </el-row>
    <el-row :gutter="10">
        <el-col :md="24">
            <el-table
                    height="250"
                    :data="tableData"
                    style="width: 100%"
                    :default-sort = "{prop: 'startDate', order: 'descending'}">
                <el-table-column
                        prop="setId"
                        label="任务ID"
                        sortable
                        width="180">
                </el-table-column>
                <el-table-column
                        prop="account"
                        label="号码"
                        sortable
                        width="250">
                </el-table-column>
                <el-table-column
                        label="身份类型"
                        :formatter="formatter"
                        width="180">
                </el-table-column>
                <el-table-column
                        prop="virtualidentity"
                        label="身份"
                        sortable
                        width="250">
                </el-table-column>
                <el-table-column
                        label="关联起始时间"
                        :formatter="formatTime"
                        sortable
                        width="250">
                </el-table-column>
                <el-table-column
                        label="关联最后时间"
                        :formatter="formatTime"
                        sortable
                        width="250">
                </el-table-column>
                <el-table-column
                        prop="count"
                        label="关联次数"
                        sortable
                        width="180">
                </el-table-column>
                <el-table-column
                        prop="levelnum"
                        label="层级"
                        sortable
                        width="180">
                </el-table-column>
            </el-table>
            <%--<el-pagination
                    :total="total"
                    :page-size="pageSize"
                    :current-page.sync="page"
                    layout="total, prev, pager, next, jumper"
                    @current-change="getTableData"
                    class="pagination_class"
            ></el-pagination>--%>
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
Date.prototype.format = function(fmt) {
    var o = {
        "M+": this.getMonth() + 1, //月份
        "d+": this.getDate(), //日
        "h+": this.getHours() % 12 == 0 ? 12 : this.getHours() % 12, //小时
        "H+": this.getHours(), //小时
        "m+": this.getMinutes(), //分
        "s+": this.getSeconds(), //秒
        "q+": Math.floor((this.getMonth() + 3) / 3), //季度
        "S": this.getMilliseconds() //毫秒
    };
    if (/(y+)/.test(fmt))
        fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
    for (var k in o)
        if (new RegExp("(" + k + ")").test(fmt))
            fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
    return fmt;
}
var Main = {
        data() {
            return {
                optionOne: [{value: '1', label: 'IMEI'}, {value: '2', label: 'IMSI'}, {value: '3', label: 'MAC地址'}, {value: '4', label: '微信ID'}],
                optionTwo: [{value: '1', label: '大于1'}, {value: '2', label: '大于2'}, {value: '3', label: '大于3'}, {value: '4', label: '大于4'}],
                typeValue: [],
                numValue: [],
                tableData: [],
                total: 0,
                pageSize: 10,
                page: 1,
                map:{},
                tabs:0
            }
        },
        methods: {
            formatter(row, column) {
                return row.type;
            },
            formatTime(row,column){
                if(column.label=="关联起始时间"){
                    var date = new Date(row.startTime).format("yyyy-MM-dd hh:mm:ss");
                    return date
                }else{
                    return new Date(row.updateTime).format("yyyy-MM-dd hh:mm:ss");
                }
            },
            selectedValueOne(value){
                value1 = value;
            },
            selectedValueTwo(value){
                value2 = value;
            },
            //根据条件筛选关联图
            updateNode(){
                console.log(this.typeValue+"====="+this.numValue)
                var obj = JSON.parse($("#taskVirtual").text());
                //通过任务ID查询关联图
                var setId = $("#taskId").val();//任务ID
                var account = obj.keyword;//手机号
                var account_ = obj.keyword;
                var accOrvir = obj.keyword_type
                var nodes;
                var edges;
                var golabData;
                $("#relation_body").empty();
                var strparam = this.typeValue;//所有选中的类型
                if(accOrvir!="account"&&accOrvir!="手机号"){
                    if(strparam==null||strparam==""){
                        strparam=xuniNode;
                    }else{
                        strparam=strparam+","+xuniNode;
                    }
                }
                var maxlevel=this.numValue;
                if(maxlevel==null||maxlevel==""){
                    return;
                }
                if(strparam==null||strparam==""){
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
                        return;
                    }
                    for(var i = 0; i<arraynode.length; i++){
                        if(arraynode[i].virtualtype==""||arraynode[i].virtualtype==null){
                            var str="";
                            if(arraynode[i].mobileArea==null||arraynode[i].mobileArea==""){
                            }else{
                                str="("+arraynode[i].mobileArea+")";
                            }
                            $("#pic").attr("src","/jetk/picture/sim.png");
                            nodes+="\""+arraynode[i].account+"\":{label:\"\\n\\n\\n"+arraynode[i].name+":"+arraynode[i].account+str+"\",rectStyle:{fill:\"url(\'/jetk/picture/sim.png\')\",stroke:\"#00D3FF\",width:42,height:42,path:\"/jetk/picture/sim.png\"},textStyle:{fill:\"#00D3FF\",stroke:\"#00D3FF\"}},";;
                        }else{
                            if(arraynode[i].name=="IMEI"){
                                var strimei="";
                                if(arraynode[i].facturer==null||arraynode[i].facturer==""){

                                }else{
                                    strimei="("+arraynode[i].facturer+")";
                                }
                                nodes+="\""+arraynode[i].virtualIdentity+arraynode[i].virtualtype+"\":{label:\"\\n\\n\\n"+arraynode[i].name+":"+arraynode[i].virtualIdentity+strimei+"\",rectStyle:{fill:\"url(picture/"+arraynode[i].picturePath+")\",stroke:\"##00D3FF\",width:42,height:42,path:\"picture/"+arraynode[i].picturePath+"\"},textStyle:{fill:\"#00D3FF\",stroke:\"#00D3FF\"}},";;
                            }else{
                                nodes+="\""+arraynode[i].virtualIdentity+arraynode[i].virtualtype+"\":{label:\"\\n\\n\\n"+arraynode[i].name+":"+arraynode[i].virtualIdentity+"\",rectStyle:{fill:\"url(picture/"+arraynode[i].picturePath+")\",stroke:\"##00D3FF\",width:42,height:42,path:\"picture/"+arraynode[i].picturePath+"\"},textStyle:{fill:\"#00D3FF\",stroke:\"#00D3FF\"}},";;
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
                    var hh="{nodes:"+nodes+",edges:"+edges+"}";
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
                $("#l-wrapper2").hide();
                });
            },
            //下载关联图片
            saveImg(event){
                console.log(event);
                event.preventDefault();
                var leftnum=$("#relation_body").find('svg')[0].viewBox.animVal.x;
                var topnum=$("#relation_body").find('svg')[0].viewBox.animVal.y;
                saveSvgAsPng($("#relation_body").find('svg')[0],"关联图.png",{left:leftnum,top:topnum});
	        },
            //初始化关联图
            relation() {
                var obj = JSON.parse($("#taskVirtual").text());
                var startType = obj.keyword_type;
                var accOrvir = obj.keyword_type
                var xuniNode = "";//如果根节点是虚拟身份需要在每次查询时带上此虚拟身份作为查询条件
                var nodes = "{";
                var edges = "[";
                //通过任务ID查询关联图
                var setId = $("#taskId").val();//任务ID
                var account = obj.keyword;//手机号
                var account_ = obj.keyword;
                var me = this;
                $.ajax({
                        url: '/jetk/identity/mapRelation',
                        type: 'post',
                        data: {
                            content:account,
                            type:startType,
                            setId:setId,
                            maxlevel:me.tabs
                        },
                        success: function(data) {
                            golabData = data;
                            var arraynode = golabData.nodes;
                            var arrayedge = golabData.edges;
                            var mapTypes = data.mapTypes;
                            startType = mapTypes[startType.toUpperCase()];
                            var stroption = "";//关联图下拉列表内容
                            var nodeTypeArray = new Array()
                            for (var item in mapTypes) {
                                if(item==accOrvir.toUpperCase()||item==accOrvir.toLowerCase()){
                                    //根节点不出现在下拉选项
                                    xuniNode = mapTypes[item];
                                } else {
                                    var obj = {}
                                    obj.value = mapTypes[item]
                                    obj.label = item
                                    nodeTypeArray.push(obj);
                                }
                            }
                            me.optionOne = nodeTypeArray
                            for(var i = 0; i<arraynode.length; i++){
                                if(arraynode[i].virtualType==""||arraynode[i].virtualType==null){
                                    var str="";
                                    if(arraynode[i].mobileArea==null||arraynode[i].mobileArea==""){
                                    }else{
                                        str="("+arraynode[i].mobileArea+")";
                                    }
                                    $("#pic").attr("src","/jetk/picture/sim.png");
                                    nodes+="\""+arraynode[i].account+"\":{label:\"\\n\\n\\n"+arraynode[i].name+":"+arraynode[i].account+str+"\",rectStyle:{fill:\"url(\'/jetk/picture/sim.png\')\",stroke:\"#00D3FF\",width:42,height:42,path:\"/jetk/picture/sim.png\"},textStyle:{fill:\"#00D3FF\",stroke:\"#00D3FF\"}},";;
                                }else{
                                    if(arraynode[i].name=="IMEI"){
                                        var strimei="";
                                        if(arraynode[i].facturer==null||arraynode[i].facturer==""){
                                        }else{
                                            strimei="("+arraynode[i].facturer+")";
                                        }
                                        nodes += "\"" + arraynode[i].virtualIdentity + arraynode[i].virtualType + "\":{label:\"\\n\\n\\n" + arraynode[i].name + ":" + arraynode[i].virtualIdentity + strimei + "\",rectStyle:{fill:\"url(/jetk/picture/" + arraynode[i].picturePath + ")\",stroke:\"#00D3FF\",width:42,height:42,path:\"/jetk/picture/" + arraynode[i].picturePath + "\"},textStyle:{fill:\"#00D3FF\",stroke:\"#00D3FF\"}},";;
                                    } else {
                                        nodes += "\"" + arraynode[i].virtualIdentity + arraynode[i].virtualType + "\":{label:\"\\n\\n\\n" + arraynode[i].name + ":" + arraynode[i].virtualIdentity + "\",rectStyle:{fill:\"url(/jetk/picture/" + arraynode[i].picturePath + ")\",stroke:\"#00D3FF\",width:42,height:42,path:\"/jetk/picture/" + arraynode[i].picturePath + "\"},textStyle:{fill:\"#00D3FF\",stroke:\"#00D3FF\"}},";;
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
                                    strtime = new Date(arrayedge[j].updateTime).format("yyyy-mm-dd HH:MM:ss")
                                    // strtime = timeFormat(strtime);
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
                                if (accOrvir == "account" || accOrvir == "手机号") {
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
                        },
                        error: function(err) {
                            console.log('出错了', err)
                            me.loading = false
                        }
                    })
            },
            getTableData(page){
                let me = this
                var id = $("#taskId").val();
                me.loading = true
                page = page || 1
                $.ajax({
                    url: '/jetk/identity/table',
                    type: 'post',
                    async: false,
                    data: {
                        set_id:id,
                        page:page,
                        limit: 10,
                    },
                    success: function(res) {
                        me.tableData = res.allVirtual
                        var arr = new Array()
                        var tab = res.tabs
                        me.tabs = tab
                        for (var i = 1; i <= tab; i++) {
                            var obj = {}
                            obj.value = i
                            obj.label = "大于"+i+"层"
                            arr.push(obj);
                        }
                        me.optionTwo = arr;
                    },
                    error: function(err) {
                        console.log('出错了', err)
                        me.loading = false
                    }
                })
            }
        },
        created: function (){
            this.getTableData(this.page)
            this.relation()
        }
    }
var Ctor = Vue.extend(Main)
new Ctor().$mount('#app')
</script>
</html>