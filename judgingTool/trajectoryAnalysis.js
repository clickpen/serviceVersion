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
	myInfoMarker:1,
	day1PointCollection:1,
	day2PointCollection:1,
	day3PointCollection:1,
	day4PointCollection:1,
	night1PointCollection:1,
	night2PointCollection:1,
	night3PointCollection:1,
	night4PointCollection:1,
	cover1PointCollection:1,
	day1point:[],
	day2point:[],
	day3point:[],
	day4point:[],
	night1point:[],
	night2point:[],
	night3point:[],
	night4point:[],
	cover1point:[],
	day1data:[],
	day2data:[],
	day3data:[],
	day4data:[],
	night1data:[],
	night2data:[],
	night3data:[],
	night4data:[],
	cover1data:[],
    init() {
        this.array = [];
        this.$map = new BMap.Map('mapContent', { enableMapClick: false })
//        this.initCloud()
        this.initMap();
    },
    initMapEventListener(coll,data) {//初始化监听
    	const me = this;
    	coll.addEventListener('click', function (e) {
    		if (data) {
	         	for (var index in data) {
	         		var item = data[index];
	 				if (item.x == e.point.lng && item.y == e.point.lat) {
	 					var point = new BMap.Point(e.point.lng,e.point.lat);
	 					me.$map.centerAndZoom(point, me.$map.getZoom());
	 					me.$map.removeOverlay(me.myInfoMarker);
	 					let className = Math.random() > 0.5 ? 'red-info' : 'green-info';
	 					me.showMapInfo(point, className,item);
	 				}
	 			}
    		}
         });
    },
    initMap() {
        const me = this
        // 初始化地图,设置中心点坐标和地图级别
        me.$map.centerAndZoom(new BMap.Point(114.966222, 27.091476), 8)
        //开启鼠标滚轮缩放
        me.$map.enableScrollWheelZoom(true);
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
        me.initMapEventListener(this.day1PointCollection,this.day1data);//初始化监听
        this.day2PointCollection =  new BMap.PointCollection([],{shape: 12});
        me.initMapEventListener(this.day2PointCollection,this.day2data);//初始化监听
        this.day3PointCollection =  new BMap.PointCollection([],{shape: 11});
        me.initMapEventListener(this.day3PointCollection,this.day3data);//初始化监听
        this.day4PointCollection =  new BMap.PointCollection([],{shape: 10});
        me.initMapEventListener(this.day4PointCollection,this.day4data);//初始化监听
        this.night1PointCollection = new BMap.PointCollection([],{shape: 9});
        me.initMapEventListener(this.night1PointCollection,this.night1data);//初始化监听
        this.night2PointCollection = new BMap.PointCollection([],{shape: 8});
        me.initMapEventListener(this.night2PointCollection,this.night2data);//初始化监听
        this.night3PointCollection = new BMap.PointCollection([],{shape: 7});
        me.initMapEventListener(this.night3PointCollection,this.night3data);//初始化监听
        this.night4PointCollection = new BMap.PointCollection([],{shape: 6});
        me.initMapEventListener(this.night4PointCollection,this.night4data);//初始化监听
        this.cover1PointCollection = new BMap.PointCollection([],{shape: 14});
        me.initMapEventListener(this.cover1PointCollection,this.cover1data);//初始化监听
		me.$map.addOverlay(this.day1PointCollection);
		me.$map.addOverlay(this.day2PointCollection);
		me.$map.addOverlay(this.day3PointCollection);
		me.$map.addOverlay(this.day4PointCollection);
		me.$map.addOverlay(this.night1PointCollection);
		me.$map.addOverlay(this.night2PointCollection);
		me.$map.addOverlay(this.night3PointCollection);
		me.$map.addOverlay(this.night4PointCollection);
		me.$map.addOverlay(this.cover1PointCollection);
    },
//    addMapObj(tt){
//		var str = '';
//		if  (tt.type ==1) {
//			var hour =  tt.num/60;
//			if (hour>=4) {
//				str = 'day1';
//			} else if (hour>=1 && hour< 4) {
//				str = 'day2';
//			} else if (hour < 1 && tt.num>=  30) {
//				str = 'day3';
//			} else if( tt.num < 30) {
//				str = 'day4';
//			}
//		} else 	if (tt.type ==2) {
//			var hour = tt.num/60;
//			if (hour>=4) {
//				str = 'night1';
//			} else if (hour>=1 && hour< 4) {
//				str = 'night2';
//			} else if (hour < 1 && tt.num>=  30) {
//				str = 'night3';
//			} else if( tt.num < 30) {
//				str = 'night4';
//			}
//		} else 	if (tt.type ==3) {
//			str = 'cover1';
//		}
//		trajectoryObj.addMapPoint(tt.x, tt.y, str,tt.num);
//    }
    // 添加地图点
//    addMapPoint(x, y, type,num) {
//        const me = this
//        if(!type) {
//            return
//        }
//        let point = new BMap.Point(x, y)
//        let icon = null
//        let iconSize = new BMap.Size(30, 39)
//        let offset = new BMap.Size(0, -18)
//        // 对type进行类型判断
//        switch(type) {
//            case 'day1':
//            icon = new BMap.Icon('/jetk/views/judgingTool/imgs/day-1.png', iconSize)
//                break
//            case 'day2':
//            icon = new BMap.Icon('/jetk/views/judgingTool/imgs/day-2.png', iconSize)
//                break
//            case 'day3':
//            icon = new BMap.Icon('/jetk/views/judgingTool/imgs/day-3.png', iconSize)
//                break
//            case 'day4':
//            icon = new BMap.Icon('/jetk/views/judgingTool/imgs/day-4.png', iconSize)
//                break
//            case 'night1':
//            icon = new BMap.Icon('/jetk/views/judgingTool/imgs/night-1.png', iconSize)
//                break
//            case 'night2':
//            icon = new BMap.Icon('/jetk/views/judgingTool/imgs/night-2.png', iconSize)
//                break
//            case 'night3':
//            icon = new BMap.Icon('/jetk/views/judgingTool/imgs/night-3.png', iconSize)
//                break
//            case 'night4':
//            icon = new BMap.Icon('/jetk/views/judgingTool/imgs/night-4.png', iconSize)
//                break
//            case 'cover1':
//            icon = new BMap.Icon('/jetk/views/judgingTool/imgs/cover-1.png', iconSize)
//                break
//            default:
//                return
//        }
//    },
    // 展示地图info框
    showMapInfo(point, className, data) {
        const me = this
        let myInfoMarker = new MyMapInfo(point, className, ($dom, pixel) => {
            let _html = `<div class="map-info-image">
            		<img src="https://dss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=1306607258,967818222&fm=111&gp=0.jpg'">
                </div>
                <ul class="map-info-list">
                    <li class="map-info-card">
                        手机号：${data.account}
                    </li>
                    <li class="map-info-card">
                        访问时间：${data.accessTime}
                    </li>
                    <li class="map-info-card">
                        停留时间：${data.num}分钟
                    </li>
                    <li class="map-info-card">
                        lac：${data.lac} --  ci：${data.ci}
                    </li>
                    <li class="map-info-card">
	                    x：${data.x} --  y：${data.y}
	                </li>
	                <li class="map-info-card">
		               地址：${data.address}
		            </li>
                </ul>`
            $dom.innerHTML = _html
            // 对地图信息窗进行重新计算位置
            $dom.style.left = pixel.x - 86 + 'px'
            $dom.style.top = pixel.y - 8 - 153 + 'px'
        });
        me.myInfoMarker = myInfoMarker;
        me.$map.addOverlay(myInfoMarker);
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
		fastforward:0.5,//快进比例
		fastrewind:2,//快退比例。
		fast:1000,//秒
		current:0,
		fastforwardMax:250,//最快速度。
		fastrewindMin:4000,//最慢速度。
		index:0,  //播放从地几个开始。 //当前执行极端。
		status:0, //0 回放结束 ,1回放进行中, 2 暂停状态。
		timescan:96,
		startTime:1,
		endTime:1,
		time_interval:0,
		icount:0,//运行到底n个
    },
    mounted() {
        trajectoryObj.init();
    },
    created: function() {
        this.getTableDada();
        this.loadDada();
    },
    methods: {
    	handleForward:function() {//快进
    		let me = this;
    		if (me.current <= me.fastforwardMax) {
    			me.current = me.fastforwardMax;	
    		} else {
    			me.current = me.current* me.fastforward;
    		} 
    	},
	/*    handleForwardMax:function() {//最大快进
	    	let me = this;
	    	me.current = me.fastforwardMax;
		},*/
    	handleRewind:function() {//慢进
    		let me = this;
    		if (me.current>= me.fastforwardMax) {
    			me.current = me.fastrewindMin;	
    		} else {
    			me.current = me.current* me.fastrewind;
    		} 
		},
	/*	handleRewindMin:function() {//最大慢进。
			let me = this;
			me.current = me.fastrewindMin;
		},*/
    	handleplayback:function() {//处理轨迹回放。
    		let me = this;
    		var count = 0;
    		trajectoryObj.$map.removeOverlay(trajectoryObj.myInfoMarker);
    		if (me.index == 0) {
    			trajectoryObj.day1point=[];
    			trajectoryObj.day2point=[];
    			trajectoryObj.day3point=[];
    			trajectoryObj.day4point=[];
    			trajectoryObj.night1point=[];
    			trajectoryObj.night2point=[];
    			trajectoryObj.night3point=[];
    			trajectoryObj.night4point=[];
    			trajectoryObj.cover1point=[];
        		if (me.trajectory.length > 2) {
        			//分时间段。
        			me.startTime =new Date(me.trajectory[0].accessTime).valueOf();//开始时间段。
        			console.log(me.trajectory[me.trajectory.length-1].accessTime);
        			me.endTime = new Date(me.trajectory[me.trajectory.length-1].accessTime).valueOf();//结束时间段。  
        			me.time_interval = Math.ceil((me.endTime-me.startTime)/me.timescan);
        			me.icount = 0;
        			me.current = me.fast;//设置初始化速度。
        		}
        		me.status = 1;
    		}
    		if (me.trajectory.length > 2) {
    			var sdate = me.startTime + me.index * me.time_interval;
    			var edate = me.startTime + (me.index+1)  *  me.time_interval;
    			for (me.icount;me.icount< me.trajectory.length;me.icount++) {
    				//判断时间段。
    				var accessTimeValue = new Date(me.trajectory[me.icount].accessTime).valueOf();
    				if (accessTimeValue>= sdate && accessTimeValue<= edate) {
    					count ++;
    					let point = new BMap.Point(me.trajectory[me.icount].x, me.trajectory[me.icount].y);
        				switch (me.trajectory[me.icount].label) {
    					case "day1":
    						trajectoryObj.day1point.push(point);
    						break;
    					case "day2":
    						trajectoryObj.day2point.push(point);
    						break;
    					case "day3":
    						trajectoryObj.day3point.push(point);
    						break;
    					case "day4":
    						trajectoryObj.day4point.push(point);
    						break;
    					case "night1":
    						trajectoryObj.night1point.push(point);
    						break;
    					case "night2":
    						trajectoryObj.night2point.push(point);
    						break;
    					case "night3":
    						trajectoryObj.night3point.push(point);
    						break;
    					case "night4":
    						trajectoryObj.night4point.push(point);
    						break;
    					case "cover1":
    						trajectoryObj.cover1point.push(point);
    						break;
    					}
    				} else {
    					break;
    				}
    			}
    			me.index += 1;
    			if (me.index>me.timescan) {
    				me.index = 0;
    				me.status = 0; 
    			}
    		} else if (me.trajectory.length == 1 ) {
    			for (var i = 0;i< me.trajectory.length; i++) {
    				let point = new BMap.Point(e.trajectory[i].x, e.trajectory.y);
    				switch (me.trajectory[me.icount].label) {
					case "day1":
						trajectoryObj.day1point.push(point);
						break;
					case "day2":
						trajectoryObj.day2point.push(point);
						break;
					case "day3":
						trajectoryObj.day3point.push(point);
						break;
					case "day4":
						trajectoryObj.day4point.push(point);
						break;
					case "night1":
						trajectoryObj.night1point.push(point);
						break;
					case "night2":
						trajectoryObj.night2point.push(point);
						break;
					case "night3":
						trajectoryObj.night3point.push(point);
						break;
					case "night4":
						trajectoryObj.night4point.push(point);
						break;
					case "cover1":
						trajectoryObj.cover1point.push(point);
						break;
					}
    			}
    			me.index = 0;
    			me.status = 0; 
    		} else {
    			me.index = 0;
    			me.status = 0; 
    			return;
    		}
    		trajectoryObj.day1PointCollection.setPoints(trajectoryObj.day1point);
    		trajectoryObj.day2PointCollection.setPoints(trajectoryObj.day2point);
    		trajectoryObj.day3PointCollection.setPoints(trajectoryObj.day3point);
    		trajectoryObj.day4PointCollection.setPoints(trajectoryObj.day4point);
    		trajectoryObj.night1PointCollection.setPoints(trajectoryObj.night1point);
    		trajectoryObj.night2PointCollection.setPoints(trajectoryObj.night2point);
    		trajectoryObj.night3PointCollection.setPoints(trajectoryObj.night3point);
    		trajectoryObj.night4PointCollection.setPoints(trajectoryObj.night4point);
    		trajectoryObj.cover1PointCollection.setPoints(trajectoryObj.cover1point);
    		//0 回放结束 ,1回放进行中, 2 暂停状态。
    		if (me.status  == 1) {
    			if (count == 0) {
    				setTimeout(me.handleplayback,0);	
    			} else {
    				setTimeout(me.handleplayback,me.current);	
    			}
    		} 
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
                    	// = trackTrajectory;
                    		for (var i= 0; i< trackTrajectory.length;i++) {
                    			var tt = trackTrajectory[i];
                    			if (tt.x && tt.y) {
   
                    				var type = tt.type;
	                    			let point = new BMap.Point(tt.x, tt.y);
	                    			if (type == 1) {                    					
	                    				var tnum = (tt.num/60).toFixed(2);
	                    				if (tnum >= 4) {
	                    					tt.label= 'day1';
	                    					trajectoryObj.day1point.push(point);
	                    					trajectoryObj.day1data.push(tt);
	                    				} else if(tnum <4 && tnum>=1) {
	                    					tt.label= 'day2';
	                    					trajectoryObj.day2point.push(point);
	                    					trajectoryObj.day2data.push(tt);
	                    				} else if(tnum <1 && tnum>=0.5) {
	                    					tt.label= 'day3';
	                    					trajectoryObj.day3point.push(point);
	                    					trajectoryObj.day3data.push(tt);
	                    				} else if(tnum <0.5) {
	                    					tt.label= 'day4';
	                    					trajectoryObj.day4point.push(point);
	                    					trajectoryObj.day4data.push(tt);
	                    				}
	                    			} else if (type == 2) {
	                    				var tnum = (tt.num/60).toFixed(2);
	                    				if (tnum >= 4) {
	                    					tt.label= 'night1';
	                    					trajectoryObj.night1point.push(point);
	                    					trajectoryObj.night1data.push(tt);
	                    				} else if(tnum <4 && tnum>=1) {
	                    					tt.label= 'night2';
	                    					trajectoryObj.night2point.push(point);
	                    					trajectoryObj.night2data.push(tt);
	                    				} else if(tnum <1 && tnum>=0.5) {
	                    					tt.label= 'night3';
	                    					trajectoryObj.night3point.push(point);
	                    					trajectoryObj.night3data.push(tt);
	                    				} else if(tnum <0.5) {
	                    					tt.label= 'night4';
	                    					trajectoryObj.night4point.push(point);
	                    					trajectoryObj.night4data.push(tt);
	                    				}
	                    			} else if (type == 3) {
	                    				tt.label= 'cover1';
	                    				trajectoryObj.cover1point.push(point);
                    					trajectoryObj.cover1data.push(tt);
	                    			}
	                    			me.trajectory.push(tt);
                    			}
                    		}
                    		trajectoryObj.day1PointCollection.setPoints(trajectoryObj.day1point);
                    		trajectoryObj.day2PointCollection.setPoints(trajectoryObj.day2point);
                    		trajectoryObj.day3PointCollection.setPoints(trajectoryObj.day3point);
                    		trajectoryObj.day4PointCollection.setPoints(trajectoryObj.day4point);
                    		trajectoryObj.night1PointCollection.setPoints(trajectoryObj.night1point);
                    		trajectoryObj.night2PointCollection.setPoints(trajectoryObj.night2point);
                    		trajectoryObj.night3PointCollection.setPoints(trajectoryObj.night3point);
                    		trajectoryObj.night4PointCollection.setPoints(trajectoryObj.night4point);
                    		trajectoryObj.cover1PointCollection.setPoints(trajectoryObj.cover1point);                    		
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