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
	<link rel="stylesheet" href="<%=basePath%>views/prevenModel/prevenModel.css">
	<!-- baidu地图鼠标绘制 -->
	<link rel="stylesheet" href="http://api.map.baidu.com/library/DrawingManager/1.4/src/DrawingManager_min.css">
</head>
<body>
    <jsp:include page="../commonHeader/commonHeader.jsp" flush="ture"></jsp:include>
    <div class="content-wrapper" id="prevenModel" v-cloak>
		<el-tabs v-model="prevenTab">
			<el-tab-pane label="防控首页" name="prevenIndex">
				<div class="child-wrapper child-map">
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
			</el-tab-pane>
			<el-tab-pane label="重点人管理" name="prevenZdr">
				<div class="child-wrapper">
					<el-table
						:data="zdrTableData"
						stripe
					>
						<el-table-column
							label="头像"
							prop="headUrl"
						>
							<template v-slot="scope">
								<img class="zdr-header" :src="scope.row.headUrl">
							</template>
						</el-table-column>
						<el-table-column
							label="姓名"
							prop="name"
							show-overflow-tooltip
						></el-table-column>
						<el-table-column
							label="手机号"
							prop="phone"
							show-overflow-tooltip
						></el-table-column>
						<el-table-column
							label="管控级别"
							prop="level"
						>
							<template v-slot="scope">
								<b :style="'color:' + (scope.row.level == '一级' ? '#eb3323' : scope.row.level == '二级' ? '#f19a38' : '#2c20f5')">{{scope.row.level}}</b>
							</template>
						</el-table-column>
						<el-table-column
							label="身份证号码"
							prop="idCard"
							show-overflow-tooltip
						></el-table-column>
						<el-table-column
							label="责任单位"
							prop="unit"
							show-overflow-tooltip
						></el-table-column>
						<el-table-column
							label="责任人"
							prop="person"
							show-overflow-tooltip
						></el-table-column>
						<el-table-column
							label="监控状态"
							prop="status"
						>
							<template v-slot="scope">
								<b class="zdr-green">{{scope.row.status}}</b>
							</template>
						</el-table-column>
						<el-table-column
							label="操作"
							prop="operate"
							width="100"
						>
							<template v-slot="scope">
								<div class="zdr-operate-btn">
									<i class="el-icon-edit-outline" @click="() => {zdrDialogShow = true}"></i>
									<i class="el-icon-delete" @click="handleDeleteRowData(scope.row, 'zdr')"></i>
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
			<el-tab-pane label="预警管理" name="prevenWarn">
				<div class="child-wrapper">
					<el-table
						:data="warnTableData"
						stripe
					>
						<el-table-column
							label="预警名称"
							prop="name"
							show-overflow-tooltip
						></el-table-column>
						<el-table-column
							label="预警动作"
							prop="action"
							show-overflow-tooltip
						></el-table-column>
						<el-table-column
							label="预警音效"
							prop="audio"
						>
							<template v-slot="scope">
								<b :style="'color:' + (scope.row.audio == '禁止' ? '#eb3323' : '#2c20f5')">{{scope.row.audio}}</b>
							</template>
						</el-table-column>
						<el-table-column
							label="预警区域"
							prop="area"
						>
							<template v-slot="scope">
								<a class="warn-area" href="#">查看区域</a>
							</template>
						</el-table-column>
						<el-table-column
							label="提交时间"
							prop="time"
							show-overflow-tooltip
						></el-table-column>
						<el-table-column
							label="提交人"
							prop="person"
							show-overflow-tooltip
						></el-table-column>
						<el-table-column
							label="操作"
							prop="operate"
							width="100"
						>
							<template v-slot="scope">
								<div class="zdr-operate-btn">
									<i class="el-icon-edit-outline" @click="() => {warnDialogShow = true}"></i>
									<i class="el-icon-delete" @click="handleDeleteRowData(scope.row, 'warn')"></i>
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
		<div class="child-table-search" v-if="prevenTab == 'prevenZdr'">
			<el-input size="mini" class="search-input" placeholder="输入您想要搜索的内容">
				<el-button slot="append" icon="el-icon-search"></el-button>
			</el-input>
			<el-button size="mini" class="el-icon-circle-plus-outline">新增重点人</el-button>
			<el-button size="mini" class="el-icon-receiving">批量导入</el-button>
		</div>
		<div class="child-table-search" v-if="prevenTab == 'prevenWarn'">
			<el-input size="mini" class="search-input" placeholder="输入您想要搜索的内容">
				<el-button slot="append" icon="el-icon-search"></el-button>
			</el-input>
			<el-button size="mini" class="el-icon-circle-plus-outline">新增预警策略</el-button>
		</div>
		<el-dialog
			:visible="zdrDialogShow"
			width="650px"
			title="新增预警策略"
			:before-close="() => {zdrDialogShow = false}"
		>
			<div class="zdr-dialog-wrapper">
				<el-upload
					class="zdr-hd"
					action="https://jsonplaceholder.typicode.com/posts/"
					:show-file-list="false"
					:on-success="handleUploadFile"
				>
					<img v-if="zdrDialogForm.hdUrl" :src="zdrDialogForm.hdUrl">
					<i v-else class="el-icon-plus zdr-hd-holder"></i>
					<span class="zdr-hd-des">(添加头像)</span>
				</el-upload>
				<el-form class="zdr-content" ref="zdrForm" :model="zdrDialogForm" label-width="100px">
					<el-form-item label="姓名：" prop="name">
						<el-input size="mini" placeholder="请输入姓名" v-model="zdrDialogForm.name"></el-input>
					</el-form-item>
					<el-form-item label="手机号码：" prop="phone">
						<el-input size="mini" placeholder="请输入姓名" v-model="zdrDialogForm.phone"></el-input>
					</el-form-item>
					<el-form-item label="管控级别：" prop="level">
						<el-select v-model="zdrDialogForm.level" size="mini">
							<el-option
								label="一级管控"
								value="1"
							></el-option>
							<el-option
								label="二级管控"
								value="2"
							></el-option>
							<el-option
								label="三级管控"
								value="3"
							></el-option>
						</el-select>
					</el-form-item>
					<el-form-item label="身份证号：" prop="idCard">
						<el-input size="mini" placeholder="请输入姓名" v-model="zdrDialogForm.idCard"></el-input>
					</el-form-item>
					<el-form-item label="责任单位：" prop="unit">
						<el-input size="mini" placeholder="请输入姓名" v-model="zdrDialogForm.unit"></el-input>
					</el-form-item>
					<el-form-item label="责任人：" prop="person">
						<el-input size="mini" placeholder="请输入姓名" v-model="zdrDialogForm.person"></el-input>
					</el-form-item>
				</el-form>
			</div>
			<span slot="footer">
				<el-button type="primary" @click="() => {zdrDialogShow = false}">确定</el-button>
				<el-button @click="() => {zdrDialogShow = false}">取消</el-button>
			</span>
		</el-dialog>
		<el-dialog
			:visible="warnDialogShow"
			width="650px"
			title="新增预警策略"
			:before-close="() => {warnDialogShow = false}"
		>
			<el-form class="warn-content" ref="warnForm" :model="warnDialogForm" label-width="100px">
				<el-form-item label="策略名称：" prop="name">
					<el-input size="mini" v-model="warnDialogForm.name"></el-input>
				</el-form-item>
				<el-form-item label="预警动作：" prop="action">
					<el-select v-model="warnDialogForm.action" size="mini" placeholder="请选择动作">
						<el-option
							label="动作1"
							value="1"
						></el-option>
						<el-option
							label="动作2"
							value="2"
						></el-option>
						<el-option
							label="动作3"
							value="3"
						></el-option>
					</el-select>
				</el-form-item>
				<el-form-item label="预警区域：" prop="area">
					<el-input size="mini" class="area-input" v-model="warnDialogForm.area" placeholder="地图数据" disabled></el-input>
					<el-button @click="() => { areaSelectShow = true }">选取范围</el-button>
					<el-dialog
						:visible="areaSelectShow"
						width="900px"
						title="区域选择"
						:before-close="() => {areaSelectShow = false}"
						append-to-body
					>
						<span slot="footer">
							<el-button type="primary" @click="() => {areaSelectShow = false}">确定</el-button>
							<el-button @click="() => {areaSelectShow = false}">取消</el-button>
						</span>
					</el-dialog>
				</el-form-item>
				<el-form-item label="预警音效：" prop="name">
					<el-switch
						v-model="warnDialogForm.switch"
						active-text="开"
						inactive-text="关"
					></el-switch>
				</el-form-item>
			</el-form>
			<span slot="footer">
				<el-button type="primary" @click="() => {warnDialogShow = false}">确定</el-button>
				<el-button @click="() => {warnDialogShow = false}">取消</el-button>
			</span>
		</el-dialog>
	</div>
	<!-- 百度地图鼠标绘制 -->
	<script type="text/javascript" src="http://api.map.baidu.com/library/DrawingManager/1.4/src/DrawingManager_min.js"></script>
    <script src="<%=basePath%>views/prevenModel/prevenModel.js"></script>
</body>
</html>