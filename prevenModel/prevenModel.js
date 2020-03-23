let prevenModel = {
    $messageBoxWrapper: $('.J-messageBoxWrapper'),
    $hideMessageBoxBtn: $('.J-hideMessageBox'),
    $showMessageBoxBtn: $('.J-showMessageBox'),
    $map: new BMap.Map('mapWrapper', { enableMapClick: false }),
    init() {
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
prevenModel.init()