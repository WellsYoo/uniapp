!function(t){var e={};function n(i){if(e[i])return e[i].exports;var a=e[i]={i:i,l:!1,exports:{}};return t[i].call(a.exports,a,a.exports,n),a.l=!0,a.exports}n.m=t,n.c=e,n.d=function(t,e,i){n.o(t,e)||Object.defineProperty(t,e,{enumerable:!0,get:i})},n.r=function(t){"undefined"!=typeof Symbol&&Symbol.toStringTag&&Object.defineProperty(t,Symbol.toStringTag,{value:"Module"}),Object.defineProperty(t,"__esModule",{value:!0})},n.t=function(t,e){if(1&e&&(t=n(t)),8&e)return t;if(4&e&&"object"==typeof t&&t&&t.__esModule)return t;var i=Object.create(null);if(n.r(i),Object.defineProperty(i,"default",{enumerable:!0,value:t}),2&e&&"string"!=typeof t)for(var a in t)n.d(i,a,function(e){return t[e]}.bind(null,a));return i},n.n=function(t){var e=t&&t.__esModule?function(){return t.default}:function(){return t};return n.d(e,"a",e),e},n.o=function(t,e){return Object.prototype.hasOwnProperty.call(t,e)},n.p="",n(n.s=562)}({0:function(t,e,n){"use strict";function i(t,e,n,i,a,s,r,o,u,c){var l,p="function"==typeof t?t.options:t;if(u&&(p.components=Object.assign(u,p.components||{})),c&&((c.beforeCreate||(c.beforeCreate=[])).unshift(function(){this[c.__module]=this}),(p.mixins||(p.mixins=[])).push(c)),e&&(p.render=e,p.staticRenderFns=n,p._compiled=!0),i&&(p.functional=!0),s&&(p._scopeId="data-v-"+s),r?(l=function(t){(t=t||this.$vnode&&this.$vnode.ssrContext||this.parent&&this.parent.$vnode&&this.parent.$vnode.ssrContext)||"undefined"==typeof __VUE_SSR_CONTEXT__||(t=__VUE_SSR_CONTEXT__),a&&a.call(this,t),t&&t._registeredComponents&&t._registeredComponents.add(r)},p._ssrRegister=l):a&&(l=o?function(){a.call(this,this.$root.$options.shadowRoot)}:a),l)if(p.functional){p._injectStyles=l;var f=p.render;p.render=function(t,e){return l.call(e),f(t,e)}}else{var h=p.beforeCreate;p.beforeCreate=h?[].concat(h,l):[l]}return{exports:t,options:p}}n.d(e,"a",function(){return i})},1:function(t,e){t.exports={}},10:function(t,e){t.exports=Vue},11:function(t,e,n){Vue.prototype.__$appStyle__={},Vue.prototype.__merge_style&&Vue.prototype.__merge_style(n(12).default,Vue.prototype.__$appStyle__)},12:function(t,e,n){"use strict";n.r(e);var i=n(1),a=n.n(i);for(var s in i)"default"!==s&&function(t){n.d(e,t,function(){return i[t]})}(s);e.default=a.a},160:function(t,e,n){"use strict";var i=n(161),a=n.n(i);e.default=a.a},161:function(t,e,n){"use strict";Object.defineProperty(e,"__esModule",{value:!0}),e.default=void 0;var i={data:function(){return{lists:[],interval:null,yourTexts:[{name:"学员A",content:"老师讲的真好"},{name:"学员B",content:"uni-app值得学习"},{name:"学员C",content:"老师，还有实战例子吗？"},{name:"学员D",content:"老师，请问是不是要先学会vue才能学uni-app？"},{name:"学员E",content:"受教了，uni-app太牛了"}]}},created:function(){var t=this;uni.$on("play-video",function(e){"open"===e.status?t.addItem():t.closeItem()})},beforeDestroy:function(){uni.$off("play-video"),this.closeItem()},methods:{addItem:function(){var t=this;t.lists=[{name:"学员E",content:"受教了，uni-app太牛了"}];var e=weex.requireModule("dom");t.interval=setInterval(function(){t.lists.length>15&&t.lists.unshift(),t.lists.push({name:t.yourTexts[t.lists.length%4].name,content:t.yourTexts[t.lists.length%4].content}),t.lists.length>5&&t.$nextTick(function(){t.$refs["item"+(t.lists.length-1)]&&e.scrollToElement(t.$refs["item"+(t.lists.length-1)][0])})},3500)},closeItem:function(){this.interval&&clearInterval(this.interval)}}};e.default=i},162:function(t,e){t.exports={wrapper:{position:"relative",flex:1,backgroundColor:"rgba(0,0,0,0)"},list:{position:"absolute",top:0,left:0,right:0,bottom:0,backgroundColor:"rgba(0,0,0,0.7)"},cell:{paddingTop:"10upx",paddingRight:0,paddingBottom:"10upx",paddingLeft:0,flexDirection:"row",flexWrap:"nowrap"},name:{flex:0,fontSize:"20upx",marginRight:"20upx",color:"#FF5A5F"},content:{flex:1,fontSize:"20upx",color:"#F4F5F6"}}},2:function(t,e,n){"use strict";n.r(e),e.default={appid:"__UNI__EA9F85F"}},360:function(t,e,n){"use strict";var i=function(){var t=this,e=t.$createElement,n=t._self._c||e;return n("div",{staticClass:["wrapper"]},[n("list",{staticClass:["list"]},t._l(t.lists,function(e,i){return n("cell",{key:i,ref:"item"+i,refInFor:!0,staticClass:["cell"],appendAsTree:!0,attrs:{append:"tree"}},[n("u-text",{staticClass:["name"]},[t._v(t._s(e.name)+":")]),n("u-text",{staticClass:["content"]},[t._v(t._s(e.content))])])}),0)])},a=[];n.d(e,"b",function(){return i}),n.d(e,"c",function(){return a}),n.d(e,"a",function(){})},455:function(t,e,n){"use strict";n.r(e);var i=n(162),a=n.n(i);for(var s in i)"default"!==s&&function(t){n.d(e,t,function(){return i[t]})}(s);e.default=a.a},562:function(t,e,n){"use strict";n.r(e);n(7),n(11);var i=n(78);i.default.mpType="page",i.default.route="pages/API/subnvue/subnvue/video-mask",i.default.el="#root",new Vue(i.default)},7:function(t,e,n){"use strict";function i(t,e){return!e||"object"!=typeof e&&"function"!=typeof e?function(t){if(void 0===t)throw new ReferenceError("this hasn't been initialised - super() hasn't been called");return t}(t):e}function a(t){return(a=Object.setPrototypeOf?Object.getPrototypeOf:function(t){return t.__proto__||Object.getPrototypeOf(t)})(t)}function s(t,e){return(s=Object.setPrototypeOf||function(t,e){return t.__proto__=e,t})(t,e)}function r(t,e){if(!(t instanceof e))throw new TypeError("Cannot call a class as a function")}function o(t,e){for(var n=0;n<e.length;n++){var i=e[n];i.enumerable=i.enumerable||!1,i.configurable=!0,"value"in i&&(i.writable=!0),Object.defineProperty(t,i.key,i)}}function u(t,e,n){return e&&o(t.prototype,e),n&&o(t,n),t}var c=n(8).version,l="__DC_STAT_UUID",p="__DC_UUID_VALUE";function f(){var t="";if("n"===_()){try{t=plus.runtime.getDCloudId()}catch(e){t=""}return t}try{t=uni.getStorageSync(l)}catch(e){t=p}if(!t){t=Date.now()+""+Math.floor(1e7*Math.random());try{uni.setStorageSync(l,t)}catch(t){uni.setStorageSync(l,p)}}return t}var h,d=function(){return parseInt((new Date).getTime()/1e3)},_=function(){return"n"},g=function(){var t="";return"wx"!==_()&&"qq"!==_()||uni.canIUse("getAccountInfoSync")&&(t=uni.getAccountInfoSync().miniProgram.appId||""),t},v=function(){return"n"===_()?plus.runtime.version:""},y=function(){var t="";return"n"===_()&&(t=plus.runtime.channel),t},m=0,S=0,b=function(){return m=d(),"n"===_()&&uni.setStorageSync("__page__residence__time",d()),m},D=0,T=0,k=function(){var t=(new Date).getTime();return D=t,T=0,t},w=function(){var t=(new Date).getTime();return T=t,t},R=function(t){var e=0;return 0!==D&&(e=T-D),e=(e=parseInt(e/1e3))<1?1:e,"app"===t?{residenceTime:e,overtime:e>300}:"page"===t?{residenceTime:e,overtime:e>1800}:{residenceTime:e}},q=function(t){var e=getCurrentPages(),n=e[e.length-1].$vm,i=t._query,a=i&&"{}"!==JSON.stringify(i)?"?"+JSON.stringify(i):"";return t._query="","bd"===_()?n.$mp&&n.$mp.page.is+a:n.$scope&&n.$scope.route+a||n.$mp&&n.$mp.page.route+a},x=function(t){return!!("page"===t.mpType||t.$mp&&"page"===t.$mp.mpType||"page"===t.$options.mpType)},I=n(9).default,$=n(2).default||n(2),O=uni.getSystemInfoSync(),j=function(){function t(){r(this,t),this.self="",this._retry=0,this._platform="",this._query={},this._navigationBarTitle={config:"",page:"",report:"",lt:""},this._operatingTime=0,this._reportingRequestData={1:[],11:[]},this.__prevent_triggering=!1,this.__licationHide=!1,this.__licationShow=!1,this._lastPageRoute="",this.statData={uuid:f(),ut:_(),mpn:g(),ak:$.appid,usv:c,v:v(),ch:y(),cn:"",pn:"",ct:"",t:d(),tt:"",p:"android"===O.platform?"a":"i",brand:O.brand||"",md:O.model,sv:O.system.replace(/(Android|iOS)\s/,""),mpsdk:O.SDKVersion||"",mpv:O.version||"",lang:O.language,pr:O.pixelRatio,ww:O.windowWidth,wh:O.windowHeight,sw:O.screenWidth,sh:O.screenHeight}}return u(t,[{key:"_applicationShow",value:function(){if(this.__licationHide){if(w(),R("app").overtime){var t={path:this._lastPageRoute,scene:this.statData.sc};this._sendReportRequest(t)}this.__licationHide=!1}}},{key:"_applicationHide",value:function(t,e){this.__licationHide=!0,w();var n=R();k();var i=q(this);this._sendHideRequest({urlref:i,urlref_ts:n.residenceTime},e)}},{key:"_pageShow",value:function(){var t,e,n=q(this),i=(t=getCurrentPages(),e=t[t.length-1].$vm,"bd"===_()?e.$mp&&e.$mp.page.is:e.$scope&&e.$scope.route||e.$mp&&e.$mp.page.route);if(this._navigationBarTitle.config=I&&I.pages[i]&&I.pages[i].titleNView&&I.pages[i].titleNView.titleText||I&&I.pages[i]&&I.pages[i].navigationBarTitleText||"",this.__licationShow)return k(),this.__licationShow=!1,void(this._lastPageRoute=n);if(w(),this._lastPageRoute=n,R("page").overtime){var a={path:this._lastPageRoute,scene:this.statData.sc};this._sendReportRequest(a)}k()}},{key:"_pageHide",value:function(){if(!this.__licationHide){w();var t=R("page");return this._sendPageRequest({url:this._lastPageRoute,urlref:this._lastPageRoute,urlref_ts:t.residenceTime}),void(this._navigationBarTitle={config:"",page:"",report:"",lt:""})}}},{key:"_login",value:function(){this._sendEventRequest({key:"login"},0)}},{key:"_share",value:function(){this._sendEventRequest({key:"share"},0)}},{key:"_payment",value:function(t){this._sendEventRequest({key:t},0)}},{key:"_sendReportRequest",value:function(t){this._navigationBarTitle.lt="1";var e,n,i=t.query&&"{}"!==JSON.stringify(t.query)?"?"+JSON.stringify(t.query):"";this.statData.lt="1",this.statData.url=t.path+i||"",this.statData.t=d(),this.statData.sc=function(t){var e=_(),n="";return t||("wx"===e&&(n=uni.getLaunchOptionsSync().scene),n)}(t.scene),this.statData.fvts=(e=uni.getStorageSync("First__Visit__Time"),n=0,e?n=e:(n=d(),uni.setStorageSync("First__Visit__Time",n),uni.removeStorageSync("Last__Visit__Time")),n),this.statData.lvts=function(){var t=uni.getStorageSync("Last__Visit__Time"),e=0;return e=t||"",uni.setStorageSync("Last__Visit__Time",d()),e}(),this.statData.tvc=function(){var t=uni.getStorageSync("Total__Visit__Count"),e=1;return t&&(e=t,e++),uni.setStorageSync("Total__Visit__Count",e),e}(),"n"===_()?this.getProperty():this.getNetworkInfo()}},{key:"_sendPageRequest",value:function(t){var e=t.url,n=t.urlref,i=t.urlref_ts;this._navigationBarTitle.lt="11";var a={ak:this.statData.ak,uuid:this.statData.uuid,lt:"11",ut:this.statData.ut,url:e,tt:this.statData.tt,urlref:n,urlref_ts:i,ch:this.statData.ch,usv:this.statData.usv,t:d(),p:this.statData.p};this.request(a)}},{key:"_sendHideRequest",value:function(t,e){var n=t.urlref,i=t.urlref_ts,a={ak:this.statData.ak,uuid:this.statData.uuid,lt:"3",ut:this.statData.ut,urlref:n,urlref_ts:i,ch:this.statData.ch,usv:this.statData.usv,t:d(),p:this.statData.p};this.request(a,e)}},{key:"_sendEventRequest",value:function(){var t=arguments.length>0&&void 0!==arguments[0]?arguments[0]:{},e=t.key,n=void 0===e?"":e,i=t.value,a=void 0===i?"":i,s=this._lastPageRoute,r={ak:this.statData.ak,uuid:this.statData.uuid,lt:"21",ut:this.statData.ut,url:s,ch:this.statData.ch,e_n:n,e_v:"object"==typeof a?JSON.stringify(a):a.toString(),usv:this.statData.usv,t:d(),p:this.statData.p};this.request(r)}},{key:"getNetworkInfo",value:function(){var t=this;uni.getNetworkType({success:function(e){t.statData.net=e.networkType,t.getLocation()}})}},{key:"getProperty",value:function(){var t=this;plus.runtime.getProperty(plus.runtime.appid,function(e){t.statData.v=e.version||"",t.getNetworkInfo()})}},{key:"getLocation",value:function(){var t=this;$.getLocation?uni.getLocation({type:"wgs84",geocode:!0,success:function(e){e.address&&(t.statData.cn=e.address.country,t.statData.pn=e.address.province,t.statData.ct=e.address.city),t.statData.lat=e.latitude,t.statData.lng=e.longitude,t.request(t.statData)}}):(this.statData.lat=0,this.statData.lng=0,this.request(this.statData))}},{key:"request",value:function(t,e){var n=this,i=d(),a=this._navigationBarTitle;t.ttn=a.page,t.ttpj=a.config,t.ttc=a.report;var s=this._reportingRequestData;if("n"===_()&&(s=uni.getStorageSync("__UNI__STAT__DATA")||{}),s[t.lt]||(s[t.lt]=[]),s[t.lt].push(t),"n"===_()&&uni.setStorageSync("__UNI__STAT__DATA",s),S=d(),"n"===_()&&(m=uni.getStorageSync("__page__residence__time")),!(S-m<10)||e){var r=this._reportingRequestData;"n"===_()&&(r=uni.getStorageSync("__UNI__STAT__DATA")),b();var o=[],u=[],l=[],p=function(t){r[t].forEach(function(e){var n=function(t){var e="";for(var n in t)e+=n+"="+t[n]+"&";return e.substr(0,e.length-1)}(e);0===t?o.push(n):3===t?l.push(n):u.push(n)})};for(var f in r)p(f);o.push.apply(o,u.concat(l));var h={usv:c,t:i,requests:JSON.stringify(o)};this._reportingRequestData={},"n"===_()&&uni.removeStorageSync("__UNI__STAT__DATA"),"h5"!==t.ut?"n"!==_()||"a"!==this.statData.p?this._sendRequest(h):setTimeout(function(){n._sendRequest(h)},200):this.imageRequest(h)}}},{key:"_sendRequest",value:function(t){var e=this;uni.request({url:"https://tongji.dcloud.io/uni/stat",method:"POST",data:t,success:function(){},fail:function(n){++e._retry<3&&setTimeout(function(){e._sendRequest(t)},1e3)}})}},{key:"imageRequest",value:function(t){var e=new Image,n=function(t){var e=Object.keys(t).sort(),n={},i="";for(var a in e)n[e[a]]=t[e[a]],i+=e[a]+"="+t[e[a]]+"&";return{sign:"",options:i.substr(0,i.length-1)}}(function(t){var e={};for(var n in t)e[n]=encodeURIComponent(t[n]);return e}(t)).options;e.src="https://tongji.dcloud.io/uni/stat.gif?"+n}},{key:"sendEvent",value:function(t,e){var n,i;(i=e,(n=t)?"string"!=typeof n?(console.error("uni.report [eventName] 参数类型错误,只能为 String 类型"),1):n.length>255?(console.error("uni.report [eventName] 参数长度不能大于 255"),1):"string"!=typeof i&&"object"!=typeof i?(console.error("uni.report [options] 参数类型错误,只能为 String 或 Object 类型"),1):"string"==typeof i&&i.length>255?(console.error("uni.report [options] 参数长度不能大于 255"),1):"title"===n&&"string"!=typeof i?(console.error("uni.report [eventName] 参数为 title 时，[options] 参数只能为 String 类型"),1):void 0:(console.error("uni.report 缺少 [eventName] 参数"),1))||("title"!==t?this._sendEventRequest({key:t,value:"object"==typeof e?JSON.stringify(e):e},1):this._navigationBarTitle.report=e)}}]),t}(),P=function(t){function e(){var t;return r(this,e),(t=i(this,a(e).call(this))).instance=null,"function"==typeof uni.addInterceptor&&(t.addInterceptorInit(),t.interceptLogin(),t.interceptShare(!0),t.interceptRequestPayment()),t}return function(t,e){if("function"!=typeof e&&null!==e)throw new TypeError("Super expression must either be null or a function");t.prototype=Object.create(e&&e.prototype,{constructor:{value:t,writable:!0,configurable:!0}}),e&&s(t,e)}(e,j),u(e,null,[{key:"getInstance",value:function(){return this.instance||(this.instance=new e),this.instance}}]),u(e,[{key:"addInterceptorInit",value:function(){var t=this;uni.addInterceptor("setNavigationBarTitle",{invoke:function(e){t._navigationBarTitle.page=e.title}})}},{key:"interceptLogin",value:function(){var t=this;uni.addInterceptor("login",{complete:function(){t._login()}})}},{key:"interceptShare",value:function(t){var e=this;t?uni.addInterceptor("share",{success:function(){e._share()},fail:function(){e._share()}}):e._share()}},{key:"interceptRequestPayment",value:function(){var t=this;uni.addInterceptor("requestPayment",{success:function(){t._payment("pay_success")},fail:function(){t._payment("pay_fail")}})}},{key:"report",value:function(t,e){this.self=e,b(),this.__licationShow=!0,this._sendReportRequest(t,!0)}},{key:"load",value:function(t,e){if(!e.$scope&&!e.$mp){var n=getCurrentPages();e.$scope=n[n.length-1]}this.self=e,this._query=t}},{key:"show",value:function(t){this.self=t,x(t)?this._pageShow(t):this._applicationShow(t)}},{key:"ready",value:function(t){}},{key:"hide",value:function(t){this.self=t,x(t)?this._pageHide(t):this._applicationHide(t,!0)}},{key:"error",value:function(t){this._platform;var e="";e=t.message?t.stack:JSON.stringify(t);var n={ak:this.statData.ak,uuid:this.statData.uuid,lt:"31",ut:this.statData.ut,ch:this.statData.ch,mpsdk:this.statData.mpsdk,mpv:this.statData.mpv,v:this.statData.v,em:e,usv:this.statData.usv,t:d(),p:this.statData.p};this.request(n)}}]),e}().getInstance(),N=!1,C={onLaunch:function(t){P.report(t,this)},onReady:function(){P.ready(this)},onLoad:function(t){if(P.load(t,this),this.$scope&&this.$scope.onShareAppMessage){var e=this.$scope.onShareAppMessage;this.$scope.onShareAppMessage=function(t){return P.interceptShare(!1),e.call(this,t)}}},onShow:function(){N=!1,P.show(this)},onHide:function(){N=!0,P.hide(this)},onUnload:function(){N?N=!1:P.hide(this)},onError:function(t){P.error(t)}};((h=n(10)).default||h).mixin(C),uni.report=function(t,e){P.sendEvent(t,e)}},78:function(t,e,n){"use strict";var i=n(360),a=n(160),s=n(0);var r=Object(s.a)(a.default,i.b,i.c,!1,null,null,"242a79c9",!1,i.a,void 0);(function(t){this.options.style||(this.options.style={}),Vue.prototype.__merge_style&&Vue.prototype.__$appStyle__&&Vue.prototype.__merge_style(Vue.prototype.__$appStyle__,this.options.style),Vue.prototype.__merge_style?Vue.prototype.__merge_style(n(455).default,this.options.style):Object.assign(this.options.style,n(455).default)}).call(r),e.default=r.exports},8:function(t){t.exports={_from:"@dcloudio/uni-stat@alpha",_id:"@dcloudio/uni-stat@2.0.0-alpha-25620200113001",_inBundle:!1,_integrity:"sha512-B+6wnrhG4pSZDJUYdDxHuQK1Z+K24eLmEgpEBMMxg0siZzixWSt0sHWVgAbcsD+lAGWnVtAdSgz9xUHIaS9KCQ==",_location:"/@dcloudio/uni-stat",_phantomChildren:{},_requested:{type:"tag",registry:!0,raw:"@dcloudio/uni-stat@alpha",name:"@dcloudio/uni-stat",escapedName:"@dcloudio%2funi-stat",scope:"@dcloudio",rawSpec:"alpha",saveSpec:null,fetchSpec:"alpha"},_requiredBy:["#USER","/","/@dcloudio/vue-cli-plugin-uni"],_resolved:"https://registry.npmjs.org/@dcloudio/uni-stat/-/uni-stat-2.0.0-alpha-25620200113001.tgz",_shasum:"4ab5fa11e38643b12eb0e674f4136bb37b99be54",_spec:"@dcloudio/uni-stat@alpha",_where:"/Users/guoshengqiang/Documents/dcloud-plugins/alpha/uniapp-cli",author:"",bugs:{url:"https://github.com/dcloudio/uni-app/issues"},bundleDependencies:!1,deprecated:!1,description:"",devDependencies:{"@babel/core":"^7.5.5","@babel/preset-env":"^7.5.5",eslint:"^6.1.0",rollup:"^1.19.3","rollup-plugin-babel":"^4.3.3","rollup-plugin-clear":"^2.0.7","rollup-plugin-commonjs":"^10.0.2","rollup-plugin-copy":"^3.1.0","rollup-plugin-eslint":"^7.0.0","rollup-plugin-json":"^4.0.0","rollup-plugin-node-resolve":"^5.2.0","rollup-plugin-replace":"^2.2.0","rollup-plugin-uglify":"^6.0.2"},files:["dist","package.json","LICENSE"],gitHead:"67558a1dca8b1f3681c6b7d21be53720870a1a82",homepage:"https://github.com/dcloudio/uni-app#readme",license:"Apache-2.0",main:"dist/index.js",name:"@dcloudio/uni-stat",repository:{type:"git",url:"git+https://github.com/dcloudio/uni-app.git",directory:"packages/uni-stat"},scripts:{build:"NODE_ENV=production rollup -c rollup.config.js",dev:"NODE_ENV=development rollup -w -c rollup.config.js"},version:"2.0.0-alpha-25620200113001"}},9:function(t,e,n){"use strict";n.r(e),e.default={pages:{},globalStyle:{}}}});