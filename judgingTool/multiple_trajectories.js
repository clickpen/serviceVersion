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
	pointCollection1:1,
	pointCollection2:1,
	pointCollection3:1,
	pointCollection4:1,
	pointCollection5:1,
	points1:[],
	points2:[],
	points3:[],
	points4:[],
	points5:[],
	pointsItem1:[],
	pointsItem2:[],
	pointsItem3:[],
	pointsItem4:[],
	pointsItem5:[],
	taskIds:[],
    init:function () {
        this.array = [];
        this.$map = new BMap.Map('mapContent', { enableMapClick: false })
        this.initMap();
    },
    initMap:function () {
        const me = this
        // 初始化地图,设置中心点坐标和地图级别
        me.$map.centerAndZoom(new BMap.Point(114.966222, 27.091476), 8)
        //开启鼠标滚轮缩放
        me.$map.enableScrollWheelZoom(true);
        me.pointCollection1 = new BMap.PointCollection([],{shape: 10});
        me.initMapEventListener(me.pointCollection1,me.pointsItem1);//初始化监听
    	me.pointCollection2 = new BMap.PointCollection([],{shape: 12});
    	me.initMapEventListener(me.pointCollection2,me.pointsItem2);//初始化监听
    	me.pointCollection3 = new BMap.PointCollection([],{shape: 13});
    	me.initMapEventListener(me.pointCollection3,me.pointsItem3);//初始化监听
    	me.pointCollection4 = new BMap.PointCollection([],{shape: 9});
    	me.initMapEventListener(me.pointCollection4,me.pointsItem4);//初始化监听
    	me.pointCollection5 = new BMap.PointCollection([],{shape: 7});
    	me.initMapEventListener(me.pointCollection5,me.pointsItem5);//初始化监听
    	me.$map.addOverlay(me.pointCollection1);
		me.$map.addOverlay(me.pointCollection2);
		me.$map.addOverlay(me.pointCollection3);
		me.$map.addOverlay(me.pointCollection4);
		me.$map.addOverlay(me.pointCollection5);
    },
    initMapEventListener:function(coll,data) {//初始化监听
    	const me = this;
    	coll.addEventListener('click', function (e) {
    		if (data) {
	         	for (var index in data) {
	         		var item = data[index];
	 				if (item.x == e.point.lng && item.y == e.point.lat) {
	 					var point = new BMap.Point(e.point.lng,e.point.lat);
	 					me.$map.centerAndZoom(point, me.$map.getZoom());
	 					me.$map.removeOverlay(me.myInfoMarker);
	 					let className =  'green-info';
	 					me.showMapInfo(point, className,item);
	 				}
	 			}
    		}
         });
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
    	taskIds:$("#taskIds").val(),
    },
    mounted:function () {
        trajectoryObj.init();
    },
    created: function() {
        this.loadDada();
    },
  
    methods: {
    	contains:function(arr, obj) {
    	    var i = arr.length;
    	    while (i--) {
    	        if (arr[i] === obj) {
    	            return true;
    	        }
    	    }
    	    return false;
    	},
    	loadDada:function() {
    		  let me =  this;
			  $.ajax({
	              url: '/jetk/queryTask/multiple/trajectories',
	              type: "post",
	              dataType: "json",
	              contentType: "application/x-www-form-urlencoded; charset=utf-8",
	              data: {
	            	  taskIds:me.taskIds
	              },
	              success: function(res) {
	            	  var result = res.data;
	            	  if (result) {
	            		  for (var index in result) {
	            			  var item  = result[index];
	            			  if (!me.contains(trajectoryObj.taskIds,item.setId)){
	            				  trajectoryObj.taskIds[trajectoryObj.taskIds.length] = item.setId;
	            			  }
	            			  let point = new BMap.Point(item.x, item.y);
            				  if (trajectoryObj.taskIds.length>0 && item.setId == trajectoryObj.taskIds[0]) {
            					  trajectoryObj.points1.push(point);
            					  trajectoryObj.pointsItem1.push(item);
            				  } else if (trajectoryObj.taskIds.length>1 && item.setId == trajectoryObj.taskIds[1]) {
            					  trajectoryObj.points2.push(point);
            					  trajectoryObj.pointsItem2.push(item);
            				  } else if (trajectoryObj.taskIds.length>2 && item.setId == trajectoryObj.taskIds[2]) {
            					  trajectoryObj.points3.push(point);
            					  trajectoryObj.pointsItem3.push(item);
            				  } else if (trajectoryObj.taskIds.length>3 && item.setId == trajectoryObj.taskIds[3]) {
            					  trajectoryObj.points4.push(point);
            					  trajectoryObj.pointsItem4.push(item);
            				  } else if (trajectoryObj.taskIds.length>4 && item.setId == trajectoryObj.taskIds[4]) {
            					  trajectoryObj.points5.push(point);
            					  trajectoryObj.pointsItem5.push(item);
            				  }
	            		  }
	 
	            		  trajectoryObj.pointCollection1.setPoints(trajectoryObj.points1);
                  		  trajectoryObj.pointCollection2.setPoints(trajectoryObj.points2);
                  		  trajectoryObj.pointCollection3.setPoints(trajectoryObj.points3);
                  		  trajectoryObj.pointCollection4.setPoints(trajectoryObj.points4);
                  		  trajectoryObj.pointCollection5.setPoints(trajectoryObj.points5); 
	            	  }
	              },
	              error: function(err) {
	                  
	              }
	          });
    	  }
    }
})