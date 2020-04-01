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
    <title>移动数据应用-系统管理</title>
    <link rel="stylesheet" href="<%=basePath%>views/systemManage/userManage.css">
</head>
<body>
    <jsp:include page="../commonHeader/commonHeader.jsp" flush="ture"></jsp:include>
    <div class="system-manage-wrapper" id="systemManage"  v-cloak>
        <el-tabs v-model="systemManageTab">
            <el-tab-pane label="用户管理" name="userManage">
                <div class="child-wrapper">
                    <p>用户管理页面</p>
                </div>
            </el-tab-pane>
        </el-tabs>
    </div>
    <script src="<%=basePath%>views/systemManage/userManage.js"></script>
</body>
</html>