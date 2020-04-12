function MyMapInfo(point, className, callback) {
    this._point = point
    this._className = typeof className === 'string' ? className : ''
    this._cb = callback
}
MyMapInfo.prototype = new BMap.Overlay()
MyMapInfo.prototype.initialize = function(map) {
    this._map = map
    let oDiv = this._div = document.createElement('div')
    oDiv.setAttribute('class', 'my-map-info-wrapper')
    if(this._className && this._className !== 'my-map-info-wrapper') {
        oDiv.classList.add(this._className)
    }
    map.getPanes().labelPane.appendChild(oDiv)
    return oDiv
}
MyMapInfo.prototype.draw = function() {
    let map = this._map
    // 平移至中心
    let pixel = map.pointToOverlayPixel(this._point)
    if(!this._notfirst) {
        this._notfirst = true
        map.panTo(this._point)
        setTimeout(() => {
            map.addEventListener('click', () => {
                map.removeOverlay(this)
            })
        }, 0)
    }
    this._div.style.left = pixel.x + 'px'
    this._div.style.top = pixel.y + 'px'
    this._cb && this._cb(this._div, pixel)
}
let prevenModel = {
    $messageBoxWrapper: null,
    $hideMessageBoxBtn: null,
    $showMessageBoxBtn: null,
    $map: null,
    mapMarkerObj: {
        redCollection: null,
        purpleCollection: null,
        greenCollection: null,
        myMapInfo: null
    },
    init() {
        this.$messageBoxWrapper = $('.J-messageBoxWrapper')
        this.$hideMessageBoxBtn = $('.J-hideMessageBox')
        this.$showMessageBoxBtn = $('.J-showMessageBox')
        this.$map = new BMap.Map('mapWrapper', {
            enableMapClick: false
        })
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
    // 切换左侧列表展示或隐藏状态
    toggMessageBox(hide) {
        const me = this
        if (hide) {
            me.$messageBoxWrapper.addClass('hide')
            me.$showMessageBoxBtn.removeClass('hide')
        } else {
            me.$messageBoxWrapper.removeClass('hide')
            me.$showMessageBoxBtn.addClass('hide')
        }
    },
    initMap() {
        let me = this
        // 初始化地图,设置中心点坐标和地图级别
        me.$map.centerAndZoom(new BMap.Point(116.404, 39.915), 6)
        //开启鼠标滚轮缩放
        me.$map.enableScrollWheelZoom(true)
        // me.$map.addEventListener('click', function(point) {
        // 	console.log(point.point)
        // 	me.addMapPoint(point.point.lng, point.point.lat, 'day1')
        // })
        me.appMapCollection([
            {
                x: 116,
                y: 39,
                url: 'https://dss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=1306607258,967818222&fm=111&gp=0.jpg',
                name: '张三',
                phone: '13546468855',
                address: '北京市紫禁城A01',
                time: '2020-4-4 12:12:50',
                action: '进入紫禁城被打了 o~o~'
            },
            {
                x: 117,
                y: 40,
                url: 'https://dss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=1306607258,967818222&fm=111&gp=0.jpg',
                name: '张三',
                phone: '13546468855',
                address: '北京市紫禁城A01',
                time: '2020-4-4 12:12:50',
                action: '进入紫禁城被打了 o~o~'
            },
            {
                x: 117,
                y: 39,
                url: 'https://dss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=1306607258,967818222&fm=111&gp=0.jpg',
                name: '张三',
                phone: '13546468855',
                address: '北京市紫禁城A01',
                time: '2020-4-4 12:12:50',
                action: '进入紫禁城被打了 o~o~'
            },
            {
                x: 116,
                y: 40,
                url: 'https://dss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=1306607258,967818222&fm=111&gp=0.jpg',
                name: '张三',
                phone: '13546468855',
                address: '北京市紫禁城A01',
                time: '2020-4-4 12:12:50',
                action: '进入紫禁城被打了 o~o~'
            }
        ], '#e60012', 1)
        me.appMapCollection([
            {
                x: 106,
                y: 39,
                url: 'https://dss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=1306607258,967818222&fm=111&gp=0.jpg',
                name: '张三',
                phone: '13546468855',
                address: '北京市紫禁城A01',
                time: '2020-4-4 12:12:50',
                action: '进入紫禁城被打了 o~o~'
            },
            {
                x: 107,
                y: 40,
                url: 'https://dss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=1306607258,967818222&fm=111&gp=0.jpg',
                name: '张三',
                phone: '13546468855',
                address: '北京市紫禁城A01',
                time: '2020-4-4 12:12:50',
                action: '进入紫禁城被打了 o~o~'
            },
            {
                x: 107,
                y: 39,
                url: 'https://dss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=1306607258,967818222&fm=111&gp=0.jpg',
                name: '张三',
                phone: '13546468855',
                address: '北京市紫禁城A01',
                time: '2020-4-4 12:12:50',
                action: '进入紫禁城被打了 o~o~'
            },
            {
                x: 106,
                y: 40,
                url: 'https://dss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=1306607258,967818222&fm=111&gp=0.jpg',
                name: '张三',
                phone: '13546468855',
                address: '北京市紫禁城A01',
                time: '2020-4-4 12:12:50',
                action: '进入紫禁城被打了 o~o~'
            }
        ], '#d660e7', 2)
    },
    // 添加地图点
    addMapPoint(x, y, type) {
        const me = this
        if(!type) {
            return
        }
        let point = new BMap.Point(x, y)
        let icon = null
        let iconSize = new BMap.Size(30, 39)
        let offset = new BMap.Size(0, -18)
        // 对type进行类型判断
        switch(type) {
            case 'day1':
            icon = new BMap.Icon('./imgs/day-1.png', iconSize)
                break
            case 'day2':
            icon = new BMap.Icon('./imgs/day-2.png', iconSize)
                break
            case 'day3':
            icon = new BMap.Icon('./imgs/day-3.png', iconSize)
                break
            case 'day4':
            icon = new BMap.Icon('./imgs/day-4.png', iconSize)
                break
            case 'night1':
            icon = new BMap.Icon('./imgs/night-1.png', iconSize)
                break
            case 'night2':
            icon = new BMap.Icon('./imgs/night-2.png', iconSize)
                break
            case 'night3':
            icon = new BMap.Icon('./imgs/night-3.png', iconSize)
                break
            case 'night4':
            icon = new BMap.Icon('./imgs/night-4.png', iconSize)
                break
            case 'cover1':
            icon = new BMap.Icon('./imgs/cover-1.png', iconSize)
                break
            default:
                return
        }
        let marker = new BMap.Marker(point, {
            icon,
            offset
        })
        me.$map.addOverlay(marker)
        // @todo
        let className = Math.random() > 0.5 ? 'red-info' : 'green-info'
        // 为添加的点加上信息窗
        marker.addEventListener('click', function() {
            me.showMapInfo(point, className, {
                url: 'https://dss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=1306607258,967818222&fm=111&gp=0.jpg',
                name: '张三',
                phone: '13546468855',
                address: '北京市紫禁城A01',
                time: '2020-4-4 12:12:50',
                action: '进入紫禁城被打了 o~o~'
            })
        })
    },
    // 添加地图海量点
    appMapCollection(list, color, type) {
        if(!list) {
            return
        }
        const me = this
        let pointArr = list.map(point => {
            return new BMap.Point(point.x, point.y)
        })
        let collectionOption = {
            size: 4,
            shape: 3, // 圆形
            color,
        }
        let marker = new BMap.PointCollection(pointArr, collectionOption)
        let className = ''
        // 用type对className进行判断赋值
        switch(type) {
            case 1:
                className = 'red-info'
                break
            case 2:
                className = 'purple-info'
                break
            case 3:
                className = 'green-info'
                break
            default:
                break
        }
        marker.addEventListener('click', function(point) {
            const currentPoint = point.point
            let [currentPointObj] = list.filter(pointObj => {
                return pointObj.x === currentPoint.lng && pointObj.y === currentPoint.lat
            })
            console.log(currentPointObj)
            if(currentPointObj) {
                me.showMapInfo(new BMap.Point(currentPointObj.x, currentPointObj.y), className, currentPointObj)
            }
        })
        // 用type对marker进行判断赋值
        switch(type) {
            case 1:
                me.mapMarkerObj.redCollection = marker
                break
            case 2:
                me.mapMarkerObj.purpleCollection = marker
                break
            case 3:
                me.mapMarkerObj.greenCollection = marker
                break
            default:
                break
        }
        me.$map.addOverlay(marker)
    },
    // 展示地图info框
    showMapInfo(point, className, data) {
        const me = this
        let myInfoMarker = new MyMapInfo(point, className, ($dom, pixel) => {
            let _html = `<div class="map-info-image">
                    <img src="${data.url}">
                </div>
                <ul class="map-info-list">
                    <li class="map-info-card">
                        姓名：${data.name}
                    </li>
                    <li class="map-info-card">
                        手机号：${data.phone}
                    </li>
                    <li class="map-info-card">
                        责任派出所：${data.address}
                    </li>
                    <li class="map-info-card">
                        预警时间：${data.time}
                    </li>
                    <li class="map-info-card">
                        预警动作：${data.action}
                    </li>
                </ul>`
            $dom.innerHTML = _html
            // 对地图信息窗进行重新计算位置
            $dom.style.left = pixel.x - 86 + 'px'
            $dom.style.top = pixel.y - 8 - 100 + 'px'
        })
        me.mapMarkerObj.myMapInfo = myInfoMarker
        me.$map.addOverlay(myInfoMarker)
    },
    // 清除地图点
    clearMapMarker() {
        const me = this
        console.log(me.mapMarkerObj)
        for(let prop in me.mapMarkerObj) {
            if(me.mapMarkerObj[prop]) {
                me.$map.removeOverlay(me.mapMarkerObj[prop])
                me.mapMarkerObj[prop] = null
            }
        }
    }
}
let prevenModelWarnAreaMap = {
    init() {
        let $map = this.$map = new BMap.Map('selectMapArea', {
            enableMapClick: false
        })
        $map.centerAndZoom(new BMap.Point(116.404, 39.915), 12)
        $map.enableScrollWheelZoom(true)
        let styleOptions = {
            strokeColor: "red",
            fillColor: "red",
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
    },
}
new Vue({
    el: '#prevenModel',
    data: {
        prevenTab: 'prevenIndex',
        indexTableData: [{
                url: 'http://pic2.zhimg.com/50/v2-fb824dbb6578831f7b5d92accdae753a_hd.jpg',
                zdrUserName: '张三',
                account: '13890873456',
                zdrEmployer: 'abcd派出所',
                time: '2020-03-16 18:30:00',
                message: '进入北京市被拘留'
            },
            {
                url: 'http://pic2.zhimg.com/50/v2-fb824dbb6578831f7b5d92accdae753a_hd.jpg',
                zdrUserName: '张三',
                account: '13890873456',
                zdrEmployer: 'abcd派出所',
                time: '2020-03-16 18:30:00',
                message: '进入北京市被拘留'
            },
            {
                url: 'http://pic2.zhimg.com/50/v2-fb824dbb6578831f7b5d92accdae753a_hd.jpg',
                zdrUserName: '张三',
                account: '13890873456',
                zdrEmployer: 'abcd派出所',
                time: '2020-03-16 18:30:00',
                message: '进入北京市被拘留'
            }
        ],
        indexTablePage: 1,
        indexSearchInput: '',
        indexSearch: '',
        zdrTableData: [{
            id: 1,
            zdrHeadPic: 'https://dss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1223780803,2412931209&fm=26&gp=0.jpg',
            zdrUserName: 'test',
            account: '138888888888',
            zdrControlLevel: '1',
            zdrIdentification: '100111111111111111111',
            zdrEmployer: '责任公司',
            zdrResponsible: '责任人',
            zdrMonitorStatus: '检测中',
        }],
        zdeTablePage: 1,
        zdrSearchInput: '',
        zdrSearch: '',
        zdrDialogShow: false,
        zdrDialogTitle: '新增重点人',
        zdrDialogForm: {
            zdrHeadPic: ''
        },
        zdrLargeImportShow: false,
        zdrLargeImpDialogForm: {
            caseId: ''
        },
        warnTableData: [{
                name: '预警名称',
                action: '预警动作',
                audio: '启动',
                area: 'link',
                time: '2020-03-30 16:00:12',
                person: '提交的大爷',
            },
            {
                name: '预警名称',
                action: '预警动作',
                audio: '禁止',
                area: 'link',
                time: '2020-03-30 16:00:12',
                person: '提交的大爷',
            },
        ],
        warnTablePage: 1,
        warnSearchInput: '',
        warnSearch: '',
        warnDialogForm: {},
        warnDialogShow: false,
        warnDialogTitle: '新增预警策略',
        areaSelectShow: false
    },
    mounted() {
        prevenModel.init()
    },
    methods: {
        // 删除行事件
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
                    switch (type) {
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
        // 获取防控模型首页列表
        getIndexTable(page) {
            const me = this
            page = page || 1
            me.indexTablePage = page
            let search = me.indexSearch || ''
            $.ajax({
                url: '',
                data: {
                    page,
                    search,
                },
                success(res) {
                    console.log(res)
                },
                error(err) {
                    me.$message.error('获取首页重点人列表数据出错了')
                    console.log(err)
                }
            })
        },
        // 搜索首页列表
        searchIndexTable() {
            this.indexSearch = this.indexSearchInput
            this.getIndexTable(1)
        },
        // 首页导出
        indexExport() {
            const me = this
            $.ajax({
                url: '',
                data: {
                    search: me.indexSearch
                },
                success(res) {
                    console.log(res)
                },
                error(err) {
                    me.$message.error('首页列表导出失败了')
                    console.log(err)
                }
            })
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
                    if (res.data) {
                        me.zdrTableData = res.data
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
            me.zdrDialogForm = Object.assign({}, data || {})
            me.zdrDialogShow = true
        },
        // 新增/修改重点人列表
        addZdrTableData() {
            const me = this
            // @todo
            console.log('提交的参数', me.zdrDialogForm)
            if (!me.zdrDialogForm.zdrUserName) {
                me.$alert('请输入姓名')
                return
            }
            if (!me.zdrDialogForm.account) {
                me.$alert('请输入手机号')
                return
            }
            if (!me.zdrDialogForm.zdrControlLevel) {
                me.$alert('请选择管控级别')
                return
            }
            if (!me.zdrDialogForm.zdrIdentification) {
                me.$alert('请输入身份证号')
                return
            }
            if (!me.zdrDialogForm.zdrEmployer) {
                me.$alert('请输入责任单位')
                return
            }
            if (!me.zdrDialogForm.zdrResponsible) {
                me.$alert('请输入责任人')
                return
            }
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
                    me.$message.error('提交重点人信息失败')
                    console.log(err)
                }
            })
        },
        // 删除重点人列表
        deleZdrTableData(zdrId) {
            const me = this
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
        // 下载重点人批量模版
        zdrDownloadTmp() {
            const me = this
            $.ajax({
                url: '',
                data: {
                    caseId: me.zdrLargeImpDialogForm.caseId,
                },
                success(res) {
                    console.log(res)
                },
                error(err) {
                    me.$message.error('获取模版下载连接失败')
                    console.log(err)
                }
            })
        },
        // 上传重点人批量文件
        zdrUploadTmpFile(res, file) {
            console.log('上传成功', res, file)
            this.zdrLargeImpDialogForm.file = {
                name: 'name',
                url: 'url'
            }
        },
        // 上传重点人批量
        zdrUploadTmp() {
            const me = this
            if (!me.zdrLargeImpDialogForm.caseId) {
                return me.$alert('请选择案件')
            }
            if (!me.zdrLargeImpDialogForm.file) {
                return me.$alert('请上传文件')
            }
            me.zdrLargeImportShow = false
            $.ajax({
                url: '',
                data: me.zdrLargeImpDialogForm,
                success(res) {
                    console.log(res)
                    me.$message.info('批量导入成功')
                },
                error(err) {
                    me.$message.error('批量导入失败')
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
                    if (res.data) {
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
        // 新增/修改预警管理弹窗展示
        showWarnDialog(data) {
            const me = this
            me.warnDialogTitle = data ? '修改预警策略' : '新增预警策略'
            me.warnDialogForm = Object.assign({}, data || {})
            me.warnDialogShow = true
        },
        // 新增/修改预警管理列表
        addWarnTableData() {
            const me = this
            // @todo
            console.log('提交的参数', me.warnDialogForm)
            if (!me.warnDialogForm.name) {
                me.$alert('请输入预警名称')
                return
            }
            if (!me.warnDialogForm.action) {
                me.$alert('请选择预警动作')
                return
            }
            if (!me.warnDialogForm.area) {
                me.$alert('请选择预警区域')
                return
            }
            $.ajax({
                url: '',
                data: me.warnDialogForm,
                success(res) {
                    console.log(res)
                    me.warnDialogShow = false
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
            const me = this
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
        // 切换tab时更新对应列表数据
        prevenTab() {
            const me = this
            switch (me.prevenTab) {
                case 'prevenZdr':
                    me.getZdrTable(1)
                    break
                case 'prevenWarn':
                    me.getWarnTable(1)
                    break
                default:
                    break
            }
        },
        // 批量上传弹窗关闭时清除form数据
        zdrLargeImportShow() {
            if (!this.zdrLargeImportShow) {
                this.zdrLargeImpDialogForm = {}
            }
        }
    }
})