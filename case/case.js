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
new Vue({
	el: '#case',
	data: {
		dialogFormVisible: false,
		auditCaseDialog: false,
		loading: false,
		tableData: [],
//		checkCase:'1',
		search: '',
		auditIds:[],
		total: 0,
		pageSize: 12,
		page: 1,
		form: {
			caseNum: '',
			caseName: '',
			caseType: '',
			invalidTime: '',
			caseDesc: ''
		},
		auditForm:{
			check:'1',
			suggest:''
		},
		inputWidth: '468px',
		formLabelWidth: '120px',
		casePickerOption: {
			// 案件失效时间不允许选择当前时间之前的时间
			disabledDate: function(time) {
				return time.getTime() < Date.now() - 8.64e7;
			}
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
				{ required: true, message: '请选案件级别', trigger: 'change' }
			],
			invalidTime: [
				{ type: 'date', required: true, message: '请选择案件失效时间', trigger: 'change' }
			],
			caseDesc: [
				{ required: true, message: '请输入案件编号', trigger: 'blur' },
				{ min: 5, max: 30, message: '长度在 5 到 150 个字符', trigger: 'blur' }
			]
		},
		auditRules: {
			suggest: [
				{ required: true, message: '请输入建议', trigger: 'blur' },
				{ min: 2, max: 200, message: '长度在2到 200 个字符', trigger: 'blur' }
			]
		},
	    multipleSelection:[]
	},
	created: function() {
		this.getTableDada();
	},
	methods: {
		formatter:function(row) {
			
		},
		selectAble:function(row) {
			if (row.status == 2  || row.status == 3 || row.status == 4) {
    			return false;
    		} else {
    			return true;
    		}
		},
		getTableDada: function(page) {
			let me = this;
			me.loading = true;
			page = page || 1;
			var search = $("#search_content").val();
			$.ajax({
				url: '/jetk/case/list',
				type: "post",
				dataType: "json",
				contentType: "application/x-www-form-urlencoded; charset=utf-8",
				data: {
					page: page,
					limit: me.pageSize,
					search: search,
				},
				success: function(res) {
					me.tableData = res.data;
					me.total = res.count;
					me.loading = false;
				},
				error: function(err) {
					console.log('出错了', err);
					me.loading = false;
				}
			});
		},
		submitForm: function(formName) {
			let me = this
			this.$refs[formName].validate((valid) => {
				console.log(me.form.invalidTime);
				console.log(typeof  me.form.invalidTime);
				console.log(me.form.invalidTime.format("yyyy-MM-dd HH:mm:ss"));
				
				if (valid) {
					$.ajax({
						url: '/jetk/case/addCase',
						type: "post",
						dataType: "json",
						contentType: "application/x-www-form-urlencoded; charset=utf-8",
						data: {
							caseNum: me.form.caseNum,
							caseName: me.form.caseName,
							caseType: me.form.caseType,
							invalidTime: me.form.invalidTime.format("yyyy-MM-dd HH:mm:ss"),
							caseDesc: me.form.caseDesc
						},
						success: function(res) {
							var result = res.result;
							if (result) {
								me.resetForm(formName);
								me.dialogFormVisible = false;
								me.getTableDada();
								me.$message({
							          message: '案件新建成功',
							          type: 'success'
							    });
							} else {
								me.$message.error('案件新建发生错误');
							}
						},
						error: function(err) {
							me.$message.error('案件新建发生错误');
							me.loading = false;
						}
					});
					dialogFormVisible = false;
				} else {
					console.log('error submit!!');
					dialogFormVisible = false;
					return false;
				}
			});
		},
		
		submitAuditForm: function(formName) {//提交
			let me = this
			this.$refs[formName].validate((valid) => {
				if (valid) {
					$.ajax({
						url: '/jetk/case/auditCase',
						type: "post",
						dataType: "json",
						contentType: "application/x-www-form-urlencoded; charset=utf-8",
						data: {
							ids:this.auditIds,
							suggest:me.auditForm.suggest,
							check:me.auditForm.check
						},
						success: function(res) {
							var result = res.result;
							if (result) {
								me.$message({
							          message: '审批完成成功',
							          type: 'success'
							    });
								me.resetForm(formName);
								me.auditCaseDialog = false;
								me.getTableDada();
							} else {
								me.$message.error('案件审批失败');
							}
						},
						error: function(err) {
							me.$message.error('案件审批失败');
							me.loading = false;
						}
					});
				} else {
					console.log('error submit!!');
					auditCaseDialog = false;
					return false;
				}
			});
		},
		resetForm: function(formName) {
			this.$refs[formName].resetFields();
		},
		closeAuditForm: function(formName) {
			this.$refs[formName].resetFields();
			this.auditCaseDialog = false;
		},
		handleClose: function(done) {
			this.$confirm('确认关闭？')
				.then(() => {
					done();
				})
				.catch(() => {});
		},
		handleAudit :function(index, row) {
			if (row) {
				this.auditIds = [];
				this.auditIds.push(row.id);
				this.auditCaseDialog = true;
			}
		},
		handleAllAudit :function(index, row) {
			if (this.multipleSelection.length >0 ) {
				this.auditIds = [];
				for(j = 0; j<this.multipleSelection.length; j++) {
					this.auditIds.push(this.multipleSelection[j].id);
				}
				console.log(this.auditIds);
				this.auditCaseDialog = true;
			} else {
				/*alert("请选择案件");*/
				this.$message({
		          message: '请选择案件',
		          type: 'warning'
		        });
			}
		},
		handleSelectionChange :function(val) {
			this.multipleSelection  = val;
		}
	}
});