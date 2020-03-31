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
    <link rel="stylesheet" href="<%=basePath%>css/element-ui-2.12.0.css">
    <link rel="stylesheet" href="<%=basePath%>views/commonHeader/commonHeader.css">
    <link rel="stylesheet" href="<%=basePath%>views/case/case.css">
</head>
<body>
    <jsp:include page="../head/head.jsp" flush="false"></jsp:include>
    <div class="content-wrapper" id = "case">  
    	<div class="title" >
    	<div class= "newCase">
			  <el-row>
				  <el-button icon="el-icon-circle-plus-outline"  @click="dialogFormVisible = true" style="width: 100%;">新建案件</el-button>
			  </el-row>
		  </div>
    	  <div class="search" >
			  <el-input placeholder="请输入您搜索的内容" id = "search_content" v-model="search" class="input-with-select">		 
			  	<el-button slot="append" @click="() => {getTableDada()}"  icon="el-icon-search"></el-button>
			  </el-input>
		  </div>
		  
		</div>
		<div  class="case">
	        <el-table
	            :data="tableData"
	            stripe
	            v-loading="loading">
				<el-table-column
					label="案件编号"
	                prop="caseNum"
	                width="200"
	                show-overflow-tooltip
				></el-table-column>
				<el-table-column
					label="案件名称"
					prop="caseName"
					show-overflow-tooltip
				></el-table-column>
				<el-table-column
					label="案件类型"
					prop="caseTypeDesc"
					show-overflow-tooltip
				></el-table-column>
				<el-table-column
					label="案件描述"
					prop="caseDesc"
					show-overflow-tooltip
				></el-table-column>
				<el-table-column
					label="新建案件时间"
					prop="operationTime"
					show-overflow-tooltip
				></el-table-column>
				<el-table-column
					label="案件失效时间"
					prop="invalidTime"
					show-overflow-tooltip
				></el-table-column>
				<el-table-column
			      fixed="right"
			      label="操作"
			      width="100">
			      <template slot-scope="scope">
			        <el-button type="text" @click="getTableDada" size="small">详情</el-button>			       
			      </template>
			    </el-table-column>
							
	        </el-table>
	        <el-pagination
	            :total="total"
	            :page-size="pageSize"
	            :current-page.sync="page"
	            layout="total, prev, pager, next, jumper"
	            @current-change="getTableDada"
	        ></el-pagination>
		    <el-dialog 
		    	width="700px" 
		    	modal= "false"
		    	class="case_dialog" 
		    	:visible.sync="dialogFormVisible"
		    	:before-close="handleClose"
		    >		
		    <div slot="title"  	class = "head-dialog">
		    	新建案件
		    </div>
		      
			<el-form :model="form"  :rules="rules" ref="ruleForm" >
			    <el-form-item label="案件编号" prop="caseNum" :label-width="formLabelWidth">
			      <el-input style="width:468px" v-model.trim="form.caseNum" autocomplete="off"></el-input>
			    </el-form-item>
			    <el-form-item label="案件名称"  prop="caseName" :label-width="formLabelWidth">
			      <el-input style="width:468px" v-model.trim="form.caseName" autocomplete="off"></el-input>
			    </el-form-item>
			    <el-form-item label="案件类型"  prop="caseType"  :label-width="formLabelWidth">
			      <el-select v-model="form.caseType" placeholder="请选择活动区域"  style="width:468px" >
			        <el-option label="一般案件" value="1"></el-option>
			        <el-option label="重大案件" value="2"></el-option>
			        <el-option label="其他案件" value="3"></el-option>
			      </el-select>
			    </el-form-item>
			    <el-form-item label="案件失效时间" prop="invalidTime"  :label-width="formLabelWidth">
					 <el-date-picker style="width:468px"
				      v-model="form.invalidTime"
				      type="datetime"
				      placeholder="选择日期时间"
				      default-time="12:00:00"
				      :picker-options="pickerOptions0">
				    </el-date-picker>
			    </el-form-item>
			    <el-form-item label="案件描述"  prop="caseDesc" :label-width="formLabelWidth">
			   		<el-input type="textarea"  style="width:468px" v-model.trim="form.caseDesc"></el-input>
			    </el-form-item>
			  </el-form>
			  <div slot="footer" class="dialog-footer">
			   	<el-button type="primary" @click="submitForm('ruleForm')">立即创建</el-button>
    			<el-button @click="resetForm('ruleForm')">重置</el-button>
			  </div>
			</el-dialog>	        
		</div>
		  
    </div>
    <script src="<%=basePath%>js/jquery-3.0.0.js"></script>
    <script src="<%=basePath%>js/vue-2.6.10.min.js"></script>
    <script src="<%=basePath%>js/element-ui-2.12.0.js"></script>
    <script src="<%=basePath%>views/commonHeader/commonHeader.js"></script>
    <script src="<%=basePath%>views/case/case.js" type="text/javascript"></script>
</body>
</html>