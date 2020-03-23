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
    <title>移动数据应用-首页</title>
    <link rel="stylesheet" href="../commonHeader/commonHeader.css">
    <link rel="stylesheet" href="./index.css">
</head>
<body>
    <div class="common-header">
        <div class="title">
            <i class="logo-icon"></i>
            <h1>移动数据应用</h1>
        </div>
        <ul class="header-nav-wrapper">
            <li class="nav-card active">
                <a href="/jetk/views/index/index.jsp">
                    <i class="index-icon"></i>首页
                </a>
            </li>
            <li class="nav-card">
                <a href="#">
                    <i class="judg-icon"></i>研判工具
                </a>
            </li>
            <li class="nav-card">
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
    <script src="../commonHeader/commonHeader.js"></script>
    <script src="./index.js"></script>
</body>
</html>