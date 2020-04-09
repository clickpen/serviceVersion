new Vue({
    el: '#systemModel',
    data: {
        prevenTab: 'userManage',
        addUserDialogTitle: '新增用户',
        userManageTotal: 0,
        usermanageTableData: [],
        usermanageDialogShow: false,
        usermanageDialogForm: {},
        showUserId: false,
        
        rolemanageTableData: [],
        roleManageTotal: 0,
        roleManageDialogShow: false,
        roleSelect: '',
        pageSize:10,
        //校验规则
        rules:{
        	userName : [
				{ required: true, message: "用户名不能为空", trigger: "change" },
				{ min: 2, max: 30, message: "长度在 2 到 30 个字符", trigger: "blur" }
        	],
        	userPass : [
				{ required: true, message: "密码不能为空", trigger: "blur" },
				{ min: 6, max: 30, message: "长度在 6 到 30 个字符", trigger: "blur" }
        	],
        	askUserPass : [
				{ required: true, message: "确认密码不能为空", trigger: "blur" },
				{ min: 6, max: 30, message: "长度在 6 到 30 个字符", trigger: "blur" },
        	],
        	roleId : [
        	     {required: true, message: "角色不能为空"}
        	]
        	
        },
    },
    created: function(){
    	this.initTableData();
    },
    methods: {
    	//默认初始化渲染用户管理
    	initTableData: function(page){
    		let me = this;
			me.loading = true;
			page = page || 1;
			let search = $("#userSearch").val();
			//加载用户列表
			$.ajax({
				url: '/jetk/user/users',
				type: "get",
				dataType: "json",
				contentType: "application/x-www-form-urlencoded; charset=utf-8",
				data: {
					page: page,
					limit: me.pageSize,
					search: search,
				},
				success: function(res) {
					me.usermanageTableData = res.data;
					me.total = res.count;
					me.loading = false;
				},
				error: function(err) {
					console.log('出错了', err);
					me.loading = false;
				}
			});
			//角色下拉选赋值
			 $.ajax({
                 url: '/jetk/user/roles',
                 type: "get",
                 dataType: "json",
                 contentType: "application/x-www-form-urlencoded; charset=utf-8",
                 success: function(res) {
                     me.rolemanageTableData = res.data;
                 },
                 error: function(err) {
                     console.log('出错了', err);
                 }
             });
        },
        // 删除数据
        handleDeleteRowData(data, type) {
            this.$confirm('删除这条数据？', '提示', {
                confirmButtonText: '确定',
                cancelButtonText: '取消',
                type: 'warn',
            })
            .then(() => {
                console.log('delete success', data, type)
            })
            .catch(() => false)
        },
        //编辑数据
        handleEditRowData(data, type) {
        	if(type === "userManage"){
        		this.usermanageDialogShow = true;
        		this.addUserDialogTitle = "编辑用户";
        		this.usermanageDialogForm = data;
        		//角色回显
                this.roleSelect = data.roleName;
        	}else if(type === "roleManage"){
        		
        	}
        },
        // 上传头像
        handleUploadFile(res, file) {
            console.log('11111', res, file)
            this.zdrDialogForm.hdUrl = URL.createObjectURL(file.raw)
        },
        changeTab(tab){
        	let me = this;
			me.loading = true;
        	if(tab === "userManage"){
        		let search = $("#userSearch").val();
                $.ajax({
                    url: '/jetk/user/users',
                    type: "get",
                    dataType: "json",
                    contentType: "application/x-www-form-urlencoded; charset=utf-8",
                    data: {
                        page: 1,
                        limit: me.pageSize,
                        search: search,
                    },
                    success: function(res) {
                        me.rolemanageTableData = res.data;
                        me.userManageTotal = res.total;
                        me.loading = false;
                    },
                    error: function(err) {
                        console.log('出错了', err);
                        me.loading = false;
                    }
                });
            }else if(tab === "roleManage"){
            	let search = $("#roleSearch").val();
                $.ajax({
                    url: '/jetk/user/roles',
                    type: "get",
                    dataType: "json",
                    contentType: "application/x-www-form-urlencoded; charset=utf-8",
                    data: {
                        page: 1,
                        limit: me.pageSize,
                        search: search,
                    },
                    success: function(res) {
                        me.rolemanageTableData = res.data;
                        me.roleManageTotal = res.total;
                        me.loading = false;
                    },
                    error: function(err) {
                        console.log('出错了', err);
                        me.loading = false;
                    }
                });
            }else if(tab === "sysConfig"){
                console.log("sysConfig")
            }else if(tab === "sysConfigManage"){
                console.log("sysConfigManage");
            }
        	
        },
        //提交信息
        submitForm : function(formName) {
            let me = this
            console.log(formName);
            if(formName === "userManageForm"){
            	//用户管理提交
                let roleId = me.usermanageDialogForm.roleId;
                let url = "";
                if(roleId){
                	url = "/jetk/user/updateUser";
                }else{
                	url = "/jetk/user/addUser";
                }
                this.$refs[formName].validate((valid) => {
                    if (valid) {
                        $.ajax({
                            url: url,
                            type: "post",
                            dataType: "json",
                            data: {
                                roleId: me.usermanageDialogForm.roleId,//用户ID
                                roleName: me.usermanageDialogForm.roleName,//用户
                                identifier: me.usermanageDialogForm.identifier,
                            },
                            success: function(res) {
                                me.loading = false;

                            },
                            error: function(err) {
                                me.loading = false;
                            }
                        });
                        usermanageDialogShow = false;
                    } else {
                        console.log('error submit!!');
                return false;
            }
            });
            }else if(formName === "roleManageForm"){
            	//角色管理提交
            	
            }
        },
    	validatePass: function(rule, value, callback){
            if (value !== this.usermanageDialogForm.userPass) {
                callback(new Error("两次输入密码不一致!"));
            } else {
                callback();
            }
        },
    },
    watch: {
        prevenTab() {
        	this.changeTab(this.prevenTab);
        }
    }
})