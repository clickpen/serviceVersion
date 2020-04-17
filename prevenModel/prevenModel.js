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
    mapPointData: {},
    mapMarkerObj: {
        redCollection: null,
        purpleCollection: null,
        greenCollection: null,
        myMapInfo: null
    },
    // 当前展示的点的类型
    mapPointSelectObj: {
        red: true,
        purple: true,
        green: true
    },
    mapPointArr: [],
    init() {
        this.$messageBoxWrapper = $('.J-messageBoxWrapper')
        this.$hideMessageBoxBtn = $('.J-hideMessageBox')
        this.$showMessageBoxBtn = $('.J-showMessageBox')
        this.$map = new BMap.Map('mapWrapper', {
            enableMapClick: false
        })
        this.initMap()
        this.bind()
    },
    bind() {
        let me = this
        me.$hideMessageBoxBtn.on('click', function() {
            me.toggMessageBox(true)
        })
        me.$showMessageBoxBtn.on('click', function() {
            me.toggMessageBox(false)
        })
        // 地图点筛选事件绑定
        $('.J-map-item-red').on('click', function() {
            if(me.mapPointSelectObj.red) {
                me.mapPointSelectObj.red = false
                $(this).addClass('not-select')
                // 清除展示
                me.mapMarkerObj.redCollection && me.clearMapMarker(me.mapMarkerObj.redCollection)
            } else {
                me.mapPointSelectObj.red = true
                $(this).removeClass('not-select')
                // 有则重新展示
                me.mapPointData['1'] && me.addMapCollection( me.mapPointData['1'], 1)
            }
        })
        $('.J-map-item-purple').on('click', function() {
            if(me.mapPointSelectObj.purple) {
                me.mapPointSelectObj.purple = false
                $(this).addClass('not-select')
                // 清除展示
                me.mapMarkerObj.purpleCollection && me.clearMapMarker(me.mapMarkerObj.purpleCollection)
            } else {
                me.mapPointSelectObj.purple = true
                $(this).removeClass('not-select')
                // 有则重新展示
                me.mapPointData['2'] && me.addMapCollection( me.mapPointData['2'], 2)
            }
        })
        $('.J-map-item-green').on('click', function() {
            if(me.mapPointSelectObj.green) {
                me.mapPointSelectObj.green = false
                $(this).addClass('not-select')
                // 清除展示
                me.mapMarkerObj.greenCollection && me.clearMapMarker(me.mapMarkerObj.greenCollection)
            } else {
                me.mapPointSelectObj.green = true
                $(this).removeClass('not-select')
                // 有则重新展示
                me.mapPointData['3'] && me.addMapCollection( me.mapPointData['3'], 3)
            }
        })
        // 返回按钮
        $('.J-back-map-item').on('click', function() {
            $(this).addClass('hide')
            $('.J-map-item-wrapper').removeClass('hide')
            me.getMapAllPoint()
            $('.J-map-item-red').removeClass('not-select')
            $('.J-map-item-purple').removeClass('not-select')
            $('.J-map-item-green').removeClass('not-select')
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
    },
    // 添加地图海量点
    addMapCollection(list, type) {
        if(!list) {
            return
        }
        const me = this
        let pointArr = list.filter(ele => {return ele.x && ele.y}).map(point => {
            return new BMap.Point(point.x, point.y)
        })
        let collectionOption = {
            size: 4,
            shape: 3, // 圆形
            color: '#e60012',
        }
        let className = ''
        // 用type对className进行判断赋值
        switch(type) {
            case 1:
                className = 'red-info'
                collectionOption.color = '#e60012'
                break
            case 2:
                className = 'purple-info'
                collectionOption.color = '#d660e7'
                break
            case 3:
                className = 'green-info'
                collectionOption.color = '#20dbdb'
                break
            default:
                break
        }
        let marker = new BMap.PointCollection(pointArr, collectionOption)
        marker.addEventListener('click', function(point) {
            const currentPoint = point.point
            let [currentPointObj] = list.filter(pointObj => {
                return pointObj.x == currentPoint.lng && pointObj.y == currentPoint.lat
            })
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
                        姓名：${data.peopleName}
                    </li>
                    <li class="map-info-card">
                        手机号：${data.account}
                    </li>
                    <li class="map-info-card">
                        责任人：${data.zdrResponsible}
                    </li>
                    <li class="map-info-card">
                        预警时间：${formatTime(data.warnTime, 'yy-MM-dd hh:mm:ss')}
                    </li>
                    <li class="map-info-card">
                        预警动作：${data.reason}
                    </li>
                </ul>
                <span class="map-info-trajectory-btn" onclick="prevenModel.currentTrajectory('${data.account}', '${className}')">查看轨迹</span>`
            $dom.innerHTML = _html
            // 对地图信息窗进行重新计算位置
            $dom.style.left = pixel.x - 86 + 'px'
            $dom.style.top = pixel.y - 8 - 100 + 'px'
        })
        me.mapMarkerObj.myMapInfo = myInfoMarker
        me.$map.addOverlay(myInfoMarker)
    },
    currentTrajectory(account, className) {
        this.getCurrentPointTrajectory({
            account,
            type: className == 'red-info' ? 1 : className == 'purple-info' ? 2 : 3
        })
    },
    // 清除地图点
    clearMapMarker(marker) {
        const me = this
        if(marker) {
            me.$map.removeOverlay(marker)
            return
        }
        for(let prop in me.mapMarkerObj) {
            if(me.mapMarkerObj[prop]) {
                me.$map.removeOverlay(me.mapMarkerObj[prop])
                me.mapMarkerObj[prop] = null
            }
        }
    },
    // 获取所有地图点
    getMapAllPoint() {
        const me = this
        me.clearMapMarker()
        $.ajax({
            url: '/jetk/zdr/getAllPositions',
            success(res) {
                if(res.status === 'success') {
                    let pointData = me.mapPointData = res.data
                    let total = []
                    if(pointData['1']) {
                        me.addMapCollection(pointData['1'], 1)
                        total = total.concat(pointData['1'])
                    }
                    if(pointData['2']) {
                        me.addMapCollection(pointData['2'], 2)
                        total = total.concat(pointData['2'])
                    }
                    if(pointData['3']) {
                        me.addMapCollection(pointData['3'], 3)
                        total = total.concat(pointData['3'])
                    }
                    // 地图展示当前所有点
                    total.length &&  me.$map.setViewport(total.filter(e => e.x && e.y).map(point => {
                        return new BMap.Point(point.x, point.y)
                    }))
                }
            },
            error() {
                Message.error('获取首页地图所有点数据出错了')
            }
        })
    },
    // 获取当前点轨迹
    getCurrentPointTrajectory(data) {
        const me = this
        // 清除地图上marker
        me.clearMapMarker()
        $('.J-map-item-wrapper').addClass('hide')
        $('.J-back-map-item').removeClass('hide')
        $.ajax({
            url: '/jetk/zdr/getFocusPeopleRecord',
            data: {
                account: data.account
            },
            success(res) {
                if(res.status === 'success') {
                    if(data.type == 1) {
                        me.addMapCollection(res.data, 1)
                    }
                    if(data.type == 2) {
                        me.addMapCollection(res.data, 2)
                    }
                    if(data.type == 3) {
                        me.addMapCollection(res.data, 3)
                    }
                }
            },
            error() {
                Message.error('获取点轨迹信息失败')
            }
        })
    }
}
let prevenModelWarnAreaMap = {
    styleOptions: {
        strokeColor: "red",
        fillColor: "red",
        strokeWeight: 3,
        strokeOpacity: 0.8,
        fillOpacity: 0.6,
        strokeStyle: 'solid',
    },
    mapMarker: null,
    $map: null,
    $drawManager: null,
    mapAreaParamsStr: '',
    init(mapAreaParamsStr, edit) {
        const me = this
        me.mapAreaParamsStr = ''
        let $map = me.$map = new BMap.Map('selectMapArea', {
            enableMapClick: false
        })
        $map.centerAndZoom(new BMap.Point(116.404, 39.915), 12)
        $map.enableScrollWheelZoom(true)
        me.$drawManager = new BMapLib.DrawingManager($map, {
            isOpen: false, //是否开启绘制模式
            enableDrawingTool: !!edit, //是否显示工具栏
            drawingToolOptions: {
                anchor: 1, //位置
                offset: new BMap.Size(5, 5), //偏离值
                drawingModes: [
                    'circle',
                    'rectangle',
                    'polygon',
                ]
            },
            circleOptions: me.styleOptions, //圆的样式
            rectangleOptions: me.styleOptions, //矩形的样式
            polygonOptions: me.styleOptions, // 多边形的样式
        })
        me.$drawManager.addEventListener('circlecomplete', (...agr) => { me.circleComplete(...agr) })
        me.$drawManager.addEventListener('rectanglecomplete', (...agr) => { me.rectangleComplete(...agr) })
        me.$drawManager.addEventListener('polygoncomplete', (...agr) => { me.rectangleComplete(...agr) })
        // 传了初始参数则加载初始地图遮罩层
        if(mapAreaParamsStr) {
            me.mapAreaParamsStr = mapAreaParamsStr
            me.initMapAreaMarker(mapAreaParamsStr)
        }
    },
    circleComplete(e, overlay) {
		const me = this
		let center = overlay.getCenter()
		let radius = overlay.getRadius().toFixed(6)
		let rectangle = overlay.getBounds() // 获取矩形（方便获取矩形四个角坐标值）
		let pointne = rectangle.getNorthEast() // 矩形东北点
		let pointsw = rectangle.getSouthWest() // 矩形西南点
		// 清除上次绘制覆盖物
		me.$map.removeOverlay(me.mapMarker)
		// 重新赋值本次覆盖物以便于下次清除
        me.mapMarker = overlay
        if(radius) {
            me.mapAreaParamsStr = '0,' + center.lat + '_' + center.lng + ',' + radius + ',' + pointsw.lng + ',' + pointsw.lat + ',' + pointne.lng + ',' + pointne.lat
        }
    },
    rectangleComplete(e, overlay) {
		const me = this
		let pointArr = overlay.getPath()
		// 清除上次绘制覆盖物
		me.$map.removeOverlay(me.mapMarker)
		// 重新赋值本次覆盖物以便于下次清除
		me.mapMarker = overlay
        if(pointArr.length) {
            // 组装点参数
            me.mapAreaParamsStr = '1,' + pointArr.map(ele => ele.lat.toFixed(6) + '_' + ele.lng.toFixed(6)).join(',')
        }
    },
    // 加载地图区域
    initMapAreaMarker(mapStr) {
        const me = this
        if(!mapStr || typeof mapStr !== 'string') {
            return
        }
        // 圆形
        if(mapStr[0] === '0') {
            // 解析参数为数组
            let paramsArr = mapStr.slice('2').split(',')
            let centerPoint = paramsArr[0].split('_').map(ele => Number(ele))
            let center = new BMap.Point(centerPoint[1], centerPoint[0])
            let radius = Number(paramsArr[1])
            // 半径经度差值
            let _viewPortDistent = Number(Math.abs(centerPoint[1] - paramsArr[2]).toFixed(6))
            me.mapMarker = new BMap.Circle(center, radius, me.styleOptions)
            // 设置x向为当前选中区域的二倍区域可见
            me.$map.setViewport([
                {x: centerPoint[1] - _viewPortDistent * 2, y: centerPoint[0]},
                {x: centerPoint[1] + _viewPortDistent * 2, y: centerPoint[0]}
            ].map(ele => new BMap.Point(ele.x, ele.y)))
            me.$map.addOverlay(me.mapMarker)
            // 多边形
        } else {
            // 解析多边形点坐标为二维数组
            let pointArr = mapStr.slice(2).split(',').map(ele => ele.split('_').map(e => Number(e)))
            let xArr = pointArr.map(ele => ele[1]).sort()
            let yArr = pointArr.map(ele => ele[0]).sort()
            // 获取最大、小xy
            let X = xArr.pop()
            let Y = yArr.pop()
            let x = xArr.shift()
            let y = yArr.shift()
            me.mapMarker = new BMap.Polygon(pointArr.map(ele => new BMap.Point(ele[1], ele[0])), me.styleOptions)
            // 设置xy可见区域均为当前多边形区域的二倍
            me.$map.setViewport([
                {x: X + Number(((X - x) / 2).toFixed(6)), y: Y + Number(((Y - y) / 2).toFixed(6))},
                {x: x - Number(((X - x) / 2).toFixed(6)), y: y - Number(((Y - y) / 2).toFixed(6))},
            ].map(ele => new BMap.Point(ele.x, ele.y)))
            me.$map.addOverlay(me.mapMarker)
        }
    },
}
new Vue({
    el: '#prevenModel',
    data: {
        prevenTab: 'prevenIndex',
        indexTableData: [],
        indexTablePage: 1,
        indexTableTotal: 0,
        indexSearchInput: '',
        indexSearch: '',
        caseOptions: [],
        zdrTableData: [],
        zdrTablePage: 1,
        zdrTableTotal: 0,
        zdrSearchInput: '',
        zdrSearch: '',
        zdrDialogShow: false,
        zdrDialogTitle: '新增重点人',
        zdrDialogForm: {
            zdrHeadPic: ''
        },
        zdrLargeImportShow: false,
        zdrLargeImpDialogForm: {
            caseId: '',
            file: ''
        },
        warnTableData: [],
        warnTablePage: 1,
        warnTableTotal: 0,
        warnSearchInput: '',
        warnSearch: '',
        warnDialogForm: {},
        warnDialogShow: false,
        warnDialogTitle: '新增预警策略',
        areaSelectShow: false
    },
    created() {
        window.Message = this.$message
    },
    mounted() {
        this.getCaseOptions()
        prevenModel.init()
        // 获取地图所有点
        prevenModel.getMapAllPoint()
        this.getIndexTable(1)
    },
    methods: {
        // 获取案件列表信息
        getCaseOptions() {
            const me = this
            $.ajax({
                url: '/jetk/judged/getCases',
                type: 'post',
                success(res) {
                    if(res.result && res.result.length) {
                        me.caseOptions = res.result.map(ele => {
                            return {
                                id: ele.id,
                                name: ele.caseName
                            }
                        })
                    }
                },
                error() {
                    me.$message.error('获取案件列表信息失败！')
                }
            })
        },
        // 删除行事件
        handleDeleteRowData(data, type) {
            const me = this
            me.$confirm('删除这条数据？', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warn',
                })
                .then(() => {
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
                url: '/jetk/zdr/getAllWarnInfo',
                data: {
                    page,
                    limit: 10,
                    search,
                },
                success(res) {
                    if(res.status === 'success') {
                        me.indexTableData = res.data
                        me.indexTableTotal = res.total
                    } else {
                        me.$message.error('获取首页重点人列表数据失败')
                    }
                },
                error() {
                    me.$message.error('获取首页重点人列表数据出错了')
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
            let indexSearch = this.indexSearch
            window.open('http://localhost:8083/jetk/zdr/exportAreaWarnInfo' + (indexSearch ? '?search=' + indexSearch : ''))
        },
        // 上传头像
        handleUploadFile(res, file) {
            // @todo
            console.log('11111', res, file)
            if(res.status == 'fail') {
                this.$message.error(res.message)
            }
            this.zdrDialogForm.zdrHeadPic = URL.createObjectURL(file.raw)
        },
        // 获取重点人列表数据
        getZdrTable(page) {
            const me = this
            page = page || 1
            me.zdrTablePage = page
            let search = me.zdrSearch
            $.ajax({
                url: '/jetk/zdr/getFocusPeople',
                data: {
                    page,
                    limit: 10,
                    search,
                },
                success(res) {
                    if (res.status === 'success') {
                        me.zdrTableData = res.data
                        me.zdrTableTotal = res.total
                    } else {
                        me.$message.error('获取重点人列表数据失败')
                    }
                },
                error() {
                    me.$message.error('获取重点人列表数据出错了')
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
            if (!me.zdrDialogForm.caseId) {
                me.$alert('请选择案件')
                return
            }
            if (!me.zdrDialogForm.zdrUserName) {
                me.$alert('请输入姓名')
                return
            }
            if (!me.zdrDialogForm.account) {
                me.$alert('请输入手机号')
                return
            }
            if (!/^1[3-9]\d{9}$/.test(me.zdrDialogForm.account)) {
                me.$alert('请输入正确的手机号')
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
            if (!/^[1-9]\d{7}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}$|^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}([0-9]|X)$/.test(me.zdrDialogForm.zdrIdentification)) {
                me.$alert('请输入正确的身份证号')
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
            let ajaxUrl = ''
            let sendData = {
                caseId: me.zdrDialogForm.caseId,
                zdrUserName: me.zdrDialogForm.zdrUserName,
                account: me.zdrDialogForm.account,
                zdrControlLevel: me.zdrDialogForm.zdrControlLevel,
                zdrIdentification: me.zdrDialogForm.zdrIdentification,
                zdrEmployer: me.zdrDialogForm.zdrEmployer,
                zdrResponsible: me.zdrDialogForm.zdrResponsible,
            }
            if(me.zdrDialogForm.id) {
                ajaxUrl = '/jetk/zdr/updateFocusPeople'
                sendData.id = me.zdrDialogForm.id
            } else {
                ajaxUrl = '/jetk/zdr/addFocusPeople'
            }
            $.ajax({
                url: ajaxUrl,
                type: 'post',
                data: sendData,
                success(res) {
                    me.zdrDialogShow = false
                    me.$message.info(res.message || '提交成功')
                    // 重新加载重点人列表
                    me.getZdrTable(1)
                },
                error() {
                    me.$message.error('提交重点人信息失败')
                }
            })
        },
        // 删除重点人列表
        deleZdrTableData(zdrId) {
            const me = this
            $.ajax({
                url: '/jetk/zdr/deleteFocusPeople',
                data: {
                    id: zdrId
                },
                success(res) {
                    me.$message.info(res.message || '删除成功')
                    // 更新下列表
                    me.getZdrTable(1)
                },
                error() {
                    me.$message.error('删除重点人信息失败')
                }
            })
        },
        // 展示上传重点人批量弹窗
        showZdrUploadTmp() {
            const me = this
            // 清空form
            me.zdrLargeImpDialogForm = {}
            me.zdrLargeImportShow = true
        },
        // 上传重点人批量
        zdrUploadTmp() {
            const me = this
            let files = $('.J-zdrFile')[0].files[0]
            if (!me.zdrLargeImpDialogForm.caseId) {
                return me.$alert('请选择案件')
            }
            if (!me.zdrLargeImpDialogForm.file) {
                return me.$alert('请上传表格文件')
            }
            if (!/\.xls[x]{0,1}$/.test(me.zdrLargeImpFile)) {
                return me.$alert('请上传excel表格文件')
            }
            let fd = new FormData()
            fd.append('file', files)
            fd.append('caseId', me.zdrLargeImpDialogForm.caseId)
            $.ajax({
                url: '/jetk/zdr/batchImport',
                type: "POST",
                dataType: "json",
                contentType: false,
                async: true,
                cache: false,
                processData: false,
                data: fd,
                success(res) {
                    me.zdrLargeImportShow = false
                    me.$message.info(res.message || '导入成功')
                },
                error() {
                    me.$message.error('批量导入失败')
                }
            })
        },
        // 获取预警管理列表
        getWarnTable(page) {
            const me = this
            page = page || 1
            let search = me.warnSearch || ''
            $.ajax({
                url: '/jetk/areaWarn/getWarnRule',
                data: {
                    page,
                    search,
                },
                success(res) {
                    if (res.data) {
                        me.warnTableData = res.data
                        me.warnTableTotal = res.total
                    }
                },
                error() {
                    me.$message.error('获取预警管理列表出错了')
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
            me.warnDialogForm = Object.assign({}, data || {})
            // 有传入data则表示编辑
            if(data) {
                me.warnDialogTitle = '修改预警策略'
                me.warnDialogForm.voiceTrigger = data.voiceTrigger == 1
            } else {
                me.warnDialogTitle = '新增预警策略'
            }
            me.warnDialogShow = true
        },
        // 新增/修改预警管理列表
        addWarnTableData() {
            const me = this
            let { id, ruleName, action, areaValue, voiceTrigger } = me.warnDialogForm
            if (!ruleName) {
                me.$alert('请输入预警名称')
                return
            }
            if (!action) {
                me.$alert('请选择预警动作')
                return
            }
            if (!areaValue) {
                me.$alert('请选择预警区域')
                me.warnDialogForm.areaValue = "1,36.311424_114.513736,39.073999_113.446693,39.602606_115.047257,39.858307_117.512495,39.886659_119.168252,39.231573_118.395565,39.245881_116.997371,39.20295_116.371863,38.440152_117.622879,37.581338_116.243082"
                return
            }
            let ajaxUrl = me.warnDialogTitle === '修改预警策略' ? '/jetk/areaWarn/updateWarnRule' : '/jetk/areaWarn/addWarnRule'
            $.ajax({
                url: ajaxUrl,
                type: 'post',
                data: {
                    id,
                    ruleName,
                    action,
                    value: areaValue,
                    voiceTrigger: voiceTrigger ? 1 : 2
                },
                success(res) {
                    me.warnDialogShow = false
                    me.$message.info(res.message || '提交成功')
                    me.getWarnTable(1)
                },
                error() {
                    me.$message.error('修改预警管理信息失败')
                }
            })
        },
        // 删除预警管理列表
        deleWarnTableData(warnId) {
            const me = this
            $.ajax({
                url: '/jetk/areaWarn/deleteWarnRule',
                data: {
                    id: warnId,
                },
                success(res) {
                    if(res.status == 'success') {
                        me.$message.info(res.message || '删除成功')
                        me.getWarnTable(1)
                    } else {
                        me.$message.error(res.message || '删除失败')
                    }
                },
                error() {
                    me.$message.error('删除预警管理信息失败')
                }
            })
        },
        // 展示预警管理区域选择弹窗
        handleShowWarnDialogAreaSelect(areaValue, edit) {
            this.areaSelectShow = true
            setTimeout(() => {
                prevenModelWarnAreaMap.init(areaValue, !!edit)
            }, 0)
        },
        // 提交选中区域
        areaSelectSubmit() {
            this.warnDialogForm.areaValue = prevenModelWarnAreaMap.mapAreaParamsStr
            this.areaSelectShow = false
        },
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
                case 'prevenIndex':
                    // 获取地图所有点
                    prevenModel.getMapAllPoint()
                    break
                default:
                    break
            }
        },
        // // 批量上传弹窗关闭时清除form数据
        // zdrLargeImportShow() {
        //     if (!this.zdrLargeImportShow) {
        //         this.zdrLargeImpDialogForm = {}
        //     }
        // }
    },
    computed: {
        // 重点人批量导入上传文件
        zdrLargeImpFile() {
            if(this.zdrLargeImpDialogForm.file) {
                return $('.J-zdrFile')[0].files[0].name
            }
            return ''
        }
    }
})