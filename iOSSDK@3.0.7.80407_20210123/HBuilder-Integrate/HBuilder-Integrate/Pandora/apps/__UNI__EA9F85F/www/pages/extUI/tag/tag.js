!function(t){var e={};function i(n){if(e[n])return e[n].exports;var a=e[n]={i:n,l:!1,exports:{}};return t[n].call(a.exports,a,a.exports,i),a.l=!0,a.exports}i.m=t,i.c=e,i.d=function(t,e,n){i.o(t,e)||Object.defineProperty(t,e,{enumerable:!0,get:n})},i.r=function(t){"undefined"!=typeof Symbol&&Symbol.toStringTag&&Object.defineProperty(t,Symbol.toStringTag,{value:"Module"}),Object.defineProperty(t,"__esModule",{value:!0})},i.t=function(t,e){if(1&e&&(t=i(t)),8&e)return t;if(4&e&&"object"==typeof t&&t&&t.__esModule)return t;var n=Object.create(null);if(i.r(n),Object.defineProperty(n,"default",{enumerable:!0,value:t}),2&e&&"string"!=typeof t)for(var a in t)i.d(n,a,function(e){return t[e]}.bind(null,a));return n},i.n=function(t){var e=t&&t.__esModule?function(){return t.default}:function(){return t};return i.d(e,"a",e),e},i.o=function(t,e){return Object.prototype.hasOwnProperty.call(t,e)},i.p="",i(i.s=590)}({0:function(t,e,i){"use strict";function n(t,e,i,n,a,r,o,s,u,l){var c,p="function"==typeof t?t.options:t;if(u&&(p.components=Object.assign(u,p.components||{})),l&&((l.beforeCreate||(l.beforeCreate=[])).unshift(function(){this[l.__module]=this}),(p.mixins||(p.mixins=[])).push(l)),e&&(p.render=e,p.staticRenderFns=i,p._compiled=!0),n&&(p.functional=!0),r&&(p._scopeId="data-v-"+r),o?(c=function(t){(t=t||this.$vnode&&this.$vnode.ssrContext||this.parent&&this.parent.$vnode&&this.parent.$vnode.ssrContext)||"undefined"==typeof __VUE_SSR_CONTEXT__||(t=__VUE_SSR_CONTEXT__),a&&a.call(this,t),t&&t._registeredComponents&&t._registeredComponents.add(o)},p._ssrRegister=c):a&&(c=s?function(){a.call(this,this.$root.$options.shadowRoot)}:a),c)if(p.functional){p._injectStyles=c;var d=p.render;p.render=function(t,e){return c.call(e),d(t,e)}}else{var f=p.beforeCreate;p.beforeCreate=f?[].concat(f,c):[c]}return{exports:t,options:p}}i.d(e,"a",function(){return n})},1:function(t,e){t.exports={}},10:function(t,e){t.exports=Vue},100:function(t,e,i){"use strict";var n=i(380),a=i(293),r=i(0);var o=Object(r.a)(a.default,n.b,n.c,!1,null,null,"757ad5f7",!1,n.a,void 0);(function(t){this.options.style||(this.options.style={}),Vue.prototype.__merge_style&&Vue.prototype.__$appStyle__&&Vue.prototype.__merge_style(Vue.prototype.__$appStyle__,this.options.style),Vue.prototype.__merge_style?Vue.prototype.__merge_style(i(519).default,this.options.style):Object.assign(this.options.style,i(519).default)}).call(o),e.default=o.exports},11:function(t,e,i){Vue.prototype.__$appStyle__={},Vue.prototype.__merge_style&&Vue.prototype.__merge_style(i(12).default,Vue.prototype.__$appStyle__)},12:function(t,e,i){"use strict";i.r(e);var n=i(1),a=i.n(n);for(var r in n)"default"!==r&&function(t){i.d(e,t,function(){return n[t]})}(r);e.default=a.a},13:function(t,e,i){"use strict";i.r(e);var n=i(6),a=i(3);for(var r in a)"default"!==r&&function(t){i.d(e,t,function(){return a[t]})}(r);var o=i(0);var s=Object(o.a)(a.default,n.b,n.c,!1,null,"4185f303","1e32d801",!1,n.a,void 0);(function(t){this.options.style||(this.options.style={}),Vue.prototype.__merge_style&&Vue.prototype.__$appStyle__&&Vue.prototype.__merge_style(Vue.prototype.__$appStyle__,this.options.style),Vue.prototype.__merge_style?Vue.prototype.__merge_style(i(14).default,this.options.style):Object.assign(this.options.style,i(14).default)}).call(s),e.default=s.exports},14:function(t,e,i){"use strict";i.r(e);var n=i(5),a=i.n(n);for(var r in n)"default"!==r&&function(t){i.d(e,t,function(){return n[t]})}(r);e.default=a.a},2:function(t,e,i){"use strict";i.r(e),e.default={appid:"__UNI__EA9F85F"}},290:function(t,e,i){"use strict";i.r(e);var n=i(291),a=i.n(n);for(var r in n)"default"!==r&&function(t){i.d(e,t,function(){return n[t]})}(r);e.default=a.a},291:function(t,e,i){"use strict";Object.defineProperty(e,"__esModule",{value:!0}),e.default=void 0;var n={name:"UniTag",props:{type:{type:String,default:"default"},size:{type:String,default:"normal"},text:{type:String,default:""},disabled:{type:[Boolean,String],defalut:!1},inverted:{type:[Boolean,String],defalut:!1},circle:{type:[Boolean,String],defalut:!1},mark:{type:[Boolean,String],defalut:!1}},methods:{onClick:function(){!0!==this.disabled&&"true"!==this.disabled&&this.$emit("click")}}};e.default=n},292:function(t,e){t.exports={"uni-tag":{paddingTop:"0",paddingRight:"16",paddingBottom:"0",paddingLeft:"16",height:"30",lineHeight:"30",justifyContent:"center",color:"#333333",borderRadius:"6rpx",backgroundColor:"#f8f8f8",borderWidth:"1rpx",borderStyle:"solid",borderColor:"#f8f8f8"},"uni-tag--circle":{borderRadius:"15"},"uni-tag--mark":{borderTopLeftRadius:0,borderBottomLeftRadius:0,borderTopRightRadius:"15",borderBottomRightRadius:"15"},"uni-tag--disabled":{opacity:.5},"uni-tag--small":{height:"20",paddingTop:"0",paddingRight:"8",paddingBottom:"0",paddingLeft:"8",lineHeight:"20",fontSize:"24rpx"},"uni-tag--default":{color:"#333333",fontSize:"28rpx"},"uni-tag-text--small":{fontSize:"24rpx"},"uni-tag-text":{color:"#ffffff",fontSize:"28rpx"},"uni-tag-text--primary":{color:"#007aff"},"uni-tag-text--success":{color:"#4cd964"},"uni-tag-text--warning":{color:"#f0ad4e"},"uni-tag-text--error":{color:"#dd524d"},"uni-tag--primary":{color:"#ffffff",backgroundColor:"#007aff",borderWidth:"1rpx",borderStyle:"solid",borderColor:"#007aff"},"primary-uni-tag--inverted":{color:"#007aff",backgroundColor:"#ffffff",borderWidth:"1rpx",borderStyle:"solid",borderColor:"#007aff"},"uni-tag--success":{color:"#ffffff",backgroundColor:"#4cd964",borderWidth:"1rpx",borderStyle:"solid",borderColor:"#4cd964"},"success-uni-tag--inverted":{color:"#4cd964",backgroundColor:"#ffffff",borderWidth:"1rpx",borderStyle:"solid",borderColor:"#4cd964"},"uni-tag--warning":{color:"#ffffff",backgroundColor:"#f0ad4e",borderWidth:"1rpx",borderStyle:"solid",borderColor:"#f0ad4e"},"warning-uni-tag--inverted":{color:"#f0ad4e",backgroundColor:"#ffffff",borderWidth:"1rpx",borderStyle:"solid",borderColor:"#f0ad4e"},"uni-tag--error":{color:"#ffffff",backgroundColor:"#dd524d",borderWidth:"1rpx",borderStyle:"solid",borderColor:"#dd524d"},"error-uni-tag--inverted":{color:"#dd524d",backgroundColor:"#ffffff",borderWidth:"1rpx",borderStyle:"solid",borderColor:"#dd524d"},"uni-tag--inverted":{color:"#333333",backgroundColor:"#ffffff",borderWidth:"1rpx",borderStyle:"solid",borderColor:"#f8f8f8"}}},293:function(t,e,i){"use strict";var n=i(294),a=i.n(n);e.default=a.a},294:function(t,e,i){"use strict";Object.defineProperty(e,"__esModule",{value:!0}),e.default=void 0;var n=r(i(517)),a=r(i(13));function r(t){return t&&t.__esModule?t:{default:t}}var o={components:{uniTag:n.default,uniSection:a.default},data:function(){return{type:"default",inverted:!1}},methods:{setType:function(){var t=["default","primary","success","warning","error"],e=t.indexOf(this.type);t.splice(e,1);var i=Math.floor(4*Math.random());this.type=t[i]},setInverted:function(){this.inverted=!this.inverted}}};e.default=o},295:function(t,e){t.exports={example:{paddingTop:0,paddingRight:"15",paddingBottom:0,paddingLeft:"15"},"example-info":{paddingTop:"15",paddingRight:"15",paddingBottom:"15",paddingLeft:"15",color:"#3b4144",backgroundColor:"#ffffff",fontSize:"14",lineHeight:"20"},"example-info-text":{fontSize:"14",lineHeight:"20",color:"#3b4144"},"example-body":{flexDirection:"row",paddingTop:"20rpx",paddingRight:"20rpx",paddingBottom:"20rpx",paddingLeft:"20rpx",backgroundColor:"#ffffff",justifyContent:"flex-start",flexWrap:"wrap"},"word-btn-white":{fontSize:"18",color:"#FFFFFF"},"word-btn":{flexDirection:"row",alignItems:"center",justifyContent:"center",borderRadius:"6",height:"48",marginTop:"15",marginRight:"15",marginBottom:"15",marginLeft:"15",backgroundColor:"#007AFF"},"word-btn--hover":{backgroundColor:"#4ca2ff"},"tag-view":{flexDirection:"column",marginTop:"10rpx",marginRight:"15rpx",marginBottom:"10rpx",marginLeft:"15rpx",justifyContent:"center"}}},3:function(t,e,i){"use strict";i.r(e);var n=i(4),a=i.n(n);for(var r in n)"default"!==r&&function(t){i.d(e,t,function(){return n[t]})}(r);e.default=a.a},380:function(t,e,i){"use strict";var n={"uni-section":i(13).default,"uni-tag":i(517).default},a=function(){var t=this.$createElement,e=this._self._c||t;return e("scroll-view",{staticStyle:{flexDirection:"column"},attrs:{scrollY:!0,enableBackToTop:!0,bubble:"true"}},[e("view",[e("u-text",{staticClass:["example-info"]},[this._v("标签组件多用于商品分类、重点内容显示等场景。")]),e("uni-section",{attrs:{title:"实心标签",type:"line"}}),e("view",{staticClass:["example-body"]},[e("view",{staticClass:["tag-view"]},[e("uni-tag",{attrs:{text:"标签"}})],1),e("view",{staticClass:["tag-view"]},[e("uni-tag",{attrs:{text:"标签",type:"primary"}})],1),e("view",{staticClass:["tag-view"]},[e("uni-tag",{attrs:{text:"标签",type:"success"}})],1),e("view",{staticClass:["tag-view"]},[e("uni-tag",{attrs:{text:"标签",type:"warning"}})],1),e("view",{staticClass:["tag-view"]},[e("uni-tag",{attrs:{text:"标签",type:"error"}})],1)]),e("uni-section",{attrs:{title:"空心标签",type:"line"}}),e("view",{staticClass:["example-body"]},[e("view",{staticClass:["tag-view"]},[e("uni-tag",{attrs:{inverted:!0,text:"标签"}})],1),e("view",{staticClass:["tag-view"]},[e("uni-tag",{attrs:{inverted:!0,text:"标签",type:"primary"}})],1),e("view",{staticClass:["tag-view"]},[e("uni-tag",{attrs:{inverted:!0,text:"标签",type:"success"}})],1),e("view",{staticClass:["tag-view"]},[e("uni-tag",{attrs:{inverted:!0,text:"标签",type:"warning"}})],1),e("view",{staticClass:["tag-view"]},[e("uni-tag",{attrs:{inverted:!0,text:"标签",type:"error"}})],1)]),e("uni-section",{attrs:{title:"圆角样式",type:"line"}}),e("view",{staticClass:["example-body"]},[e("view",{staticClass:["tag-view"]},[e("uni-tag",{attrs:{circle:!0,text:"标签",type:"primary",size:"small"}})],1),e("view",{staticClass:["tag-view"]},[e("uni-tag",{attrs:{inverted:!0,circle:!0,text:"标签",type:"success",size:"small"}})],1),e("view",{staticClass:["tag-view"]},[e("uni-tag",{attrs:{circle:!0,text:"标签",type:"warning"}})],1),e("view",{staticClass:["tag-view"]},[e("uni-tag",{attrs:{inverted:!0,circle:!0,text:"标签",type:"error"}})],1)]),e("uni-section",{attrs:{title:"标记样式",type:"line"}}),e("view",{staticClass:["example-body"]},[e("view",{staticClass:["tag-view"]},[e("uni-tag",{attrs:{mark:!0,text:"标签",type:"primary",size:"small"}})],1),e("view",{staticClass:["tag-view"]},[e("uni-tag",{attrs:{mark:!0,text:"标签",type:"success",size:"small"}})],1),e("view",{staticClass:["tag-view"]},[e("uni-tag",{attrs:{mark:!0,text:"标签",type:"warning"}})],1),e("view",{staticClass:["tag-view"]},[e("uni-tag",{attrs:{mark:!0,circle:!0,text:"标签",type:"error"}})],1)]),e("uni-section",{attrs:{title:"点击事件",type:"line"}}),e("view",{staticClass:["example-body"]},[e("view",{staticClass:["tag-view"]},[e("uni-tag",{attrs:{type:this.type,text:"标签"},on:{click:this.setType}})],1),e("view",{staticClass:["tag-view"]},[e("uni-tag",{attrs:{circle:!0,inverted:this.inverted,text:"标签",type:"primary"},on:{click:this.setInverted}})],1)]),e("uni-section",{attrs:{title:"小标签",type:"line"}}),e("view",{staticClass:["example-body"]},[e("view",{staticClass:["tag-view"]},[e("uni-tag",{attrs:{text:"标签",size:"small"}})],1),e("view",{staticClass:["tag-view"]},[e("uni-tag",{attrs:{text:"标签",type:"primary",size:"small"}})],1),e("view",{staticClass:["tag-view"]},[e("uni-tag",{attrs:{text:"标签",type:"success",size:"small"}})],1),e("view",{staticClass:["tag-view"]},[e("uni-tag",{attrs:{inverted:!0,mark:!0,text:"标签",type:"warning",size:"small"}})],1),e("view",{staticClass:["tag-view"]},[e("uni-tag",{attrs:{inverted:!0,circle:!0,text:"标签",type:"error",size:"small"}})],1)]),e("uni-section",{attrs:{title:"不可点击状态",type:"line"}}),e("view",{staticClass:["example-body"]},[e("view",{staticClass:["tag-view"]},[e("uni-tag",{attrs:{disabled:!0,text:"标签"}})],1),e("view",{staticClass:["tag-view"]},[e("uni-tag",{attrs:{disabled:!0,text:"标签",type:"primary"}})],1),e("view",{staticClass:["tag-view"]},[e("uni-tag",{attrs:{inverted:!0,disabled:!0,text:"标签",type:"error",size:"small"}})],1)])],1)])},r=[];i.d(e,"b",function(){return a}),i.d(e,"c",function(){return r}),i.d(e,"a",function(){return n})},4:function(t,e,i){"use strict";Object.defineProperty(e,"__esModule",{value:!0}),e.default=void 0;var n={name:"UniTitle",props:{type:{type:String,default:""},title:{type:String,default:""},subTitle:{type:String,default:""}},data:function(){return{}},watch:{title:function(t){uni.report&&""!==t&&uni.report("title",t)}},methods:{onClick:function(){this.$emit("click")}}};e.default=n},419:function(t,e,i){"use strict";var n=function(){var t=this,e=t.$createElement,i=t._self._c||e;return t.text?i("view",{staticClass:["uni-tag"],class:["uni-tag--"+t.type,!0===t.disabled||"true"===t.disabled?"uni-tag--disabled":"",!0===t.inverted||"true"===t.inverted?t.type+"-uni-tag--inverted":"",!0===t.circle||"true"===t.circle?"uni-tag--circle":"",!0===t.mark||"true"===t.mark?"uni-tag--mark":"","uni-tag--"+t.size],on:{click:function(e){t.onClick()}}},[i("u-text",{class:["default"===t.type?"uni-tag--default":"uni-tag-text",!0===t.inverted||"true"===t.inverted?"uni-tag-text--"+t.type:"","small"===t.size?"uni-tag-text--small":""]},[t._v(t._s(t.text))])]):t._e()},a=[];i.d(e,"b",function(){return n}),i.d(e,"c",function(){return a}),i.d(e,"a",function(){})},5:function(t,e){t.exports={"uni-section":{position:"relative",marginTop:"10",flexDirection:"row",alignItems:"center",paddingTop:0,paddingRight:"10",paddingBottom:0,paddingLeft:"10",height:"50",backgroundColor:"#f8f8f8",borderBottomColor:"#e5e5e5",borderBottomStyle:"solid",borderBottomWidth:"0.5",fontWeight:"normal"},"uni-section__head":{flexDirection:"row",justifyContent:"center",alignItems:"center",marginRight:"10"},line:{height:"15",backgroundColor:"#c0c0c0",borderRadius:"5",width:"3"},circle:{width:"8",height:"8",borderTopRightRadius:"50",borderTopLeftRadius:"50",borderBottomLeftRadius:"50",borderBottomRightRadius:"50",backgroundColor:"#c0c0c0"},"uni-section__content":{flex:1,color:"#333333"},"uni-section__content-title":{fontSize:"28rpx",color:"#333333"},distraction:{flexDirection:"row",alignItems:"center"},"uni-section__content-sub":{fontSize:"24rpx",color:"#999999"}}},517:function(t,e,i){"use strict";i.r(e);var n=i(419),a=i(290);for(var r in a)"default"!==r&&function(t){i.d(e,t,function(){return a[t]})}(r);var o=i(0);var s=Object(o.a)(a.default,n.b,n.c,!1,null,"0a3ab0e8","4659eeeb",!1,n.a,void 0);(function(t){this.options.style||(this.options.style={}),Vue.prototype.__merge_style&&Vue.prototype.__$appStyle__&&Vue.prototype.__merge_style(Vue.prototype.__$appStyle__,this.options.style),Vue.prototype.__merge_style?Vue.prototype.__merge_style(i(518).default,this.options.style):Object.assign(this.options.style,i(518).default)}).call(s),e.default=s.exports},518:function(t,e,i){"use strict";i.r(e);var n=i(292),a=i.n(n);for(var r in n)"default"!==r&&function(t){i.d(e,t,function(){return n[t]})}(r);e.default=a.a},519:function(t,e,i){"use strict";i.r(e);var n=i(295),a=i.n(n);for(var r in n)"default"!==r&&function(t){i.d(e,t,function(){return n[t]})}(r);e.default=a.a},590:function(t,e,i){"use strict";i.r(e);i(7),i(11);var n=i(100);n.default.mpType="page",n.default.route="pages/extUI/tag/tag",n.default.el="#root",new Vue(n.default)},6:function(t,e,i){"use strict";var n=function(){var t=this,e=t.$createElement,i=t._self._c||e;return i("view",{staticClass:["uni-section"]},[t.type?i("view",{staticClass:["uni-section__head"]},[i("view",{staticClass:["uni-section__head-tag"],class:t.type})]):t._e(),i("view",{staticClass:["uni-section__content"]},[i("u-text",{staticClass:["uni-section__content-title"],class:{distraction:!t.subTitle}},[t._v(t._s(t.title))]),t.subTitle?i("u-text",{staticClass:["uni-section__content-sub"]},[t._v(t._s(t.subTitle))]):t._e()]),t._t("default")],2)},a=[];i.d(e,"b",function(){return n}),i.d(e,"c",function(){return a}),i.d(e,"a",function(){})},7:function(t,e,i){"use strict";function n(t,e){return!e||"object"!=typeof e&&"function"!=typeof e?function(t){if(void 0===t)throw new ReferenceError("this hasn't been initialised - super() hasn't been called");return t}(t):e}function a(t){return(a=Object.setPrototypeOf?Object.getPrototypeOf:function(t){return t.__proto__||Object.getPrototypeOf(t)})(t)}function r(t,e){return(r=Object.setPrototypeOf||function(t,e){return t.__proto__=e,t})(t,e)}function o(t,e){if(!(t instanceof e))throw new TypeError("Cannot call a class as a function")}function s(t,e){for(var i=0;i<e.length;i++){var n=e[i];n.enumerable=n.enumerable||!1,n.configurable=!0,"value"in n&&(n.writable=!0),Object.defineProperty(t,n.key,n)}}function u(t,e,i){return e&&s(t.prototype,e),i&&s(t,i),t}var l=i(8).version,c="__DC_STAT_UUID",p="__DC_UUID_VALUE";function d(){var t="";if("n"===h()){try{t=plus.runtime.getDCloudId()}catch(e){t=""}return t}try{t=uni.getStorageSync(c)}catch(e){t=p}if(!t){t=Date.now()+""+Math.floor(1e7*Math.random());try{uni.setStorageSync(c,t)}catch(t){uni.setStorageSync(c,p)}}return t}var f,g=function(){return parseInt((new Date).getTime()/1e3)},h=function(){return"n"},_=function(){var t="";return"wx"!==h()&&"qq"!==h()||uni.canIUse("getAccountInfoSync")&&(t=uni.getAccountInfoSync().miniProgram.appId||""),t},v=function(){return"n"===h()?plus.runtime.version:""},y=function(){var t="";return"n"===h()&&(t=plus.runtime.channel),t},m=0,b=0,w=function(){return m=g(),"n"===h()&&uni.setStorageSync("__page__residence__time",g()),m},S=0,x=0,C=function(){var t=(new Date).getTime();return S=t,x=0,t},k=function(){var t=(new Date).getTime();return x=t,t},D=function(t){var e=0;return 0!==S&&(e=x-S),e=(e=parseInt(e/1e3))<1?1:e,"app"===t?{residenceTime:e,overtime:e>300}:"page"===t?{residenceTime:e,overtime:e>1800}:{residenceTime:e}},T=function(t){var e=getCurrentPages(),i=e[e.length-1].$vm,n=t._query,a=n&&"{}"!==JSON.stringify(n)?"?"+JSON.stringify(n):"";return t._query="","bd"===h()?i.$mp&&i.$mp.page.is+a:i.$scope&&i.$scope.route+a||i.$mp&&i.$mp.page.route+a},R=function(t){return!!("page"===t.mpType||t.$mp&&"page"===t.$mp.mpType||"page"===t.$options.mpType)},q=i(9).default,j=i(2).default||i(2),O=uni.getSystemInfoSync(),$=function(){function t(){o(this,t),this.self="",this._retry=0,this._platform="",this._query={},this._navigationBarTitle={config:"",page:"",report:"",lt:""},this._operatingTime=0,this._reportingRequestData={1:[],11:[]},this.__prevent_triggering=!1,this.__licationHide=!1,this.__licationShow=!1,this._lastPageRoute="",this.statData={uuid:d(),ut:h(),mpn:_(),ak:j.appid,usv:l,v:v(),ch:y(),cn:"",pn:"",ct:"",t:g(),tt:"",p:"android"===O.platform?"a":"i",brand:O.brand||"",md:O.model,sv:O.system.replace(/(Android|iOS)\s/,""),mpsdk:O.SDKVersion||"",mpv:O.version||"",lang:O.language,pr:O.pixelRatio,ww:O.windowWidth,wh:O.windowHeight,sw:O.screenWidth,sh:O.screenHeight}}return u(t,[{key:"_applicationShow",value:function(){if(this.__licationHide){if(k(),D("app").overtime){var t={path:this._lastPageRoute,scene:this.statData.sc};this._sendReportRequest(t)}this.__licationHide=!1}}},{key:"_applicationHide",value:function(t,e){this.__licationHide=!0,k();var i=D();C();var n=T(this);this._sendHideRequest({urlref:n,urlref_ts:i.residenceTime},e)}},{key:"_pageShow",value:function(){var t,e,i=T(this),n=(t=getCurrentPages(),e=t[t.length-1].$vm,"bd"===h()?e.$mp&&e.$mp.page.is:e.$scope&&e.$scope.route||e.$mp&&e.$mp.page.route);if(this._navigationBarTitle.config=q&&q.pages[n]&&q.pages[n].titleNView&&q.pages[n].titleNView.titleText||q&&q.pages[n]&&q.pages[n].navigationBarTitleText||"",this.__licationShow)return C(),this.__licationShow=!1,void(this._lastPageRoute=i);if(k(),this._lastPageRoute=i,D("page").overtime){var a={path:this._lastPageRoute,scene:this.statData.sc};this._sendReportRequest(a)}C()}},{key:"_pageHide",value:function(){if(!this.__licationHide){k();var t=D("page");return this._sendPageRequest({url:this._lastPageRoute,urlref:this._lastPageRoute,urlref_ts:t.residenceTime}),void(this._navigationBarTitle={config:"",page:"",report:"",lt:""})}}},{key:"_login",value:function(){this._sendEventRequest({key:"login"},0)}},{key:"_share",value:function(){this._sendEventRequest({key:"share"},0)}},{key:"_payment",value:function(t){this._sendEventRequest({key:t},0)}},{key:"_sendReportRequest",value:function(t){this._navigationBarTitle.lt="1";var e,i,n=t.query&&"{}"!==JSON.stringify(t.query)?"?"+JSON.stringify(t.query):"";this.statData.lt="1",this.statData.url=t.path+n||"",this.statData.t=g(),this.statData.sc=function(t){var e=h(),i="";return t||("wx"===e&&(i=uni.getLaunchOptionsSync().scene),i)}(t.scene),this.statData.fvts=(e=uni.getStorageSync("First__Visit__Time"),i=0,e?i=e:(i=g(),uni.setStorageSync("First__Visit__Time",i),uni.removeStorageSync("Last__Visit__Time")),i),this.statData.lvts=function(){var t=uni.getStorageSync("Last__Visit__Time"),e=0;return e=t||"",uni.setStorageSync("Last__Visit__Time",g()),e}(),this.statData.tvc=function(){var t=uni.getStorageSync("Total__Visit__Count"),e=1;return t&&(e=t,e++),uni.setStorageSync("Total__Visit__Count",e),e}(),"n"===h()?this.getProperty():this.getNetworkInfo()}},{key:"_sendPageRequest",value:function(t){var e=t.url,i=t.urlref,n=t.urlref_ts;this._navigationBarTitle.lt="11";var a={ak:this.statData.ak,uuid:this.statData.uuid,lt:"11",ut:this.statData.ut,url:e,tt:this.statData.tt,urlref:i,urlref_ts:n,ch:this.statData.ch,usv:this.statData.usv,t:g(),p:this.statData.p};this.request(a)}},{key:"_sendHideRequest",value:function(t,e){var i=t.urlref,n=t.urlref_ts,a={ak:this.statData.ak,uuid:this.statData.uuid,lt:"3",ut:this.statData.ut,urlref:i,urlref_ts:n,ch:this.statData.ch,usv:this.statData.usv,t:g(),p:this.statData.p};this.request(a,e)}},{key:"_sendEventRequest",value:function(){var t=arguments.length>0&&void 0!==arguments[0]?arguments[0]:{},e=t.key,i=void 0===e?"":e,n=t.value,a=void 0===n?"":n,r=this._lastPageRoute,o={ak:this.statData.ak,uuid:this.statData.uuid,lt:"21",ut:this.statData.ut,url:r,ch:this.statData.ch,e_n:i,e_v:"object"==typeof a?JSON.stringify(a):a.toString(),usv:this.statData.usv,t:g(),p:this.statData.p};this.request(o)}},{key:"getNetworkInfo",value:function(){var t=this;uni.getNetworkType({success:function(e){t.statData.net=e.networkType,t.getLocation()}})}},{key:"getProperty",value:function(){var t=this;plus.runtime.getProperty(plus.runtime.appid,function(e){t.statData.v=e.version||"",t.getNetworkInfo()})}},{key:"getLocation",value:function(){var t=this;j.getLocation?uni.getLocation({type:"wgs84",geocode:!0,success:function(e){e.address&&(t.statData.cn=e.address.country,t.statData.pn=e.address.province,t.statData.ct=e.address.city),t.statData.lat=e.latitude,t.statData.lng=e.longitude,t.request(t.statData)}}):(this.statData.lat=0,this.statData.lng=0,this.request(this.statData))}},{key:"request",value:function(t,e){var i=this,n=g(),a=this._navigationBarTitle;t.ttn=a.page,t.ttpj=a.config,t.ttc=a.report;var r=this._reportingRequestData;if("n"===h()&&(r=uni.getStorageSync("__UNI__STAT__DATA")||{}),r[t.lt]||(r[t.lt]=[]),r[t.lt].push(t),"n"===h()&&uni.setStorageSync("__UNI__STAT__DATA",r),b=g(),"n"===h()&&(m=uni.getStorageSync("__page__residence__time")),!(b-m<10)||e){var o=this._reportingRequestData;"n"===h()&&(o=uni.getStorageSync("__UNI__STAT__DATA")),w();var s=[],u=[],c=[],p=function(t){o[t].forEach(function(e){var i=function(t){var e="";for(var i in t)e+=i+"="+t[i]+"&";return e.substr(0,e.length-1)}(e);0===t?s.push(i):3===t?c.push(i):u.push(i)})};for(var d in o)p(d);s.push.apply(s,u.concat(c));var f={usv:l,t:n,requests:JSON.stringify(s)};this._reportingRequestData={},"n"===h()&&uni.removeStorageSync("__UNI__STAT__DATA"),"h5"!==t.ut?"n"!==h()||"a"!==this.statData.p?this._sendRequest(f):setTimeout(function(){i._sendRequest(f)},200):this.imageRequest(f)}}},{key:"_sendRequest",value:function(t){var e=this;uni.request({url:"https://tongji.dcloud.io/uni/stat",method:"POST",data:t,success:function(){},fail:function(i){++e._retry<3&&setTimeout(function(){e._sendRequest(t)},1e3)}})}},{key:"imageRequest",value:function(t){var e=new Image,i=function(t){var e=Object.keys(t).sort(),i={},n="";for(var a in e)i[e[a]]=t[e[a]],n+=e[a]+"="+t[e[a]]+"&";return{sign:"",options:n.substr(0,n.length-1)}}(function(t){var e={};for(var i in t)e[i]=encodeURIComponent(t[i]);return e}(t)).options;e.src="https://tongji.dcloud.io/uni/stat.gif?"+i}},{key:"sendEvent",value:function(t,e){var i,n;(n=e,(i=t)?"string"!=typeof i?(console.error("uni.report [eventName] 参数类型错误,只能为 String 类型"),1):i.length>255?(console.error("uni.report [eventName] 参数长度不能大于 255"),1):"string"!=typeof n&&"object"!=typeof n?(console.error("uni.report [options] 参数类型错误,只能为 String 或 Object 类型"),1):"string"==typeof n&&n.length>255?(console.error("uni.report [options] 参数长度不能大于 255"),1):"title"===i&&"string"!=typeof n?(console.error("uni.report [eventName] 参数为 title 时，[options] 参数只能为 String 类型"),1):void 0:(console.error("uni.report 缺少 [eventName] 参数"),1))||("title"!==t?this._sendEventRequest({key:t,value:"object"==typeof e?JSON.stringify(e):e},1):this._navigationBarTitle.report=e)}}]),t}(),I=function(t){function e(){var t;return o(this,e),(t=n(this,a(e).call(this))).instance=null,"function"==typeof uni.addInterceptor&&(t.addInterceptorInit(),t.interceptLogin(),t.interceptShare(!0),t.interceptRequestPayment()),t}return function(t,e){if("function"!=typeof e&&null!==e)throw new TypeError("Super expression must either be null or a function");t.prototype=Object.create(e&&e.prototype,{constructor:{value:t,writable:!0,configurable:!0}}),e&&r(t,e)}(e,$),u(e,null,[{key:"getInstance",value:function(){return this.instance||(this.instance=new e),this.instance}}]),u(e,[{key:"addInterceptorInit",value:function(){var t=this;uni.addInterceptor("setNavigationBarTitle",{invoke:function(e){t._navigationBarTitle.page=e.title}})}},{key:"interceptLogin",value:function(){var t=this;uni.addInterceptor("login",{complete:function(){t._login()}})}},{key:"interceptShare",value:function(t){var e=this;t?uni.addInterceptor("share",{success:function(){e._share()},fail:function(){e._share()}}):e._share()}},{key:"interceptRequestPayment",value:function(){var t=this;uni.addInterceptor("requestPayment",{success:function(){t._payment("pay_success")},fail:function(){t._payment("pay_fail")}})}},{key:"report",value:function(t,e){this.self=e,w(),this.__licationShow=!0,this._sendReportRequest(t,!0)}},{key:"load",value:function(t,e){if(!e.$scope&&!e.$mp){var i=getCurrentPages();e.$scope=i[i.length-1]}this.self=e,this._query=t}},{key:"show",value:function(t){this.self=t,R(t)?this._pageShow(t):this._applicationShow(t)}},{key:"ready",value:function(t){}},{key:"hide",value:function(t){this.self=t,R(t)?this._pageHide(t):this._applicationHide(t,!0)}},{key:"error",value:function(t){this._platform;var e="";e=t.message?t.stack:JSON.stringify(t);var i={ak:this.statData.ak,uuid:this.statData.uuid,lt:"31",ut:this.statData.ut,ch:this.statData.ch,mpsdk:this.statData.mpsdk,mpv:this.statData.mpv,v:this.statData.v,em:e,usv:this.statData.usv,t:g(),p:this.statData.p};this.request(i)}}]),e}().getInstance(),V=!1,B={onLaunch:function(t){I.report(t,this)},onReady:function(){I.ready(this)},onLoad:function(t){if(I.load(t,this),this.$scope&&this.$scope.onShareAppMessage){var e=this.$scope.onShareAppMessage;this.$scope.onShareAppMessage=function(t){return I.interceptShare(!1),e.call(this,t)}}},onShow:function(){V=!1,I.show(this)},onHide:function(){V=!0,I.hide(this)},onUnload:function(){V?V=!1:I.hide(this)},onError:function(t){I.error(t)}};((f=i(10)).default||f).mixin(B),uni.report=function(t,e){I.sendEvent(t,e)}},8:function(t){t.exports={_from:"@dcloudio/uni-stat@alpha",_id:"@dcloudio/uni-stat@2.0.0-alpha-25620200113001",_inBundle:!1,_integrity:"sha512-B+6wnrhG4pSZDJUYdDxHuQK1Z+K24eLmEgpEBMMxg0siZzixWSt0sHWVgAbcsD+lAGWnVtAdSgz9xUHIaS9KCQ==",_location:"/@dcloudio/uni-stat",_phantomChildren:{},_requested:{type:"tag",registry:!0,raw:"@dcloudio/uni-stat@alpha",name:"@dcloudio/uni-stat",escapedName:"@dcloudio%2funi-stat",scope:"@dcloudio",rawSpec:"alpha",saveSpec:null,fetchSpec:"alpha"},_requiredBy:["#USER","/","/@dcloudio/vue-cli-plugin-uni"],_resolved:"https://registry.npmjs.org/@dcloudio/uni-stat/-/uni-stat-2.0.0-alpha-25620200113001.tgz",_shasum:"4ab5fa11e38643b12eb0e674f4136bb37b99be54",_spec:"@dcloudio/uni-stat@alpha",_where:"/Users/guoshengqiang/Documents/dcloud-plugins/alpha/uniapp-cli",author:"",bugs:{url:"https://github.com/dcloudio/uni-app/issues"},bundleDependencies:!1,deprecated:!1,description:"",devDependencies:{"@babel/core":"^7.5.5","@babel/preset-env":"^7.5.5",eslint:"^6.1.0",rollup:"^1.19.3","rollup-plugin-babel":"^4.3.3","rollup-plugin-clear":"^2.0.7","rollup-plugin-commonjs":"^10.0.2","rollup-plugin-copy":"^3.1.0","rollup-plugin-eslint":"^7.0.0","rollup-plugin-json":"^4.0.0","rollup-plugin-node-resolve":"^5.2.0","rollup-plugin-replace":"^2.2.0","rollup-plugin-uglify":"^6.0.2"},files:["dist","package.json","LICENSE"],gitHead:"67558a1dca8b1f3681c6b7d21be53720870a1a82",homepage:"https://github.com/dcloudio/uni-app#readme",license:"Apache-2.0",main:"dist/index.js",name:"@dcloudio/uni-stat",repository:{type:"git",url:"git+https://github.com/dcloudio/uni-app.git",directory:"packages/uni-stat"},scripts:{build:"NODE_ENV=production rollup -c rollup.config.js",dev:"NODE_ENV=development rollup -w -c rollup.config.js"},version:"2.0.0-alpha-25620200113001"}},9:function(t,e,i){"use strict";i.r(e),e.default={pages:{},globalStyle:{}}}});