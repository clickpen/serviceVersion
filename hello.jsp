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
	<title>hello</title>
	<!-- 引入vue.js -->
	<script src="https://cdn.jsdelivr.net/npm/vue@2.6.11"></script>
	<!-- 引入样式 -->
	<link rel="stylesheet" href="https://unpkg.com/element-ui/lib/theme-chalk/index.css">
	<!-- 引入组件库 -->
	<script src="https://unpkg.com/element-ui/lib/index.js"></script>
	<script src="https://cdn.bootcss.com/jquery/3.1.1/jquery.min.js"></script>
</head>
<body>
	
	<div id="app">
	
		<div>
		  <el-input placeholder="请输入内容" v-model="input1">
		    <template slot="prepend">Http://</template>
		  </el-input>
		</div>
        <el-table
            :data="tableData"
            v-loading="loading">
			<el-table-column
				label="id"
                prop="id"
                width="200"
			></el-table-column>
			<el-table-column
				label="tt1"
				prop="tt1"
			></el-table-column>
			<el-table-column
				label="tt2"
				prop="tt2"
			></el-table-column>
			<el-table-column
				label="tt3"
				prop="tt3"
			></el-table-column>
			<el-table-column
				label="tt4"
				prop="tt4"
			></el-table-column>
        </el-table>
        <el-pagination
            :total="total"
            :page-size="pageSize"
            :current-page.sync="page"
            layout="total, prev, pager, next, jumper"
            @current-change="getTableDada"
        ></el-pagination>
	</div>
	<script>
		new Vue({
			el: '#app',
			data: {
				input1: '',
                loading: false,
				tableData: [],
                total: 0,
                pageSize: 10,
                page: 1,
			},
			created() {
				this.getTableDada()
			},
            methods: {
                getTableDada(page) {
                    let me = this
                    me.loading = true
                    page = page || 1
                    $.ajax({
                        url: '/jetk/hello/test',
                        data: {
                            page:page,
                            limit: 10
                        },
                        success: function(res) {
                            me.tableData = res.data
                            me.total = res.count
                            me.loading = false
                        },
                        error: function(err) {
                            console.log('出错了', err)
                            me.loading = false
                        }
                    })
                }
            }
		})
	</script>
</body>
</html>