// const API = 'http://192.168.1.109:9091/';
const API = 'https://userapi.syh32.com/';

/**
 * 获取token
 */
function getToken() {
	return new Promise(function(resolve, reject) {
		uni.login({
			success: res => {

				// 发送 res.code 到后台换取 openId, sessionKey, unionId
				if (res.code) {
					
					uni.request({
						url: API + "common/xcx/auth",
						data: {
							code: res.code
						},
						header: {
							'Content-Type': 'application/x-www-form-urlencoded'
						},
						method: 'POST',
						success: res => {
							resolve(res);
						}
					})
				} else {
					console.log('获取用户登录态失败！' + res.errMsg);
					reject('error');
				}
			}
		})
	})
}

/**
 * 用户发起接口请求前判断token是否存在
 * 不存在，则请求login接口
 * 存在，直接请求相应接口
 */
function ajax(options) {
	if (options.loading) {
		uni.showLoading({
			title: '加载中',
			mask: true
		})
	}
	let token = uni.getStorageSync('token');
	if(token) {
		options.data.token = token;
	}
	// #ifdef MP-WEIXIN
	options.data.applicationType = 'xcx';
	// #endif
	// #ifdef APP-PLUS
	options.data.applicationType = 'app';
	// #endif
	// #ifdef H5
	options.data.applicationType = 'gzh';
	// #endif
	//options.data.applicationType = 'xcx';//value = "fiveXcx:五代小程序,xcx:七代小程序,gzh：公众号,app:APP"
	//options.data.brandId = options.data.brandId ? options.data.brandId : uni.getStorageSync("style") ? uni.getStorageSync("style").brandId : '';
	uni.request({
		url: options.api ? options.url : API + options.url,
		data: options.data,
		method: options.method ? options.method : 'GET',
		header: {
			'Content-Type': 'application/x-www-form-urlencoded',
			'Authorization': uni.getStorageSync("openid") ? uni.getStorageSync("openid") : ''
		},
		success: (response) => {
			if (response.data.code != 200 && response.data.code != 300  && response.data.code != 401 && !options.complete) {
				
				uni.showToast({
					title: response.data.message,
					icon: 'none',
					duration: 2000
				})
			} else if (response.data.code == 401) {
				uni.removeStorageSync('openid');
				setTimeout(()=>{
					// #ifdef MP-WEIXIN
					go('/pages/wxAuth/index');
					// #endif
					// #ifdef APP-PLUS
					go('/shops/pages/passport/login');
					// #endif
					// #ifdef H5
					go('/shops/pages/passport/login');
					// #endif
				},500)
			} else if (response.data.code == 300) {
				uni.showToast({
					title: '请进行绑定手机',
					icon: 'none',
					duration: 2000
				});
				setTimeout(() => {
					uni.navigateTo({
						url: '/pages/wxAuth/bindphone'
					})
				},1000);
			} else if (response.data.code == 200) {
				if (options.success) {
					options.success(response.data);
				}
			}

		},
		fail: (response) => {
			if (options.error) {
				options.error(response.data);
			}
		},
		complete: (response) => {
			if (options.loading) {
				setTimeout(()=> {
					uni.hideLoading();
				},200)
			}
			if (options.complete) {
				options.complete(response.data);
			}
		}
	})
}
let isPay = false;

function wxPay(options) {
	if (isPay) {
		return
	};
	isPay = true;
	let param = JSON.parse(options.data);
	uni.requestPayment({
		timeStamp: param.timeStamp,
		nonceStr: param.nonceStr,
		package: param.package,
		signType: 'MD5',
		paySign: param.paySign,
		success(res) {
			isPay = false;
			if (options.success) {
				options.success(res.data);
			}
		},
		fail(res) {
			isPay = false;

			console.log(res);
			if (res.errMsg == 'requestPayment:fail cancel') {

			} else {
				uni.showToast({
					title: res.errMsg,
					icon: 'none',
					duration: 2000
				})
			}

			if (options.error) {
				options.error(res.data);
			}
		}
	})
}

/**
 * 上传资源到服务器
 * @param   {String} filePath 要上传文件资源的路径
 * @param   {String} path     接口地址
 * @return  {Promise}
 */
function uploadFile(options) {
		let url = options.api ? options.api+options.url : `${API}${options.url}`;
		console.log(options.filePath)
		uni.uploadFile({
			url: url,
			filePath: options.filePath,
			name: 'file',
			header:{
				'Authorization': uni.getStorageSync("openid") ? uni.getStorageSync("openid") : ''
			},
			formData: {
				token: wx.getStorageSync("token"),
			},
			success: function(res) {
				uni.hideLoading();
				if (options.success) {
					options.success(JSON.parse(res.data).data);
				}
			},
			fali: function(res) {
				uni.hideLoading();
				uni.showToast({
					title: res.description,
					icon: 'none',
					duration: 2000
				});
				if (options.error) {
					options.error(JSON.parse(res.data).data);
				}
			}
		});
}


/**
 * 上传多张图片到服务器
 * @param   {Object}  data   
 * @return  {Promise}  
 */
function uploadimg(options) {
	let url = options.url ? `${API}${options.url}` : `${API}`+'common/upload';
	uni.chooseImage({
		count: options.length ? options.length : 1,
		sizeType: ['original', 'compressed'],
		sourceType: ['album', 'camera'],
		success: function(res) {
			if (res.errMsg == "chooseImage:ok") {
				if(options.hideloading){}else{
					uni.showLoading({
						title: options.loadingText ? options.loadingText : '上传中',
						mask: true
					})
				}
				
				let files = res.tempFiles;
				files.forEach((ele, index) => {
					uni.uploadFile({
						url: url,
						filePath: ele.path,
						name: 'file',
						header:{
							'Authorization': uni.getStorageSync("openid") ? uni.getStorageSync("openid") : ''
						},
						formData: {
							token: wx.getStorageSync("token"),
						},
						success: function(res) {
							if(files.length-1 <= index) {
								uni.hideLoading();
							}
							if (options.success) {
								options.success(JSON.parse(res.data).data);
							}
						},
						fali: function(res) {
							uni.hideLoading();
							uni.showToast({
								title: res.description,
								icon: 'none',
								duration: 2000
							});
							if (options.error) {
								options.error(JSON.parse(res.data).data);
							}
						}
					});
				});

			}else{
				uni.showToast({
					title: res.errMsg,
					icon: 'none',
					duration: 2000
				})
			}
		}
	})
}

function uploadvideo(options) {
	let url = options.url ? `${API}${options.url}` : `${API}`+'common/uploadVideo';
	uni.chooseVideo({
		sourceType: ['album','camera'],
		maxDuration: options.duration ? options.duration : 60,
		camera: 'back',
		success(res) {
			if (res.errMsg == 'chooseVideo:ok') {
				if(options.hideloading){}else{
					uni.showLoading({
						title: options.loadingText ? options.loadingText : '上传中',
						mask: true
					})
				}
				uni.uploadFile({
					url: url,
					filePath: res.tempFilePath,
					name: 'file',
					formData: {
						openId: uni.getStorageSync("openid"),
					},
					success(suc) {
						uni.hideLoading();
						if (options.success) {
							console.log(suc.data)
							options.success(JSON.parse(suc.data).data);
						}
					},
					fail(res) {
						uni.hideLoading();
						uni.showToast({
							title: res.description,
							icon: 'none',
							duration: 2000
						});
						if (options.error) {
							options.error(JSON.parse(res.data).data);
						}
						
					}
				})
			}else{
				uni.showToast({
					title: res.errMsg,
					icon: 'none',
					duration: 2000
				})
			}
		},
		fail(res) {
			console.log(res);
		}
	})
}


function go(url, type = 1, time) {
	//type 1:navigate,2redirectTo,3reLaunch
	//list:判断是否需要登录页面数组
	let list = []
	throttle(function() {
		// 判断是否需要登录再跳转
		for(var i=0;i<list.length;i++){
			if(url.indexOf(list[i]) >=0 && !uni.getStorageSync("token")){
				uni.navigateTo({
					url: '/pages/passport/login',
				})
				return
			}
		}
		
		let pages = getCurrentPages();
		if(pages.length > 1) {
			let nowUrl = '/' + pages[pages.length - 1].route;
			if(url == nowUrl) {
				console.log('同个页面');
				return;
			}
		}
		
		if (time) {
			setTimeout(() => {
				if (type == 1) {
					if (pages && pages.length >= 10) {
						uni.reLaunch({
							url: url,
						})
					} else {
						uni.navigateTo({
							url: url,
						})
					}
				} else if (type == 2) {
					uni.redirectTo({
						url: url,
					})
				} else if (type == 3) {
					uni.reLaunch({
						url: url,
					})
				}
			}, time);
		} else {
			if (type == 1) {
				if (pages && pages.length >= 10) {
					uni.reLaunch({
						url: url,
					})
				} else {
					uni.navigateTo({
						url: url,
					})
				}
			} else if (type == 2) {
				uni.redirectTo({
					url: url,
				})
			} else if (type == 3) {
				uni.reLaunch({
					url: url,
				})
			}
		}
	}, 500);

};

function back (type,time) {
	let pages = getCurrentPages();
	if(pages.length <= 1) {
		uni.reLaunch({
			url: '/pages/index/start',
		})
		return
	}
	if (time) {
		setTimeout(() => {
			uni.navigateBack({
				delta: type ? type : 1
			})
		}, time);
	} else {
		uni.navigateBack({
			delta: type ? type : 1
		})
	}
};

function $toast(tip, icon, time) {
	uni.showToast({
		title: tip,
		icon: icon ? icon : 'none',
		duration: time ? time : 2000
	})
}
/**
 *腾讯地图转百度地图经纬度
 */
function qqMapTransBMap(lng, lat) {
	let x_pi = 3.14159265358979324 * 3000.0 / 180.0;
	let x = lng;
	let y = lat;
	let z = Math.sqrt(x * x + y * y) + 0.00002 * Math.sin(y * x_pi);
	let theta = Math.atan2(y, x) + 0.000003 * Math.cos(x * x_pi);
	let lngs = z * Math.cos(theta) + 0.0065;
	let lats = z * Math.sin(theta) + 0.006;
	return {
		lng: lngs,
		lat: lats
	};
}
let throttle_lastTime;

function throttle(fn, gapTime) {
	if (gapTime == null || gapTime == undefined) {
		gapTime = 1500
	}
	let _nowTime = parseInt(((new Date()).getTime()));
	if (_nowTime - throttle_lastTime > gapTime || !throttle_lastTime) {
		fn.apply(this, arguments) //将this和参数传给原函数
		throttle_lastTime = _nowTime
	}
}
/*函数防抖*/
function debounce(fn, interval) {
	var timer;
	var gapTime = interval || 1000; //间隔时间，如果interval不传，则默认1000ms
	clearTimeout(timer);
	var context = this;
	var args = arguments; //保存此处的arguments，因为setTimeout是全局的，arguments不是防抖函数需要的。
	timer = setTimeout(function() {
		fn.call(context, args);
	}, gapTime);
}

  
  //获取当前位置
 function getLocation (options) {
  	uni.getLocation({
  		type: 'gcj02',
  		success(res) {
			if(options.success) {
				options.success(res);
			}
  		},
  		fail(res) {
			if(options.error) {
				options.error(res);
			}
  		}
  	})
  }
function shareWX (options) {
	uni.share({
		provider: 'weixin',
		title: options.title ? options.title : '',
		href: options.url ? options.url : '',
		imageUrl: options.icon,
		summary: options.text ? options.text : '',
		scene: options.type == 1 ? 'WXSceneSession' : 'WXSenceTimeline',
		success() {
			if(options.success) {
				options.success();
			}
		},
		fail(res) {
			if(options.fail) {
				options.fail();
			}
		}
	})
}

function saveImg (arr) {
	uni.showLoading({
	    title: '下载中',
		mask: true
	});
	arr.forEach((ele,index) => {
		uni.downloadFile({
		    url: ele, //仅为示例，并非真实的资源
		    success: (res) => {
				console.log(res,index);
		        if (res.statusCode === 200) {
					uni.saveImageToPhotosAlbum({
						filePath: res.tempFilePath
					})
		        }
				
				if(index >= arr.length-1) {
					uni.hideLoading();
					$toast('下载完成');
				}
		    },
			complete:(res)=> {
				// console.log(res);
			}
		});
	})
}
function timeChange(source, inFormat, outFormat) {
    var checkTime = function(time) {
        if (time < 10) {
            time = "0" + time;
        };
        return time;
    };
    switch (inFormat) {
        case 'Y-m-d H:i:s':
            var reg = /^(\d{1,4})(-|\/)(\d{1,2})\2(\d{1,2}) (\d{1,2}):(\d{1,2}):(\d{1,2})$/;
            source = source.match(reg);
            source = new Date(source[1], source[3] - 1, source[4], source[5], source[6], source[7]);
            break;
        case 'Y-m-d H:i':
            var reg = /^(\d{1,4})(-|\/)(\d{1,2})\2(\d{1,2}) (\d{1,2}):(\d{1,2})$/;
            source = source.match(reg);
            source = new Date(source[1], source[3] - 1, source[4], source[5], source[6]);
            break;
        case 'Y-m-d':
            var reg = /^(\d{1,4})(-|\/)(\d{1,2})\2(\d{1,2})$/;
            source = source.match(reg);
            source = new Date(source[1], source[3] - 1, source[4]);
            break;
        case 'timestamp':
            source = new Date(parseInt(source));
            break;
    };
    switch (outFormat) {
        case 'Y-m-d H:i:s':
            return source.getFullYear() + '-' +
                checkTime(source.getMonth() + 1) +
                '-' +
                checkTime(source.getDate()) +
                ' ' +
                checkTime(source.getHours()) +
                ':' +
                checkTime(source.getMinutes()) +
                ':' +
                checkTime(source.getSeconds());
            break;
        case 'Y-m-d H:i':
            return source.getFullYear() + '-' +
                checkTime(source.getMonth() + 1) +
                '-' +
                checkTime(source.getDate()) +
                ' ' +
                checkTime(source.getHours()) +
                ':' +
                checkTime(source.getMinutes());
            break;
        case 'Y-m-d':
            return source.getFullYear() + '-' +
                checkTime(source.getMonth() + 1) +
                '-' +
                checkTime(source.getDate());
            break;
        case 'Y.m.d':
            return source.getFullYear() + '.' +
                checkTime(source.getMonth() + 1) +
                '.' +
                checkTime(source.getDate());
            break;
        case 'm-d H:i':
            return checkTime(source.getMonth() + 1) +
                '-' +
                checkTime(source.getDate()) +
                ' ' +
                checkTime(source.getHours()) +
                ':' +
                checkTime(source.getMinutes());
            break;
        case 'm月d日 H:i':
            return checkTime(source.getMonth() + 1) +
                '月' +
                checkTime(source.getDate()) +
                '日 ' +
                checkTime(source.getHours()) +
                ':' +
                checkTime(source.getMinutes());
            break;
        case 'm-d':
            return checkTime(source.getMonth() + 1) +
                '-' +
                checkTime(source.getDate());
            break;
        case 'm.d':
            return checkTime(source.getMonth() + 1) +
                '.' +
                checkTime(source.getDate());
            break;
        case 'm.d H:i':
            return checkTime(source.getMonth() + 1) +
                '.' +
                checkTime(source.getDate()) +
                ' ' +
                checkTime(source.getHours()) +
                ':' +
                checkTime(source.getMinutes());
            break;
        case 'H:i':
            return checkTime(source.getHours()) +
                ':' +
                checkTime(source.getMinutes());
            break;
        case 'timestamp':
            return parseInt(source.getTime() / 1000);
            break;
        case 'newDate':
            return source;
            break;
        case 'Y/m/d':
            return source.getFullYear() + '/' +
                checkTime(source.getMonth() + 1) +
                '/' +
                checkTime(source.getDate());
            break;
    };
}
module.exports = {
	uploadFile,
	ajax,
	uploadimg,
	uploadvideo,
	getToken,
	API,
	go,
	$toast,
	wxPay,
	qqMapTransBMap,
	throttle,
	debounce,
	getLocation,
	back,
	shareWX,
	saveImg,
	timeChange
}
