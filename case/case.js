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
		loading: false,
		tableData: [],
		search: '',
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
		}
	},
	created: function() {
		this.getTableDada();
	},
	methods: {
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
							}
						},
						error: function(err) {
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
		resetForm: function(formName) {
			this.$refs[formName].resetFields();
		},
		handleClose: function(done) {
			this.$confirm('确认关闭？')
				.then(() => {
					done();
				})
				.catch(() => {});
		}
	}
});