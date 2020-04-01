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
    <style>
        body, h1 {
            padding: 0;
            margin: 0;
        }
        .login-wrapper {
            position: relative;
            width: 100%;
            height: 100vh;
        }
        .login-wrapper .title {
            position: absolute;
            left: 50%;
            top: 50%;
            transform: translate(-50%, -100%);
            font-size: 40px;
        }
        .login-wrapper .login-form {
            position: absolute;
            width: 200px;
            text-align: center;
            top: 50%;
            left: 50%;
            transform: translate(-50%, 10px);
        }
        .login-wrapper .login-form .user-input {
            box-sizing: border-box;
            width: 100%;
            height: 30px;
            margin-bottom: 10px;
            padding-left: 10px;
            border-radius: 4px;
            outline: none;
            border: 1px solid #ccc;
        }
        .login-wrapper .login-form .submit-btn {
            width: 60px;
            height: 30px;
            background-color: #409EFF;
            text-align: center;
            font-size: 14px;
            color: #fff;
            outline: none;
            border-radius: 4px;
            border: none;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <div class="login-wrapper">
        <h1 class="title">移动数据应用</h1>
        <div class="input-wrapper">
            <form class="login-form" action="login" method="post">
                <input class="user-input" type="text" name="userName" placeholder="请输入账号">
                <input class="user-input" type="password" name="userPass" placeholder="请输入密码">
                <input class="submit-btn" type="submit" value="登录"></button>
            </form>
        </div>
    </div>
</body>
</html>