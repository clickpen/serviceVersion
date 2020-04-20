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
            background: url('../images/login-bg.jpg') center / cover no-repeat;
        }
        .login-wrapper .title {
            position: absolute;
            left: 50%;
            top: 50%;
            transform: translate(10px, -160px);
            font-size: 30px;
        }
        .login-wrapper .title .icon {
            display: inline-block;
            vertical-align: text-bottom;
            width: 38px;
            height: 38px;
            background: url('../images/logo.png') center / contain no-repeat;
        }
        .login-wrapper .title .welcome-tips {
            position: absolute;
            top: 100%;
            left: 0;
            font-size: 18px;
            color: #ccc;
            letter-spacing: 2px;
            font-weight: 100;
        }
        .login-wrapper .login-form {
            position: absolute;
            width: 260px;
            text-align: center;
            top: 50%;
            left: 50%;
            transform: translate(10px, -60px);
        }
        .login-wrapper .login-form i {
            position: absolute;
            left: 0px;
            width: 30px;
            height: 30px;
        }
        .login-wrapper .login-form .user-icon {
            top: 8px;
            background: url('../images/user-icon.png') center / contain no-repeat;
        }
        .login-wrapper .login-form .pass-icon {
            top: 83px;
            background: url('../images/pass-icon.png') center / contain no-repeat;
        }
        .login-wrapper .login-form .user-input {
            box-sizing: border-box;
            background-color: transparent;
            width: 100%;
            height: 46px;
            margin-bottom: 30px;
            padding-left: 36px;
            outline: none;
            border: none;
            border-bottom: 1px solid #ccc;
        }
        .login-wrapper .login-form .submit-btn {
            width: 90%;
            height: 40px;
            background-color: #006eff;
            text-align: center;
            font-size: 18px;
            font-weight: bold;
            letter-spacing: 4px;
            color: #fff;
            outline: none;
            border-radius: 20px;
            border: none;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <div class="login-wrapper">
        <h1 class="title">
            <i class="icon"></i>
            移动数据应用平台
            <span class="welcome-tips">Wekcome欢迎登陆</span>
        </h1>
        <div class="input-wrapper">
            <form class="login-form" action="login" method="post">
                <i class="user-icon"></i>
                <i class="pass-icon"></i>
                <input class="user-input" type="text" name="userName" placeholder="请输入账号">
                <input class="user-input" type="password" name="userPass" placeholder="请输入密码">
                <span style ="color: red;margin-top: 0px;display: block; margin-bottom: 20px;"> ${msg}</span>
                <button class="submit-btn" type="submit">登录</button>
            </form>
        </div>
    </div>
</body>
</html>