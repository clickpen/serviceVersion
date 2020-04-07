new Vue({
    el: '#identityConfig',
    data: {
        dialogFormVisible: false,
        dialogTableVisible: false,
        modifyDialogShow: false,
        modifyDialogSonShow: false,
        modifyDialogForm: {},
        loading: false,
        sonFormTitle:'',
        sonFormType:'',
        parentId:'',
        tableData: [],
        search:'',
        total: 0,
        pageSize: 12,
        page: 1,
        gridTotal: 0,
        gridPageSize: 12,
        gridPage: 1,
        fileList: {
            src:''
        },
        configEditForm: {
           name: ''
        },
        configUpdateForm: {
            name: '',
            words:'',
            type:'',
            picturepath:'',
        },
        configSonForm: {
            id:'',
            parentId:'',
            role: '',
            virgetrule: '',
            minLength:'',
            maxLength:'',
            exceptionvalue:'',
            exceptionsign:'',
            includesign:'',
        },
        pictureArr:[

        ],
        gridData: [],
        inputWidth: '250px',
        formLabelWidth: '140px',
        formPictureWidth: '140px',
        value3:'',
        pickerOptions0: {
            disabledDate:function(time) {
                return time.getTime() < Date.now() - 8.64e7;
            }
        },
        rules: {
            name: [
                { required: true, message: '请输入虚拟身份名称', trigger: 'blur' },
                { min: 1, max: 30, message: '长度在 1 到 30 个字符', trigger: 'blur' }
            ],
            role: [
                { required: true, message: '请输入匹配规则', trigger: 'blur' },
                { min: 1, max: 30, message: '长度在 1 到 30 个字符', trigger: 'blur' }
            ],
            virgetrule: [
                { required: true, message: '请输入提取规则', trigger: 'blur' },
                { min: 1, max: 30, message: '长度在 1 到 30 个字符', trigger: 'blur' }
            ],
            minLength: [
                { required: true, message: '请输入最短匹配长度', trigger: 'blur' },
                { min: 1, max: 100, message: '数字在 1 到 100之间', trigger: 'blur' }
            ],
            maxLength: [
                { required: true, message: '请输入最长匹配长度', trigger: 'blur' },
                { min: 1, max: 100, message: '数字在 1 到 100之间', trigger: 'blur' }
            ],
            exceptionvalue: [
                { required: false, message: '请输入异常值', trigger: 'blur' },
                { min: 1, max: 30, message: '长度在 1 到 30 个字符', trigger: 'blur' }
            ],
            exceptionsign: [
                { required: false, message: '请输入异常符号', trigger: 'blur' },
                { min: 1, max: 30, message: '长度在 1 到 30 个字符', trigger: 'blur' }
            ],
            includesign: [
                { required: false, message: '请输入必含符号', trigger: 'blur' },
                { min: 1, max: 30, message: '长度在 1 到 30 个字符', trigger: 'blur' }
            ],
            type: [
                { required: true, message: '请选类别', trigger: 'change' }
            ],
            words: [
                { required: false, message: '请输入关键词', trigger: 'blur' },
                { min: 1, max: 30, message: '长度在 1 到 30 个字符', trigger: 'blur' }
            ],

        }
    },
    created:function() {
        this.getTableData();
        this.getAllPicture();
    },
    methods: {
        handleSelect:function(e) {
            let me = this;
            me.fileList.src = e
            console.log(e)
            me.configEditForm.picturepath = e
        },
        handleDeleteRowData(data, type) {
            console.log(data)
            this.$confirm('确认删除？', '提示', {
                confirmButtonText: '确定',
                cancelButtonText: '取消',
                type: 'warn',
            })
                .then(() => {
                this.deleteTableRow("/jetk/identityConfig/delete",{id:data.id,parentId:data.parentId})
        })
        .catch(() => false)
        },
        handleDeleteSonData(data, type) {
            this.$confirm('确认删除？', '提示', {
                confirmButtonText: '确定',
                cancelButtonText: '取消',
                type: 'warn',
            })
                .then(() => {
                this.deleteTableRow("/jetk/identityConfig/deleteSon",{id:data})

        })
        .catch(() => false)
        },
        selectSonConfig: function(data) {
            this.dialogTableVisible = true
            this.getIdentityConfigData(1,data.id)
        },
        editIdentityConfig: function(data) {
            this.modifyDialogShow = true
            console.log(data)
            this.configUpdateForm.name = data.name
            this.configUpdateForm.type = data.type
            this.configUpdateForm.words = data.words
            this.configUpdateForm.picturepath = data.picturepath
        },
        deleteTableRow: function(url,data) {
            $.ajax({
                url: url,
                type: "get",
                dataType: "json",
                data:data,
                success: function(res) {
                    if (res.status == 'success') {
                        alert("删除成功")
                    }
                    me.loading = false;
                },
                error: function(err) {
                    console.log('出错了', err);
                    me.loading = false;
                }
            });
        },
        getTableData:function(page) {
            let me = this;
            me.loading = true;
            page = page || 1;
            var search = $("#search_content").val();
            $.ajax({
                url: '/jetk/identityConfig/get',
                type: "get",
                dataType: "json",
                data: {
                    page:page,
                    limit: 12,
                    search:search,
                },
                success: function(res) {
                    me.tableData = res.data;
                    me.total = res.total;
                    me.loading = false;
                },
                error: function(err) {
                    console.log('出错了', err);
                    me.loading = false;
                }
            });
        },
        getIdentityConfigData: function(page,parentId) {
            let me = this;
            me.loading = true;
            page = page || 1;
            var search = $("#search_content").val();
            $.ajax({
                url: '/jetk/identityConfig/getSon',
                type: "get",
                dataType: "json",
                data: {
                    parentId: parentId,
                    page:page,
                    limit: 12,
                    search:search,
                },
                success: function(res) {
                    me.parentId = parentId
                    me.gridData = res.data;
                    me.gridTotal = res.total;
                    me.loading = false;
                },
                error: function(err) {
                    console.log('出错了', err);
                    me.loading = false;
                }
            });
        },
        getAllPicture:function() {
            let me = this;
            me.loading = true;
            $.ajax({
                url: '/jetk/identityConfig/listImage',
                type: "get",
                dataType: "json",
                success: function(res) {
                    me.pictureArr = res.data;
                    me.loading = false;
                },
                error: function(err) {
                    console.log('出错了', err);
                    me.loading = false;
                }
            });
        },
        handleAvatarSuccess(res, file) {
            if (res.status = "success") {
                this.configEditForm.picturepath = res.data
                this.fileList.src = res.data
            }
        },
        beforeAvatarUpload(file) {
            const isJPG = file.type === 'image/jpeg' || file.type === 'image/png';
            console.log(file)
            const isLt2M = file.size / 1024 / 1024 < 2;

            if (!isJPG) {
                this.$message.error('上传图片只能是 JPG 格式!');
            }
            if (!isLt2M) {
                this.$message.error('上传图片大小不能超过 2MB!');
            }
            return isJPG && isLt2M;
        },
        formatterType: function(row, column) {
            if (row.type == 1) {
                return "虚拟身份"
            } else if (row.type == 2) {
                return "互联网ID"
            } else if (row.type == 0) {
                return "信令"
            } else {
                return "未知"
            }
        },
        addIdentityConfigSon: function(form) {
            console.log(form)
            this.sonFormTitle = '新增规则配置'
            this.modifyDialogSonShow = true
            this.sonFormType = 1
            this.configSonForm.parentId = this.parentId
            this.configSonForm.role = ''
            this.configSonForm.virgetrule = ''
            this.configSonForm.exceptionvalue = ''
            this.configSonForm.exceptionsign = ''
            this.configSonForm.includesign = ''
            this.configSonForm.maxLength = ''
            this.configSonForm.minLength = ''
        },
        updateIdentityConfigSon: function(form) {
            this.sonFormTitle = '修改规则配置'
            this.modifyDialogSonShow = true
            console.log(form)
            this.sonFormType = 2
            this.configSonForm.id = form.id
            this.configSonForm.parentId = form.parentId
            this.configSonForm.role = form.role
            this.configSonForm.virgetrule = form.virgetrule
            this.configSonForm.exceptionvalue = form.exceptionvalue
            this.configSonForm.exceptionsign = form.exceptionsign
            this.configSonForm.includesign = form.includesign
            this.configSonForm.maxLength = form.maxLength
            this.configSonForm.minLength = form.minLength

        },
        submitForm: function(formName) {
            let me = this
            console.log(formName)
            this.$refs[formName].validate((valid) => {
                if (valid) {
                    $.ajax({
                        url: '/jetk/identityConfig/add',
                        type: "post",
                        dataType: "json",
                        data: {
                            name: me.configEditForm.name,
                            role: me.configEditForm.role,
                            virgetrule: me.configEditForm.virgetrule,
                            maxLength: me.configEditForm.maxLength,
                            minLength: me.configEditForm.minLength,
                            type: me.configEditForm.type,
                            picturepath: me.configEditForm.picturepath,
                            exceptionvalue: me.configEditForm.exceptionvalue,
                            exceptionsign: me.configEditForm.exceptionsign,
                            includesign: me.configEditForm.includesign,
                            words: me.configEditForm.words
                        },
                        success: function(res) {
                            me.loading = false;

                        },
                        error: function(err) {
                            me.loading = false;
                        }
                    });
                    dialogFormVisible = false;
                } else {
                    console.log('error submit!!');
            return false;
            dialogFormVisible = false;

        }
        });
        },
        submitEditForm: function(form) {
            let me = this
            this.$refs[form].validate((valid) => {
                if (valid) {
                    $.ajax({
                        url: '/jetk/identityConfig/update',
                        type: "post",
                        dataType: "json",
                        data: {
                            name: me.configUpdateForm.name,
                            picturepath: me.configUpdateForm.picturepath,
                            type: me.configUpdateForm.type,
                            words: me.configUpdateForm.words,
                            id: me.configUpdateForm.id
                        },
                        success: function(res) {
                            me.loading = false;

                        },
                        error: function(err) {
                            me.loading = false;
                        }
                    });
                    dialogFormVisible = false;
                } else {
                    console.log('error submit!!');
            return false;
            dialogFormVisible = false;

        }
        });
        },
        submitSonForm: function(formName) {

            let me = this
            if (me.sonFormType == 1) {
                url = '/jetk/identityConfig/addSon'
            } else if (me.sonFormType == 2) {
                url = '/jetk/identityConfig/updateSon'
            }
            this.$refs[formName].validate((valid) => {
                if (valid) {
                    $.ajax({
                        url: url,
                        type: "post",
                        dataType: "json",
                        data: {
                            id: me.configSonForm.id,
                            parentId: me.configSonForm.parentId,
                            role: me.configSonForm.role,
                            virgetrule: me.configSonForm.virgetrule,
                            maxLength: me.configSonForm.maxLength,
                            minLength: me.configSonForm.minLength,
                            exceptionvalue: me.configSonForm.exceptionvalue,
                            exceptionsign: me.configSonForm.exceptionsign,
                            includesign: me.configSonForm.includesign,
                        },
                        success: function(res) {
                            me.loading = false;
                            console.log(res)
                            if (me.sonFormType == 1) {
                                alert("添加成功")
                            }else if (me.sonFormType == 2) {
                                alert("修改成功")
                            }
                        },
                        error: function(err) {
                            me.loading = false;
                        }
                    });
                    modifyDialogSonShow = false;
                } else {
                    console.log('error submit!!');
            return false;
            modifyDialogSonShow = false;
        }
        });
        },
        resetForm: function(formName) {
            this.$refs[formName].resetFields();
        },
    }
});