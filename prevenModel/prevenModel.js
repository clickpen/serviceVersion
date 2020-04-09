let prevenModel = {
    init() {
        this.$messageBoxWrapper = $('.J-messageBoxWrapper')
        this.$hideMessageBoxBtn = $('.J-hideMessageBox')
        this.$showMessageBoxBtn = $('.J-showMessageBox')
        this.$map = new BMap.Map('mapWrapper', { enableMapClick: false })
        this.bind()
        this.initMap()
    },
    bind() {
        let me = this
        me.$hideMessageBoxBtn.on('click', function() {
            me.toggMessageBox(true)
        })
        me.$showMessageBoxBtn.on('click', function() {
            me.toggMessageBox(false)
        })
    },
    initMap() {
        let me = this
        // 初始化地图,设置中心点坐标和地图级别
        me.$map.centerAndZoom(new BMap.Point(116.404, 39.915), 6)
        //开启鼠标滚轮缩放
        me.$map.enableScrollWheelZoom(true)
    },
    // 切换左侧列表展示或隐藏状态
    toggMessageBox(hide) {
        const me = this
        if(hide) {
            me.$messageBoxWrapper.addClass('hide')
            me.$showMessageBoxBtn.removeClass('hide')
        } else {
            me.$messageBoxWrapper.removeClass('hide')
            me.$showMessageBoxBtn.addClass('hide')
        }
    }
}
new Vue({
    el: '#prevenModel',
    data: {
        prevenTab: 'prevenIndex',
        zdrTableData: [
            {
                headUrl: 'https://dss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1223780803,2412931209&fm=26&gp=0.jpg',
                name: 'test',
                phone: '138888888888',
                level: '一级',
                idCard: '100111111111111111111',
                unit: '责任公司',
                person: '责任人',
                status: '检测中',
            },
            {
                headUrl: 'https://dss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1223780803,2412931209&fm=26&gp=0.jpg',
                name: 'test',
                phone: '138888888888',
                level: '二级',
                idCard: '100111111111111111111',
                unit: '责任公司',
                person: '责任人',
                status: '检测中',
            },
            {
                headUrl: 'https://dss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1223780803,2412931209&fm=26&gp=0.jpg',
                name: 'test',
                phone: '138888888888',
                level: '三级',
                idCard: '100111111111111111111',
                unit: '责任公司',
                person: '责任人',
                status: '检测中',
            }
        ],
        zdrDialogForm: {
            hdUrl: ''
        },
        zdrDialogShow: false,
        warnTableData: [
            {
                name: '预警名称',
                action: '预警动作',
                audio: '启动',
                area: 'link',
                time: '2020-03-30 16:00',
                person: '提交的大爷',
            },
            {
                name: '预警名称',
                action: '预警动作',
                audio: '禁止',
                area: 'link',
                time: '2020-03-30 16:00',
                person: '提交的大爷',
            },
            {
                name: '预警名称',
                action: '预警动作',
                audio: '禁止',
                area: 'link',
                time: '2020-03-30 16:00',
                person: '提交的大爷',
            }
        ],
        warnDialogForm: {},
        warnDialogShow: false,
        areaSelectShow: false
    },
    mounted() {
        prevenModel.init()
    },
    methods: {
        handleDeleteRowData(data, type) {
            this.$confirm('删除这条数据？', '提示', {
                confirmButtonText: '确定',
                cancelButtonText: '取消',
                type: 'warn',
            })
                .then(() => {
                    // @todo
                    console.log('delete success', data, type)
                })
                .catch(() => false)
        },
        // 上传头像
        handleUploadFile(res, file) {
            console.log('11111', res, file)
            this.zdrDialogForm.hdUrl = URL.createObjectURL(file.raw)
        },
    },
    watch: {
        prevenTab() {
            // @todo
            console.log(this.prevenTab)
        }
    }
})