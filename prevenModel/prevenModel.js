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
let prevenModelWarnAreaMap = {
    init() {
        let $map = this.$map = new BMap.Map('selectMapArea', { enableMapClick: false })
        $map.centerAndZoom(new BMap.Point(116.404, 39.915), 12)
        $map.enableScrollWheelZoom(true)
        let styleOptions = {
            strokeColor:"red",
            fillColor:"red",
            strokeWeight: 3,
            strokeOpacity: 0.8,
            fillOpacity: 0.6,
            strokeStyle: 'solid',
        }
        this.$drawManager = new BMapLib.DrawingManager($map, {
            isOpen: false, //是否开启绘制模式
            enableDrawingTool: true, //是否显示工具栏
            drawingToolOptions: {
                anchor: 1, //位置
                offset: new BMap.Size(5, 5), //偏离值
                drawingModes: [
                    'circle',
                    'rectangle',
                ]
            },
            circleOptions: styleOptions, //圆的样式
            rectangleOptions: styleOptions //矩形的样式
        })
        this.$drawManager.addEventListener('circlecomplete', this.drawComplete)
        this.$drawManager.addEventListener('rectanglecomplete', this.drawComplete)
        this.$drawManager.addEventListener('overlaycomplete', this.drawComplete)
    },
    circleComplete(e) {
        console.log('circlesuccess', e)
    },
    rectangleComplete(e) {
        console.log('rectanglesuccess', e)
    },
    drawComplete(e) {
        console.log('success', e)
    }
}
new Vue({
    el: '#prevenModel',
    data: {
        prevenTab: 'prevenIndex',
        zdrTableData: [],
        zdeTablePage: 1,
        zdrSearchInput: '',
        zdrSearch: '',
        zdrDialogTitle: '新增重点人',
        zdrDialogForm: {
            zdrHeadPic: ''
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
        ],
        warnTablePage: 1,
        warnSearchInput: '',
        warnSearch: '',
        warnDialogForm: {},
        warnDialogShow: false,
        areaSelectShow: false
    },
    mounted() {
        prevenModel.init()
    },
    methods: {
        handleDeleteRowData(data, type) {
            const me = this
            me.$confirm('删除这条数据？', '提示', {
                confirmButtonText: '确定',
                cancelButtonText: '取消',
                type: 'warn',
            })
                .then(() => {
                    // @todo
                    console.log('delete success', data, type)
                    switch(type) {
                        case 'zdr':
                            me.deleZdrTableData(data.id)
                            break
                        case 'warn':
                            me.deleWarnTableData(data.id)
                        default:
                            break
                    }
                })
                .catch(() => false)
        },
        // 上传头像
        handleUploadFile(res, file) {
            console.log('11111', res, file)
            this.zdrDialogForm.zdrHeadPic = URL.createObjectURL(file.raw)
        },
        // 获取重点人列表数据
        getZdrTable(page) {
            const me = this
            page = page || 1
            me.zdeTablePage = page
            let search = me.zdrSearch
            $.ajax({
                url: '/jetk/zdr/getFocusPeople',
                data: {
                    page,
                    limit: 10,
                    search,
                },
                success(res) {
                    if(res.data) {
                        me.zdrTableData = res.data
                        // @todo
                        me.zdrTableData.push({
                            id: 1,
                            zdrHeadPic: 'https://dss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1223780803,2412931209&fm=26&gp=0.jpg',
                            zdrUserName: 'test',
                            account: '138888888888',
                            zdrControlLevel: '1',
                            zdrIdentification: '100111111111111111111',
                            zdrEmployer: '责任公司',
                            zdrResponsible: '责任人',
                            zdrMonitorStatus: '检测中',
                        })
                    }
                },
                error(err) {
                    me.$message.error('获取重点人列表数据出错了')
                    console.log(err)
                }
            })
        },
        // 重点人搜索
        searchZdrTable() {
            this.zdrSearch = this.zdrSearchInput
            this.getZdrTable(1)
        },
        // 新增/修改重点人弹窗展示
        showZdrDialog(data) {
            const me = this
            me.zdrDialogTitle = data ? '修改重点人' : '新增重点人'
            me.zdrDialogForm = data || {}
            me.zdrDialogShow = true
        },
        // 新增/修改重点人列表
        addZdrTableData() {
            const me = this
            console.log('提交的参数', me.zdrDialogForm)
            $.ajax({
                url: '/jetk/zdr/addFocusPeople',
                type: 'post',
                headers: {
                    'Content-Type': 'multipart/form-data'
                },
                data: me.zdrDialogForm,
                success(res) {
                    console.log(res)
                    me.zdrDialogShow = false
                    me.$message.success('提交成功')
                },
                error(err) {
                    me.$message.error('修改重点人信息失败')
                    console.log(err)
                }
            })
        },
        // 删除重点人列表
        deleZdrTableData(zdrId) {
            $.ajax({
                url: '',
                data: {
                    id: zdrId
                },
                success(res) {
                    console.log(res)
                    me.$message.success('删除成功')
                },
                error(err) {
                    me.$message.error('删除重点人信息失败')
                    console.log(err)
                }
            })
        },
        // 获取预警管理列表
        getWarnTable(page) {
            const me = this
            page = page || 1
            let search = me.warnSearch || ''
            $.ajax({
                url: '',
                data: {
                    page,
                    search,
                },
                success(res) {
                    console.log(res)
                    if(res.data) {
                        me.warnTableData = res.data
                    }
                },
                error(err) {
                    me.$message.error('获取预警管理列表出错了')
                    console.log(err)
                }
            })
        },
        // 搜索预警管理列表
        searchWarnTable() {
            this.warnSearch = this.warnSearchInput
            this.getWarnTable(1)
        },
        // 新增/修改预警管理列表
        addWarnTableData(data) {
            $.ajax({
                url: '',
                data: {},
                success(res) {
                    console.log(res)
                    me.$message.success('提交成功')
                },
                error(err) {
                    me.$message.error('修改预警管理信息失败')
                    console.log(err)
                }
            })
        },
        // 删除预警管理列表
        deleWarnTableData(warnId) {
            $.ajax({
                url: '',
                data: {},
                success(res) {
                    console.log(res)
                    me.$message.success('删除成功')
                },
                error(err) {
                    me.$message.error('删除预警管理信息失败')
                    console.log(err)
                }
            })
        },
        // 展示预警管理区域选择弹窗
        handleShowWarnDialogAreaSelect() {
            this.areaSelectShow = true
            setTimeout(() => {
                prevenModelWarnAreaMap.init()
            }, 0)
        }
    },
    watch: {
        prevenTab() {
            const me = this
            // @todo
            console.log(me.prevenTab)
            switch(me.prevenTab) {
                case 'prevenZdr':
                    me.getZdrTable(1)
                    break
                case 'prevenWarn':
                    me.getWarnTable(1)
                    break
                default:
                    break
            }
        }
    }
})