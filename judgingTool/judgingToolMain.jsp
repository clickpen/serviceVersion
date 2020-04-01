<%--
  Created by IntelliJ IDEA.
  User: xupanpan
  Date: 2020/3/30
  Time: 11:01
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%
    String contextPath = request.getContextPath();
%>
<html>
<head>
    <meta charset="UTF-8">
    <title>judgingTool-main</title>
    <style>
        .judge-wrapper .input_class{
            width: 300px;
        }
        .judge-wrapper .head_class{
            padding-top: 10px;
        }
        .judge-wrapper .pagination_class{
            float: right;
        }
    </style>
</head>
<body>
    <jsp:include page="../commonHeader/commonHeader.jsp" flush="true"></jsp:include>
    <div class="judge-wrapper" id="app">
        <el-container>
            <el-header class="head_class">
                <el-button type="primary">多号码轨迹对比</el-button>
                <div style="float: right;">
                    <el-input placeholder="请输入内容" v-model="inputone" class="input_class">
                        <el-button slot="append" icon="el-icon-search"></el-button>
                    </el-input>
                    <el-button type="info" icon="el-icon-circle-plus" @click="dialogFormVisible = true">新建任务</el-button>
                    <el-button type="info" icon="el-icon-s-unfold">批量导入</el-button>
                </div>
            </el-header>
            <el-main>
                <el-table
                        :data="tableData"
                        stripe
                        v-loading="loading"
                        class="table_class"
                >
                    <el-table-column
                            label="所属案件名称"
                            prop="caseName"
                            width="200"
                            show-overflow-tooltip
                    ></el-table-column>
                    <el-table-column
                            label="查询类型"
                            :formatter="formatter"
                            show-overflow-tooltip
                    ></el-table-column>
                    <el-table-column
                            label="查询线索"
                            prop="account"
                            show-overflow-tooltip
                    ></el-table-column>
                    <el-table-column
                            label="查询时间范围"
                            :formatter="formatterTime"
                            show-overflow-tooltip
                    ></el-table-column>
                    <el-table-column
                            label="任务耗时"
                            :formatter="formatterTimes"
                            show-overflow-tooltip
                    ></el-table-column>
                    <el-table-column
                            label="结果条数"
                            prop="resultCnt"
                            show-overflow-tooltip
                    ></el-table-column>
                    <el-table-column
                            label="任务状态"
                            prop="status"
                            show-overflow-tooltip
                    ></el-table-column>
                    <el-table-column
                            fixed="right"
                            label="操作"
                            width="100">
                        <template slot-scope="scope">
                            <el-button  @click="" icon="el-icon-s-claim"></el-button>
                        </template>
                    </el-table-column>
                </el-table>
                <el-pagination
                        :total="total"
                        :page-size="pageSize"
                        :current-page.sync="page"
                        layout="total, prev, pager, next, jumper"
                        @current-change="getTableData"
                        class="pagination_class"
                ></el-pagination>
            </el-main>
            <el-dialog
                    width="700px"
                    modal= "false"
                    class="case_dialog"
                    title="新建案件"
                    :visible.sync="dialogFormVisible"
                    :before-close="handleClose"
            >
                <el-form :inline="true" :model="form"  :rules="rules" ref="ruleForm" >
                    <el-form-item :label-width="formLabelWidth">
                        <el-radio v-model="radio" label="1" @click="showDiff(1)">轨迹分析</el-radio>
                        <el-radio v-model="radio" label="2" @click="showDiff(2)">身份扩线分析</el-radio>
                    </el-form-item></br>
                    <el-form-item label="选择案件" prop="caseNum" :label-width="formLabelWidth">
                        <el-input style="width:150px" v-model.trim="form.caseNum" autocomplete="off"></el-input>
                    </el-form-item>
                    <el-form-item label="检索条件"  prop="caseName" :label-width="formLabelWidth">
                        <el-input style="width:150px" v-model.trim="form.caseName" autocomplete="off"></el-input>
                    </el-form-item>
                    <el-form-item label="检索类型"  prop="caseType"  :label-width="formLabelWidth">
                        <el-select v-model="form.caseType" placeholder="请选择活动区域"  style="width:150px" >
                            <el-option label="一般案件" value="1"></el-option>
                        </el-select>
                    </el-form-item>
                    <div v-if="show">
                        <el-form-item label="时间范围" prop="invalidTime"  :label-width="formLabelWidth">
                            <el-date-picker style="width:150px"
                                            v-model="form.invalidTime"
                                            type="datetime"
                                            placeholder="选择开始时间"
                                            default-time="12:00:00"
                                            :picker-options="pickerOptions0">
                            </el-date-picker>
                            <el-date-picker style="width:150px"
                                            v-model="form.invalidTime"
                                            type="datetime"
                                            placeholder="选择结束时间"
                                            default-time="12:00:00"
                                            :picker-options="pickerOptions0">
                            </el-date-picker>
                        </el-form-item>
                        <div style="background-color: #5e5e5e;color: black">其他配置</div>
                        <el-form-item label="是否定时查询"  prop="caseDesc" :label-width="formLabelWidth">
                            <el-radio v-model="radioTime" label="1" @click="">是</el-radio>
                            <el-radio v-model="radioTime" label="2" @click="">否</el-radio>
                        </el-form-item>
                        <el-form-item label="间隔时间" prop="bwTime"  :label-width="formLabelWidth">
                            <el-select v-model="form.bwTime" placeholder="请选择"  style="width:150px" >
                                <el-option label="1" value="1"></el-option>
                            </el-select>
                        </el-form-item>
                    </div>
                </el-form>
                <div slot="footer" class="dialog-footer">
                    <el-button type="primary" @click="submitForm('ruleForm')">立即创建</el-button>
                    <el-button @click="resetForm('ruleForm')">重置</el-button>
                </div>
            </el-dialog>
        </el-container>
    </div>
</body>
<script src="<%=contextPath%>/js/jquery-3.0.0.js"></script>
<script src="<%=contextPath%>/js/vue-2.6.10.min.js" type="text/javascript"></script>
<script src="<%=contextPath%>/js/element-ui-2.12.0.js" type="text/javascript"></script>
<script src="<%=contextPath%>/js/ajaxUtil.js"></script>
<script>
    var App = {
        data(){
            return{
                show: false,
                radio: '1',
                radioTime:'1',
                inputone: "",
                loading: false,
                dialogFormVisible: false,
                tableData: [],
                form: {
                    caseNum: '',
                    caseName: '',
                    caseType: '',
                    invalidTime:'',
                    caseDesc:'',
                    bwTime:''
                },
                rules: {
                    caseNum: [
                        { required: true, message: '请输入案件编号', trigger: 'blur' },
                        { min: 5, max: 30, message: '长度在 5 到 30 个字符', trigger: 'blur' }
                    ],
                    caseName: [
                        { required: true, message: '请输入案件名称', trigger: 'blur' },
                        { min: 5, max: 30, message: '长度在 5 到 30 个字符', trigger: 'blur' }
                    ],
                    caseType: [
                        { type: 'array', required: true, message: '请选案件界别', trigger: 'change' }
                    ],
                    invalidTime: [
                        { type: 'date', required: true, message: '请选择案件失效时间', trigger: 'change' }
                    ],
                    caseDesc: [
                        { required: true, message: '请输入案件编号', trigger: 'blur' },
                        { min: 5, max: 30, message: '长度在 5 到 150 个字符', trigger: 'blur' }
                    ]
                },
                inputWidth: '468px',
                formLabelWidth: '120px',
                pickerOptions0: {
                    disabledDate:function(time) {
                        return time.getTime() < Date.now() - 8.64e7;
                    }
                },
                total: 0,
                pageSize: 10,
                page: 1,
            }
        },
        methods: {
            handleClose:function(done) {
                this.$confirm('确认关闭？')
                    .then(_ => {
                        done();
                    })
                    .catch(_ => {});
            },
            formatter(row, column) {
                return row.operationType==2 ? "轨迹分析":"身份扩线";
            },
            formatterTime(row,column){
              return row.startTime+"-"+row.endTime;
            },
            formatterTimes(row,colum){
              return (Date.parse(row.resultTime)-Date.parse(row.sendTime))/1000;
            },
            getTableData(page) {
                let me = this
                me.loading = true
                page = page || 1
                $.ajax({
                    url: '/jetk/judged/getTable',
                    type: 'post',
                    data: {
                        page,
                        limit: 10
                    },
                    success: function(res) {
                        me.tableData = res.list
                        me.total = res.count
                        me.loading = false
                    },
                    error: function(err) {
                        console.log('出错了', err)
                        me.loading = false
                    }
                })
            }
        },
        created: function () {
            this.tableData = this.getTableData(this.page)
        }
    };
    var Ctor = Vue.extend(App)
    new Ctor().$mount('#app')
</script>
</html>
