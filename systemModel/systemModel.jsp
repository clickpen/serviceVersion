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
    <link rel="stylesheet" href="<%=basePath%>views/systemModel/systemModel.css">
</head>
<body>
    <jsp:include page="../commonHeader/commonHeader.jsp" flush="ture"></jsp:include>
    <div class="system-manage-wrapper" id="systemModel" v-cloak>
		<el-tabs v-model="prevenTab">
			<el-tab-pane label="用户管理" name="userManage">
				<div class="child-wrapper child-map">
                    <el-table :data="usermanageTableData">
						<el-table-column label="用户名" prop="userName" width="100" show-overflow-tooltip ></el-table-column>
						<el-table-column label="真实姓名" prop="trueName" width="100" show-overflow-tooltip ></el-table-column>
						<el-table-column label="联系方式" prop="mobile" width="130" show-overflow-tooltip ></el-table-column>
						<el-table-column label="身份证号码" prop="identifier" show-overflow-tooltip ></el-table-column>
						<el-table-column label="ip地址" prop="ip" show-overflow-tooltip ></el-table-column>
						<el-table-column label="MAC地址" prop="mac" show-overflow-tooltip ></el-table-column>
						<el-table-column label="UKEY信息" prop="ukey" width="220" show-overflow-tooltip ></el-table-column>
						<el-table-column label="到期时间" prop="endTime" width="180" show-overflow-tooltip ></el-table-column>
						<el-table-column label="所属角色" prop="roleName" show-overflow-tooltip ></el-table-column>
						<el-table-column label="操作" width="100" prop="operate" >
							<template v-slot="scope">
								<div class="manage-operate-btn">
									<i class="el-icon-edit-outline" @click="handleEditRowData(scope.row, 'userManage')"></i>
									<i class="el-icon-delete" @click="handleDeleteRowData(scope.row, 'userManage')"></i>
								</div>
							</template>
						</el-table-column>
                    </el-table>
                    <el-pagination background :total="userManageTotal" page-size="10"  layout="prev, pager, next, jumper"></el-pagination>
                </div>
			</el-tab-pane>
			<el-tab-pane label="角色管理" name="roleManage">
                <div class="child-wrapper child-map">
                    <el-table :data="rolemanageTableData">
						<el-table-column label="角色ID" prop="roleId" show-overflow-tooltip ></el-table-column>
						<el-table-column label="角色名称" prop="roleName" show-overflow-tooltip ></el-table-column>
						<el-table-column label="角色描述" prop="roleDesc" show-overflow-tooltip ></el-table-column>
						<el-table-column label="操作" prop="operate" >
							<template v-slot="scope">
								<div class="manage-operate-btn">
									<i class="el-icon-edit-outline" @click="() => {usermanageDialogShow = true}"></i>
									<i class="el-icon-delete" @click="handleDeleteRowData(scope.row, 'roleManage')"></i>
								</div>
							</template>
						</el-table-column>
                    </el-table>
                    <el-pagination background total="roleManageTotal" page-size="10" layout="prev, pager, next, jumper"></el-pagination>
                </div>
			</el-tab-pane>
            <el-tab-pane label="系统配置" name="sysConfig">
            </el-tab-pane>
            <el-tab-pane label="配置管理" name="sysConfigManage">
			</el-tab-pane>
		</el-tabs>
		<div class="child-table-search" v-if="prevenTab == 'userManage'">
			<el-input size="mini" class="search-input" id="userSearch" placeholder="输入您想要搜索的内容">
				<el-button slot="append" icon="el-icon-search"></el-button>
			</el-input>
			<el-button size="mini" class="el-icon-circle-plus-outline" @click="usermanageDialogShow = true">新增用户</el-button>
        </div>
        <div class="child-table-search" v-if="prevenTab == 'roleManage'">
			<el-input size="mini" class="search-input" placeholder="输入您想要搜索的内容">
				<el-button slot="append" icon="el-icon-search"></el-button>
			</el-input>
			<el-button size="mini" class="el-icon-circle-plus-outline" @click="usermanageDialogShow = true">新增角色</el-button>
		</div>
        <el-dialog :visible="usermanageDialogShow" width="650px;height:700px;" :title="addUserDialogTitle" :before-close="() => {usermanageDialogShow = false}">
			<div class="usermanage-dialog-wrapper">
				<el-upload class="usermanage-hd" action="https://jsonplaceholder.typicode.com/posts/" :show-file-list="false" :on-success="handleUploadFile" >
					<img v-if="usermanageDialogForm.hdUrl" :src="usermanageDialogForm.hdUrl">
					<i v-else class="el-icon-plus usermanage-hd-holder"></i>
					<span class="usermanage-hd-des">(添加头像)</span>
				</el-upload>
				<el-form class="usermanage-content" ref="userManageForm" :rules="rules" :model="usermanageDialogForm" label-width="100px">
					<el-form-item label="用户账号：" v-show="showUserId" prop="userId">
						<el-input size="mini" placeholder="用户ID" v-model="usermanageDialogForm.userId"></el-input>
					</el-form-item>
					<el-form-item label="用户账号：" prop="userName">
						<el-input size="mini"  placeholder="请输入姓名" v-model="usermanageDialogForm.userName"></el-input>
					</el-form-item>
					<el-form-item label="用户密码：" prop="userPass">
						<el-input size="mini" type="password" placeholder="请输入密码" v-model="usermanageDialogForm.userPass"></el-input>
					</el-form-item>
					<el-form-item label="确认密码：" prop="askUserPass">
						<el-input size="mini" type="password" placeholder="请输入确认密码" v-model="usermanageDialogForm.askUserPass"></el-input>
                    </el-form-item>
                    <el-form-item label="真实姓名：" prop="trueName">
						<el-input size="mini" placeholder="请输入真实姓名" v-model="usermanageDialogForm.trueName"></el-input>
					</el-form-item>
					<el-form-item label="联系方式：" prop="mobile">
						<el-input size="mini" placeholder="请输入联系方式" v-model="usermanageDialogForm.mobile"></el-input>
					</el-form-item>
					<el-form-item label="身份证号码：" prop="identifier">
						<el-input size="mini" placeholder="请输入身份证号" v-model="usermanageDialogForm.identifier"></el-input>
					</el-form-item>
					<el-form-item label="IP地址：" prop="ip">
						<el-input size="mini" placeholder="请输入IP地址" v-model="usermanageDialogForm.ip"></el-input>
					</el-form-item>
					<el-form-item label="MAC地址：" prop="mac">
						<el-input size="mini" placeholder="请输入MAC地址" v-model="usermanageDialogForm.mac"></el-input>
					</el-form-item>
					<el-form-item label="UKEY信息：" prop="ukey">
						<el-input size="mini" placeholder="请输入UKEY信息" v-model="usermanageDialogForm.ukey"></el-input>
					</el-form-item>
					<el-form-item label="有效期：" prop="timeLess">
						<el-date-picker type="datetime" size="mini" placeholder="请选择有效期" v-model="usermanageDialogForm.endTime"></el-date-picker>
					</el-form-item>
					<el-form-item label="所属角色：" prop="roleId">
						<el-select size="mini" v-model="roleSelect" placeholder="请选择角色">
							<el-option v-for="item in rolemanageTableData" :key="item.roleId" :label="item.roleName" :value="item.roleId"> </el-option>
						</el-select>
					</el-form-item>
				</el-form>
			</div>
			<span slot="footer">
				<el-button type="primary" @click="submitForm('userManageForm')">确定</el-button>
				<el-button @click="resetForm('userManageForm')">重置</el-button>
				<el-button @click="() => {usermanageDialogShow = false}">取消</el-button>
			</span>
		</el-dialog>
	</div>
    <script src="<%=basePath%>views/systemModel/systemModel.js"></script>
</body>
</html>