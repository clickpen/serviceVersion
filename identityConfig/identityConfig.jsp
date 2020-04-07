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
    <link rel="stylesheet" href="<%=basePath%>views/identityConfig/identityConfig.css">
</head>
<body>
    <jsp:include page="../commonHeader/commonHeader.jsp" flush="false"></jsp:include>
    <div class="content-wrapper" id = "identityConfig">
    	<div class="title" >
    	<div class= "new_config">
			  <el-row>
				  <el-button icon="el-icon-circle-plus-outline"  @click="dialogFormVisible = true" style="width: 100%;">新增虚拟身份</el-button>
			  </el-row>
		  </div>
    	  <div class="search" >
			  <el-input placeholder="请输入您搜索的内容" id = "search_content" v-model="search" class="input-with-select">		 
			  	<el-button slot="append" @click="() => {getTableData()}"  icon="el-icon-search"></el-button>
			  </el-input>
		  </div>
		  
		</div>
		<div  class="config">
	        <el-table :data="tableData" stripe v-loading="loading">
				<el-table-column label="虚拟身份名称" prop="name" width="200" show-overflow-tooltip></el-table-column>
				<el-table-column label="虚拟身份图片" prop="picturepath" show-overflow-tooltip>
					<template scope="scope">
						<img :src="'/jetk/picture/'+scope.row.picturepath" width="40" height="40" />
					</template>
				</el-table-column>
				<el-table-column label="类型" :formatter="formatterType" show-overflow-tooltip></el-table-column>
				<el-table-column fixed="right" label="操作" width="200">
			      <template slot-scope="scope">
				 	<el-button type="text" @click="() => {selectSonConfig(scope.row)}" size="small">配置</el-button>
			        <el-button type="text" @click="() => {editIdentityConfig(scope.row)}" size="small">编辑</el-button>
					<el-button type="text" @click="() => {handleDeleteRowData(scope.row)}" size="small">删除</el-button>
			      </template>
			    </el-table-column>
	        </el-table>
	        <el-pagination :total="total"
	            :page-size="pageSize"
	            :current-page.sync="page"
	            layout="total, prev, pager, next, jumper"
	            @current-change="getTableData"
	        ></el-pagination>
		    <el-dialog 
		    	width="700px"
		    	modal= "false"
		    	class="identityConfig_dialog"
		    	:visible.sync="dialogFormVisible"
		    	:before-close="() => { dialogFormVisible = false }"
		    >		
		    <div slot="title"  	class = "head-dialog">
		    	新增虚拟身份规则
		    </div>
			<el-form :model="configEditForm" :inline="true" :rules="rules" ref="ruleForm" >
			    <el-form-item label="虚拟身份名称" prop="name" :label-width="formLabelWidth">
			      <el-input style="width:150px" v-model.trim="configEditForm.name" autocomplete="off"></el-input>
			    </el-form-item>
			    <el-form-item label="虚拟身份匹配规则"  prop="role" :label-width="formLabelWidth">
			      <el-input style="width:150px" v-model.trim="configEditForm.role" autocomplete="off"></el-input>
			    </el-form-item>
				<el-form-item label="虚拟身份提取规则"  prop="virgetrule" :label-width="formLabelWidth">
					<el-input style="width:150px" v-model.trim="configEditForm.virgetrule" autocomplete="off"></el-input>
				</el-form-item>
                <el-form-item label="最大长度"  prop="maxLength" :label-width="formLabelWidth">
                    <el-input style="width:150px" v-model.trim="configEditForm.maxLength" autocomplete="off"></el-input>
                </el-form-item>
                <el-form-item label="最短长度"  prop="minLength" :label-width="formLabelWidth">
                    <el-input style="width:150px" v-model.trim="configEditForm.minLength" autocomplete="off"></el-input>
                </el-form-item>
                <el-form-item label="所属类型"  prop="type"  :label-width="formLabelWidth">
                    <el-select v-model="configEditForm.type" placeholder="选择所属类型"  style="width:150px" >
                        <el-option label="信令" value="0"></el-option>
                        <el-option label="互联网ID" value="1"></el-option>
                        <el-option label="虚拟身份" value="2"></el-option>
                    </el-select>
                </el-form-item>
				<el-form-item label="异常值"  prop="exceptionvalue" :label-width="formLabelWidth">
					<el-input style="width:150px" v-model.trim="configEditForm.exceptionvalue" autocomplete="off"></el-input>
				</el-form-item>
				<el-form-item label="异常符号"  prop="exceptionsign" :label-width="formLabelWidth">
					<el-input style="width:150px" v-model.trim="configEditForm.exceptionsign" autocomplete="off"></el-input>
				</el-form-item>
				<el-form-item label="必含符号"  prop="includesign" :label-width="formLabelWidth">
					<el-input style="width:150px" v-model.trim="configEditForm.includesign" autocomplete="off"></el-input>
				</el-form-item>
				<el-form-item label="关键词"  prop="words" :label-width="formLabelWidth">
					<el-input style="width:150px" v-model.trim="configEditForm.words" autocomplete="off"></el-input>
				</el-form-item>
				<el-form-item label="选择图片"  prop="picturepath" :label-width="formPictureWidth">
					<el-row style="width: 300px">
						<el-col :span="12">
							<el-dropdown  trigger="click" @command="handleSelect">
								<span class="el-dropdown-link">
									下拉菜单
									<i class="el-icon-arrow-down"></i>
								</span>
								<el-dropdown-menu slot="dropdown" class="img-select">
									<el-dropdown-item v-for="(ele,inx) in pictureArr" :key="inx" class="img-list" :command="ele">
										<img :src="ele">
									</el-dropdown-item>
								</el-dropdown-menu>
							</el-dropdown>
						</el-col>
						<el-col :span="12">
							<el-upload
									class="avatar-uploader"
									action="/jetk/identityConfig/uploadImage"
									:show-file-list="false"
									:on-success="handleAvatarSuccess"
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
            <el-dialog
                    :visible="modifyDialogShow"
                    width="650px"
                    title="修改虚拟身份"
                    :before-close="() => {modifyDialogShow = false}"
            >
                <div class="identity-dialog-wrapper">
                    <el-form class="identity-content" ref="identityEditForm" :model="configUpdateForm" label-width="80px">
                        <el-form-item label="虚拟身份名称" prop="name">
                            <el-input placeholder="虚拟身份名称" v-model="configUpdateForm.name"></el-input>
                        </el-form-item>
						<el-form-item label="所属类型"  prop="type"  :label-width="formLabelWidth">
							<el-select v-model="configUpdateForm.type" placeholder="选择所属类型"  style="width:150px" >
								<el-option label="信令" value="0"></el-option>
								<el-option label="互联网ID" value="1"></el-option>
								<el-option label="虚拟身份" value="2"></el-option>
							</el-select>
						</el-form-item>
						<el-form-item label="关键词"  prop="words" :label-width="formLabelWidth">
							<el-input style="width:150px" v-model.trim="configUpdateForm.words" autocomplete="off"></el-input>
						</el-form-item>
						<el-form-item label="选择图片"  prop="picturepath" :label-width="formPictureWidth">
							<el-row style="width: 300px">
								<el-col :span="12">
									<el-dropdown  trigger="click" @command="handleSelect">
								<span class="el-dropdown-link">
									下拉菜单
									<i class="el-icon-arrow-down"></i>
								</span>
										<el-dropdown-menu slot="dropdown" class="img-select">
											<el-dropdown-item v-for="(ele,inx) in pictureArr" :key="inx" class="img-list" :command="ele">
												<img :src="ele">
											</el-dropdown-item>
										</el-dropdown-menu>
									</el-dropdown>
								</el-col>
								<el-col :span="12">
									<el-upload
											class="avatar-uploader"
											action="/jetk/identityConfig/uploadImage"
											:show-file-list="false"
											:on-success="handleAvatarSuccess"
											:before-upload="beforeAvatarUpload">
										<img v-if="configUpdateForm.picturepath" :src="'/jetk/picture/'+configUpdateForm.picturepath" class="avatar">
										<i v-else class="el-icon-plus picture-hd-holder"></i>
										<span class="picture-hd-des">(添加图标)</span>
									</el-upload>
								</el-col>
							</el-row>
						</el-form-item>
                    </el-form>
                </div>
                <span slot="footer">
				<el-button type="primary" @click="() => {submitEditForm('identityEditForm')}">确定</el-button>
				<el-button @click="() => {modifyDialogShow = false}">取消</el-button>
			</span>
            </el-dialog>
			<el-dialog
					width="1200px"
					modal= "false"
					class="identityConfig_dialog"
					:visible.sync="dialogTableVisible"
					:before-close="() => {dialogTableVisible = false}" >
				<div slot="title"  	class = "head-dialog">
					虚拟身份规则配置
				</div>
				<div class= "new_config">
					<el-row>
						<el-button icon="el-icon-circle-plus-outline"  size="mini" @click="() => {addIdentityConfigSon()}" style="width: 100px;">新增规则</el-button>
					</el-row>
				</div>
				<el-table :data="gridData">
					<el-table-column show-overflow-tooltip property="role" label="匹配规则" width="150"></el-table-column>
                    <el-table-column show-overflow-tooltip property="virgetrule" label="提取规则" width="150"></el-table-column>
                    <el-table-column show-overflow-tooltip property="exceptionvalue" label="异常值" width="150"></el-table-column>
                    <el-table-column show-overflow-tooltip property="exceptionsign" label="异常符号" width="150"></el-table-column>
                    <el-table-column show-overflow-tooltip property="includesign" label="必含符号" width="150"></el-table-column>
					<el-table-column show-overflow-tooltip property="minLength" label="最短匹配长度" width="150"></el-table-column>
					<el-table-column show-overflow-tooltip property="maxLength" label="最长匹配长度" width="150"></el-table-column>
					<el-table-column label="操作" width="100">
						<template slot-scope="scope">
						  <el-button type="text" @click="() => {updateIdentityConfigSon(scope.row)}" size="small">编辑</el-button>
						  <el-button type="text" @click="() => {handleDeleteSonData(scope.row.id)}" size="small">删除</el-button>
						</template>
					  </el-table-column>
				</el-table>
				<el-pagination :total="gridTotal"
							   :page-size="gridPageSize"
							   :current-page.sync="gridPage"
							   layout="total, prev, pager, next, jumper"
							   @current-change="getIdentityConfigData"
				></el-pagination>
			</el-dialog>
			<el-dialog
					:visible="modifyDialogSonShow"
					width="650px"
					:title="sonFormTitle"
					:before-close="() => {modifyDialogSonShow = false}"
			>
				<div class="identity-dialog-wrapper">
					<el-form class="identity-content" ref="identitySonEditForm" :model="configSonForm" label-width="130px">
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
				<el-button type="primary" @click="() => {submitSonForm('identitySonEditForm')}">确定</el-button>
				<el-button @click="() => {modifyDialogSonShow = false}">取消</el-button>
			</span>
			</el-dialog>
		</div>
		  
    </div>
    <script src="<%=basePath%>views/identityConfig/identityConfig.js" type="text/javascript"></script>
</body>
</html>