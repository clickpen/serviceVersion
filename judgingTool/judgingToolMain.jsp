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
    <link href="<%=contextPath%>/css/element-ui-2.12.0.css" rel="stylesheet"/>
    <style>
        .input_class{
            width: 300px;
        }
        .head_class{
            padding-top: 10px;
        }
        .pagination_class{
            float: right;
        }
    </style>
</head>
<body>
    <jsp:include page="../commonHeader/commonHeader.jsp" flush="true"></jsp:include>
    <div id="app">
        <el-container>
            <el-header class="head_class">
                <el-button type="primary">多号码轨迹对比</el-button>
                <div style="float: right;">
                    <el-input placeholder="请输入内容" v-model="inputone" class="input_class">
                        <el-button slot="append" icon="el-icon-search"></el-button>
                    </el-input>
                    <el-button type="info" icon="el-icon-circle-plus">新建任务</el-button>
                    <el-button type="info" icon="el-icon-s-unfold">批量导入</el-button>
                </div>
            </el-header>
            <el-main>
                <el-table
                        :data="tableData"
                        v-loading="loading"
                >
                    <el-table-column
                            label="所属案件名称"
                            prop="caseName"
                            width="200"
                    ></el-table-column>
                    <el-table-column
                            label="查询类型"
                            :formatter="formatter"
                    ></el-table-column>
                    <el-table-column
                            label="查询线索"
                            prop="account"
                    ></el-table-column>
                    <el-table-column
                            label="查询时间范围"
                            :formatter="formatterTime"
                    ></el-table-column>
                    <el-table-column
                            label="任务耗时"
                            :formatter="formatterTimes"
                    ></el-table-column>
                    <el-table-column
                            label="结果条数"
                            prop="resultCnt"
                    ></el-table-column>
                    <el-table-column
                            label="任务状态"
                            prop="status"
                    ></el-table-column>
                    <el-table-column
                            label="操作"
                            prop="tt4"
                    ></el-table-column>
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
                inputone: "",
                loading: false,
                tableData: [],
                total: 0,
                pageSize: 10,
                page: 1,
            }
        },
        methods: {
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
                    url: '../judged/getTable',
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
