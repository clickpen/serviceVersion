<%--
  User: xupanpan
  Date: 2020/3/30
  Time: 11:27
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <meta charset="UTF-8">
    <title>commonHeader</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/views/commonHeader/commonHeader.css">
</head>
<div class="common-header">
    <div class="title">
        <i class="logo-icon"></i>
        <h1>移动数据应用</h1>
    </div>
    <ul class="header-nav-wrapper">
        <li class="nav-card active">
                <a href="index?path=index/index">
                    <i class="index-icon"></i>首页
                </a>
            </li>
            <li class="nav-card">
                <a href="index?path=prevenModel/prevenModel">
                    <i class="judg-icon"></i>研判工具
                </a>
            </li>
            <li class="nav-card">
                <a href="index?path=prevenModel/prevenModel">
                    <i class="preven-icon"></i>防控模型
                </a>
            </li>
            <li class="nav-card">
                <a href="index?path=case/case">
                    <i class="case-icon"></i>案件管理
                </a>
            </li>
    </ul>
    <div class="header-user-info">
            <span class="header-user-tips">
                <span class="numbers">24</span>
            </span>
        <span class="header-user-messages">
                <span class="numbers">5</span>
            </span>
        <img src="http://tupian.qqjay.com/tou2/2017/1011/45baf16d6ec0d40735cbb74dfd7f894a.jpg" class="header-user-hd">
        <span class="header-user-name">admin</span>
        <span title="退出" class="header-quit-btn"></span>
    </div>
</div>
