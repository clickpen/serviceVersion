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
    <title>移动数据应用-登录</title>
</head>
<body>
    <div class="login-wrapper">
        <h1 class="title">移动数据应用</h1>
        <div class="input-wrapper">
        	<form action="login" method="post">
	            <input type="text" name="userName"  placeholder="请输入账号">
	            <input type="password" name="userPass" placeholder="请输入密码">
	           <!--  <span class="login-btn">登录</span> -->
	           <input type="submit" value="登录" ></button>
            </form>
        </div>
    </div>
</body>
</html>