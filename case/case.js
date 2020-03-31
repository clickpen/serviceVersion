new Vue({
	el: '#case',
	data: {
	    dialogFormVisible: false,
        loading: false,
		tableData: [],
		search:'',
        total: 0,
        pageSize: 10,
        page: 1,
        form: {
        	caseNum: '',
        	caseName: '',
        	caseType: '',
        	invalidTime:'',
        	caseDesc:''  	
         },
         inputWidth: '468px',
        formLabelWidth: '120px',
        value3:'',
        pickerOptions0: {
            disabledDate:function(time) {
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
              { type: 'array', required: true, message: '请选案件界别', trigger: 'change' }
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
	created:function() {
		this.getTableDada();
	},
    methods: {
        getTableDada:function(page) {
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
                    page:page,
                    limit: 12,
                    search:search,
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
        	console.log(formName)
         this.$refs[formName].validate((valid) => {
           if (valid) {
            /*alert('submit!')*/
        	   $.ajax({
                   url: '/jetk/case/addCase',
                   type: "post",
                   dataType: "json",
                   contentType: "application/x-www-form-urlencoded; charset=utf-8",
                   data: {
	            	   caseNum: me.form.caseNum,
	                   caseName:  me.form.caseName,
	                   caseType:  me.form.caseType,
	                   invalidTime: me.form.invalidTime,
	                   caseDesc: me.form.caseDesc  	
                   },
                   success: function(res) {
//                       me.tableData = res.data;
//                       me.total = res.count;
                       me.loading = false;
                	   
                   },
                   error: function(err) {
//                       console.log('出错了', err);
                       me.loading = false;
                   }
        	   });  
//            console.log(me.form)
            dialogFormVisible = false;
           } else {
             console.log('error submit!!');
             return false;
             dialogFormVisible = false;
           }
         });
        },
        resetForm: function(formName) {
         this.$refs[formName].resetFields();
        },
        handleClose:function(done) {
            this.$confirm('确认关闭？')
              .then(_ => {
                done();
              })
              .catch(_ => {});
          }
    }
});