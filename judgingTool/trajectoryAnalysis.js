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
	day1PointCollection:1,
	day2PointCollection:1,
	day3PointCollection:1,
	day4PointCollection:1,
	night1PointCollection:1,
	night2PointCollection:1,
	night3PointCollection:1,
	night4PointCollection:1,
	cover1PointCollection:1,
    init() {
        this.array = [];
        this.$map = new BMap.Map('mapContent', { enableMapClick: false })
//        this.initCloud()
        this.initMap();
    },
//    initCloud() {
//        $('#keyCloud').jQCloud(this.array);
//    },
    initMap() {
        const me = this
        // 初始化地图,设置中心点坐标和地图级别
        me.$map.centerAndZoom(new BMap.Point(116.404, 39.915), 8)
        //开启鼠标滚轮缩放
        me.$map.enableScrollWheelZoom(true);
        let point = new BMap.Point(116.404, 39.915);
        var points1 = [];
        points1.push(point);
        
        //6  夜间 小于30分钟
        //7  夜间 大于30分钟 小于1小时
        //8  夜间 大于 1小时
        //9  夜间 大于4小时
        //10  日间 小于30分钟
        //11  日间 大于30分钟 小于1小时
        //12  日间 大于 1小时
        //13  日间 大于4小时
        //14  日夜间
        this.day1PointCollection =  new BMap.PointCollection([],{shape: 13});
        this.day2PointCollection =  new BMap.PointCollection([],{shape: 12});
        this.day3PointCollection =  new BMap.PointCollection([],{shape: 11});
        this.day4PointCollection =  new BMap.PointCollection([],{shape: 10});
        this.night1PointCollection = new BMap.PointCollection([],{shape: 9});
        this.night2PointCollection = new BMap.PointCollection([],{shape: 8});
        this.night3PointCollection = new BMap.PointCollection([],{shape: 7});
        this.night4PointCollection = new BMap.PointCollection([],{shape: 6});
        this.cover1PointCollection = new BMap.PointCollection([],{shape: 14});
		me.$map.addOverlay(this.day1PointCollection);
		me.$map.addOverlay(this.day2PointCollection);
		me.$map.addOverlay(this.day3PointCollection);
		me.$map.addOverlay(this.day4PointCollections);
		me.$map.addOverlay(this.night1PointCollection);
		me.$map.addOverlay(this.night2PointCollection);
		me.$map.addOverlay(this.night3PointCollection);
		me.$map.addOverlay(this.night4PointCollection);
		me.$map.addOverlay(this.night4PointCollection);
		
		
		 this.day1PointCollection.setPoints(points1);
		
		
		
    },
    addMapObj(tt){
		var str = '';
		if  (tt.type ==1) {
			var hour =  tt.num/60;
			if (hour>=4) {
				str = 'day1';
			} else if (hour>=1 && hour< 4) {
				str = 'day2';
			} else if (hour < 1 && tt.num>=  30) {
				str = 'day3';
			} else if( tt.num < 30) {
				str = 'day4';
			}
		} else 	if (tt.type ==2) {
			var hour = tt.num/60;
			if (hour>=4) {
				str = 'night1';
			} else if (hour>=1 && hour< 4) {
				str = 'night2';
			} else if (hour < 1 && tt.num>=  30) {
				str = 'night3';
			} else if( tt.num < 30) {
				str = 'night4';
			}
		} else 	if (tt.type ==3) {
			str = 'cover1';
		}
		trajectoryObj.addMapPoint(tt.x, tt.y, str,tt.num);
    },
    // 添加地图点
    addMapPoint(x, y, type,num) {
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
        mapAnalysisTable: [],
        trajectoryTableData: [],//结果
		trajectory:[],//轨迹点。
		fastforward:0.25,//快进比例
		fastrewind:2,//快退比例。
		fast:100,//秒
		suspend:1,//暂停方式。 1 是不暂停  2 是暂停。
		fastforwardMax:0.25,//快进最大比例
		fastrewindMin:4,//最大比例
		iCount:1,
		index:0,  //播放从地几个开始。
    },
    mounted() {
        trajectoryObj.init();
    },
    created: function() {
        this.getTableDada();
        this.loadDada();
    },
    methods: {
    	handleplayback:function() {//处理轨迹回放。
    	
    	},
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
                	var result = res.result;
                	if (result) {
                		//号码归属地。
                    	var address = result.accountBelong;
                    	if (address) {
                    		$("#accountAddress").text(address);
                    	}
                    	//虚拟身份。
                    	var  trackVirtual  = result.trackVirtual;
                    	if (trackVirtual) {
                    		for (var i = 0;i<trackVirtual.length;i++) {
                    			var str = "<p class='content'><span class='label'>"+trackVirtual[i].virtualName+"：</span><span>"+trackVirtual[i].virtualIdentity+"</span></p>";
                    			$("#virtualList").append(str);
                    		}
                    	}
                    	//网站分析。
                     	var  trackWebName  = result.trackWebName;
                     	if (trackWebName) {
                     		for (var i = 0;i<trackWebName.length;i++) {
                     			var  str = "<p class='content'><span class='des'>"+trackWebName[i].website+"</span><span class='type'>"+trackWebName[i].webName+"</span><span class='number'>"+trackWebName[i].num+"条</span></p>";
                    			$("#trackWebNameList").append(str);
                    		}
                     	}
                    	//访问协议分析
                     	var trackProtocol = result.trackProtocol;
                     	if (trackProtocol) {
                     		for (var i = 0;i<trackProtocol.length;i++) {
                     			var str = "<p class='content'><span class='des'>"+trackProtocol[i].dstPort+"</span><span class='type'>"+trackProtocol[i].dstName+"</span><span class='number'>"+trackProtocol[i].num+"条</span></p>";
                     			$("#trackProtocolList").append(str);
                    		}
                     	}
                    	//关键词分析(注：文字云)
                    	var keyWord = [];
                    	var trackKeyWord = result.trackKeyWord;
                    	if (trackKeyWord) {
                    		for (var i = 0;i<trackKeyWord.length;i++) {
                    			var objKeyWord = {};
                    			objKeyWord.text = trackKeyWord[i].keyWord;
                    			objKeyWord.weight = trackKeyWord[i].num;
                    			keyWord.push(objKeyWord);
                    		}
                    	}
                    	 $('#keyCloud').jQCloud(keyWord);
                    	//使用APP分析
                    	var trackKeyApp = result.trackKeyApp;
                    	if (trackKeyApp) {
                    		for (var i = 0;i<trackKeyApp.length;i++) {
            					var str =   "<li class='app-card'>'"+
            						"<img src='https://dss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=1306607258,967818222&fm=111&gp=0.jpg'>"+
                                	"<p class='app-tit'>"+trackKeyApp[i].serviceName+"</p>"+
                                	"<p class='app-num'>"+trackKeyApp[i].num+"条</p>"+
                                "</li>";
            					$('#trackApp').html(str);	
                    		}
                    	}
                    	//白天落脚点。
                    	var trackDayStopover = result.trackDayStopover;
                    	if (trackDayStopover) {
                    		$("#dayLac").text(trackDayStopover.lac);
                    		$("#dayCi").text(trackDayStopover.ci);
                    		$("#dayAddress").text(trackDayStopover.address);
                    	}
                    	//夜间落脚点。
                    	var trackNightStopover = result.trackNightStopover;
                    	if (trackNightStopover) {
                    		$("#nightLac").text(trackNightStopover.lac);
                    		$("#nightCi").text(trackNightStopover.ci);
                    		$("#nightAddress").text(trackNightStopover.address);
                    	}
                    	//时空分布。
                    	var mapTrackSapceTime = [];
                    	var trackSpaceTime = result.trackSpaceTime;
                    	if (trackSpaceTime) {
                    		for (var i = 0;i<trackSpaceTime.length;i++) {
                    			var index = {};
                    			index.timeScan = trackSpaceTime[i].timeScan;
                    			var tlist = trackSpaceTime[i].list;
                    			if (tlist.length >=1) {
                    				index.position1 = tlist[0].lac +"," +tlist[0].ci ;
                    			}
                    			if (tlist.length >=2) {
                    				index.position2 =tlist[1].lac +"," +tlist[0].ci ;
                    			}
								if (tlist.length >=3) {
									index.position3 =tlist[2].lac +"," +tlist[2].ci ;
                    			}
								mapTrackSapceTime.push(index);
                    		}
                    	}
                    	me.mapAnalysisTable = mapTrackSapceTime;
                    	//轨迹。
                    	var trackTrajectory = result.trackTrajectory;
                    	if (trackTrajectory) {
                    		me.trajectory = trackTrajectory;
                    		for (var i= 0; i< trackTrajectory.length;i++) {
                    			var tt = trackTrajectory[i];
                    			trajectoryObj.addMapObj(tt);
                    		}
                    	}
                	}
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