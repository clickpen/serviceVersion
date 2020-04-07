<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.io.*"%>
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
    <div class="content-wrapper" id="trajectoryAnalysis" v-cloak>
		<p class="breadcrumb">
            研判工具
            <span class="current-bread">轨迹关联</span>
        </p>
        <div class="map-wrapper">
            <div class="map-title">
                <b>地图展示</b>
                <b class="msg">（手机号：<span class="phone">13196998788</span><span class="address">山东 烟台</span>）</b>
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
                <span class="tips-prev">
                    <i></i>
                    减速
                </span>
                <span class="tips-play">
                    <i class="el-icon-video-play"></i>播放
                </span>
                <span class="tips-next">
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
                        lac：
                        <span>4454</span>
                        ci：
                        <span>56467877</span>
                    </p>
                    <p class="point-des">
                        基站位置：
                        <span>山东省烟台市XX路XX街道XX号</span>
                    </p>
                </div>
                <div class="point-night">
                    <p class="point-tit">
                        <i></i>
                        夜晚落脚点
                    </p>
                    <p class="point-poi">
                        lac：
                        <span>4454</span>
                        ci：
                        <span>56467877</span>
                    </p>
                    <p class="point-des">
                        基站位置：
                        <span>山东省烟台市XX路XX街道XX号</span>
                    </p>
                </div>
            </div>
            <div class="time-analysis">
                <p class="tit">时空分布分析</p>
                <el-table :data="mapAnalysisTable">
                    <el-table-column
                        prop="timeRange"
                        label="时间段"
                    ></el-table-column>
                    <el-table-column
                        prop="position1"
                        label="基站1"
                    ></el-table-column>
                    <el-table-column
                        prop="position2"
                        label="基站2"
                    ></el-table-column>
                </el-table>
            </div>
        </div>
        <div class="netimage-analysis">
            <p class="content-tit">
                网络画像
                <span :class="{'hide-area-btn': true, 'active': netimageShow}" @click="netimageShow = !netimageShow">{{netimageShow ? '收起' : '展开'}}</span>
            </p>
            <transition name="el-zoom-in-top">
                <div v-show="netimageShow" class="netimage-content">
                    <div class="id-analysis-card">
                        <p class="card-tit">身份特征分析</p>
                        <p class="content">
                            <span class="label">IEMI串号：</span>
                            1234567890123,1234567890123
                        </p>
                        <p class="content">
                            <span class="label">IESI串号：</span>
                            1234567890123,1234567890123
                        </p>
                        <p class="content">
                            <span class="label">MAC：</span>
                            QW-12 12-12-12
                        </p>
                        <p class="content">
                            <span class="label">微信ID：</span>
                            Q131313
                        </p>
                        <p class="content">
                            <span class="label">QQ号码：</span>
                            123456789
                        </p>
                        <p class="content">
                            <span class="label">微博ID：</span>
                            12345678
                        </p>
                        <p class="content">
                            <span class="label">淘宝账号：</span>
                            12345678
                        </p>
                    </div>
                    <div class="web-analysis-card">
                        <p class="card-tit">网站访问分析</p>
                        <p class="content">
                            <span class="des">www.weixin.com</span>
                            <span class="type">腾讯</span>
                            <span class="number">80条</span>
                        </p>
                        <p class="content">
                            <span class="des">www.weixin.com</span>
                            <span class="type">腾讯</span>
                            <span class="number">80条</span>
                        </p>
                        <p class="content">
                            <span class="des">www.weixin.com</span>
                            <span class="type">腾讯</span>
                            <span class="number">80条</span>
                        </p>
                        <p class="content">
                            <span class="des">www.weixin.com</span>
                            <span class="type">腾讯</span>
                            <span class="number">80条</span>
                        </p>
                        <p class="content">
                            <span class="des">www.weixin.com</span>
                            <span class="type">腾讯</span>
                            <span class="number">80条</span>
                        </p>
                    </div>
                    <div class="active-analysis-card">
                        <p class="card-tit">访问协议分析</p>
                        <p class="content">
                            <span class="des">80</span>
                            <span class="type">https</span>
                            <span class="number">80条</span>
                        </p>
                        <p class="content">
                            <span class="des">80</span>
                            <span class="type">https</span>
                            <span class="number">80条</span>
                        </p>
                        <p class="content">
                            <span class="des">80</span>
                            <span class="type">https</span>
                            <span class="number">80条</span>
                        </p>
                        <p class="content">
                            <span class="des">80</span>
                            <span class="type">https</span>
                            <span class="number">80条</span>
                        </p>
                        <p class="content">
                            <span class="des">80</span>
                            <span class="type">https</span>
                            <span class="number">80条</span>
                        </p>
                    </div>
                    <div class="key-analysis-card">
                        <p class="card-tit">关键词分析<span>(注：文字云)</span></p>
                        <div class="key-cloud" id="keyCloud"></div>
                    </div>
                    <div class="app-analysis-card">
                        <p class="card-tit">使用APP分析</p>
                        <ul class="app-wrapper">
                            <li class="app-card">
                                <img src="https://dss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=1306607258,967818222&fm=111&gp=0.jpg">
                                <p class="app-tit">头条头条</p>
                                <p class="app-num">800条</p>
                            </li>
                            <li class="app-card">
                                <img src="https://dss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=1306607258,967818222&fm=111&gp=0.jpg">
                                <p class="app-tit">头条头条</p>
                                <p class="app-num">800条</p>
                            </li>
                            <li class="app-card">
                                <img src="https://dss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=1306607258,967818222&fm=111&gp=0.jpg">
                                <p class="app-tit">头条头条</p>
                                <p class="app-num">800条</p>
                            </li>
                            <li class="app-card">
                                <img src="https://dss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=1306607258,967818222&fm=111&gp=0.jpg">
                                <p class="app-tit">头条头条</p>
                                <p class="app-num">800条</p>
                            </li>
                            <li class="app-card">
                                <img src="https://dss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=1306607258,967818222&fm=111&gp=0.jpg">
                                <p class="app-tit">头条头条</p>
                                <p class="app-num">800条</p>
                            </li>
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
                <el-table
                    :data="trajectoryTableData"
                >
                    <el-table-column
                        prop="taskId"
                        label="任务ID"
                        show-overflow-tooltip
                    ></el-table-column>
                    <el-table-column
                        prop="phone"
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
                        prop="prevIp"
                        label="私网IP"
                        show-overflow-tooltip
                    ></el-table-column>
                    <el-table-column
                        prop="originIp"
                        label="源IP"
                        show-overflow-tooltip
                    ></el-table-column>
                    <el-table-column
                        prop="originPort"
                        label="源端口"
                        show-overflow-tooltip
                    ></el-table-column>
                    <el-table-column
                        prop="targetIp"
                        label="目标IP"
                        show-overflow-tooltip
                    ></el-table-column>
                    <el-table-column
                        prop="targetPort"
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
                        prop="position"
                        label="基站位置"
                        show-overflow-tooltip
                    ></el-table-column>
                </el-table>
                <el-pagination
                    :total="100"
                    :page-size="10"
                    layout="total, prev, pager, next, jumper"
                ></el-pagination>
            </div>
        </div>
    </div>
    <!-- jqueryCloud -->
    <script src="https://cdn.bootcss.com/jqcloud/1.0.4/jqcloud-1.0.4.min.js"></script>
    <script src="<%=basePath%>views/judgingTool/trajectoryAnalysis.js"></script>
</body>
</html>