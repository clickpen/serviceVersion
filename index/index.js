let index = {
    $historyStatChart: null,
    $caseStatChart: null,
    // $funStatChart: null,
    init() {
        this.initCharts()
    },
    // 初始化charts
    initCharts() {
        const me = this
        me.$historyStatChart =  echarts.init(document.getElementById('historyStatChart'))
        me.$caseStatChart =  echarts.init(document.getElementById('caseStatChart'))
        // me.$funStatChart =  echarts.init(document.getElementById('funStatChart'))
    },
    // 更新历史折线chart
    updateHistoryChart(historyData) {
        this.$historyStatChart.setOption({
            legend: {
                data: ['新建案件', '任务次数']
            },
            tooltip: {
                trigger: 'axis'
            },
            xAxis: {
                type: 'category',
                data: historyData.caseTcs.map(ele => ele.time)
            },
            yAxis: {
                type: 'value'
            },
            series: [{
                name: '新建案件',
                data: historyData.caseTcs.map(ele => ele.count),
                type: 'line',
                smooth: true
            }, {
                name: '任务次数',
                data: historyData.taskTcs.map(ele => ele.count),
                type: 'line',
                smooth: true
            }]
        })
    },
    // 更新案件统计类型
    updateCaseTypeChart(caseTypeData) {
        this.$caseStatChart.setOption({
            tooltip: {
                trigger: 'item',
                formatter: '{a} <br/>{b}: {c} ({d}%)'
            },
            legend: {
                orient: 'horizontal',
                bottom: 0,
                data: caseTypeData.map(ele => ele.type)
            },
            series: [
                {
                    name: '案件类型',
                    type: 'pie',
                    hoverOffset: 5,
                    radius: ['45%', '50%'],
                    avoidLabelOverlap: false,
                    label: {
                        show: false,
                        position: 'center'
                    },
                    emphasis: {
                        label: {
                            show: true,
                            fontSize: '20',
                            fontWeight: 'bold'
                        }
                    },
                    labelLine: {
                        show: false
                    },
                    data: caseTypeData.map(ele => {
                        return {
                            name: ele.type,
                            value: Number(ele.count)
                        }
                    })
                }
            ]
        })
    },
    // // 更新功能使用情况chart
    // updateFunStatChart(data) {
    //     this.$funStatChart.setOption({
    //         angleAxis: {
    //             max: 10,
    //             startAngle: 90,
    //             splitLine: {
    //                 show: true
    //             }
    //         },
    //         radiusAxis: {
    //             type: 'category',
    //             data: ['v', 'w', 'x', 'y', 'z'],
    //             z: 10,
    //             max: 10,
    //         },
    //         polar: {
    //         },
    //         series: [{
    //             type: 'bar',
    //             data: [0, 6, 0, 5, 0, 4, 0, 3, 0, 1],
    //             coordinateSystem: 'polar',
    //             name: 'With Round Cap',
    //             roundCap: true,
    //             color: 'rgba(0, 200, 0, 0.5)',
    //             itemStyle: {
    //                 borderColor: 'green',
    //                 borderWidth: 1
    //             }
    //         }],
    //         legend: {
    //             show: true,
    //             data: ['Without Round Cap', 'With Round Cap']
    //         }
    //     })
    // },
    // 新建一个webSocket监听预警管理
    webSocket(userName, callback) {
        if(!WebSocket) {
            console.warn('当前浏览器不支持socket')
        }
        let ws = new window.WebSocket('ws://' + document.location.host + '/jetk/websocket/' + userName)
        ws.onopen = () => {
            console.warn('WebSocket connecting...')
        }
        ws.onmessage = res => {
            if(res && callback) {
                callback(res)
            }
        }
        // 刷新、离开、关闭页面时断开websocket
        window.onbeforeunload = () => {
            ws.close()
        }
    },
}
new Vue({
    el: '#indexApp',
    data: {
        userInfo: {
            userName: '- -',
            endTime: '- -',
            mobile: '- -'
        },
        headerHolderSrc: headerHolderSrc,
        judgePercent: 0,
        focusPeoplePercent: 0,
        warnTipsList: [
            { warnTime: '2019-01-10 23:48:32', userName: '张益达', reason: '离开北京市预警' },
            { warnTime: '2019-01-10 23:48:32', userName: '张益达', reason: '离开北京市预警' },
            { warnTime: '2019-01-10 23:48:32', userName: '张益达', reason: '离开北京市预警' },
        ],
        zdrInformation: [],
        historyDateType: 1,
        nearlyTableColumn: [
            { label: '案件编号', prop: 'caseNum' },
            { label: '案件名称', prop: 'caseName' },
            { label: '案件类型', prop: 'caseTypeDesc' },
            { label: '案件失效时间', prop: 'invalidTime' },
        ],
        nearlyTableData: [],
        processColorList: ['#ffb73a', '#eb4549', '#25d1d7', '#f152eb', '#fe69b3', '#3aee8a'],
        funStatDataList: [],
        sourceStatDataList: []
    },
    mounted() {
        index.init()
        this.getNearlyCaseData()
        this.getUserInfoData()
        this.getZdrMessage()
        this.getSystemInformation()
    },
    methods: {
        // 获取近期案件、案件类型数据
        getNearlyCaseData() {
            const me = this
            $.ajax({
                url: '/jetk/home/caseInfo',
                type: 'post',
                success(res) {
                    if(res.cases) {
                        me.nearlyTableData = res.cases
                    }
                    if(res.caseType) {
                        index.updateCaseTypeChart(res.caseType)
                    }
                },
                error() {
                    console.log('获取失败')
                }
            })
        },
        // 获取用户信息数据
        getUserInfoData() {
            const me = this
            $.ajax({
                url: '/jetk/home/userInfo',
                type: 'post',
                success(res) {
                    if(res.user) {
                        me.userInfo = { ...res.user }
                        for(let prop in me.userInfo) {
                            console.log(prop + ': ' + me.userInfo[prop])
                        }
                        // 有用户信息时开始socket监听
                        res.user.userName && index.webSocket(res.user.userName, socketData => {
                            let _SocData = JSON.parse(socketData.data)
                            // 数据为空则直接返回
                            if(!_SocData.length) {
                                return
                            }
                            let needSpeakText = ''
                            me.warnTipsList = JSON.parse(socketData.data)
                            _SocData.forEach(ele => {
                                me.warnTipsList.unshift({
                                    userName: ele.userName,
                                    warnTime: formatTime(ele.warnTime, 'yy-MM-dd hh:mm:ss'),
                                    reason: ele.reason,
                                })
                                // 读取顺序为 时间 -> 人名 -> 原因
                                if(ele.voiceTrigger == 1) {
                                    // 调取commonHeader.js中定义的 时间格式化 方法
                                    needSpeakText += formatTime(ele.warnTime, 'yy-MM-dd hh:mm:ss') + '，'
                                    needSpeakText += ele.userName + '，'
                                    needSpeakText += ele.reason + '。'
                                }
                            })
                            if(me.warnTipsList.length > 3) {
                                // 超过3则截取并丢弃
                                me.warnTipsList.splice(3)
                            }
                            if(needSpeakText) {
                                // 调取commonHeader.js中定义的 文字阅读 方法
                                myReadText(needSpeakText)
                            }
                        })
                    }
                },
                error() {
                    console.log('获取用户信息失败了')
                }
            })
        },
        // 获取重点人信息
        getZdrMessage() {
            const me = this
            $.ajax({
                url: '/jetk/home/maintenance',
                type: 'post',
                success(res) {
                    if(res.result) {
                        me.zdrInformation = res.result
                    }
                },
                error() {
                    console.log('获取重点人信息失败了')
                }
            })
        },
        // 获取系统任务使用情况
        getSystemInformation() {
            const me = this
            $.ajax({
                url: '/jetk/home/taskInfo',
                type: 'post',
                data: {
                    search: me.historyDateType
                },
                success(res) {
                    // 历史数据更新
                    if(res.caseTcs && res.taskTcs) {
                        index.updateHistoryChart({
                            caseTcs: res.caseTcs,
                            taskTcs: res.taskTcs
                        })
                    }
                    // 研判数据百分比
                    if(res.judgeUsing && res.judgeAll) {
                        me.judgePercent = (res.judgeUsing / res.judgeAll).toFixed(2) * 100
                    }
                    // 防控模型百分比
                    if(res.focusPeopleUsing && res.focusPeopleAll) {
                        me.focusPeoplePercent = (res.focusPeopleUsing / res.focusPeopleAll).toFixed(2) * 100
                    }
                    // 功能使用情况
                    if(res.taskAll && res.taskUsing) {
                        let allObj = {}
                        res.taskAll.forEach(ele => {
                            // @todo 此处计算最大值是因为可能会有重复的ele.type 实际数据不应该有重复的
                            allObj[ele.type] = Math.max(ele.count, allObj[ele.type] || 0)
                        })
                        me.funStatDataList = res.taskUsing.map(ele => {
                            let percent = parseInt(ele.count * 100 / allObj[ele.type])
                            return {
                                ...ele,
                                total: allObj[ele.type],
                                percent: percent >= 100 ? 100 : percent
                            }
                        })
                    }
                    // 资源累计情况
                    if(res.tvs) {
                        // @todo 按总数为1000来计算百分比
                        me.sourceStatDataList = res.tvs.map(ele => {
                            return {
                                ...ele,
                                percent: ele.count >= 1000 ? 100 : ele.count / 10 // 此处按总数为1000来计算
                            }
                        })
                    }
                },
                error() {
                    console.log('获取系统任务使用情况失败了')
                }
            })
        },
    }
})