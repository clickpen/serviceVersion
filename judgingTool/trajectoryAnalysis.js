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
    },

}
new Vue({
    el: '#trajectoryAnalysis',
    data: {
        netimageShow: true,
    	total: 0,
		pageSize: 10,
		loading: false,
		page: 1,
		labes:[],
		taskId:$("#taskId").val(),
		account:$("#taskAccount").val(),
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
		srcPortFormatter:function(row,colum) {
			return row.startPort + "-" + row.endPort
		}
	}
	
	
})