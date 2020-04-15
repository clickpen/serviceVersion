<%--
  User: xupanpan
  Date: 2020/3/30
  Time: 11:27
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <meta charset="UTF-8">
    <title>commonHeader</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/element-ui-2.12.0.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/views/commonHeader/commonHeader.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/bmap.css" />
</head>
<div class="common-header">
    <div class="title">
        <i class="logo-icon"></i>
        <h1>移动数据应用</h1>
    </div>
    <ul class="header-nav-wrapper">
        <li class="nav-card J-nav-card">
            <a href="index?path=index/index">
                <i class="index-icon"></i>首页
            </a>
        </li>
        <li class="nav-card J-nav-card">
            <a href="index?path=judgingTool/judgingToolMain">
                <i class="judg-icon"></i>研判工具
            </a>
        </li>
        <li class="nav-card J-nav-card">
            <a href="index?path=prevenModel/prevenModel">
                <i class="preven-icon"></i>防控模型
            </a>
        </li>
        <li class="nav-card J-nav-card">
            <a href="index?path=case/case">
                <i class="case-icon"></i>案件管理
            </a>
        </li>
        <li class="nav-card J-nav-card">
            <a href="index?path=systemModel/systemModel">
                <i class="el-icon-setting"></i>系统管理
            </a>
        </li>
    </ul>
    <div class="header-user-info">
        <!-- <span class="header-user-tips">
            <span class="numbers">24</span>
        </span>
        <span class="header-user-messages">
            <span class="numbers">5</span>
        </span> -->
        <img src="http://tupian.qqjay.com/tou2/2017/1011/45baf16d6ec0d40735cbb74dfd7f894a.jpg" class="header-user-hd">
        <span class="header-user-name">admin</span>
        <span title="退出" class="header-quit-btn"></span>
    </div>
</div>
<script src="<%=request.getContextPath()%>/js/jquery-3.0.0.js"></script>
<script src="<%=request.getContextPath()%>/js/vue-2.6.10.min.js"></script>
<script src="<%=request.getContextPath()%>/js/echarts-4.4.0.min.js"></script>
<script src="<%=request.getContextPath()%>/js/element-ui-2.12.0.js"></script>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=cfEylnTgGMTSQy6BiWxP0hrVsVRkS8vM"></script>
<!-- <script type="text/javascript" src="<%=request.getContextPath()%>/js/map/bootstrapformap.js"></script> -->
<!-- <script type="text/javascript" src="<%=request.getContextPath()%>/js/map/pointcollection/offlinemap/map_load.js"></script> -->
<script type="text/javascript" src="<%=request.getContextPath()%>/js/map/mapv.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/map/Heatmap_min.js"></script>

<script src="<%=request.getContextPath()%>/views/commonHeader/commonHeader.js"></script>