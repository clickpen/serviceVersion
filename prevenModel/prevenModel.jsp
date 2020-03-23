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
    <link rel="stylesheet" href="../commonHeader/commonHeader.css">
    <link rel="stylesheet" href="./prevenModel.css">
</head>
<body>
    <div class="common-header">
        <div class="title">
            <i class="logo-icon"></i>
            <h1>移动数据应用</h1>
        </div>
        <ul class="header-nav-wrapper">
            <li class="nav-card">
                <a href="/jetk/views/index/index.jsp">
                    <i class="index-icon"></i>首页
                </a>
            </li>
            <li class="nav-card">
                <a href="#">
                    <i class="judg-icon"></i>研判工具
                </a>
            </li>
            <li class="nav-card active">
                <a href="/jetk/views/prevenModel/prevenModel.jsp">
                    <i class="preven-icon"></i>防控模型
                </a>
            </li>
            <li class="nav-card">
                <a href="#">
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
    <div class="content-wrapper">
        <div class="map-wrapper" id="mapWrapper"></div>
        <ul class="map-item-wrapper">
            <li class="map-item red">
                <i class="icon"></i>
                <span class="name">一级管控</span>
            </li>
            <li class="map-item pink">
                <i class="icon"></i>
                <span class="name">二级管控</span>
            </li>
            <li class="map-item skyBlue">
                <i class="icon"></i>
                <span class="name">三级管控</span>
            </li>
        </ul>
        <div class="message-wrapper J-messageBoxWrapper">
            <div class="message-box">
                <h5 class="tit">
                    重点人列表
                    <span class="message-box-btn J-hideMessageBox">&lt;&lt;</span>
                </h5>
                <div class="message-search">
                    <input type="text" placeholder="请输入需要搜索的预警信息">
                    <span class="search-btn"></span>
                    <span class="export-btn">导出</span>
                </div>
                <ul class="message-list">
                    <li class="message-card">
                        <img class="left-img" src="http://pic2.zhimg.com/50/v2-fb824dbb6578831f7b5d92accdae753a_hd.jpg">
                        <div class="right-des">
                            <p>姓名：<span>张三</span></p>
                            <p>手机号：<span>13169954321</span></p>
                            <p>责任派出所：<span>abcd派出所</span></p>
                            <p>预警时间：<span>2020-03-16 18:30:00</span></p>
                            <p>预警信息：<span>进入北京市被拘留</span></p>
                        </div>
                    </li>
                    <li class="message-card">
                        <img class="left-img" src="http://pic2.zhimg.com/50/v2-fb824dbb6578831f7b5d92accdae753a_hd.jpg">
                        <div class="right-des">
                            <p>姓名：<span>张三</span></p>
                            <p>手机号：<span>13169954321</span></p>
                            <p>责任派出所：<span>abcd派出所</span></p>
                            <p>预警时间：<span>2020-03-16 18:30:00</span></p>
                            <p>预警信息：<span>进入北京市被拘留</span></p>
                        </div>
                    </li>
                    <li class="message-card">
                        <img class="left-img" src="http://pic2.zhimg.com/50/v2-fb824dbb6578831f7b5d92accdae753a_hd.jpg">
                        <div class="right-des">
                            <p>姓名：<span>张三</span></p>
                            <p>手机号：<span>13169954321</span></p>
                            <p>责任派出所：<span>abcd派出所</span></p>
                            <p>预警时间：<span>2020-03-16 18:30:00</span></p>
                            <p>预警信息：<span>进入北京市被拘留</span></p>
                        </div>
                    </li>
                    <li class="message-card">
                        <img class="left-img" src="http://pic2.zhimg.com/50/v2-fb824dbb6578831f7b5d92accdae753a_hd.jpg">
                        <div class="right-des">
                            <p>姓名：<span>张三</span></p>
                            <p>手机号：<span>13169954321</span></p>
                            <p>责任派出所：<span>abcd派出所</span></p>
                            <p>预警时间：<span>2020-03-16 18:30:00</span></p>
                            <p>预警信息：<span>进入北京市被拘留</span></p>
                        </div>
                    </li>
                    <li class="message-card">
                        <img class="left-img" src="http://pic2.zhimg.com/50/v2-fb824dbb6578831f7b5d92accdae753a_hd.jpg">
                        <div class="right-des">
                            <p>姓名：<span>张三</span></p>
                            <p>手机号：<span>13169954321</span></p>
                            <p>责任派出所：<span>abcd派出所</span></p>
                            <p>预警时间：<span>2020-03-16 18:30:00</span></p>
                            <p>预警信息：<span>进入北京市被拘留</span></p>
                        </div>
                    </li>
                    <li class="message-card">
                        <img class="left-img" src="http://pic2.zhimg.com/50/v2-fb824dbb6578831f7b5d92accdae753a_hd.jpg">
                        <div class="right-des">
                            <p>姓名：<span>张三</span></p>
                            <p>手机号：<span>13169954321</span></p>
                            <p>责任派出所：<span>abcd派出所</span></p>
                            <p>预警时间：<span>2020-03-16 18:30:00</span></p>
                            <p>预警信息：<span>进入北京市被拘留</span></p>
                        </div>
                    </li>
                    <li class="message-card">
                        <img class="left-img" src="http://pic2.zhimg.com/50/v2-fb824dbb6578831f7b5d92accdae753a_hd.jpg">
                        <div class="right-des">
                            <p>姓名：<span>张三</span></p>
                            <p>手机号：<span>13169954321</span></p>
                            <p>责任派出所：<span>abcd派出所</span></p>
                            <p>预警时间：<span>2020-03-16 18:30:00</span></p>
                            <p>预警信息：<span>进入北京市被拘留</span></p>
                        </div>
                    </li>
                </ul>
            </div>
        </div>
        <span class="show-message-wrapper hide J-showMessageBox" title="展示重点人列表">&gt;&gt;</span>
    </div>
    <script src="../../js/jquery-3.0.0.js"></script>
    <script type="text/javascript"
		src="http://api.map.baidu.com/api?v=2.0&ak=cfEylnTgGMTSQy6BiWxP0hrVsVRkS8vM"></script>
    <script src="../commonHeader/commonHeader.js"></script>
    <script src="./prevenModel.js"></script>
</body>
</html>