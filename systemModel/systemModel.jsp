<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.io.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
	<link rel="stylesheet" href="<%=basePath%>css/zTreeStyle/zTreeStyle.css">
</head>

<body>
	<jsp:include page="../commonHeader/commonHeader.jsp" flush="ture"></jsp:include>
	<div class="system-manage-wrapper" id="systemModel" v-cloak>
		<el-tabs v-model="prevenTab">
			<c:forEach var="li" items="${sessionScope.permissions}" >
				<c:if test="${li.moduleId == 6000001}">
					<el-tab-pane label="用户管理" name="userManage">
						<div class="child-wrapper">
							<el-table :data="usermanageTableData">
								<el-table-column label="用户名" prop="userName" width="100" show-overflow-tooltip>
								</el-table-column>
								<el-table-column label="真实姓名" prop="trueName" width="100" show-overflow-tooltip>
								</el-table-column>
								<el-table-column label="联系方式" prop="mobile" width="130" show-overflow-tooltip></el-table-column>
								<el-table-column label="身份证号码" prop="identifier" show-overflow-tooltip></el-table-column>
								<el-table-column label="ip地址" prop="ip" show-overflow-tooltip></el-table-column>
								<el-table-column label="MAC地址" prop="mac" show-overflow-tooltip></el-table-column>
								<el-table-column label="UKEY信息" prop="ukey" width="220" show-overflow-tooltip></el-table-column>
								<el-table-column label="到期时间" prop="endTime" width="180" show-overflow-tooltip>
								</el-table-column>
								<el-table-column label="生效时间" prop="effectiveTime" width="180" show-overflow-tooltip>
								</el-table-column>
								<el-table-column label="所属角色" prop="roleName" show-overflow-tooltip></el-table-column>
								<el-table-column label="所属角色" prop="roleId" v-if="false"></el-table-column>
								<el-table-column label="操作" width="100" prop="operate">
									<template v-slot="scope">
										<div class="manage-operate-btn">
											<i class="el-icon-edit-outline"
												@click="handleEditRowData(scope.row, 'userManage')"></i>
											<i class="el-icon-delete" @click="handleDeleteRowData(scope.row, 'userManage')"></i>
										</div>
									</template>
								</el-table-column>
							</el-table>
							<el-pagination background :total="userManageTotal" :page-size="pageSize" :current-page.sync="page"
								@current-change="changeTableData" layout="total, prev, pager, next, jumper"></el-pagination>
						</div>
					</el-tab-pane>
				</c:if>
				<c:if test="${li.moduleId == 6000002}">
					<el-tab-pane label="用户组管理" name="userGroupManage">
						<div class="child-wrapper child-map">
							<el-table :data="usergroupmanageTableData">
								<el-table-column label="用户组ID" prop="id"  show-overflow-tooltip>
								</el-table-column>
								<el-table-column label="用户组名" prop="userGroupName" show-overflow-tooltip>
								</el-table-column>
								<el-table-column label="用户组描述" prop="userGroupCity" show-overflow-tooltip>
								</el-table-column>
								<el-table-column label="操作">
									<template v-slot="scope">
										<div class="manage-operate-btn">
											<i class="el-icon-edit-outline"
												@click="handleEditRowData(scope.row, 'userGroupManage')"></i>
											<i class="el-icon-delete" @click="handleDeleteRowData(scope.row, 'userGroupManage')"></i>
										</div>
									</template>
								</el-table-column>
							</el-table>
							<el-pagination background :total="userGroupManageTotal" :page-size="pageSize" :current-page.sync="page"
								@current-change="changeTableData" layout="total, prev, pager, next, jumper"></el-pagination>
						</div>
					</el-tab-pane>
				</c:if>
				<c:if test="${li.moduleId == 6000003}">
					<el-tab-pane label="角色管理" name="roleManage">
						<div class="child-wrapper">
							<el-table :data="rolemanageTableData">
								<el-table-column label="角色ID" prop="roleId" show-overflow-tooltip></el-table-column>
								<el-table-column label="角色名称" prop="roleName" show-overflow-tooltip></el-table-column>
								<el-table-column label="角色描述" prop="roleDesc" show-overflow-tooltip></el-table-column>
								<el-table-column label="操作" prop="operate">
									<template v-slot="scope">
										<div class="manage-operate-btn">
											<i class="el-icon-edit-outline"
												@click="handleEditRowData(scope.row, 'roleManage')"></i>
											<i class="el-icon-delete" @click="handleDeleteRowData(scope.row, 'roleManage')"></i>
										</div>
									</template>
								</el-table-column>
							</el-table>
							<el-pagination background :total="roleManageTotal" :page-size="pageSize" :current-page.sync="page"
								@current-change="changeTableData" layout="total, prev, pager, next, jumper"></el-pagination>
						</div>
					</el-tab-pane>
				</c:if>
				<c:if test="${li.moduleId == 6000004}">
					<el-tab-pane label="系统配置" name="sysConfig">
						<div>
							<el-form class="usermanage-content" ref="sysManageForm" :rules="rules" :model="sysmanageDialogForm"
								label-width="150px">
								<el-form-item label="系统名称：" prop="sysName">
									<el-input size="mini" placeholder="系统名称" v-model="sysmanageDialogForm.sysName"></el-input>
								</el-form-item>
								<el-form-item label="系统提示：" prop="sysTips">
									<el-input size="mini" placeholder="系统提示" v-model="sysmanageDialogForm.sysTips"></el-input>
								</el-form-item>
								<el-form-item label="最大查询天数：" prop="sysMaxQueryDays">
									<el-input size="mini" placeholder="请输入密码" v-model="sysmanageDialogForm.sysMaxQueryDays">
									</el-input>
								</el-form-item>
								<el-form-item label="白天开始时间：" prop="sysDayTimeMin">
									<el-input size="mini" placeholder="白天开始时间" v-model="sysmanageDialogForm.sysDayTimeMin">
									</el-input>
								</el-form-item>
								<el-form-item label="白天结束时间：" prop="sysDayTimeMax">
									<el-input size="mini" placeholder="白天结束时间" v-model="sysmanageDialogForm.sysDayTimeMax">
									</el-input>
								</el-form-item>
								<el-form-item label="夜晚开始时间：" prop="sysNightTimeMin">
									<el-input size="mini" placeholder="夜晚开始时间" v-model="sysmanageDialogForm.sysNightTimeMin">
									</el-input>
								</el-form-item>
								<el-form-item label="夜晚结束时间：" prop="sysNightTimeMax">
									<el-input size="mini" placeholder="夜晚结束时间" v-model="sysmanageDialogForm.sysNightTimeMax">
									</el-input>
								</el-form-item>
								<el-form-item label="地图最小层级：" prop="sysMapMin">
									<el-input size="mini" placeholder="地图最小层级" v-model="sysmanageDialogForm.sysMapMin">
									</el-input>
								</el-form-item>
								<el-form-item label="地图最大层级：" prop="sysMapMax">
									<el-input size="mini" placeholder="地图最大层级" v-model="sysmanageDialogForm.sysDayTimeMax">
									</el-input>
								</el-form-item>
							</el-form>
							<span slot="footer">
								<el-button type="primary" style="margin-left:40px;" @click="submitForm('sysManageForm')">修改
								</el-button>
							</span>
						</div>
					</el-tab-pane>
				</c:if>
				<c:if test="${li.moduleId == 6000005}">
					<el-tab-pane label="配置管理" name="sysConfigManage">
						<div class="content-wrapper" id="identityConfig">
							<div class="config">
								<el-table :data="rulemanageTableData" stripe v-loading="loading">
									<el-table-column label="虚拟身份名称" prop="name" width="200" show-overflow-tooltip>
									</el-table-column>
									<el-table-column label="虚拟身份图片" prop="picturepath" show-overflow-tooltip>
										<template scope="scope">
											<img :src="'/jetk/picture/'+scope.row.picturepath" width="40" height="40" />
										</template>
									</el-table-column>
									<el-table-column label="类型" :formatter="formatterType" show-overflow-tooltip>
									</el-table-column>
									<el-table-column fixed="right" label="操作" width="200">
										<template slot-scope="scope">
											<el-button type="text" @click="() => {selectSonConfig(scope.row)}" size="small">配置
											</el-button>
											<el-button type="text" @click="() => {editIdentityConfig(scope.row)}" size="small">
												编辑</el-button>
											<el-button type="text" @click="() => {handleDeleteRowData(scope.row)}" size="small">
												删除</el-button>
										</template>
									</el-table-column>
								</el-table>
								<el-pagination :total="rulemanageTotal" :page-size="pageSize" :current-page.sync="page"
									@current-change="changeTableData" layout="total, prev, pager, next, jumper"></el-pagination>
								<el-dialog width="700px" modal="false" class="identityConfig_dialog"
									:visible.sync="dialogFormVisible" :before-close="() => { dialogFormVisible = false }">
									<div slot="title" class="head-dialog">
										新增虚拟身份规则
									</div>
									<el-form :model="configEditForm" :inline="true" :rules="rules" ref="ruleForm">
										<el-form-item label="虚拟身份名称" prop="name" :label-width="formLabelWidth">
											<el-input style="width:150px" v-model.trim="configEditForm.name" autocomplete="off">
											</el-input>
										</el-form-item>
										<el-form-item label="虚拟身份匹配规则" prop="role" :label-width="formLabelWidth">
											<el-input style="width:150px" v-model.trim="configEditForm.role" autocomplete="off">
											</el-input>
										</el-form-item>
										<el-form-item label="虚拟身份提取规则" prop="virgetrule" :label-width="formLabelWidth">
											<el-input style="width:150px" v-model.trim="configEditForm.virgetrule"
												autocomplete="off"></el-input>
										</el-form-item>
										<el-form-item label="最大长度" prop="maxLength" :label-width="formLabelWidth">
											<el-input style="width:150px" v-model.trim="configEditForm.maxLength"
												autocomplete="off"></el-input>
										</el-form-item>
										<el-form-item label="最短长度" prop="minLength" :label-width="formLabelWidth">
											<el-input style="width:150px" v-model.trim="configEditForm.minLength"
												autocomplete="off"></el-input>
										</el-form-item>
										<el-form-item label="所属类型" prop="type" :label-width="formLabelWidth">
											<el-select v-model="configEditForm.type" placeholder="选择所属类型" style="width:150px">
												<el-option label="信令" value="0"></el-option>
												<el-option label="互联网ID" value="1"></el-option>
												<el-option label="虚拟身份" value="2"></el-option>
											</el-select>
										</el-form-item>
										<el-form-item label="异常值" prop="exceptionvalue" :label-width="formLabelWidth">
											<el-input style="width:150px" v-model.trim="configEditForm.exceptionvalue"
												autocomplete="off"></el-input>
										</el-form-item>
										<el-form-item label="异常符号" prop="exceptionsign" :label-width="formLabelWidth">
											<el-input style="width:150px" v-model.trim="configEditForm.exceptionsign"
												autocomplete="off"></el-input>
										</el-form-item>
										<el-form-item label="必含符号" prop="includesign" :label-width="formLabelWidth">
											<el-input style="width:150px" v-model.trim="configEditForm.includesign"
												autocomplete="off"></el-input>
										</el-form-item>
										<el-form-item label="关键词" prop="words" :label-width="formLabelWidth">
											<el-input style="width:150px" v-model.trim="configEditForm.words"
												autocomplete="off"></el-input>
										</el-form-item>
										<el-form-item label="选择图片" prop="picturepath" :label-width="formPictureWidth">
											<el-row style="width: 300px">
												<el-col :span="12">
													<el-dropdown trigger="click" @command="handleSelect">
														<span class="el-dropdown-link">
															下拉菜单
															<i class="el-icon-arrow-down"></i>
														</span>
														<el-dropdown-menu slot="dropdown" class="img-select">
															<el-dropdown-item v-for="(ele,inx) in pictureArr" :key="inx"
																class="img-list" :command="ele">
																<img :src="ele">
															</el-dropdown-item>
														</el-dropdown-menu>
													</el-dropdown>
												</el-col>
												<el-col :span="12">
													<el-upload class="avatar-uploader" action="/jetk/identityConfig/uploadImage"
														:show-file-list="false" :on-success="handleAvatarSuccess"
														:before-upload="beforeAvatarUpload">
														<img v-if="fileList.src" :src="fileList.src" class="avatar">
														<i v-else class="el-icon-plus picture-hd-holder"></i>
														<span class="picture-hd-des">(添加图标)</span>
													</el-upload>
												</el-col>
											</el-row>
										</el-form-item>
									</el-form>
									<div slot="footer" class="dialog-footer">
										<el-button type="primary" @click="submitForm('ruleForm')">确认添加</el-button>
										<el-button @click="resetForm('ruleForm')">重置</el-button>
									</div>
								</el-dialog>
								<el-dialog :visible="modifyDialogShow" width="650px" title="修改虚拟身份"
									:before-close="() => {modifyDialogShow = false}">
									<div class="identity-dialog-wrapper">
										<el-form class="identity-content" ref="identityEditForm" :model="configUpdateForm"
											label-width="80px">
											<el-form-item label="虚拟身份名称" prop="name">
												<el-input placeholder="虚拟身份名称" v-model="configUpdateForm.name"></el-input>
											</el-form-item>
											<el-form-item label="所属类型" prop="type" :label-width="formLabelWidth">
												<el-select v-model="configUpdateForm.type" placeholder="选择所属类型"
													style="width:150px">
													<el-option label="信令" value="0"></el-option>
													<el-option label="互联网ID" value="1"></el-option>
													<el-option label="虚拟身份" value="2"></el-option>
												</el-select>
											</el-form-item>
											<el-form-item label="关键词" prop="words" :label-width="formLabelWidth">
												<el-input style="width:150px" v-model.trim="configUpdateForm.words"
													autocomplete="off"></el-input>
											</el-form-item>
											<el-form-item label="选择图片" prop="picturepath" :label-width="formPictureWidth">
												<el-row style="width: 300px">
													<el-col :span="12">
														<el-dropdown trigger="click" @command="handleSelect">
															<span class="el-dropdown-link">
																下拉菜单
																<i class="el-icon-arrow-down"></i>
															</span>
															<el-dropdown-menu slot="dropdown" class="img-select">
																<el-dropdown-item v-for="(ele,inx) in pictureArr" :key="inx"
																	class="img-list" :command="ele">
																	<img :src="ele">
																</el-dropdown-item>
															</el-dropdown-menu>
														</el-dropdown>
													</el-col>
													<el-col :span="12">
														<el-upload class="avatar-uploader"
															action="/jetk/identityConfig/uploadImage" :show-file-list="false"
															:on-success="handleAvatarSuccess"
															:before-upload="beforeAvatarUpload">
															<img v-if="configUpdateForm.picturepath"
																:src="'/jetk/picture/'+configUpdateForm.picturepath"
																class="avatar">
															<i v-else class="el-icon-plus picture-hd-holder"></i>
															<span class="picture-hd-des">(添加图标)</span>
														</el-upload>
													</el-col>
												</el-row>
											</el-form-item>
										</el-form>
									</div>
									<span slot="footer">
										<el-button type="primary" @click="() => {submitEditForm('identityEditForm')}">确定
										</el-button>
										<el-button @click="() => {modifyDialogShow = false}">取消</el-button>
									</span>
								</el-dialog>
								<el-dialog width="1200px" modal="false" class="identityConfig_dialog"
									:visible.sync="dialogTableVisible" :before-close="() => {dialogTableVisible = false}">
									<div slot="title" class="head-dialog">
										虚拟身份规则配置
									</div>
									<div class="new_config">
										<el-row>
											<el-button icon="el-icon-circle-plus-outline" size="mini"
												@click="() => {addIdentityConfigSon()}" style="width: 100px;">新增规则</el-button>
										</el-row>
									</div>
									<el-table :data="gridData">
										<el-table-column show-overflow-tooltip property="role" label="匹配规则" width="150">
										</el-table-column>
										<el-table-column show-overflow-tooltip property="virgetrule" label="提取规则" width="150">
										</el-table-column>
										<el-table-column show-overflow-tooltip property="exceptionvalue" label="异常值"
											width="150"></el-table-column>
										<el-table-column show-overflow-tooltip property="exceptionsign" label="异常符号"
											width="150"></el-table-column>
										<el-table-column show-overflow-tooltip property="includesign" label="必含符号" width="150">
										</el-table-column>
										<el-table-column show-overflow-tooltip property="minLength" label="最短匹配长度" width="150">
										</el-table-column>
										<el-table-column show-overflow-tooltip property="maxLength" label="最长匹配长度" width="150">
										</el-table-column>
										<el-table-column label="操作" width="100">
											<template slot-scope="scope">
												<el-button type="text" @click="() => {updateIdentityConfigSon(scope.row)}"
													size="small">编辑</el-button>
												<el-button type="text" @click="() => {handleDeleteSonData(scope.row.id)}"
													size="small">删除</el-button>
											</template>
										</el-table-column>
									</el-table>
									<el-pagination :total="gridTotal" :page-size="gridPageSize" :current-page.sync="gridPage"
										layout="total, prev, pager, next, jumper" @current-change="getIdentityConfigData">
									</el-pagination>
								</el-dialog>
								<el-dialog :visible="modifyDialogSonShow" width="650px" :title="sonFormTitle"
									:before-close="() => {modifyDialogSonShow = false}">
									<div class="identity-dialog-wrapper">
										<el-form class="identity-content" ref="identitySonEditForm" :model="configSonForm"
											label-width="130px">
											<el-form-item label="匹配规则" prop="role">
												<el-input placeholder="匹配规则" v-model="configSonForm.role"></el-input>
											</el-form-item>
											<el-form-item label="提取规则" prop="virgetrole">
												<el-input placeholder="提取规则" v-model="configSonForm.virgetrule"></el-input>
											</el-form-item>
											<el-form-item label="异常值" prop="exceptionvalue">
												<el-input placeholder="异常值" v-model="configSonForm.exceptionvalue"></el-input>
											</el-form-item>
											<el-form-item label="异常符号" prop="exceptionsign">
												<el-input placeholder="异常符号" v-model="configSonForm.exceptionsign"></el-input>
											</el-form-item>
											<el-form-item label="必含符号" prop="includesign">
												<el-input placeholder="必含符号" v-model="configSonForm.includesign"></el-input>
											</el-form-item>
											<el-form-item label="最长匹配长度" prop="maxLength">
												<el-input placeholder="最长匹配长度" v-model="configSonForm.maxLength"></el-input>
											</el-form-item>
											<el-form-item label="最短匹配长度" prop="minLength">
												<el-input placeholder="最短匹配长度" v-model="configSonForm.minLength"></el-input>
											</el-form-item>
										</el-form>
									</div>
									<span slot="footer">
										<el-button type="primary" @click="() => {submitSonForm('identitySonEditForm')}">确定
										</el-button>
										<el-button @click="() => {modifyDialogSonShow = false}">取消</el-button>
									</span>
								</el-dialog>
							</div>
						</div>
					</el-tab-pane>
				</c:if>
			</c:forEach>
		</el-tabs>
		<div class="child-table-search" v-if="prevenTab == 'userManage'">
			<el-input size="mini" class="search-input" v-model="search" id="userSearch" placeholder="输入您想要搜索的内容">
				<el-button slot="append" icon="el-icon-search" @click="() => {changeTableData()}"></el-button>
			</el-input>
			<el-button size="mini" class="el-icon-circle-plus-outline" @click="handleAddRowData('userManage')">新增用户
			</el-button>
		</div>
		<div class="child-table-search" v-if="prevenTab == 'userGroupManage'">
			<el-input size="mini" class="search-input" v-model="search" id="userGroupSearch" placeholder="输入您想要搜索的内容">
				<el-button slot="append" icon="el-icon-search" @click="() => {changeTableData()}"></el-button>
			</el-input>
			<el-button size="mini" class="el-icon-circle-plus-outline" @click="handleAddRowData('userGroupManage')">新增用户组
			</el-button>
		</div>
		<div class="child-table-search" v-if="prevenTab == 'roleManage'">
			<el-input size="mini" class="search-input" v-model="search" id="roleSearch" placeholder="输入您想要搜索的内容">
				<el-button slot="append" icon="el-icon-search" @click="() => {changeTableData()}"></el-button>
			</el-input>
			<el-button size="mini" class="el-icon-circle-plus-outline" @click="handleAddRowData('roleManage')">新增角色
			</el-button>
		</div>
		<div class="child-table-search" v-if="prevenTab == 'sysConfigManage'">
			<el-input size="mini" class="search-input" v-model="search" id="ruleSearch" placeholder="输入您想要搜索的内容">
				<el-button slot="append" icon="el-icon-search" @click="() => {changeTableData()}"></el-button>
			</el-input>
			<el-button size="mini" class="el-icon-circle-plus-outline" @click="dialogFormVisible = true">新增虚拟身份
			</el-button>
		</div>
		<el-dialog :visible="usermanageDialogShow" width="650px;height:700px;" :title="addUserDialogTitle"
			:before-close="() => {usermanageDialogShow = false}">
			<div class="usermanage-dialog-wrapper">
				<el-upload class="usermanage-hd" action="/jetk/identityConfig/uploadImage" :show-file-list="false"
					:before-upload="beforeAvatarUpload" :on-success="handleUploadFile">
					<img v-if="usermanageDialogForm.picturePath" style="width:50px;height:50px;"
						:src="'/jetk/picture/'+usermanageDialogForm.picturePath">
					<i v-else class="el-icon-plus usermanage-hd-holder"></i>
					<span class="usermanage-hd-des" id="usermanage-head-picture" v-html="addUserPicMsg"></span>
				</el-upload>
				<el-form class="usermanage-content" ref="userManageForm" :rules="rules" :model="usermanageDialogForm"
					label-width="130px">
					<el-form-item label="用户账号：" v-show="showUserId" prop="userId">
						<el-input size="mini" placeholder="用户ID" v-model="usermanageDialogForm.userId"></el-input>
					</el-form-item>
					<el-form-item label="用户账号：" prop="userName">
						<el-input size="mini" placeholder="请输入姓名" v-model="usermanageDialogForm.userName"></el-input>
					</el-form-item>
					<el-form-item label="用户密码：" prop="userPass">
						<el-input size="mini" type="password" placeholder="请输入密码"
							v-model="usermanageDialogForm.userPass"></el-input>
					</el-form-item>
					<el-form-item label="确认密码：" prop="askUserPass">
						<el-input size="mini" type="password" placeholder="请输入确认密码"
							v-model="usermanageDialogForm.askUserPass"></el-input>
					</el-form-item>
					<el-form-item label="真实姓名：" prop="trueName">
						<el-input size="mini" placeholder="请输入真实姓名" v-model="usermanageDialogForm.trueName"></el-input>
					</el-form-item>
					<el-form-item label="联系方式：" prop="mobile">
						<el-input size="mini" placeholder="请输入联系方式" v-model="usermanageDialogForm.mobile"></el-input>
					</el-form-item>
					<el-form-item label="身份证号码：" prop="identifier">
						<el-input size="mini" placeholder="请输入身份证号" v-model="usermanageDialogForm.identifier">
						</el-input>
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
					<el-form-item label="有效期：" prop="endTime">
						<el-date-picker type="datetime" size="mini" placeholder="请选择有效期"
							v-model="usermanageDialogForm.endTime"></el-date-picker>
					</el-form-item>
					<el-form-item label="生效时间：" prop="effectiveTime">
						<el-date-picker type="datetime" size="mini" placeholder="请选择有效期"
							v-model="usermanageDialogForm.effectiveTime"></el-date-picker>
					</el-form-item>
					<el-form-item label="所属角色：">
						<el-select size="mini" v-model="usermanageDialogForm.roleId" prop="roleId" placeholder="请选择角色">
							<el-option v-for="item in rolemanageTableData" :key="item.roleId" :label="item.roleName"
								:value="item.roleId"> </el-option>
						</el-select>
					</el-form-item>
					<el-form-item label="每日任务限制数：" prop="tasknum">
						<el-input size="mini" placeholder="请输入每日任务限制数" v-model="usermanageDialogForm.tasknum"></el-input>
					</el-form-item>
					<el-form-item label="每月任务限制数：" prop="taskMonthNum">
						<el-input size="mini" placeholder="请输入每月任务限制数" v-model="usermanageDialogForm.taskMonthNum"></el-input>
					</el-form-item>
					<el-form-item label="每年任务限制数：" prop="taskYearNum">
						<el-input size="mini" placeholder="请输入每年任务限制数" v-model="usermanageDialogForm.taskYearNum"></el-input>
					</el-form-item>
					<el-form-item label="研判工具并发数：" prop="taskExeNum">
						<el-input size="mini" placeholder="请输入研判工具并发数" v-model="usermanageDialogForm.taskExeNum"></el-input>
					</el-form-item>
					<el-form-item label="轨迹分析并发数：" prop="focuspeopleNum">
						<el-input size="mini" placeholder="请输入轨迹分析并发数" v-model="usermanageDialogForm.focuspeopleNum	"></el-input>
					</el-form-item>
				</el-form>
			</div>
			<span slot="footer">
				<el-button type="primary" @click="submitForm('userManageForm')">确定</el-button>
				<el-button @click="resetForm('userManageForm')">重置</el-button>
				<el-button @click="() => {usermanageDialogShow = false}">取消</el-button>
			</span>
		</el-dialog>
		
		<el-dialog :visible="usergroupmanageDialogShow" width="650px;height:700px;" :title="addUserGroupDialogTitle"
			:before-close="() => {usergroupmanageDialogShow = false}">
			<div class="usermanage-dialog-wrapper">
				<el-form class="usermanage-content" ref="userGroupManageForm" :rules="rules" :model="usergroupmanageDialogForm"
					label-width="100px">
					<el-form-item label="id：" v-show="showUserId" >
						<el-input size="mini" placeholder="用户组ID" v-model="usergroupmanageDialogForm.id"></el-input>
					</el-form-item>
					<el-form-item label="用户组名：" prop="userGroupName">
						<el-input size="mini" placeholder="请输入姓名" v-model="usergroupmanageDialogForm.userGroupName"></el-input>
					</el-form-item>
					<el-form-item label="用户组城市：" prop="userGroupCity">
						<el-input size="mini"  placeholder="用户组城市" v-model="usergroupmanageDialogForm.userGroupCity"></el-input>
					</el-form-item>
					
					<el-form-item label="用户：">
						<el-select size="mini" multiple v-model="usergroupmanageDialogForm.userIds"  placeholder="请选择用户">
							<el-option v-for="item in usermanageTableData" :key="item.userId" :label="item.userName"
								:value="item.userId"></el-option>
						</el-select>
					</el-form-item>
				</el-form>
			</div>
			<span slot="footer">
				<el-button type="primary" @click="submitForm('userGroupManageForm')">确定</el-button>
				<el-button @click="resetForm('userGroupManageForm')">重置</el-button>
				<el-button @click="() => {usergroupmanageDialogShow = false}">取消</el-button>
			</span>
		</el-dialog>

		<el-dialog :visible="rolemanageDialogShow" width="650px;height:700px;" :title="addRoleDialogTitle"
			:before-close="() => {rolemanageDialogShow = false}">
			<div class="usermanage-dialog-wrapper">
				<el-form class="usermanage-content" ref="roleManageForm" :rules="rules" :model="rolemanageDialogForm"
					label-width="100px">
					<el-form-item label="角色名：" prop="roleName">
						<el-input size="mini" placeholder="角色名称" v-model="rolemanageDialogForm.roleName"></el-input>
					</el-form-item>
					<el-form-item label="角色描述：" prop="roleDesc">
						<el-input size="mini" placeholder="角色描述" v-model="rolemanageDialogForm.roleDesc"></el-input>
					</el-form-item>
					<el-form-item label="权限列表：" prop="properties">
						<div class="zTreeDemoBackground left">
							<ul id="treeDemo" class="ztree"></ul>
						</div>
					</el-form-item>
				</el-form>
			</div>
			<span slot="footer">
				<el-button type="primary" @click="submitForm('roleManageForm')">确定</el-button>
				<el-button @click="resetForm('roleManageForm')">重置</el-button>
				<el-button @click="() => {rolemanageDialogShow = false}">取消</el-button>
			</span>
		</el-dialog>
	</div>
	<script src="<%=basePath%>js/zTree/jquery.ztree.core.js"></script>
	<script src="<%=basePath%>js/zTree/jquery.ztree.excheck.js"></script>
	<script src="<%=basePath%>views/systemModel/systemModel.js"></script>
</body>

</html>