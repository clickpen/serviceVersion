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
                <b class="msg">（手机号：<span class="phone">${param.account}</span><span class="address" id= "accountAddress"></span>）</b>
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
                <span class="tips-prev"  @click="handleRewind()">
                    <i></i>
                    减速
                </span>
                <span class="tips-play"  @click="handleplayback()">
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
                    <p class="point-poi" id = "dayStopover" >

                        lac：
                        <span id="dayLac"></span>
                        ci：
                        <span id="dayCi"></span>
                    </p>
                    <p class="point-des">
                        基站位置：
                        <span id="dayAddress"></span>
                    </p>
                </div>
                <div class="point-night">
                    <p class="point-tit">
                        <i></i>
                        夜晚落脚点
                    </p>
                    <p class="point-poi" id = "nightStopover">
                        lac：
                        <span id="nightLac"></span>
                        ci：
                        <span id="nightCi"></span>
                    </p>
                    <p class="point-des">
                        基站位置：
                        <span id="nightAddress"></span>
                    </p>
                </div>
            </div>
            <div class="time-analysis">
                <p class="tit">时空分布分析</p>
                <el-table :data="mapAnalysisTable">
                    <el-table-column prop="timeScan" label="时间段" show-overflow-tooltip></el-table-column>
                    <el-table-column prop="position1" label="基站1" show-overflow-tooltip></el-table-column>
                    <el-table-column prop="position2" label="基站2" show-overflow-tooltip></el-table-column>
                    <el-table-column prop="position3" label="基站3" show-overflow-tooltip></el-table-column>
                </el-table>
            </div>
        </div>
        <div class="netimage-analysis">
            <p class="content-tit">
                网络画像
                <span
                    :class="{'hide-area-btn': true, 'active': netimageShow}"
                    @click="netimageShow = !netimageShow"
                >{{netimageShow ? '收起' : '展开'}}</span>
            </p>
            <transition name="el-zoom-in-top">
                <div v-show="netimageShow" class="netimage-content">
                    <div class="id-analysis-card" id ="virtualList">
                        <p class="card-tit">身份特征分析</p>
                    </div>
                    <div class="web-analysis-card" id ="trackWebNameList">
                        <p class="card-tit">网站访问分析</p>
                    </div>
                    <div class="active-analysis-card" id = "trackProtocolList">
                        <p class="card-tit">访问协议分析</p>
                    </div>
                    <div class="key-analysis-card">
                        <p class="card-tit">关键词分析<span>(注：文字云)</span></p>
                        <div class="key-cloud" id="keyCloud"></div>
                    </div>
                    <div class="app-analysis-card">
                        <p class="card-tit">使用APP分析</p>
                        <ul class="app-wrapper" id = "trackApp">
                        </ul>
                    </div>
                </div>
            </transition>
        </div>
        <div class="journal-detail">
            <div class="card-tit">
                上网日志明细
                <ul class="journal-search-wrapper">
                    <li class="journal-search-card">非标APP(2000)</li>
                    <li class="journal-search-card">境外IP地址(2000)</li>
                    <li class="journal-search-card">非标端口(2000)</li>
                </ul>
                <el-button class="journal-search-btn" size="mini" type="primary">结果筛选</el-button>
            </div>
            <div class="card-con">
                <el-table :data="trajectoryTableData" stripe v-loading="loading">
                    <el-table-column
                        prop="setId"
                        label="任务ID"
                        show-overflow-tooltip
                    ></el-table-column>
                    <el-table-column
                        prop="accessTime"
                        label="访问时间"
                        show-overflow-tooltip
                    ></el-table-column>
                    <el-table-column
                        prop="account"
                        label="号码"
                        show-overflow-tooltip
                    ></el-table-column>
                    <el-table-column
                        prop="imei"
                        label="IMEI"
                        show-overflow-tooltip
                    ></el-table-column>
                    <el-table-column
                        prop="imsi"
                        label="IMSI"
                        show-overflow-tooltip
                    ></el-table-column>
                    <el-table-column
                        prop="priIp"
                        label="私网IP"
                        show-overflow-tooltip
                    ></el-table-column>
                    <el-table-column
                        prop="srcIp"
                        label="源IP"
                        show-overflow-tooltip
                    ></el-table-column>
                    <el-table-column
                        :formatter="srcPortFormatter"
                        label="源端口"
                        show-overflow-tooltip
                    ></el-table-column>
                    <el-table-column
                        prop="dstIp"
                        label="目标IP"
                        show-overflow-tooltip
                    ></el-table-column>
                    <el-table-column
                        prop="dstPort"
                        label="目标端口"
                        show-overflow-tooltip
                    ></el-table-column>
                    <el-table-column
                        prop="appName"
                        label="应用名称"
                        show-overflow-tooltip
                    ></el-table-column>
                    <el-table-column
                        prop="url"
                        label="URL"
                        show-overflow-tooltip
                    ></el-table-column>
                    <el-table-column
                        prop="label"
                        label="标签"
                        show-overflow-tooltip
                    ></el-table-column>
                    <el-table-column
                        prop="lac"
                        label="LAC"
                        show-overflow-tooltip
                    ></el-table-column>
                    <el-table-column
                        prop="ci"
                        label="CI"
                        show-overflow-tooltip
                    ></el-table-column>
                    <el-table-column
                        prop="address"
                        label="基站位置"
                        show-overflow-tooltip
                    ></el-table-column>
                </el-table>
                <el-pagination
                    :total="total"
                    :page-size="pageSize"
                    :current-page.sync="page"
                    layout="total, prev, pager, next, jumper"
                    @current-change="getTableDada"
                ></el-pagination>
            </div>
        </div>
    </div>
    <!-- jqueryCloud -->
    <script src="https://cdn.bootcss.com/jqcloud/1.0.4/jqcloud-1.0.4.min.js"></script>
    <script src="<%=basePath%>views/judgingTool/trajectoryAnalysis.js"></script>
</body>
</html>