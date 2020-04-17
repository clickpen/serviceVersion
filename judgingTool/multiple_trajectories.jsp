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
            <span class="current-bread">多号码轨迹对比</span>
        </p>
        <div class="map-wrapper">
            <div class="map-title">
                <b>轨迹展示</b>
                <input type="hidden" id = "taskIds" value="${param.id}" />
            </div>
            <div class="main-map-content" id="mapContent"></div>
        </div>    	
    </div>
</body>       
<script src="<%=basePath%>views/judgingTool/multiple_trajectories.js"></script>   
            
            