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
        this.initCloud()
    },
    initCloud() {
        console.table(this.array)
        $('#keyCloud').jQCloud(this.array)
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