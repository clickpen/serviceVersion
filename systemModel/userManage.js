const systamManageObj = {
    init() {
        this.bind()
    },
    bind() {

    }
}
new Vue({
    el: '#systemManage',
    data: {
        systemManageTab: 'userManage',
        usermanageTableData: [
            {
                userName: 'zhangsan',
                truthName: '张三',
                phone: '13012345678',
                idCard: '100001194901010001',
                ipStress: '192.168.1.1',
                macStress: 'A01:B01:C01:D01:E01',
                ukeyMessage: 'lkJldJIpdksL',
                timeLess: '2021-12-12 12:00:00',
                role: '超级无敌vip'
            },
            {
                userName: 'zhangsan',
                truthName: '张三',
                phone: '13012345678',
                idCard: '100001194901010001',
                ipStress: '192.168.1.1',
                macStress: 'A01:B01:C01:D01:E01',
                ukeyMessage: 'lkJldJIpdksL',
                timeLess: '2021-12-12 12:00:00',
                role: '超级无敌vip'
            },
            {
                userName: 'zhangsan',
                truthName: '张三',
                phone: '13012345678',
                idCard: '100001194901010001',
                ipStress: '192.168.1.1',
                macStress: 'A01:B01:C01:D01:E01',
                ukeyMessage: 'lkJldJIpdksL',
                timeLess: '2021-12-12 12:00:00',
                role: '超级无敌vip'
            },
        ],
        usermanageDialogShow: false,
        usermanageDialogForm: {
            hdUrl: ''
        },
    },
    mounted() {
        systamManageObj.init()
    },
    methods: {
        // 删除用户
        handleDeleteRowData(data, type) {
            this.$confirm('删除这条数据？', '提示', {
                confirmButtonText: '确定',
                cancelButtonText: '取消',
                type: 'warn',
            })
                .then(() => {
                    console.log('delete success', data)
                })
                .catch(() => false)
        },
        handleUploadFile(res, file) {
            this.usermanageDialogForm.hdUrl = URL.createObjectURL(file.raw)
        }
    }
})