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
	<title>移动数据应用-防控模型</title>
	<link rel="stylesheet" href="<%=basePath%>views/case/case.css">
</head>
<body>
	<jsp:include page="../commonHeader/commonHeader.jsp" flush="false"></jsp:include>
	<div class="content-wrapper" id="case">
		<div class="title">	
			<c:forEach  var="li" items="${sessionScope.permissions}" >
       			<c:if test="${li.moduleId == 5000002}">
       				<div class="newCase">
						<el-row><el-button icon="el-icon-check" @click="handleAllAudit()" style="width: 100%;">批量审批</el-button></el-row>
					</div>
       			</c:if>
       		</c:forEach>
       		
       		
       		
			<div class="newCase">
				<el-row>
					<el-button icon="el-icon-circle-plus-outline" @click="dialogFormVisible = true"
						style="width: 100%;">新建案件</el-button>
				</el-row>
			</div>		
			<div class="search">
				<el-input placeholder="请输入您搜索的内容" id="search_content" v-model="search" class="input-with-select">
					<el-button slot="append" @click="() => {getTableDada()}" icon="el-icon-search"></el-button>
				</el-input>
			</div>
			
			<c:forEach  var="li" items="${sessionScope.permissions}" >
       			<c:if test="${li.moduleId == 5000002}">
       				<div class="newCase">
						<el-form ref="formCheck" :model="formCheck" label-width="80px">
						  <el-form-item label="审批案件">
				    		<el-switch v-model="formCheck.delivery" @change="handleAuditBnt()"></el-switch>
				  		  </el-form-item>
						</el-form>
					</div>
       			</c:if>
       		</c:forEach>
		</div>
		<div class="case">
				<el-table :data="tableData"  @selection-change="handleSelectionChange" stripe v-loading="loading">
				
				<c:forEach  var="li" items="${sessionScope.permissions}" >
       				<c:if test="${li.moduleId == 5000002}">
       					<el-table-column type="selection"  width="55"  :selectable = "selectAble"></el-table-column>
       				</c:if>
       			</c:forEach>
				
				
				<!--<el-table-column label="案件ID"  prop="id"></el-table-column> -->
				<el-table-column label="案件编号" prop="caseNum" show-overflow-tooltip></el-table-column>
				<el-table-column label="案件名称" prop="caseName" show-overflow-tooltip></el-table-column>
				<el-table-column label="案件类型" prop="caseTypeDesc"  show-overflow-tooltip></el-table-column>
				<el-table-column label="案件状态" prop="statusStr"  show-overflow-tooltip></el-table-column>
				<el-table-column label="提交人" prop="userName"  show-overflow-tooltip></el-table-column>
				<el-table-column label="案件描述" prop="caseDesc"  show-overflow-tooltip></el-table-column>
				<el-table-column label="新建案件时间" prop="operationTime" show-overflow-tooltip></el-table-column>
				<el-table-column label="案件失效时间" prop="invalidTime"   show-overflow-tooltip></el-table-column>
				<el-table-column label="审核人" prop="auditUser"   show-overflow-tooltip></el-table-column>
				<el-table-column label="案件审批意见" prop="auditSuggest"   show-overflow-tooltip></el-table-column>
				
				<c:forEach  var="li" items="${sessionScope.permissions}" >
       				<c:if test="${li.moduleId == 5000002}">
       					<el-table-column label="操作">
			    			<template slot-scope="scope"><el-button v-if="scope.row.status == 1"  @click="handleAudit(scope.$index, scope.row)">审批</el-button></template>
			   			</el-table-column>
       				</c:if>
       			</c:forEach>
				
				
			</el-table>
			<el-pagination :total="total" :page-size="pageSize" :current-page.sync="page"
				layout="total, prev, pager, next, jumper" @current-change="getTableDada"></el-pagination>
			<el-dialog width="700px" modal="false" title="新建案件" class="case_dialog" :visible.sync="dialogFormVisible"
				:before-close="handleClose">
				<el-form :model="form" :rules="rules" ref="ruleForm">
					<el-form-item label="案件编号" prop="caseNum" :label-width="formLabelWidth">
						<el-input style="width:468px" v-model.trim="form.caseNum" autocomplete="off"></el-input>
					</el-form-item>
					<el-form-item label="案件名称" prop="caseName" :label-width="formLabelWidth">
						<el-input style="width:468px" v-model.trim="form.caseName" autocomplete="off"></el-input>
					</el-form-item>
					<el-form-item label="案件类型" prop="caseType" :label-width="formLabelWidth">
						<el-select v-model="form.caseType" placeholder="请选择活动区域" style="width:468px">
							<el-option label="一般案件" value="1"></el-option>
							<el-option label="重大案件" value="2"></el-option>
							<el-option label="其他案件" value="3"></el-option>
						</el-select>
					</el-form-item>
					<el-form-item label="案件失效时间" prop="invalidTime" :label-width="formLabelWidth">
						<el-date-picker style="width:468px" v-model="form.invalidTime" type="datetime"
							placeholder="选择日期时间" default-time="12:00:00" :picker-options="casePickerOption">
						</el-date-picker>
					</el-form-item>
					<el-form-item label="案件描述" prop="caseDesc" :label-width="formLabelWidth">
						<el-input type="textarea" style="width:468px" v-model.trim="form.caseDesc"></el-input>
					</el-form-item>
				</el-form>
				<div slot="footer" class="dialog-footer">
					<el-button type="primary" @click="submitForm('ruleForm')">立即创建</el-button>
					<el-button @click="resetForm('ruleForm')">重置</el-button>
				</div>
			</el-dialog>
			<el-dialog title="审核案件"   modal="false" :before-close="handleClose"  :visible.sync="auditCaseDialog">
			  	<el-form :model="auditForm"  :rules="auditRules" ref="ruleAuditForm">
			  	 <el-form-item label="特殊资源"  :label-width="formLabelWidth">
				   <el-radio-group v-model="auditForm.check">
				    <el-radio label="1">通过</el-radio>
  					<el-radio label="2">不通过</el-radio>
				   </el-radio-group>
				 </el-form-item>
			    <el-form-item label="审批意见" prop="suggest" :label-width="formLabelWidth">
			      <el-input type="textarea" v-model="auditForm.suggest"></el-input>
			    </el-form-item>
			  </el-form>
			  <div slot="footer" class="dialog-footer">
			    <el-button @click="closeAuditForm('ruleAuditForm')">取 消</el-button>
			    <el-button type="primary"  @click="submitAuditForm('ruleAuditForm')">确 定</el-button>
			  </div>
			</el-dialog>
		</div>
	</div>
	<script src="<%=basePath%>views/case/case.js" type="text/javascript"></script>
</body>
</html>