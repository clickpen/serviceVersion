Date.prototype.format = function(fmt) {
	var o = {
		"M+": this.getMonth() + 1, //月份
		"d+": this.getDate(), //日
		"h+": this.getHours() % 12 == 0 ? 12 : this.getHours() % 12, //小时
		"H+": this.getHours(), //小时
		"m+": this.getMinutes(), //分
		"s+": this.getSeconds(), //秒
		"q+": Math.floor((this.getMonth() + 3) / 3), //季度
		"S": this.getMilliseconds() //毫秒
	};
	if (/(y+)/.test(fmt))
		fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
	for (var k in o)
		if (new RegExp("(" + k + ")").test(fmt))
			fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
	return fmt;
}

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
	if (this._className && this._className !== 'my-map-info-wrapper') {
		oDiv.classList.add(this._className)
	}
	map.getPanes().labelPane.appendChild(oDiv)
	return oDiv
}
MyMapInfo.prototype.draw = function() {
	let map = this._map
	// 平移至中心
	let pixel = map.pointToOverlayPixel(this._point)
	if (!this._notfirst) {
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
	myInfoMarker: 1,
	day1PointCollection: 1,
	day2PointCollection: 1,
	day3PointCollection: 1,
	day4PointCollection: 1,
	night1PointCollection: 1,
	night2PointCollection: 1,
	night3PointCollection: 1,
	night4PointCollection: 1,
	cover1PointCollection: 1,
	day1point: [],
	day2point: [],
	day3point: [],
	day4point: [],
	night1point: [],
	night2point: [],
	night3point: [],
	night4point: [],
	cover1point: [],
	day1data: [],
	day2data: [],
	day3data: [],
	day4data: [],
	night1data: [],
	night2data: [],
	night3data: [],
	night4data: [],
	cover1data: [],
	trajectoryPoints: [],
	init: function() {
		this.array = [];
		this.$map = new BMap.Map('mapContent', { enableMapClick: false })
		//        this.initCloud()
		this.initMap();
	},
	initMapEventListener: function(coll, data) {//初始化监听
		const me = this;
		coll.addEventListener('click', function(e) {
			if (data) {
				for (var index in data) {
					var item = data[index];
					if (item.x == e.point.lng && item.y == e.point.lat) {
						var point = new BMap.Point(e.point.lng, e.point.lat);
						me.$map.centerAndZoom(point, me.$map.getZoom());
						me.$map.removeOverlay(me.myInfoMarker);
						let className = item.num >= 30 ? 'red-info' : 'green-info';
						me.showMapInfo(point, className, item);
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
		this.day1PointCollection = new BMap.PointCollection([], { shape: 13 });
		me.initMapEventListener(this.day1PointCollection, this.day1data);//初始化监听
		this.day2PointCollection = new BMap.PointCollection([], { shape: 12 });
		me.initMapEventListener(this.day2PointCollection, this.day2data);//初始化监听
		this.day3PointCollection = new BMap.PointCollection([], { shape: 11 });
		me.initMapEventListener(this.day3PointCollection, this.day3data);//初始化监听
		this.day4PointCollection = new BMap.PointCollection([], { shape: 10 });
		me.initMapEventListener(this.day4PointCollection, this.day4data);//初始化监听
		this.night1PointCollection = new BMap.PointCollection([], { shape: 9 });
		me.initMapEventListener(this.night1PointCollection, this.night1data);//初始化监听
		this.night2PointCollection = new BMap.PointCollection([], { shape: 8 });
		me.initMapEventListener(this.night2PointCollection, this.night2data);//初始化监听
		this.night3PointCollection = new BMap.PointCollection([], { shape: 7 });
		me.initMapEventListener(this.night3PointCollection, this.night3data);//初始化监听
		this.night4PointCollection = new BMap.PointCollection([], { shape: 6 });
		me.initMapEventListener(this.night4PointCollection, this.night4data);//初始化监听
		this.cover1PointCollection = new BMap.PointCollection([], { shape: 14 });
		me.initMapEventListener(this.cover1PointCollection, this.cover1data);//初始化监听
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
	// 展示地图info框
	showMapInfo(point, className, data) {
		const me = this
		let myInfoMarker = new MyMapInfo(point, className, ($dom, pixel) => {
			let _html = `<div class="map-info-image">
            		<img src="/jetk/appIcon/http.png">
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
	                <el-popover placement="top-start" title="协议" width="200" trigger="hover"
                        v-bind:content="${data.address}">
                        <li  slot="reference" class="map-info-card" title ="${data.address}">
			               地址：${data.address}
			            </li>
                    </el-popover>
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
		trackKeyApp: [],
		trackVirtual: [],//虚拟身份分析
		webSite: [], //网站分析。
		trackProtocol: [],//协议分析。
		dialogSearch: false,
		netimageShow: true,
		total: 0,
		labelname: '',
		pageSize: 10,
		loading: false,
		page: 1,
		labes: [],
		taskId: $("#taskId").val(),
		account: $("#taskAccount").val(),
		mapAnalysisTable: [],
		trajectoryTableData: [],//结果
		trajectory: [],//轨迹点。
		fastforward: 0.5,//快进比例
		fastrewind: 2,//快退比例。
		fast: 1000,//秒
		current: 0,
		fastforwardMax: 250,//最快速度。
		fastrewindMin: 4000,//最慢速度。
		index: 0,  //播放从地几个开始。 //当前执行极端。
		status: 0, //0 回放结束 ,1回放进行中, 2 暂停状态。
		timescan: 96,
		startTime: 1,
		accountAddress: '',
		endTime: 1,
		time_interval: 0,
		icount: 0,//运行到底n个
		inputWidth: '468px',
		formLabelWidth: '120px',
		trackDayStopover: '',
		trackNightStopover: '',
		form: {
			accessTime: '',
			imei: '',
			imsi: '',
			priIp: '',
			pubIp: '',
			pubPort: '',
			dstIp: '',
			dstPort: '',
			serviceName: '',
			labelName: '',
			url: '',
			lac: '',
			ci: '',
			address: '',
		},
		pickerOptions: {
			shortcuts: [{
				text: '最近一周',
				onClick(picker) {
					const end = new Date();
					const start = new Date();
					start.setTime(start.getTime() - 3600 * 1000 * 24 * 7);
					picker.$emit('pick', [start, end]);
				}
			}, {
				text: '最近一个月',
				onClick(picker) {
					const end = new Date();
					const start = new Date();
					start.setTime(start.getTime() - 3600 * 1000 * 24 * 30);
					picker.$emit('pick', [start, end]);
				}
			}, {
				text: '最近三个月',
				onClick(picker) {
					const end = new Date();
					const start = new Date();
					start.setTime(start.getTime() - 3600 * 1000 * 24 * 90);
					picker.$emit('pick', [start, end]);
				}
			}]
		},

		rules: {

		},
	},
	mounted() {
		trajectoryObj.init();
	},
	created: function() {
		this.getTableDada();
		this.loadDada();
	},
	methods: {
		// 点击列表展示地图点
		handleShowPoint(data) {
			let me = this;
			//判断是否已经结束 回放了。
			if (me.status != 0) {
				me.$message.closeAll();
				me.$message({
					message: '请等待轨迹回放完成',
					type: 'warning'
				});
				return;
			}
			if (!data.x || !data.y) {
				return
			} else {
				for (var index in me.trajectory) {
					var item = me.trajectory[index];
					if (item.x == data.x && item.y == data.y) {
						var point = new BMap.Point(data.x, data.y);
						trajectoryObj.$map.centerAndZoom(point, trajectoryObj.$map.getZoom());
						trajectoryObj.$map.removeOverlay(trajectoryObj.myInfoMarker);
						let className = item.num > 30 ? 'red-info' : 'green-info';
						trajectoryObj.showMapInfo(point, className, item);
						break;
					}
				}
			}
		},
		submitForm(formName) {
			this.getTableDada();
		},
		resetForm(formName) {
			this.$refs[formName].resetFields();
			this.form = {
				accessTime: '',
				imei: '',
				imsi: '',
				priIp: '',
				pubIp: '',
				pubPort: '',
				dstIp: '',
				dstPort: '',
				serviceName: '',
				labelName: '',
				url: '',
				lac: '',
				ci: '',
				address: ''
			}
		},
		handleClose: function(done) {
			this.$confirm('确认关闭？')
				.then(() => {
					done();
				})
				.catch(() => { });
		},
		handleForward: function() {//快进
			let me = this;
			if (me.current <= me.fastforwardMax) {
				me.current = me.fastforwardMax;
			} else {
				me.current = me.current * me.fastforward;
			}
		},

		handleRewind: function() {//慢进
			let me = this;
			if (me.current >= me.fastforwardMax) {
				me.current = me.fastrewindMin;
			} else {
				me.current = me.current * me.fastrewind;
			}
		},

		handleplayback: function(ck) {//处理轨迹回放。
			let me = this;
			if (ck) {
				if (me.status == 1) {
					me.status = 2;
					me.$message.closeAll();
					me.$message({
						message: '暂停',
						type: 'success',
						duration: 0
					});
				} else if (me.status == 2) {
					me.$message.closeAll();
					me.$message({
						message: '取消暂停',
						type: 'success'
					});
					me.status = 1;
				}
			}
			var count = 0;
			trajectoryObj.$map.removeOverlay(trajectoryObj.myInfoMarker);
			if (me.index == 0) {
				trajectoryObj.day1point = [];
				trajectoryObj.day2point = [];
				trajectoryObj.day3point = [];
				trajectoryObj.day4point = [];
				trajectoryObj.night1point = [];
				trajectoryObj.night2point = [];
				trajectoryObj.night3point = [];
				trajectoryObj.night4point = [];
				trajectoryObj.cover1point = [];
				if (me.trajectory.length > 2) {
					//分时间段。
					me.startTime = new Date(me.trajectory[0].accessTime).valueOf();//开始时间段。
					console.log(me.trajectory[me.trajectory.length - 1].accessTime);
					me.endTime = new Date(me.trajectory[me.trajectory.length - 1].accessTime).valueOf();//结束时间段。  
					me.time_interval = Math.ceil((me.endTime - me.startTime) / me.timescan);
					me.icount = 0;
					me.current = me.fast;//设置初始化速度。
				}
				me.status = 1;
			}
			if (me.trajectory.length > 2) {
				var sdate = me.startTime + me.index * me.time_interval;
				var edate = me.startTime + (me.index + 1) * me.time_interval;
				for (me.icount; me.icount < me.trajectory.length; me.icount++) {
					//判断时间段。
					var accessTimeValue = new Date(me.trajectory[me.icount].accessTime).valueOf();
					if (accessTimeValue >= sdate && accessTimeValue <= edate) {
						count++;
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
				if (me.index > me.timescan) {
					me.index = 0;
					me.status = 0;
					me.$message({
						message: '轨迹回放完成',
						type: 'success'
					});
					me.$message.closeAll();
				}
			} else if (me.trajectory.length == 1) {
				for (var i = 0; i < me.trajectory.length; i++) {
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
			if (me.status == 1) {
				if (count == 0) {
					setTimeout(me.handleplayback, 0);
				} else {
					setTimeout(me.handleplayback, me.current);
				}
			}
		},
		getTableDada: function(page) {
			let me = this;
			me.loading = true;
			page = page || 1;
			var startTime = '';
			var endTime = '';
			console.log(me.labelName);
			if (me.form.accessTime) {
				startTime = (me.form.accessTime[0]).format("yyyy-MM-dd HH:mm:ss");
				endTime = (me.form.accessTime[1]).format("yyyy-MM-dd HH:mm:ss");
			}
			$.ajax({
				url: '/jetk/queryTask/syresult/list',
				type: "post",
				dataType: "json",
				contentType: "application/x-www-form-urlencoded; charset=utf-8",
				data: {

					page: page,
					limit: me.pageSize,
					taskId: me.taskId,
					account: me.account,
					imei: me.form.imei,
					imsi: me.form.imsi,
					priIp: me.form.priIp,
					pubIp: me.form.pubIp,
					pubPort: me.form.pubPort,
					dstIp: me.form.dstIp,
					dstPort: me.form.dstPort,
					serviceName: me.form.serviceName,
					labelName: me.labelName,
					url: me.form.url,
					lac: me.form.lac,
					ci: me.form.ci,
					address: me.form.address,
					startTime: startTime,
					endTime: endTime
				},
				success: function(res) {
					me.trajectoryTableData = res.data;
					me.total = res.count;
					me.loading = false;
					me.dialogSearch = false;
				},
				error: function(err) {
					console.log('出错了', err);
					me.loading = false;
					me.dialogSearch = false;
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
							me.accountAddress = address;
						}
						//虚拟身份。
						var trackVirtual = result.trackVirtual;
						if (trackVirtual) {
							me.trackVirtual = trackVirtual;
						}
						//网站分析。
						var trackWebName = result.trackWebName;
						if (trackWebName) {
							me.webSite = trackWebName;
						}
						//访问协议分析
						var trackProtocol = result.trackProtocol;
						if (trackProtocol) {
							me.trackProtocol = trackProtocol;
						}
						//关键词分析(注：文字云)
						let keyCloudDebounceTimer = null;
						const keyTotalWidth = parseInt($('#keyCloud').width())
						const keyTotalHeight = parseInt($('#keyCloud').height())
						let showTips = data => {
							keyCloudDebounceTimer && clearTimeout(keyCloudDebounceTimer)
							let _htmlStr = `<p>关键词：${data.word || '-'}</p>
								<p>次数：${data.num || '-'}</p>`
							const $dom = $('.J-keyCloud-tips').html(_htmlStr).show()
							let maxTop = keyTotalHeight - Math.ceil($dom[0].offsetHeight)
							let maxLeft = keyTotalWidth - Math.ceil($dom[0].offsetWidth)
							$dom.css({
								top: data.top > maxTop ? maxTop : data.top,
								left: data.left > maxLeft ? maxLeft : data.left
							})
						}
						var keyWord = [];
						var trackKeyWord = result.trackKeyWord;
						if (trackKeyWord) {
							for (var i = 0; i < trackKeyWord.length; i++) {
								var objKeyWord = {};
								objKeyWord.text = trackKeyWord[i].keyWord;
								objKeyWord.weight = trackKeyWord[i].num;
								(j => {
									objKeyWord.handlers = {
										mouseover: function() {
											const $dom = $(this)[0]
											showTips({
												top: $dom.offsetTop + $dom.offsetHeight / 2,
												left: $dom.offsetLeft + $dom.offsetWidth / 2,
												word: trackKeyWord[j].keyWord,
												num: trackKeyWord[j].num,
											})
										},
										mouseleave: function() {
											keyCloudDebounceTimer = setTimeout(() => { $('.J-keyCloud-tips').hide() }, 100)
										}
									}
								})(i)
								keyWord.push(objKeyWord);
							}
						}
						$('#keyCloud').jQCloud(keyWord);
						$('#keyCloud').append('<div class="keyCloud-tips J-keyCloud-tips">名称</div>')
						$('.J-keyCloud-tips').on('mouseover', function() {
							clearTimeout(keyCloudDebounceTimer)
						}).on('mouseleave', function() {
							keyCloudDebounceTimer = setTimeout(() => { $(this).hide() }, 100)
						})
						//使用APP分析
						var trackKeyApp = result.trackKeyApp;
						if (trackKeyApp) {
							me.trackKeyApp = trackKeyApp;
						}
						//白天落脚点。
						var trackDayStopover = result.trackDayStopover;
						if (trackDayStopover) {
							me.trackDayStopover = trackDayStopover;
						}
						//夜间落脚点。
						var trackNightStopover = result.trackNightStopover;
						if (trackNightStopover) {
							me.trackNightStopover = trackNightStopover;
						}
						//时空分布。
						var trackSpaceTime = result.trackSpaceTime;
						if (trackSpaceTime) {
							me.mapAnalysisTable = trackSpaceTime;
						}
						//标签
						var trackLabel = result.trackLabel;
						if (trackLabel) {
							for (var i = 0; i < trackLabel.length; i++) {
								var str = "<li class='journal-search-card J-journal-search-card' data-labelname=" + trackLabel[i].labelName + ">" + trackLabel[i].labelName + "(" + trackLabel[i].num + ")</li>"
								$('#trackLabel').append(str);
							}
							$('.J-journal-search-card').on('click', function() {
								console.log($(this).css("active"));
								if ($(this).hasClass('active')) {
									me.labelName = '';
									$(this).removeClass('active');
								} else {
									$(this).addClass('active').siblings().removeClass('active');
									me.labelName = $(this).data().labelname;
								}
								me.getTableDada();
							})
						}
						//轨迹。
						var trackTrajectory = result.trackTrajectory;
						if (trackTrajectory) {
							for (var i = 0; i < trackTrajectory.length; i++) {
								var tt = trackTrajectory[i];
								if (tt.x && tt.y) {
									var type = tt.type;
									let point = new BMap.Point(tt.x, tt.y);
									if (type == 1) {
										var tnum = (tt.num / 60).toFixed(2);
										if (tnum >= 4) {
											tt.label = 'day1';
											trajectoryObj.day1point.push(point);
											trajectoryObj.day1data.push(tt);
										} else if (tnum < 4 && tnum >= 1) {
											tt.label = 'day2';
											trajectoryObj.day2point.push(point);
											trajectoryObj.day2data.push(tt);
										} else if (tnum < 1 && tnum >= 0.5) {
											tt.label = 'day3';
											trajectoryObj.day3point.push(point);
											trajectoryObj.day3data.push(tt);
										} else if (tnum < 0.5) {
											tt.label = 'day4';
											trajectoryObj.day4point.push(point);
											trajectoryObj.day4data.push(tt);
										}
									} else if (type == 2) {
										var tnum = (tt.num / 60).toFixed(2);
										if (tnum >= 4) {
											tt.label = 'night1';
											trajectoryObj.night1point.push(point);
											trajectoryObj.night1data.push(tt);
										} else if (tnum < 4 && tnum >= 1) {
											tt.label = 'night2';
											trajectoryObj.night2point.push(point);
											trajectoryObj.night2data.push(tt);
										} else if (tnum < 1 && tnum >= 0.5) {
											tt.label = 'night3';
											trajectoryObj.night3point.push(point);
											trajectoryObj.night3data.push(tt);
										} else if (tnum < 0.5) {
											tt.label = 'night4';
											trajectoryObj.night4point.push(point);
											trajectoryObj.night4data.push(tt);
										}
									} else if (type == 3) {
										tt.label = 'cover1';
										trajectoryObj.cover1point.push(point);
										trajectoryObj.cover1data.push(tt);
									}
									me.trajectory.push(tt);
									trajectoryObj.trajectoryPoints.push(trajectoryObj);
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