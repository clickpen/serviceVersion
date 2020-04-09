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
        .judge-wrapper .div-separator{
            background-color:rgb(204, 201, 201);
            color: #5e5e5e;
            margin-bottom: 10px;
        }
        .judge-wrapper .row_center{
            text-align: center;
        }
    </style>
</head>
<body>
    <jsp:include page="../commonHeader/commonHeader.jsp" flush="true"></jsp:include>
    <div class="judge-wrapper" id="app">
        <el-container>
            <el-header class="head_class">
                <el-button type="primary" :disabled="telButtonDisabled" @click="moreTelCompare();">多号码轨迹对比</el-button>
                <div style="float: right;">
                    <el-select v-model="caseValue" placeholder="请选择案件">
                        <el-option
                                v-for="item in caseOptions"
                                :key="item.value"
                                :label="item.label"
                                :Value="item.value">
                        </el-option>
                    </el-select>
                    <el-input placeholder="请输入内容" v-model="inputOne" class="input_class">
                        <el-button slot="append" icon="el-icon-search" @click="queryTask();"></el-button>
                    </el-input>
                    <el-button type="info" icon="el-icon-circle-plus" @click="dialogFormVisible = true">新建任务</el-button>
                    <el-button type="info" icon="el-icon-s-unfold" @click="dialogBatchUploadVisible = true">批量导入</el-button>
                </div>
            </el-header>
            <el-main>
                <el-table
                        :data="tableData"
                        stripe
                        v-loading="loading"
                        class="table_class"
                        @selection-change="handleSelectionChange"
                >
                    <el-table-column
                            type="selection"
                            width="55">
                    </el-table-column>
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
                            <el-button  @click="handleDetail(scope.$index, scope.row)" icon="el-icon-s-claim"></el-button>
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
                <el-row style="margin-bottom: 10px">
                    <el-radio v-model="radio" label="1" @change="showDiff('1')">轨迹分析</el-radio>
                    <el-radio v-model="radio" label="2" @change="showDiff('2')">身份扩线分析</el-radio>
                </el-row>
                <div v-if="virShow">
                <el-form :inline="true" :model="virForm" ref="virForm" >
                    <el-form-item label="选择案件" prop="caseNum" :label-width="formLabelWidth">
                        <el-select style="width:150px" v-model="virForm.caseNum" placeholder="请选择案件">
                            <el-option
                                    v-for="item in caseOptions"
                                    :key="item.value"
                                    :label="item.label"
                                    :value="item.value">
                            </el-option>
                        </el-select>
                    </el-form-item>
                    <el-form-item label="检索条件"  prop="searchCondition" :label-width="formLabelWidth">
                        <el-input style="width:150px" v-model.trim="virForm.searchCondition" autocomplete="off"></el-input>
                    </el-form-item>
                    <el-form-item label="检索类型"  prop="searchType"  :label-width="formLabelWidth">
                        <el-select v-model="virForm.searchType" placeholder="请选择检索类型"  style="width:150px" >
                            <el-option
                                    v-for="item in searchTypes"
                                    :key="item.value"
                                    :label="item.label"
                                    :value="item.value">
                            </el-option>
                        </el-select>
                    </el-form-item>
                </el-form>
                </div>
                <div v-if="show">
                <el-form :inline="true" :model="form"  ref="ruleForm" >
                    <el-form-item label="选择案件" prop="caseNum" :label-width="formLabelWidth">
                        <el-select style="width:150px" v-model="form.caseNum" placeholder="请选择案件">
                            <el-option
                                    v-for="item in caseOptions"
                                    :key="item.value"
                                    :label="item.label"
                                    :value="item.value">
                            </el-option>
                        </el-select>
                    </el-form-item>
                    <el-form-item label="检索条件"  prop="searchCondition" :label-width="formLabelWidth">
                        <el-input style="width:150px" v-model.trim="form.searchCondition" autocomplete="off"></el-input>
                    </el-form-item>
                    <el-form-item label="检索类型"  prop="searchType"  :label-width="formLabelWidth">
                        <el-select v-model="form.searchType" placeholder="请选择检索类型"  style="width:150px" >
                            <el-option
                                    v-for="item in searchTypes"
                                    :key="item.value"
                                    :label="item.label"
                                    :value="item.value">
                            </el-option>
                        </el-select>
                    </el-form-item></br>
                    <el-form-item label="时间范围" prop="startTime"  :label-width="formLabelWidth">
                        <el-date-picker style="width:200px"
                                        v-model="form.startTime"
                                        type="datetime"
                                        placeholder="选择开始时间"
                                        default-time="12:00:00"
                                        :picker-options="pickerOptions0">
                        </el-date-picker><em> -</em>
                    </el-form-item>
                    <el-form-item  prop="endTime">
                        <el-date-picker style="width:200px"
                                        v-model="form.endTime"
                                        type="datetime"
                                        placeholder="选择结束时间"
                                        default-time="12:00:00"
                                        :picker-options="pickerOptions0">
                        </el-date-picker>
                    </el-form-item>
                    <div class="div-separator">其他配置</div>
                    <el-form-item label="是否定时查询"  prop="timing" :label-width="formLabelWidth">
                        <el-radio v-model="radioTime" label="0" @change="timeChoice('0')">是</el-radio>
                        <el-radio v-model="radioTime" label="3" @change="timeChoice('3')">否</el-radio>
                    </el-form-item>
                    <el-form-item label="间隔时间" prop="bwTime"  :label-width="formLabelWidth">
                        <el-select v-model="form.bwTime" :disabled="disabled" placeholder="请选择"  style="width:150px" >
                            <el-option label="2h" value="2"></el-option>
                            <el-option label="4h" value="4"></el-option>
                            <el-option label="8h" value="8"></el-option>
                            <el-option label="12h" value="12"></el-option>
                            <el-option label="24h" value="24"></el-option>
                        </el-select>
                    </el-form-item>
                </el-form>
            </div>
                <div slot="footer" class="dialog-footer">
                    <el-button type="primary" @click="submitForm()">立即创建</el-button>
                    <el-button @click="resetForm()">重置</el-button>
                </div>
            </el-dialog>
            <el-dialog
                    title="批量导入"
                    :visible.sync="dialogBatchUploadVisible"
                    width="30%"
                    :before-close="handleClose"
                    center
            >
                <el-row class="row_center">
                    <el-radio v-model="batchRadio" label="1" @change="showBatchRadio('1')">轨迹分析</el-radio>
                    <el-radio v-model="batchRadio" label="2" @change="showBatchRadio('2')">身份扩线分析</el-radio>
                    <el-select v-model="batchCaseValue" placeholder="请选择案件">
                        <el-option
                                v-for="item in caseOptions"
                                :key="item.value"
                                :label="item.label"
                                :Value="item.value">
                        </el-option>
                    </el-select>
                </el-row>
                <input type="file" id="batchUpload" @change="uploadBatach();" style="display:none" />
                <span slot="footer" class="dialog-footer">
                    <form id="downloadForm" method="post" action="/jetk/judged/downloadModel">
                        <input name="taskType" :value="batchRadio" type="hidden">
                    </form>
                    <el-button type="primary" @click="downloadModel();">模板下载</el-button>
                    <el-button type="primary" @click="importBatch();">直接导入</el-button>
                </span>
            </el-dialog>
        </el-container>
    </div>
</body>
<script src="<%=contextPath%>/js/ajaxUtil.js"></script>
<script>
    Date.prototype.format = function(fmt) {
        var o = {
            "M+": this.getMonth() + 1, //月份
            "d+": this.getDate(), //日
            "h+": this.getHours() % 12 == 0 ? 12 : this.getHours() % 12, //小时
            "H+": this.getHours(), //小时
            "m+": this.getMinutes(), //分
            "s+": this.getSeconds(), //秒
            "q+": Math.floor((this.getMonth() + 3) / 3), //季度
            "S": this.getMilliseconds() //毫秒
        };
        if (/(y+)/.test(fmt))
            fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
        for (var k in o)
            if (new RegExp("(" + k + ")").test(fmt))
                fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
        return fmt;
    }
    var App = {
        data(){
            return{
                batchCaseValue:'',
                batchRadio:'1',
                multipleSelection:[],
                telButtonDisabled:true,
                virShow:false,
                caseValue:'',
                caseOptions:[{'value':1,'label':'caseone'},{'value':2,'label':'casetwo'}],
                searchTypes:[{'value':1,'label':'手机号'},{'value':2,'label':'微信'}],
                disabled: false,
                show: true,
                radio: '1',
                radioTime:'0',
                inputOne: "",
                loading: false,
                dialogFormVisible: false,
                dialogBatchUploadVisible: false,
                tableData: [],
                virForm: {
                    caseNum: '',
                    searchCondition: '',
                    searchType: ''
                },
                form: {
                    caseNum: '',
                    searchCondition: '',
                    searchType: '',
                    startTime:'',
                    endTime:'',
                    caseDesc:'',
                    bwTime:''
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
            handleDetail:function (index,row) {
            	/* console.log(row); */
            	if(row.operationType==2) {
            		console.log(row);
            		//window.location.href = 'index?path=judgingTool/trajectoryAnalysis&param='+row.account;
            		window.open('index?path=judgingTool/trajectoryAnalysis&account='+row.account+"&id="+row.id);  
            	}  else if (row.operationType==10) {
            		window.location.href = 'index?path=identityModel/identity';	
            	}
            },
            /*任务查询*/
            queryTask(){
                alert(this.caseValue+"---"+this.inputOne);
            },
            /*批量上传的模板类型（单选）*/
            showBatchRadio(str){
                this.batchRadio = str;
            },
            /*多号码轨迹按钮*/
            moreTelCompare(){
                var list = this.multipleSelection;
                if(list.length>5){
                    alert("号码数量不可以超过5");
                }else{
                    /*跳转到轨迹分析*/
                }
            },
            /*多号码轨迹按钮显示控制*/
            handleSelectionChange(val) {
                if(val.length>1){
                    this.telButtonDisabled = false;
                }else{
                    this.telButtonDisabled = true;
                }
                this.multipleSelection = val;
            },
            //导入excel按钮
            importBatch(){
                if(this.batchCaseValue!=''&&this.batchCaseValue!=null){
                    $("#batchUpload").click();
                    this.dialogBatchUploadVisible = false
                }else{
                    alert("案件不能为空！")
                }

            },
            //上传功能
            uploadBatach(){
                var file = $("#batchUpload")[0].files[0];//上传的文件
                var location = $("#batchUpload").val();//文件路径
                if (location == "" || location == undefined) {
                    return false;
                }
                var point = location.lastIndexOf(".");
                var type = location.substr(point).toUpperCase();
                if (!(type == '.XLSX' || type == '.XLS')) {
                   Alert('只能上传XLSX或XLS类型的文件', 'warning');
                    return false;
                }
                var fd = new FormData();
                fd.append('file1', file);
                fd.append("taskType",this.radio);
                $.ajax({
                    url: "/jetk/judged/uploadBatch",
                    type: "POST",
                    dataType: "json",
                    contentType: false,
                    async: true,
                    cache: false,
                    processData: false,
                    data: fd,
                    success: function (data) {
                        $("#batchUpload").val("");
                        var result = data.result;
                        var msg = data.msg;
                        if (!result) {

                        } else {

                        }
                    }
                });
            },
            //下载模板
            downloadModel(){
                if(this.batchCaseValue!=null&&this.batchCaseValue!=''){
                    $("#downloadForm").submit();
                    this.dialogBatchUploadVisible = false;
                }else{
                    alert("案件不能为空");
                }
            },
            //选择是否定时
            timeChoice(num){
                if(0!=num){
                    this.disabled = true;
                }else {
                    this.disabled = false;
                }
                this.radioTime = num;
            },
            //选择轨迹或者虚拟身份
            showDiff(num){
                if(num!=1){
                    this.show = false;
                    this.virShow = true;
                }else{
                    this.virShow = false;
                    this.show = true;
                }
                this.radio = num;
                // console.log(this.radio);
            },
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
            submitForm: function() {
                let me = this
                var data = {};
                if(this.radio==1){
                    data.caseNum = me.form.caseNum
                    data.searchCondition= me.form.searchCondition
                    data.searchType= me.form.searchType
                    data.startTime= me.form.startTime.format("yyyy-MM-dd HH:mm:ss")
                    data.endTime= me.form.startTime.format("yyyy-MM-dd HH:mm:ss")
                    data.caseDesc= me.form.caseDesc
                    data.timingSend= me.radioTime
                    data.bwTime= me.form.bwTime
                    data.taskType= me.radio
                }else{
                    data.caseNum = me.virForm.caseNum
                    data.searchCondition= me.virForm.searchCondition
                    data.searchType= me.virForm.searchType
                    data.taskType= me.radio
                }
                var valid = true;

                if (valid) {
                    $.ajax({
                        url: '/jetk/judged/addTask',
                        type: "post",
                        dataType: "json",
                        contentType: "application/x-www-form-urlencoded; charset=utf-8",
                        data: data,
                        success: function(res) {
                            var result = res.result;
                            if (result) {
                                me.resetForm(formName);
                                me.dialogFormVisible = false;
                                me.getTableDada();
                            }
                        },
                        error: function(err) {
                            me.loading = false;
                        }
                    });
                    this.dialogFormVisible = false;
                }else{
                    console.log('error submit!!');
                    this.dialogFormVisible = false;
                    return false;
                    }

            },
            validate: function(){
                if(this.radio==1){
                    return false;
                }else{//2代表虚拟身份
                    return true;
                }

            },
            resetForm: function() {
                var formName = 'ruleForm';
                if(this.radio!=1){
                    formName = 'virForm'
                }
                this.$refs[formName].resetFields();
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
            },
            getCaseOptions(){
                $.ajax({
                    url:'/jetk/judged/getCase',
                    type:'post',
                    success: function (res) {
                        var arr = new Array();
                        for(i=0;i<res.result.length;i++){
                            var obj = {};
                            obj.value = res.result[i].id
                            obj.label = res.result[i].caseName
                            arr.push(obj)
                        }
                        this.caseOptions = arr;
                    },
                    error: function (err) {
                        console.log('error',err);
                    }

                })
            }
        },
        created: function () {
            this.tableData = this.getTableData(this.page)
            this.getCaseOptions()
        }
    };
    var Ctor = Vue.extend(App)
    new Ctor().$mount('#app')
</script>
</html>
