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
    <title>移动数据应用-首页</title>
	    <link rel="stylesheet" href="<%=basePath%>views/index/index.css">
</head>
<body>
 	<jsp:include page="../commonHeader/commonHeader.jsp" flush="true"></jsp:include>
    <div class="content-wrapper" id="indexApp">
		<div class="left-content">
			<div class="user-message">
				<p class="title"><b>您好，</b>您属于初级会员用户</p>
				<div class="user-card">
					<img src="http://pic1.zhimg.com/v2-823ed707923542746602f489a1527a81_fhd.jpg">
					<p>admin</p>
					<p class="timeless">账号有效期：<span>2020-02-17</span></p>
					<p class="phone">13369912541</p>
				</div>
				<div class="judge-card">
					<p class="tit">研判工具使用情况</p>
					<el-progress class="judge-progress" width="90" type="circle" :percentage="25"></el-progress>
					<el-progress class="judge-progress" width="90" type="circle" :percentage="25"></el-progress>
				</div>
				<div class="preven-card">
					<p class="tit">防控模型使用情况</p>
					<el-progress class="preven-progress" width="90" type="circle" :percentage="25"></el-progress>
				</div>
			</div>
			<div class="zdr-message">
				<p class="title">重点人资源情况</p>
				<div class="zdr-card">
					<p class="des">
						<span class="name">张三：</span>
						<span class="phone">13888888888</span>
						<span class="work">运维</span>
					</p>
					<p class="des">
						<span class="name">李四：</span>
						<span class="phone">13888888889</span>
						<span class="work">负责人</span>
					</p>
				</div>
			</div>
		</div>
		<div class="right-content">
			<div class="top-tips">
				<p class="card">
					<span class="tit">预警：</span>
					<span class="time">2019-01-01 12:00:12</span>
					<span class="name">张茂盛</span>
					<span class="action">离开北京轨迹预警</span>
				</p>
				<p class="card">
					<span class="tit">预警：</span>
					<span class="time">2019-01-01 12:00:12</span>
					<span class="name">张茂盛</span>
					<span class="action">离开北京轨迹预警</span>
				</p>
				<p class="card">
					<span class="tit">预警：</span>
					<span class="time">2019-01-01 12:00:12</span>
					<span class="name">张茂盛</span>
					<span class="action">离开北京轨迹预警</span>
				</p>
			</div>
			<div class="mid-card">
				<div class="history-stat">
					<b class="tit">历史使用情况</b>
					<el-date-picker class="hisroty-dateselect" v-model="historyDate" type="date" placeholder="请选择日期"></el-date-picker>
					<div class="history-stat-chart" id="historyStatChart"></div>
				</div>
				<div class="nearly-table">
					<b class="tit">近期案件</b>
					<a href="#" class="more-nearly">查看更多&gt;&gt;</a>
					<el-table
						:data="nearlyTableData"
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
				<div class="fun-stat">
					<b class="tit">功能使用情况</b>
					<div class="fun-stat-chart" id="funStatChart"></div>
				</div>
				<div class="source-stat">
					<b class="tit">资源累积情况</b>
					<div class="source-stat-wrapper">
						<p>
							<span>手机</span>
							<span class="num">1058</span>
							<el-progress :percentage="57" :color="'#ffb73a'" :show-text="false"/>
						</p>
						<p>
							<span>MAC</span>
							<span class="num">726</span>
							<el-progress :percentage="20" :color="'#eb4549'" :show-text="false"/>
						</p>
						<p>
							<span>IMEI</span>
							<span class="num">1417</span>
							<el-progress :percentage="50" :color="'#25d1d7'" :show-text="false"/>
						</p>
						<p>
							<span>QQ</span>
							<span class="num">726</span>
							<el-progress :percentage="25" :color="'#f152eb'" :show-text="false"/>
						</p>
						<p>
							<span>微信</span>
							<span class="num">1417</span>
							<el-progress :percentage="40" :color="'#fe69b3'" :show-text="false"/>
						</p>
						<p>
							<span>其他</span>
							<span class="num">1417</span>
							<el-progress :percentage="65" :color="'#3aee8a'" :show-text="false"/>
						</p>
					</div>
				</div>
			</div>
		</div>
    </div>
    <script src="<%=basePath%>views/index/index.js"></script>
</body>
</html>