new Vue({
    el: '#indexApp',
    data: {
        historyDate: '',
        nearlyTableColumn: [
            { label: '案件编号', prop: 'caseNum' },
            { label: '案件名称', prop: 'caseName' },
            { label: '案件类型', prop: 'caseType' },
            { label: '案件失效时间', prop: 'caseTimeless' },
        ],
        nearlyTableData: [
            { caseNum: 'AW212211', caseName: 'xxxxx案件', caseType: '一般案件', caseTimeless: '2020/10/10' },
            { caseNum: 'AW212211', caseName: 'xxxxx案件', caseType: '一般案件', caseTimeless: '2020/10/10' },
            { caseNum: 'AW212211', caseName: 'xxxxx案件', caseType: '一般案件', caseTimeless: '2020/10/10' },
            { caseNum: 'AW212211', caseName: 'xxxxx案件', caseType: '一般案件', caseTimeless: '2020/10/10' },
            { caseNum: 'AW212211', caseName: 'xxxxx案件', caseType: '一般案件', caseTimeless: '2020/10/10' },
            { caseNum: 'AW212211', caseName: 'xxxxx案件', caseType: '一般案件', caseTimeless: '2020/10/10' },
            { caseNum: 'AW212211', caseName: 'xxxxx案件', caseType: '一般案件', caseTimeless: '2020/10/10' },
            { caseNum: 'AW212211', caseName: 'xxxxx案件', caseType: '一般案件', caseTimeless: '2020/10/10' },
            { caseNum: 'AW212211', caseName: 'xxxxx案件', caseType: '一般案件', caseTimeless: '2020/10/10' },
            { caseNum: 'AW212211', caseName: 'xxxxx案件', caseType: '一般案件', caseTimeless: '2020/10/10' },
        ]
    },
    methods: {
        sourcePhoneFormat(percentage) {
            return percentage
        }
    }
})
let index = {
    $historyStatChart: echarts.init(document.getElementById('historyStatChart')),
    $caseStatChart: echarts.init(document.getElementById('caseStatChart')),
    $funStatChart: echarts.init(document.getElementById('funStatChart')),
    init() {
        this.bind()
        this.initCharts()
    },
    initCharts() {
        const me = this
        me.$historyStatChart.setOption({
            legend: {
                data: ['line1', 'line2']
            },
            tooltip: {
                trigger: 'axis'
            },
            xAxis: {
                type: 'category',
                data: ['一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月', '十二月',]
            },
            yAxis: {
                type: 'value'
            },
            series: [{
                name: 'line1',
                data: [820, 932, 901, 934, 1290, 1330, 1320, 901, 934, 1290, 1330, 1320],
                type: 'line',
                smooth: true
            }, {
                name: 'line2',
                data: [932, 901, 934, 1290, 800, 900, 1330, 1320, 1290, 1330, 1320, 1440],
                type: 'line',
                smooth: true
            }]
        })
        me.$caseStatChart.setOption({
            tooltip: {
                trigger: 'item',
                formatter: '{a} <br/>{b}: {c} ({d}%)'
            },
            legend: {
                orient: 'vertical',
                left: 10,
                data: ['直接访问', '邮件营销', '联盟广告', '视频广告', '搜索引擎']
            },
            series: [
                {
                    name: '访问来源',
                    type: 'pie',
                    radius: ['50%', '70%'],
                    avoidLabelOverlap: false,
                    label: {
                        show: false,
                        position: 'center'
                    },
                    emphasis: {
                        label: {
                            show: true,
                            fontSize: '30',
                            fontWeight: 'bold'
                        }
                    },
                    labelLine: {
                        show: false
                    },
                    data: [
                        { value: 335, name: '直接访问' },
                        { value: 310, name: '邮件营销' },
                        { value: 234, name: '联盟广告' },
                        { value: 135, name: '视频广告' },
                        { value: 1548, name: '搜索引擎' }
                    ]
                }
            ]
        })
        me.$funStatChart.setOption({
            angleAxis: {
                max: 10,
                startAngle: 90,
                splitLine: {
                    show: true
                }
            },
            radiusAxis: {
                type: 'category',
                data: ['v', 'w', 'x', 'y', 'z'],
                z: 10,
                max: 10,
            },
            polar: {
            },
            series: [{
                type: 'bar',
                data: [0, 6, 0, 5, 0, 4, 0, 3, 0, 1],
                coordinateSystem: 'polar',
                name: 'With Round Cap',
                roundCap: true,
                color: 'rgba(0, 200, 0, 0.5)',
                itemStyle: {
                    borderColor: 'green',
                    borderWidth: 1
                }
            }],
            legend: {
                show: true,
                data: ['Without Round Cap', 'With Round Cap']
            }
        })
    },
    bind() { }
}
index.init()