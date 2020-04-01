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
                    <el-table :data="usermanageTableData">
						<el-table-column
							label="用户名"
							prop="userName"
							show-overflow-tooltip
						></el-table-column>
						<el-table-column
							label="真实姓名"
							prop="truthName"
							show-overflow-tooltip
						></el-table-column>
						<el-table-column
							label="联系方式"
							prop="phone"
							show-overflow-tooltip
						></el-table-column>
						<el-table-column
							label="身份证号码"
							prop="idCard"
							show-overflow-tooltip
						></el-table-column>
						<el-table-column
							label="ip地址"
							prop="ipStress"
							show-overflow-tooltip
						></el-table-column>
						<el-table-column
							label="MAC地址"
							prop="macStress"
							show-overflow-tooltip
						></el-table-column>
						<el-table-column
							label="UKEY信息"
							prop="ukeyMessage"
							show-overflow-tooltip
						></el-table-column>
						<el-table-column
							label="到期时间"
							prop="timeLess"
							show-overflow-tooltip
						></el-table-column>
						<el-table-column
							label="所属角色"
							prop="role"
							show-overflow-tooltip
						></el-table-column>
						<el-table-column
							label="操作"
							prop="operate"
						>
							<template v-slot="scope">
								<div class="usermanage-operate-btn">
									<i class="el-icon-edit-outline" @click="() => {usermanageDialogShow = true}"></i>
									<i class="el-icon-delete" @click="handleDeleteRowData(scope.row, 'usermanage')"></i>
								</div>
							</template>
						</el-table-column>
                    </el-table>
                    <el-pagination
						background
						:total="50"
						page-size="10"
						current-page="1"
						layout="prev, pager, next, jumper"
					></el-pagination>
                </div>
            </el-tab-pane>
        </el-tabs>
        <div class="child-table-search" v-if="prevenTab === 'userManage'">
			<el-input size="mini" class="search-input" placeholder="输入您想要搜索的内容">
				<el-button slot="append" icon="el-icon-search"></el-button>
			</el-input>
			<el-button size="mini" class="el-icon-circle-plus-outline">新增用户</el-button>
		</div>
        <el-dialog
			:visible="usermanageDialogShow"
			width="650px"
			title="新增用户"
			:before-close="() => {usermanageDialogShow = false}"
		>
			<div class="usermanage-dialog-wrapper">
				<el-upload
					class="usermanage-hd"
					action="https://jsonplaceholder.typicode.com/posts/"
					:show-file-list="false"
					:on-success="handleUploadFile"
				>
					<img v-if="usermanageDialogForm.hdUrl" :src="usermanageDialogForm.hdUrl">
					<i v-else class="el-icon-plus usermanage-hd-holder"></i>
					<span class="usermanage-hd-des">(添加头像)</span>
				</el-upload>
				<el-form class="usermanage-content" ref="userManageForm" :model="usermanageDialogForm" label-width="100px">
					<el-form-item label="用户账号：" prop="account">
						<el-input size="mini" placeholder="请输入姓名" v-model="usermanageDialogForm.account"></el-input>
					</el-form-item>
					<el-form-item label="用户密码：" prop="password">
						<el-input size="mini" placeholder="请输入密码" v-model="usermanageDialogForm.password"></el-input>
					</el-form-item>
					<el-form-item label="确认密码：" prop="askpassword">
						<el-input size="mini" placeholder="请输入确认密码" v-model="usermanageDialogForm.askpassword"></el-input>
					</el-form-item>
					<el-form-item label="联系方式：" prop="phone">
						<el-input size="mini" placeholder="请输入联系方式" v-model="usermanageDialogForm.phone"></el-input>
					</el-form-item>
					<el-form-item label="身份证号码：" prop="idCard">
						<el-input size="mini" placeholder="请输入身份证号" v-model="usermanageDialogForm.idCard"></el-input>
					</el-form-item>
					<el-form-item label="IP地址：" prop="ipStress">
						<el-input size="mini" placeholder="请输入IP地址" v-model="usermanageDialogForm.ipStress"></el-input>
					</el-form-item>
					<el-form-item label="MAC地址：" prop="macStress">
						<el-input size="mini" placeholder="请输入MAC地址" v-model="usermanageDialogForm.macStress"></el-input>
					</el-form-item>
					<el-form-item label="UKEY信息：" prop="ukeyMessage">
						<el-input size="mini" placeholder="请输入UKEY信息" v-model="usermanageDialogForm.ukeyMessage"></el-input>
					</el-form-item>
					<el-form-item label="有效期：" prop="timeLess">
						<el-date-picker
							type="datetime"
							size="mini"
							placeholder="请选择有效期"
							v-model="usermanageDialogForm.timeLess"
						></el-date-picker>
					</el-form-item>
					<el-form-item label="所属角色：" prop="name">
						<el-select v-model="usermanageDialogForm.timeLess" size="mini" placeholder="请选择角色">
							<el-option
								label="角色1"
								value="1"
							></el-option>
							<el-option
								label="角色2"
								value="2"
							></el-option>
							<el-option
								label="角色3"
								value="3"
							></el-option>
						</el-select>
					</el-form-item>
				</el-form>
			</div>
			<span slot="footer">
				<el-button type="primary" @click="() => {usermanageDialogShow = false}">确定</el-button>
				<el-button @click="() => {usermanageDialogShow = false}">重置</el-button>
				<el-button @click="() => {usermanageDialogShow = false}">取消</el-button>
			</span>
		</el-dialog>
    </div>
    <script src="<%=basePath%>views/systemManage/userManage.js"></script>
</body>
</html>