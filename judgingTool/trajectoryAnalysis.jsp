<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.io.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	request.getSession().removeAttribute("page");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>移动数据应用-防控模型</title>
    <link rel="stylesheet" href="<%=basePath%>views/judgingTool/trajectoryAnalysis.css">
    <!-- jqueryCloud -->
    <link href="https://cdn.bootcss.com/jqcloud/1.0.4/jqcloud.css" rel="stylesheet">
</head>
<body>
    <jsp:include page="../commonHeader/commonHeader.jsp" flush="ture"></jsp:include>
    <%-- ${param.param} --%>
    <div class="trajectory-analysis" id="trajectoryAnalysis" v-cloak>
        <p class="breadcrumb">
            研判工具
            <span class="current-bread">轨迹关联</span>
        </p>
        <div class="map-wrapper">
            <div class="map-title">
                <b>地图展示</b>
                <b class="msg">（手机号：<span class="phone">${param.account}</span><span
                        class="address">{{accountAddress}}</span>）</b>
                <input type="hidden" id="taskId" value="${param.id}" />
                <input type="hidden" id="taskAccount" value="${param.account}" />
            </div>
            <div class="main-map-content" id="mapContent"></div>
            <div class="tips">
                <b>白天：</b>
                <span class="des">
                    <i class="day-1"></i>大于4小时
                </span>
                <span class="des">
                    <i class="day-2"></i>大于1小时
                </span>
                <span class="des">
                    <i class="day-3"></i>大于30分钟
                </span>
                <span class="des">
                    <i class="day-4"></i>小于30分钟
                </span>
                <b class="tip-devide">夜晚：</b>
                <span class="des">
                    <i class="night-1"></i>大于4小时
                </span>
                <span class="des">
                    <i class="night-2"></i>大于1小时
                </span>
                <span class="des">
                    <i class="night-3"></i>大于30分钟
                </span>
                <span class="des">
                    <i class="night-4"></i>小于30分钟
                </span>
                <b class="tip-devide">特殊：</b>
                <span class="des">
                    <i class="cover-1"></i>横跨昼夜
                </span>
                <span class="tips-prev" @click="handleRewind()">
                    <i></i>
                    减速
                </span>
                <span class="tips-play" @click="handleplayback('ck')">
                    <i class="el-icon-video-play"></i>播放
                </span>
                <span class="tips-next" @click="handleForward()">
                    加速
                    <i></i>
                </span>
            </div>
            <div class="point-analysis">
                <p class="tit">落脚点分析</p>
                <div class="point-day">
                    <p class="point-tit">
                        <i></i>
                        白天落脚点
                    </p>
                    <p class="point-poi">
                        lac：<span v-if="trackDayStopover.lac">{{trackDayStopover.lac}}</span>
                        ci： <span v-if="trackDayStopover.ci">{{trackDayStopover.ci}}</span>
                    </p>
                    <p class="point-des">   
                                                   基站位置：
                     <el-popover placement="top-start" title="网址" width="200" trigger="hover"
                        v-bind:content="trackNightStopover.address">
                     	<span slot="reference" @click="() => { handleShowPoint(trackDayStopover) }" :class="trackDayStopover.x && trackDayStopover.y? 'address_blue' : '' "  v-if="trackDayStopover.address">{{trackDayStopover.address}}</span>
                     </el-popover>    
                    </p>
                </div>
                <div class="point-night">
                    <p class="point-tit">
                        <i></i>
                        夜晚落脚点
                    </p>
                    <p class="point-poi">
                         lac：<span v-if="trackNightStopover.lac">{{trackNightStopover.lac}}</span>
                         ci： <span v-if="trackNightStopover.ci">{{trackNightStopover.ci}}</span>
                    </p>
                    <p class="point-des">
                                            基站位置：
                   <el-popover placement="top-start" title="网址" width="200" trigger="hover"
                        v-bind:content="trackNightStopover.address">
                        	<span slot="reference" @click="() => { handleShowPoint(trackNightStopover) }"  :class="trackNightStopover.x && trackNightStopover.y? 'address_blue' : '' "  v-if="trackNightStopover.address">{{trackNightStopover.address}}</span>
                   </el-popover>                    
                    </p>
                </div>
            </div>
            <div class="time-analysis">
                <p class="tit">时空分布分析</p>
                <el-table class="webkit-scroll-custom" :data="mapAnalysisTable">
                    <el-table-column prop="timeScan" label="时间段" show-overflow-tooltip></el-table-column>
                    <el-table-column label="基站1" show-overflow-tooltip>
				    	<template v-slot="scope">
				    		<el-button v-if="scope.row.list.length > 0" :class="scope.row.list.length > 0 && scope.row.list[0].x && scope.row.list[0].y ? '' : 'text-normal'" type="text" size="small" @click="() => { handleShowPoint(scope.row.list[0]) }">
				    			{{scope.row.list[0].lac}},{{scope.row.list[0].ci}}
				    		</el-button>
				    	</template>
                    </el-table-column>
                    <el-table-column label="基站2" show-overflow-tooltip>
                   	<template v-slot="scope">
				    	<el-button v-if="scope.row.list.length > 1" :class="scope.row.list.length > 1 && scope.row.list[1].x && scope.row.list[1].y ? '' : 'text-normal'" type="text" size="small" @click="() => { handleShowPoint(scope.row.list[1]) }">
				    			{{scope.row.list[1].lac}},{{scope.row.list[1].ci}}
				    	</el-button>
				    </template>
                    </el-table-column>
                    <el-table-column label="基站3" show-overflow-tooltip>
                    <template v-slot="scope">
				      	<el-button v-if="scope.row.list.length > 2" :class="scope.row.list.length > 2 && scope.row.list[2].x && scope.row.list[2].y ? '' : 'text-normal'" type="text" size="small" @click="() => { handleShowPoint(scope.row.list[2]) }">
				    			{{scope.row.list[2].lac}},{{scope.row.list[2].ci}}
				      	</el-button>
				    </template>
                    </el-table-column>
                </el-table>
            </div>
        </div>
        <div class="netimage-analysis">
            <p class="content-tit">
                网络画像
                <span :class="{'hide-area-btn': true, 'active': netimageShow}"
                    @click="netimageShow = !netimageShow">{{netimageShow ? '收起' : '展开'}}</span>
            </p>
            <transition name="el-zoom-in-top">
                <div v-show="netimageShow" class="netimage-content">
                    <div class="id-analysis-card" id="virtualList">
                        <p class="card-tit">身份特征分析</p>
                        <p class='content' v-for="virtual in trackVirtual" :key="virtual">
                            <el-popover placement="top-start" title="虚拟身份类型" width="200" trigger="hover"
                                v-bind:content="virtual.virtualName">
                                <span slot="reference" class='label'>
                                    {{virtual.virtualName}}
                                </span>
                            </el-popover>
                            <el-popover placement="top-start" title="虚拟身份" width="200" trigger="hover"
                                v-bind:content="virtual.virtualIdentity">
                                <span slot="reference" class='label'>
                                    {{virtual.virtualIdentity}}
                                </span>
                            </el-popover>
                        </p>
                    </div>
                    <div class="web-analysis-card webkit-scroll-custom">
                        <p class="card-tit">网站访问分析</p>
                        <p class='content' v-for="web in webSite" :key="web">
                            <el-popover placement="top-start" title="网址" width="200" trigger="hover"
                                v-bind:content="web.webName">
                                <span class='des' slot="reference">{{web.website}}</span>
                            </el-popover>
                            <el-popover placement="top-start" title="网站名称" width="200" trigger="hover"
                                v-bind:content="web.webName">
                                <span class='type' slot="reference">{{web.webName}}</span>
                            </el-popover>
                            <span class='number'>{{web.num}}</span>
                        </p>
                    </div>
                    <div class="active-analysis-card webkit-scroll-custom" id="trackProtocolList">
                        <p class="card-tit">访问协议分析</p>
                        <p class='content' v-for="protocol in trackProtocol" :key="protocol">
                            <el-popover placement="top-start" title="端口" width="200" trigger="hover"
                                v-bind:content="protocol.dstPort">
                                <span class='des' slot="reference">{{protocol.dstPort}}</span>
                            </el-popover>
                            <el-popover placement="top-start" title="协议" width="200" trigger="hover"
                                v-bind:content="protocol.dstName">
                                <span class='type' slot="reference">{{protocol.dstName}}</span>
                            </el-popover>
                            <span class='number'>{{protocol.num}}</span>
                        </p>
                    </div>
                    <div class="key-analysis-card">
                        <p class="card-tit">关键词分析<span>(注：文字云)</span></p>
                        <div class="key-cloud" id="keyCloud"></div>
                    </div>
                    <div class="app-analysis-card">
                        <p class="card-tit">使用APP分析</p>
                        <ul class="app-wrapper webkit-scroll-custom">
	                        <li class="app-card"  v-for="keyapp in trackKeyApp" :key="keyapp">
									<img v-bind:src="'/jetk/appIcon/'+keyapp.fileName">
									<p class='app-tit'>{{keyapp.serviceName}}</p>
									<p class='app-num'>{{keyapp.num}}</p>
							</li>
                        </ul>
                    </div>
                </div>
            </transition>
        </div>
        <div class="journal-detail">
            <div class="card-tit">
                上网日志明细
                <ul class="journal-search-wrapper" id="trackLabel">
                    <!--    <li class="journal-search-card">非标APP(2000)</li>
                    <li class="journal-search-card">境外IP地址(2000)</li>
                    <li class="journal-search-card">非标端口(2000)</li> -->
                </ul>
                <el-button class="journal-search-btn" size="mini" @click="dialogSearch= true" type="primary">结果筛选
                </el-button>
            </div>
            <div class="card-con">
                <el-table :data="trajectoryTableData" stripe v-loading="loading">
                    <el-table-column prop="setId" label="任务ID" show-overflow-tooltip></el-table-column>
                    <el-table-column prop="accessTime" label="访问时间" show-overflow-tooltip></el-table-column>
                    <el-table-column prop="account" label="号码" show-overflow-tooltip></el-table-column>
                    <el-table-column prop="imei" label="IMEI" show-overflow-tooltip></el-table-column>
                    <el-table-column prop="imsi" label="IMSI" show-overflow-tooltip></el-table-column>
                    <el-table-column prop="priIp" label="私网IP" show-overflow-tooltip></el-table-column>
                    <el-table-column prop="srcIp" label="源IP" show-overflow-tooltip></el-table-column>
                    <el-table-column :formatter="srcPortFormatter" label="源端口" show-overflow-tooltip></el-table-column>
                    <el-table-column prop="dstIp" label="目标IP" show-overflow-tooltip></el-table-column>
                    <el-table-column prop="dstPort" label="目标端口" show-overflow-tooltip></el-table-column>
                    <el-table-column prop="appName" label="应用名称" show-overflow-tooltip></el-table-column>
                    <el-table-column prop="url" label="URL" show-overflow-tooltip></el-table-column>
                    <el-table-column prop="label" label="标签" show-overflow-tooltip></el-table-column>
                    <el-table-column prop="lac" label="LAC" show-overflow-tooltip></el-table-column>
                    <el-table-column prop="ci" label="CI" show-overflow-tooltip></el-table-column>
                    <el-table-column prop="address" label="基站位置" show-overflow-tooltip></el-table-column>
                </el-table>
                <el-pagination :total="total" :page-size="pageSize" :current-page.sync="page"
                    layout="total, prev, pager, next, jumper" @current-change="getTableDada"></el-pagination>
                <el-dialog width="700px" modal="false" title="筛选结果" class="case_dialog" :visible.sync="dialogSearch"
                    :before-close="handleClose">
                    <el-form :model="form" ref="ruleForm">
                        <el-row>
                            <el-form-item label="访问时间" prop="accessTime" :label-width="formLabelWidth">
                                <el-col :span="24">
                                    <el-date-picker style="width:530px" v-model="form.accessTime" type="datetimerange"
                                        range-separator="至" :picker-options="pickerOptions" start-placeholder="开始时间"
                                        end-placeholder="结束时间">
                                    </el-date-picker>
                            </el-form-item>
                            </el-col>
                        </el-row>
                        <el-row>
                            <el-col :span="12">
                                <el-form-item label="IMEI" :label-width="formLabelWidth" prop="imei">
                                    <el-input style="width:200px" v-model.trim="form.imei" autocomplete="off">
                                    </el-input>
                                </el-form-item>
                            </el-col>
                            <el-col :span="12">
                                <el-form-item label="IMSI" :label-width="formLabelWidth" prop="imsi">
                                    <el-input style="width:200px" v-model.trim="form.imsi" autocomplete="off">
                                    </el-input>
                                </el-form-item>
                            </el-col>
                        </el-row>
                        <el-row>
                            <el-col :span="12">
                                <el-form-item label="私网IP" :label-width="formLabelWidth" prop="priIp">
                                    <el-input style="width:200px" v-model.trim="form.priIp" autocomplete="off">
                                    </el-input>
                                </el-form-item>
                            </el-col>
                            <el-col :span="12">
                                <el-form-item label="公网IP" :label-width="formLabelWidth" prop="pubIp">
                                    <el-input style="width:200px" v-model.trim="form.pubIp" autocomplete="off">
                                    </el-input>
                                </el-form-item>
                            </el-col>
                        </el-row>
                        <el-row>
                            <el-col :span="12">
                                <el-form-item label="公网端口" :label-width="formLabelWidth" prop="pubIp">
                                    <el-input style="width:200px" v-model.trim="form.pubPort" autocomplete="off">
                                    </el-input>
                                </el-form-item>
                            </el-col>
                            <el-col :span="12">
                                <el-form-item label="目标IP" :label-width="formLabelWidth" prop="dstIp">
                                    <el-input style="width:200px" v-model.trim="form.dstIp" autocomplete="off">
                                    </el-input>
                                </el-form-item>
                            </el-col>
                        </el-row>
                        <el-row>
                            <el-col :span="12">
                                <el-form-item label="目标端口" :label-width="formLabelWidth" prop="dstPort">
                                    <el-input style="width:200px" v-model.trim="form.dstPort" autocomplete="off">
                                    </el-input>
                                </el-form-item>
                            </el-col>
                            <el-col :span="12">
                                <el-form-item label="应用名称" :label-width="formLabelWidth" prop="serviceName">
                                    <el-input style="width:200px" v-model.trim="form.serviceName" autocomplete="off">
                                    </el-input>
                                </el-form-item>
                            </el-col>
                        </el-row>
                        <el-row>
                            <el-col :span="24">
                                <el-form-item label="url" :label-width="formLabelWidth" prop="url">
                                    <el-input style="width:530px" v-model.trim="form.url" autocomplete="off"></el-input>
                                </el-form-item>
                            </el-col>
                        </el-row>
                        <el-row>
                            <el-col :span="12">
                                <el-form-item label="lac" :label-width="formLabelWidth" prop="lac">
                                    <el-input style="width:200px" v-model.trim="form.lac" autocomplete="off"></el-input>
                                </el-form-item>
                            </el-col>
                            <el-col :span="12">
                                <el-form-item label="ci" :label-width="formLabelWidth" prop="ci">
                                    <el-input style="width:200px" v-model.trim="form.ci" autocomplete="off"></el-input>
                                </el-form-item>
                            </el-col>
                        </el-row>
                        <el-row>
                            <el-col :span="24">
                                <el-form-item label="address" :label-width="formLabelWidth" prop="address">
                                    <el-input style="width:530px" v-model.trim="form.address" autocomplete="off">
                                    </el-input>
                                </el-form-item>
                            </el-col>
                        </el-row>
                    </el-form>
                    <div slot="footer" class="dialog-footer">
                        <el-button type="primary" @click="submitForm('ruleForm')">查找</el-button>
                        <el-button @click="resetForm('ruleForm')">重置</el-button>
                    </div>
                </el-dialog>
            </div>
        </div>
    </div>
    <!-- jqueryCloud -->
    <script src="https://cdn.bootcss.com/jqcloud/1.0.4/jqcloud-1.0.4.min.js"></script>
    <script src="<%=basePath%>views/judgingTool/trajectoryAnalysis.js"></script>
</body>
</html>