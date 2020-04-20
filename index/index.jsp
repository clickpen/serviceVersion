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
    <title>移动数据应用-首页</title>
	    <link rel="stylesheet" href="<%=basePath%>views/index/index.css">
</head>
<body>
 	<jsp:include page="../commonHeader/commonHeader.jsp" flush="true"></jsp:include>
    <div class="content-wrapper" id="indexApp" v-cloak>
		<div class="left-content">
			<div class="user-message">
				<!-- <p class="title"><b>您好，</b>您属于初级会员用户</p> -->
				<div class="user-card">
					<img :src="userInfo.picturePath || headerHolderSrc">
					<p>{{userInfo.userName}}</p>
					<p class="timeless">账号有效期：<span>{{userInfo.endTime}}</span></p>
					<p class="phone">{{userInfo.mobile}}</p>
				</div>
				<div class="judge-card">
					<p class="tit">研判工具使用情况</p>
					<el-progress class="judge-progress" width="90" type="circle" :percentage="judgePercent"></el-progress>
					<!-- <el-progress class="judge-progress" width="90" type="circle" :percentage="25"></el-progress> -->
				</div>
				<div class="preven-card">
					<p class="tit">防控模型使用情况</p>
					<el-progress class="preven-progress" width="90" type="circle" :percentage="focusPeoplePercent"></el-progress>
				</div>
			</div>
			<div class="zdr-message">
				<p class="title">重点人资源情况</p>
				<div class="zdr-card">
					<p class="des" v-for="(ele, inx) in zdrInformation" :key="inx">
						<span class="name">{{ele.userName}}：</span>
						<span class="phone">{{ele.tel}}</span>
						<span class="work">{{ele.role}}</span>
					</p>
				</div>
			</div>
		</div>
		<div class="right-content">
			<div class="top-tips">
				<p :class="{'card': true, 'heart-beat': ele.new}" v-for="(ele, inx) in warnTipsList" @click="() => { handleCancelHeartBeat(inx) }" :key="inx">
					<span class="tit">预警：</span>
					<span class="time">{{ele.warnTime}}</span>
					<span class="name">{{ele.userName}}</span>
					<span class="action">{{ele.reason}}</span>
				</p>
				<p v-if="!warnTipsList.length" class="no-data-holder">暂无新的预警信息</p>
			</div>
			<div class="mid-card">
				<div class="history-stat">
					<b class="tit">历史使用情况</b>
					<el-select size="mini" class="hisroty-dateselect" @change="getHistoryCaseData" v-model="historyDateType">
						<el-option
							label="按月查看"
							:value="1"
						></el-option>
						<el-option
							label="按年查看"
							:value="2"
						></el-option>
					</el-select>
					<div class="history-stat-chart" id="historyStatChart"></div>
				</div>
				<div class="nearly-table">
					<b class="tit">近期案件</b>
					<a href="index?path=case/case" class="more-nearly">查看更多&gt;&gt;</a>
					<el-table
						:data="nearlyTableData"
						v-loading="nearlyTableLoading"
					>
						<el-table-column
							v-for="(ele, inx) in nearlyTableColumn"
							:key="inx"
							:prop="ele.prop"
							:label="ele.label"
							:show-overflow-tooltip="true"
						/>
					</el-table>
					<!-- <el-pagination
						small
						page-size="10"
						layout="prev, pager, next"
						:total="100"
					/> -->
				</div>
			</div>
			<div class="bottom-card">
				<div class="case-stat">
					<b class="tit">案件类型统计</b>
					<div class="case-stat-chart" id="caseStatChart"></div>
				</div>
				<div class="fun-stat webkit-scroll-custom">
					<b class="tit">功能使用情况</b>
					<!-- <div class="fun-stat-chart" id="funStatChart"></div> -->
					<div class="fun-stat-wrapper">
						<p v-for="(ele, inx) in funStatDataList" :key="inx">
							<span>{{ele.type}}</span>
							<span class="num">{{ele.count}}/{{ele.total}}</span>
							<el-progress :percentage="ele.percent" :color="processColorList[inx % 7]" :show-text="false"/>
						</p>
					</div>
				</div>
				<div class="source-stat webkit-scroll-custom">
					<b class="tit">资源累计情况</b>
					<div class="source-stat-wrapper">
						<p v-for="(ele, inx) in sourceStatDataList" :key="inx">
							<span>{{ele.type}}</span>
							<span class="num">{{ele.count}}</span>
							<el-progress :percentage="ele.percent" :color="processColorList[inx % 7]" :show-text="false"/>
						</p>
					</div>
				</div>
			</div>
		</div>
    </div>
    <script src="<%=basePath%>views/index/index.js"></script>
</body>
</html>