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
const trajectoryObj = {
    init() {
        this.array = [
            {
                text: '北京1',
                weight: Math.ceil(Math.random() * 20)
            },
            {
                text: '微博1',
                weight: Math.floor(Math.random() * 20)
            },
            {
                text: '疫情1',
                weight: Math.ceil(Math.random() * 20)
            },
            {
                text: '北京',
                weight: Math.ceil(Math.random() * 20)
            },
            {
                text: '微博',
                weight: Math.floor(Math.random() * 20)
            },
            {
                text: '疫情',
                weight: Math.ceil(Math.random() * 20)
            },
            {
                text: '北京1',
                weight: Math.ceil(Math.random() * 20)
            },
            {
                text: '微博1',
                weight: Math.floor(Math.random() * 20)
            },
            {
                text: '疫情1',
                weight: Math.ceil(Math.random() * 20)
            },
            {
                text: '北京',
                weight: Math.ceil(Math.random() * 20)
            },
            {
                text: '微博',
                weight: Math.floor(Math.random() * 20)
            },
            {
                text: '疫情',
                weight: Math.ceil(Math.random() * 20)
            },
            {
                text: '北京1',
                weight: Math.ceil(Math.random() * 20)
            },
            {
                text: '微博1',
                weight: Math.floor(Math.random() * 20)
            },
            {
                text: '疫情1',
                weight: Math.ceil(Math.random() * 20)
            },
            {
                text: '北京',
                weight: Math.ceil(Math.random() * 20)
            },
            {
                text: '微博',
                weight: Math.floor(Math.random() * 20)
            },
            {
                text: '疫情',
                weight: Math.ceil(Math.random() * 20)
            },
            {
                text: '北京1',
                weight: Math.ceil(Math.random() * 20)
            },
            {
                text: '微博1',
                weight: Math.floor(Math.random() * 20)
            },
            {
                text: '疫情1',
                weight: Math.ceil(Math.random() * 20)
            },
            {
                text: '北京',
                weight: Math.ceil(Math.random() * 20)
            },
            {
                text: '微博',
                weight: Math.floor(Math.random() * 20)
            },
            {
                text: '疫情',
                weight: Math.ceil(Math.random() * 20)
            }
        ]
        this.$map = new BMap.Map('mapContent', { enableMapClick: false })
        this.initCloud()
        this.initMap()
    },
    initCloud() {
        $('#keyCloud').jQCloud(this.array)
    },
    initMap() {
        const me = this
        // 初始化地图,设置中心点坐标和地图级别
        me.$map.centerAndZoom(new BMap.Point(116.404, 39.915), 8)
        //开启鼠标滚轮缩放
        me.$map.enableScrollWheelZoom(true)
        // 添加地图点示例
        me.addMapPoint(114.404, 39.915, 'day1')
        me.addMapPoint(115.404, 39.915, 'day2')
        me.addMapPoint(116.404, 39.915, 'day3')
        me.addMapPoint(117.404, 39.915, 'day4')
        me.addMapPoint(114.404, 38.915, 'night1')
        me.addMapPoint(115.404, 38.915, 'night2')
        me.addMapPoint(116.404, 38.915, 'night3')
        me.addMapPoint(117.404, 38.915, 'night4')
        me.addMapPoint(118.404, 39.415, 'cover1')
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
            icon = new BMap.Icon('/jetk/views/judgingTool/imgs/day-1.png', iconSize)
                break
            case 'day2':
            icon = new BMap.Icon('/jetk/views/judgingTool/imgs/day-2.png', iconSize)
                break
            case 'day3':
            icon = new BMap.Icon('/jetk/views/judgingTool/imgs/day-3.png', iconSize)
                break
            case 'day4':
            icon = new BMap.Icon('/jetk/views/judgingTool/imgs/day-4.png', iconSize)
                break
            case 'night1':
            icon = new BMap.Icon('/jetk/views/judgingTool/imgs/night-1.png', iconSize)
                break
            case 'night2':
            icon = new BMap.Icon('/jetk/views/judgingTool/imgs/night-2.png', iconSize)
                break
            case 'night3':
            icon = new BMap.Icon('/jetk/views/judgingTool/imgs/night-3.png', iconSize)
                break
            case 'night4':
            icon = new BMap.Icon('/jetk/views/judgingTool/imgs/night-4.png', iconSize)
                break
            case 'cover1':
            icon = new BMap.Icon('/jetk/views/judgingTool/imgs/cover-1.png', iconSize)
                break
            default:
                return
        }
        let marker = new BMap.Marker(point, {
            icon,
            offset
        })
        me.$map.addOverlay(marker)
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
        me.$map.addOverlay(myInfoMarker)
    }
}
new Vue({
    el: '#trajectoryAnalysis',
    data: {
        netimageShow: true,
        total: 0,
        pageSize: 10,
        loading: false,
        page: 1,
        labes: [],
        taskId: $("#taskId").val(),
        account: $("#taskAccount").val(),
        mapAnalysisTable: [
            {
                timeRange: '20-23',
                position1: '231231231231',
                position2: '123123123123'
            },
            {
                timeRange: '0-3',
                position1: '231231231231',
                position2: '123123123123'
            },
            {
                timeRange: '4-7',
                position1: '231231231231',
                position2: '123123123123'
            },
            {
                timeRange: '8-11',
                position1: '231231231231',
                position2: '123123123123'
            },
            {
                timeRange: '12-15',
                position1: '231231231231',
                position2: '123123123123'
            },
            {
                timeRange: '16-19',
                position1: '231231231231',
                position2: '123123123123'
            }
        ],
        trajectoryTableData: []//结果
    },
    mounted() {
        trajectoryObj.init();
    },
    created: function() {
        this.getTableDada();
        this.loadDada();
    },
    methods: {
        getTableDada: function(page) {
            let me = this;
            me.loading = true;
            page = page || 1;
            $.ajax({
                url: '/jetk/queryTask/syresult/list',
                type: "post",
                dataType: "json",
                contentType: "application/x-www-form-urlencoded; charset=utf-8",
                data: {
                    page: page,
                    limit: me.pageSize,
                    taskId: me.taskId,
                },
                success: function(res) {
                    me.trajectoryTableData = res.data;
                    me.total = res.count;
                    me.loading = false;
                },
                error: function(err) {
                    console.log('出错了', err);
                    me.loading = false;
                }
            });
        },
        loadDada: function() {
            let me = this;
            me.loading = true;
            $.ajax({
                url: '/jetk/queryTask/loadSyResult/info',
                type: "post",
                dataType: "json",
                contentType: "application/x-www-form-urlencoded; charset=utf-8",
                data: {
                    account: me.account,
                    taskId: me.taskId
                },
                success: function(res) {
                    me.trajectoryTableData = res.data;
                    me.total = res.count;
                    me.loading = false;
                },
                error: function(err) {
                    console.log('出错了', err);
                    me.loading = false;
                }
            });
        },
        srcPortFormatter: function(row, colum) {
            return row.startPort + "-" + row.endPort
        }
    }
})