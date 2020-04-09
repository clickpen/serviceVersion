/**
 * @name 地图自定义信息框div
 * @params point Object BMap.Point对象
 * @params className String 创建的div的class名，默认为“my-map-info-wrapper”
 * @params callback Function 每次地图draw时执行的回调，携带参数为(当前div的dom, 当前div对应父级的绝对定位数据)
 * @return Object BMap.Marker对象
*/
class MyMapInfo extends BMap.Overlay {
    constructor(point, className, callback) {
        super() // 调用BMap.Overlay构造方法
        this._point = point
        this._className = typeof className === 'string' ? className : ''
        this._cb = callback
    }
    initialize(map) {
        this._map = map
        const _oDiv = this._oDiv = document.createElement('div')
        _oDiv.setAttribute('class', this._className || 'my-map-info-wrapper')
        map.getPanes().labelPane.appendChild(_oDiv)
        return _oDiv
    }
    draw() {
        const _oDiv = this._oDiv
        const pixel = this._map.pointToOverlayPixel(this._point)
        _oDiv.style.left = pixel.x + 'px'
        _oDiv.style.top = pixel.y + 'px'
        this._cb && this._cb(_oDiv, pixel)
    }
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
        console.table(this.array)
        $('#keyCloud').jQCloud(this.array)
    },
    initMap() {
        const me = this
        // 初始化地图,设置中心点坐标和地图级别
        me.$map.centerAndZoom(new BMap.Point(116.404, 39.915), 8)
        //开启鼠标滚轮缩放
        me.$map.enableScrollWheelZoom(true)
        me.addMapPoint(114.404, 39.915, 'day1')
        me.addMapPoint(115.404, 39.915, 'day2')
        me.addMapPoint(116.404, 39.915, 'day3')
        me.addMapPoint(117.404, 39.915, 'day4')
        me.addMapPoint(114.404, 38.915, 'night1')
        me.addMapPoint(115.404, 38.915, 'night2')
        me.addMapPoint(116.404, 38.915, 'night3')
        me.addMapPoint(117.404, 38.915, 'night4')
        me.addMapPoint(118.404, 39.415, 'cover1')
        // 添加自定义地图信息窗
        let myMarkerInfo = new MyMapInfo(new BMap.Point(116.404, 40.915), 'my-map-info-wrapper', ($dom, pixel) => {
            let htmlStr = `<div class="map-info-image">
                    <img src="https://dss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=1306607258,967818222&fm=111&gp=0.jpg">
                </div>
                <ul class="map-info-list">
                    <li class="map-info-card">
                        姓名：张三
                    </li>
                    <li class="map-info-card">
                        手机号：1234567890123
                    </li>
                    <li class="map-info-card">
                        责任派出所：北京市故宫博物院
                    </li>
                    <li class="map-info-card">
                        预警时间：2020-4-8 12:30:59
                    </li>
                    <li class="map-info-card">
                        预警动作：进入故宫搞破坏
                    </li>
                </ul>`
            $dom.innerHTML = htmlStr
            // 对地图信息窗进行重新
            $dom.style.left = pixel.x - 86 + 'px'
            $dom.style.top = pixel.y - 8 - 100 + 'px'
        })
        me.$map.addOverlay(myMarkerInfo)
    },
    // 添加地图点
    addMapPoint(x, y, type) {
        const me = this
        if(!type) {
            return
        }
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
        let marker = new BMap.Marker(new BMap.Point(x, y), {
            icon,
            offset
        })
        me.$map.addOverlay(marker)
    }
}
new Vue({
    el: '#trajectoryAnalysis',
    data: {
        netimageShow: true,
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
        trajectoryTableData: [
            {
                taskId: '123456',
                phone: '13423450987',
                imei: '123456',
                imsi: '654321',
                prevIp: '1.1.1.1',
                originIp: '0.0.0.0',
                originPort: '3000',
                targetIp: '192.168.1.1',
                targetPort: '8080',
                appName: '头条头条',
                url: 'www.toutiao.com',
                lac: '30:390:KJ3:IK0',
                ci: '1234567890',
                position: '北京市海淀区中关村1号'
            },{
                taskId: '123456',
                phone: '13423450987',
                imei: '123456',
                imsi: '654321',
                prevIp: '1.1.1.1',
                originIp: '0.0.0.0',
                originPort: '3000',
                targetIp: '192.168.1.1',
                targetPort: '8080',
                appName: '头条头条',
                url: 'www.toutiao.com',
                lac: '30:390:KJ3:IK0',
                ci: '1234567890',
                position: '北京市海淀区中关村1号'
            },{
                taskId: '123456',
                phone: '13423450987',
                imei: '123456',
                imsi: '654321',
                prevIp: '1.1.1.1',
                originIp: '0.0.0.0',
                originPort: '3000',
                targetIp: '192.168.1.1',
                targetPort: '8080',
                appName: '头条头条',
                url: 'www.toutiao.com',
                lac: '30:390:KJ3:IK0',
                ci: '1234567890',
                position: '北京市海淀区中关村1号'
            },{
                taskId: '123456',
                phone: '13423450987',
                imei: '123456',
                imsi: '654321',
                prevIp: '1.1.1.1',
                originIp: '0.0.0.0',
                originPort: '3000',
                targetIp: '192.168.1.1',
                targetPort: '8080',
                appName: '头条头条',
                url: 'www.toutiao.com',
                lac: '30:390:KJ3:IK0',
                ci: '1234567890',
                position: '北京市海淀区中关村1号'
            },{
                taskId: '123456',
                phone: '13423450987',
                imei: '123456',
                imsi: '654321',
                prevIp: '1.1.1.1',
                originIp: '0.0.0.0',
                originPort: '3000',
                targetIp: '192.168.1.1',
                targetPort: '8080',
                appName: '头条头条',
                url: 'www.toutiao.com',
                lac: '30:390:KJ3:IK0',
                ci: '1234567890',
                position: '北京市海淀区中关村1号'
            },{
                taskId: '123456',
                phone: '13423450987',
                imei: '123456',
                imsi: '654321',
                prevIp: '1.1.1.1',
                originIp: '0.0.0.0',
                originPort: '3000',
                targetIp: '192.168.1.1',
                targetPort: '8080',
                appName: '头条头条',
                url: 'www.toutiao.com',
                lac: '30:390:KJ3:IK0',
                ci: '1234567890',
                position: '北京市海淀区中关村1号'
            },{
                taskId: '123456',
                phone: '13423450987',
                imei: '123456',
                imsi: '654321',
                prevIp: '1.1.1.1',
                originIp: '0.0.0.0',
                originPort: '3000',
                targetIp: '192.168.1.1',
                targetPort: '8080',
                appName: '头条头条',
                url: 'www.toutiao.com',
                lac: '30:390:KJ3:IK0',
                ci: '1234567890',
                position: '北京市海淀区中关村1号'
            },{
                taskId: '123456',
                phone: '13423450987',
                imei: '123456',
                imsi: '654321',
                prevIp: '1.1.1.1',
                originIp: '0.0.0.0',
                originPort: '3000',
                targetIp: '192.168.1.1',
                targetPort: '8080',
                appName: '头条头条',
                url: 'www.toutiao.com',
                lac: '30:390:KJ3:IK0',
                ci: '1234567890',
                position: '北京市海淀区中关村1号'
            },{
                taskId: '123456',
                phone: '13423450987',
                imei: '123456',
                imsi: '654321',
                prevIp: '1.1.1.1',
                originIp: '0.0.0.0',
                originPort: '3000',
                targetIp: '192.168.1.1',
                targetPort: '8080',
                appName: '头条头条',
                url: 'www.toutiao.com',
                lac: '30:390:KJ3:IK0',
                ci: '1234567890',
                position: '北京市海淀区中关村1号'
            },{
                taskId: '123456',
                phone: '13423450987',
                imei: '123456',
                imsi: '654321',
                prevIp: '1.1.1.1',
                originIp: '0.0.0.0',
                originPort: '3000',
                targetIp: '192.168.1.1',
                targetPort: '8080',
                appName: '头条头条',
                url: 'www.toutiao.com',
                lac: '30:390:KJ3:IK0',
                ci: '1234567890',
                position: '北京市海淀区中关村1号'
            },
        ]
    },
    mounted() {
        trajectoryObj.init()
    }
})