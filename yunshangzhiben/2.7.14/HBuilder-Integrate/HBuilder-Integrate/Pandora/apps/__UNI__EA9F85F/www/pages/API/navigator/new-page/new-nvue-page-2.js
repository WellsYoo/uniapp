!function(t){var e={};function n(i){if(e[i])return e[i].exports;var o=e[i]={i:i,l:!1,exports:{}};return t[i].call(o.exports,o,o.exports,n),o.l=!0,o.exports}n.m=t,n.c=e,n.d=function(t,e,i){n.o(t,e)||Object.defineProperty(t,e,{enumerable:!0,get:i})},n.r=function(t){"undefined"!=typeof Symbol&&Symbol.toStringTag&&Object.defineProperty(t,Symbol.toStringTag,{value:"Module"}),Object.defineProperty(t,"__esModule",{value:!0})},n.t=function(t,e){if(1&e&&(t=n(t)),8&e)return t;if(4&e&&"object"==typeof t&&t&&t.__esModule)return t;var i=Object.create(null);if(n.r(i),Object.defineProperty(i,"default",{enumerable:!0,value:t}),2&e&&"string"!=typeof t)for(var o in t)n.d(i,o,function(e){return t[e]}.bind(null,o));return i},n.n=function(t){var e=t&&t.__esModule?function(){return t.default}:function(){return t};return n.d(e,"a",e),e},n.o=function(t,e){return Object.prototype.hasOwnProperty.call(t,e)},n.p="",n(n.s=558)}({0:function(t,e,n){"use strict";function i(t,e,n,i,o,r,a,s,u,c){var p,l="function"==typeof t?t.options:t;if(u&&(l.components=Object.assign(u,l.components||{})),c&&((c.beforeCreate||(c.beforeCreate=[])).unshift(function(){this[c.__module]=this}),(l.mixins||(l.mixins=[])).push(c)),e&&(l.render=e,l.staticRenderFns=n,l._compiled=!0),i&&(l.functional=!0),r&&(l._scopeId="data-v-"+r),a?(p=function(t){(t=t||this.$vnode&&this.$vnode.ssrContext||this.parent&&this.parent.$vnode&&this.parent.$vnode.ssrContext)||"undefined"==typeof __VUE_SSR_CONTEXT__||(t=__VUE_SSR_CONTEXT__),o&&o.call(this,t),t&&t._registeredComponents&&t._registeredComponents.add(a)},l._ssrRegister=p):o&&(p=s?function(){o.call(this,this.$root.$options.shadowRoot)}:o),p)if(l.functional){l._injectStyles=p;var f=l.render;l.render=function(t,e){return p.call(e),f(t,e)}}else{var h=l.beforeCreate;l.beforeCreate=h?[].concat(h,p):[p]}return{exports:t,options:l}}n.d(e,"a",function(){return i})},1:function(t,e){t.exports={}},10:function(t,e){t.exports=Vue},11:function(t,e,n){Vue.prototype.__$appStyle__={},Vue.prototype.__merge_style&&Vue.prototype.__merge_style(n(12).default,Vue.prototype.__$appStyle__)},12:function(t,e,n){"use strict";n.r(e);var i=n(1),o=n.n(i);for(var r in i)"default"!==r&&function(t){n.d(e,t,function(){return i[t]})}(r);e.default=o.a},148:function(t,e,n){"use strict";var i=n(149),o=n.n(i);e.default=o.a},149:function(t,e,n){"use strict";Object.defineProperty(e,"__esModule",{value:!0}),e.default=void 0;var i=n(438);function o(t){for(var e=1;e<arguments.length;e++){var n=null!=arguments[e]?arguments[e]:{},i=Object.keys(n);"function"==typeof Object.getOwnPropertySymbols&&(i=i.concat(Object.getOwnPropertySymbols(n).filter(function(t){return Object.getOwnPropertyDescriptor(n,t).enumerable}))),i.forEach(function(e){r(t,e,n[e])})}return t}function r(t,e,n){return e in t?Object.defineProperty(t,e,{value:n,enumerable:!0,configurable:!0,writable:!0}):t[e]=n,t}var a={data:function(){return{}},computed:o({},(0,i.mapState)(["colorIndex","colorList"]),(0,i.mapGetters)(["currentColor"])),methods:o({},(0,i.mapMutations)(["setColorIndex"]))};e.default=a},150:function(t,e){t.exports={"new-page__text":{fontSize:"14",color:"#666666"},root:{flexDirection:"column"},"page-body":{flex:1,flexDirection:"column",justifyContent:"flex-start",alignItems:"center",paddingTop:"50"},"new-page__text-box":{paddingTop:"20",paddingRight:"20",paddingBottom:"20",paddingLeft:"20"},"new-page__color":{width:"200",height:"100",justifyContent:"center",alignItems:"center"},"new-page__color-text":{fontSize:"14",color:"#FFFFFF",lineHeight:"30",textAlign:"center"},"new-page__button-item":{marginTop:"15",width:"300"}}},2:function(t,e,n){"use strict";n.r(e),e.default={appid:"__UNI__EA9F85F"}},377:function(t,e,n){"use strict";var i=function(){var t=this,e=t.$createElement,n=t._self._c||e;return n("scroll-view",{staticStyle:{flexDirection:"column"},attrs:{scrollY:!0,enableBackToTop:!0,bubble:"true"}},[n("view",{staticClass:["root"]},[n("view",{staticClass:["page-body"]},[n("view",{staticClass:["new-page__color"],style:{backgroundColor:t.currentColor},on:{click:function(e){t.setColorIndex(t.colorIndex>1?0:t.colorIndex+1)}}},[n("u-text",{staticClass:["new-page__color-text"]},[t._v("点击改变颜色")])]),n("view",{staticClass:["new-page__text-box"]},[n("u-text",{staticClass:["new-page__text"]},[t._v("点击上方色块使用vuex在页面之间进行通讯")])])])])])},o=[];n.d(e,"b",function(){return i}),n.d(e,"c",function(){return o}),n.d(e,"a",function(){})},438:function(t,e,n){"use strict";n.r(e),n.d(e,"Store",function(){return p}),n.d(e,"install",function(){return y}),n.d(e,"mapState",function(){return m}),n.d(e,"mapMutations",function(){return b}),n.d(e,"mapGetters",function(){return S}),n.d(e,"mapActions",function(){return w}),n.d(e,"createNamespacedHelpers",function(){return D});
/**
 * vuex v3.0.1
 * (c) 2017 Evan You
 * @license MIT
 */
var i=function(t){if(Number(t.version.split(".")[0])>=2)t.mixin({beforeCreate:n});else{var e=t.prototype._init;t.prototype._init=function(t){void 0===t&&(t={}),t.init=t.init?[n].concat(t.init):n,e.call(this,t)}}function n(){var t=this.$options;t.store?this.$store="function"==typeof t.store?t.store():t.store:t.parent&&t.parent.$store&&(this.$store=t.parent.$store)}},o="undefined"!=typeof window&&window.__VUE_DEVTOOLS_GLOBAL_HOOK__;function r(t,e){Object.keys(t).forEach(function(n){return e(t[n],n)})}var a=function(t,e){this.runtime=e,this._children=Object.create(null),this._rawModule=t;var n=t.state;this.state=("function"==typeof n?n():n)||{}},s={namespaced:{configurable:!0}};s.namespaced.get=function(){return!!this._rawModule.namespaced},a.prototype.addChild=function(t,e){this._children[t]=e},a.prototype.removeChild=function(t){delete this._children[t]},a.prototype.getChild=function(t){return this._children[t]},a.prototype.update=function(t){this._rawModule.namespaced=t.namespaced,t.actions&&(this._rawModule.actions=t.actions),t.mutations&&(this._rawModule.mutations=t.mutations),t.getters&&(this._rawModule.getters=t.getters)},a.prototype.forEachChild=function(t){r(this._children,t)},a.prototype.forEachGetter=function(t){this._rawModule.getters&&r(this._rawModule.getters,t)},a.prototype.forEachAction=function(t){this._rawModule.actions&&r(this._rawModule.actions,t)},a.prototype.forEachMutation=function(t){this._rawModule.mutations&&r(this._rawModule.mutations,t)},Object.defineProperties(a.prototype,s);var u=function(t){this.register([],t,!1)};u.prototype.get=function(t){return t.reduce(function(t,e){return t.getChild(e)},this.root)},u.prototype.getNamespace=function(t){var e=this.root;return t.reduce(function(t,n){return t+((e=e.getChild(n)).namespaced?n+"/":"")},"")},u.prototype.update=function(t){!function t(e,n,i){0;n.update(i);if(i.modules)for(var o in i.modules){if(!n.getChild(o))return void 0;t(e.concat(o),n.getChild(o),i.modules[o])}}([],this.root,t)},u.prototype.register=function(t,e,n){var i=this;void 0===n&&(n=!0);var o=new a(e,n);0===t.length?this.root=o:this.get(t.slice(0,-1)).addChild(t[t.length-1],o);e.modules&&r(e.modules,function(e,o){i.register(t.concat(o),e,n)})},u.prototype.unregister=function(t){var e=this.get(t.slice(0,-1)),n=t[t.length-1];e.getChild(n).runtime&&e.removeChild(n)};var c;var p=function(t){var e=this;void 0===t&&(t={}),!c&&"undefined"!=typeof window&&window.Vue&&y(window.Vue);var n=t.plugins;void 0===n&&(n=[]);var i=t.strict;void 0===i&&(i=!1);var r=t.state;void 0===r&&(r={}),"function"==typeof r&&(r=r()||{}),this._committing=!1,this._actions=Object.create(null),this._actionSubscribers=[],this._mutations=Object.create(null),this._wrappedGetters=Object.create(null),this._modules=new u(t),this._modulesNamespaceMap=Object.create(null),this._subscribers=[],this._watcherVM=new c;var a=this,s=this.dispatch,p=this.commit;this.dispatch=function(t,e){return s.call(a,t,e)},this.commit=function(t,e,n){return p.call(a,t,e,n)},this.strict=i,_(this,r,[],this._modules.root),d(this,r),n.forEach(function(t){return t(e)}),c.config.devtools&&function(t){o&&(t._devtoolHook=o,o.emit("vuex:init",t),o.on("vuex:travel-to-state",function(e){t.replaceState(e)}),t.subscribe(function(t,e){o.emit("vuex:mutation",t,e)}))}(this)},l={state:{configurable:!0}};function f(t,e){return e.indexOf(t)<0&&e.push(t),function(){var n=e.indexOf(t);n>-1&&e.splice(n,1)}}function h(t,e){t._actions=Object.create(null),t._mutations=Object.create(null),t._wrappedGetters=Object.create(null),t._modulesNamespaceMap=Object.create(null);var n=t.state;_(t,n,[],t._modules.root,!0),d(t,n,e)}function d(t,e,n){var i=t._vm;t.getters={};var o=t._wrappedGetters,a={};r(o,function(e,n){a[n]=function(){return e(t)},Object.defineProperty(t.getters,n,{get:function(){return t._vm[n]},enumerable:!0})});var s=c.config.silent;c.config.silent=!0,t._vm=new c({data:{$$state:e},computed:a}),c.config.silent=s,t.strict&&function(t){t._vm.$watch(function(){return this._data.$$state},function(){0},{deep:!0,sync:!0})}(t),i&&(n&&t._withCommit(function(){i._data.$$state=null}),c.nextTick(function(){return i.$destroy()}))}function _(t,e,n,i,o){var r=!n.length,a=t._modules.getNamespace(n);if(i.namespaced&&(t._modulesNamespaceMap[a]=i),!r&&!o){var s=g(e,n.slice(0,-1)),u=n[n.length-1];t._withCommit(function(){c.set(s,u,i.state)})}var p=i.context=function(t,e,n){var i=""===e,o={dispatch:i?t.dispatch:function(n,i,o){var r=v(n,i,o),a=r.payload,s=r.options,u=r.type;return s&&s.root||(u=e+u),t.dispatch(u,a)},commit:i?t.commit:function(n,i,o){var r=v(n,i,o),a=r.payload,s=r.options,u=r.type;s&&s.root||(u=e+u),t.commit(u,a,s)}};return Object.defineProperties(o,{getters:{get:i?function(){return t.getters}:function(){return function(t,e){var n={},i=e.length;return Object.keys(t.getters).forEach(function(o){if(o.slice(0,i)===e){var r=o.slice(i);Object.defineProperty(n,r,{get:function(){return t.getters[o]},enumerable:!0})}}),n}(t,e)}},state:{get:function(){return g(t.state,n)}}}),o}(t,a,n);i.forEachMutation(function(e,n){!function(t,e,n,i){(t._mutations[e]||(t._mutations[e]=[])).push(function(e){n.call(t,i.state,e)})}(t,a+n,e,p)}),i.forEachAction(function(e,n){var i=e.root?n:a+n,o=e.handler||e;!function(t,e,n,i){(t._actions[e]||(t._actions[e]=[])).push(function(e,o){var r,a=n.call(t,{dispatch:i.dispatch,commit:i.commit,getters:i.getters,state:i.state,rootGetters:t.getters,rootState:t.state},e,o);return(r=a)&&"function"==typeof r.then||(a=Promise.resolve(a)),t._devtoolHook?a.catch(function(e){throw t._devtoolHook.emit("vuex:error",e),e}):a})}(t,i,o,p)}),i.forEachGetter(function(e,n){!function(t,e,n,i){if(t._wrappedGetters[e])return void 0;t._wrappedGetters[e]=function(t){return n(i.state,i.getters,t.state,t.getters)}}(t,a+n,e,p)}),i.forEachChild(function(i,r){_(t,e,n.concat(r),i,o)})}function g(t,e){return e.length?e.reduce(function(t,e){return t[e]},t):t}function v(t,e,n){var i;return null!==(i=t)&&"object"==typeof i&&t.type&&(n=e,e=t,t=t.type),{type:t,payload:e,options:n}}function y(t){c&&t===c||i(c=t)}l.state.get=function(){return this._vm._data.$$state},l.state.set=function(t){0},p.prototype.commit=function(t,e,n){var i=this,o=v(t,e,n),r=o.type,a=o.payload,s=(o.options,{type:r,payload:a}),u=this._mutations[r];u&&(this._withCommit(function(){u.forEach(function(t){t(a)})}),this._subscribers.forEach(function(t){return t(s,i.state)}))},p.prototype.dispatch=function(t,e){var n=this,i=v(t,e),o=i.type,r=i.payload,a={type:o,payload:r},s=this._actions[o];if(s)return this._actionSubscribers.forEach(function(t){return t(a,n.state)}),s.length>1?Promise.all(s.map(function(t){return t(r)})):s[0](r)},p.prototype.subscribe=function(t){return f(t,this._subscribers)},p.prototype.subscribeAction=function(t){return f(t,this._actionSubscribers)},p.prototype.watch=function(t,e,n){var i=this;return this._watcherVM.$watch(function(){return t(i.state,i.getters)},e,n)},p.prototype.replaceState=function(t){var e=this;this._withCommit(function(){e._vm._data.$$state=t})},p.prototype.registerModule=function(t,e,n){void 0===n&&(n={}),"string"==typeof t&&(t=[t]),this._modules.register(t,e),_(this,this.state,t,this._modules.get(t),n.preserveState),d(this,this.state)},p.prototype.unregisterModule=function(t){var e=this;"string"==typeof t&&(t=[t]),this._modules.unregister(t),this._withCommit(function(){var n=g(e.state,t.slice(0,-1));c.delete(n,t[t.length-1])}),h(this)},p.prototype.hotUpdate=function(t){this._modules.update(t),h(this,!0)},p.prototype._withCommit=function(t){var e=this._committing;this._committing=!0,t(),this._committing=e},Object.defineProperties(p.prototype,l);var m=O(function(t,e){var n={};return k(e).forEach(function(e){var i=e.key,o=e.val;n[i]=function(){var e=this.$store.state,n=this.$store.getters;if(t){var i=T(this.$store,"mapState",t);if(!i)return;e=i.context.state,n=i.context.getters}return"function"==typeof o?o.call(this,e,n):e[o]},n[i].vuex=!0}),n}),b=O(function(t,e){var n={};return k(e).forEach(function(e){var i=e.key,o=e.val;n[i]=function(){for(var e=[],n=arguments.length;n--;)e[n]=arguments[n];var i=this.$store.commit;if(t){var r=T(this.$store,"mapMutations",t);if(!r)return;i=r.context.commit}return"function"==typeof o?o.apply(this,[i].concat(e)):i.apply(this.$store,[o].concat(e))}}),n}),S=O(function(t,e){var n={};return k(e).forEach(function(e){var i=e.key,o=e.val;o=t+o,n[i]=function(){if(!t||T(this.$store,"mapGetters",t))return this.$store.getters[o]},n[i].vuex=!0}),n}),w=O(function(t,e){var n={};return k(e).forEach(function(e){var i=e.key,o=e.val;n[i]=function(){for(var e=[],n=arguments.length;n--;)e[n]=arguments[n];var i=this.$store.dispatch;if(t){var r=T(this.$store,"mapActions",t);if(!r)return;i=r.context.dispatch}return"function"==typeof o?o.apply(this,[i].concat(e)):i.apply(this.$store,[o].concat(e))}}),n}),D=function(t){return{mapState:m.bind(null,t),mapGetters:S.bind(null,t),mapMutations:b.bind(null,t),mapActions:w.bind(null,t)}};function k(t){return Array.isArray(t)?t.map(function(t){return{key:t,val:t}}):Object.keys(t).map(function(e){return{key:e,val:t[e]}})}function O(t){return function(e,n){return"string"!=typeof e?(n=e,e=""):"/"!==e.charAt(e.length-1)&&(e+="/"),t(e,n)}}function T(t,e,n){return t._modulesNamespaceMap[n]}var x={Store:p,install:y,version:"3.0.1",mapState:m,mapMutations:b,mapGetters:S,mapActions:w,createNamespacedHelpers:D};e.default=x},451:function(t,e,n){"use strict";n.r(e);var i=n(150),o=n.n(i);for(var r in i)"default"!==r&&function(t){n.d(e,t,function(){return i[t]})}(r);e.default=o.a},558:function(t,e,n){"use strict";n.r(e);n(7),n(11);var i=n(74);i.default.mpType="page",i.default.route="pages/API/navigator/new-page/new-nvue-page-2",i.default.el="#root",new Vue(i.default)},7:function(t,e,n){"use strict";function i(t,e){return!e||"object"!=typeof e&&"function"!=typeof e?function(t){if(void 0===t)throw new ReferenceError("this hasn't been initialised - super() hasn't been called");return t}(t):e}function o(t){return(o=Object.setPrototypeOf?Object.getPrototypeOf:function(t){return t.__proto__||Object.getPrototypeOf(t)})(t)}function r(t,e){return(r=Object.setPrototypeOf||function(t,e){return t.__proto__=e,t})(t,e)}function a(t,e){if(!(t instanceof e))throw new TypeError("Cannot call a class as a function")}function s(t,e){for(var n=0;n<e.length;n++){var i=e[n];i.enumerable=i.enumerable||!1,i.configurable=!0,"value"in i&&(i.writable=!0),Object.defineProperty(t,i.key,i)}}function u(t,e,n){return e&&s(t.prototype,e),n&&s(t,n),t}var c=n(8).version,p="__DC_STAT_UUID",l="__DC_UUID_VALUE";function f(){var t="";if("n"===_()){try{t=plus.runtime.getDCloudId()}catch(e){t=""}return t}try{t=uni.getStorageSync(p)}catch(e){t=l}if(!t){t=Date.now()+""+Math.floor(1e7*Math.random());try{uni.setStorageSync(p,t)}catch(t){uni.setStorageSync(p,l)}}return t}var h,d=function(){return parseInt((new Date).getTime()/1e3)},_=function(){return"n"},g=function(){var t="";return"wx"!==_()&&"qq"!==_()||uni.canIUse("getAccountInfoSync")&&(t=uni.getAccountInfoSync().miniProgram.appId||""),t},v=function(){return"n"===_()?plus.runtime.version:""},y=function(){var t="";return"n"===_()&&(t=plus.runtime.channel),t},m=0,b=0,S=function(){return m=d(),"n"===_()&&uni.setStorageSync("__page__residence__time",d()),m},w=0,D=0,k=function(){var t=(new Date).getTime();return w=t,D=0,t},O=function(){var t=(new Date).getTime();return D=t,t},T=function(t){var e=0;return 0!==w&&(e=D-w),e=(e=parseInt(e/1e3))<1?1:e,"app"===t?{residenceTime:e,overtime:e>300}:"page"===t?{residenceTime:e,overtime:e>1800}:{residenceTime:e}},x=function(t){var e=getCurrentPages(),n=e[e.length-1].$vm,i=t._query,o=i&&"{}"!==JSON.stringify(i)?"?"+JSON.stringify(i):"";return t._query="","bd"===_()?n.$mp&&n.$mp.page.is+o:n.$scope&&n.$scope.route+o||n.$mp&&n.$mp.page.route+o},$=function(t){return!!("page"===t.mpType||t.$mp&&"page"===t.$mp.mpType||"page"===t.$options.mpType)},j=n(9).default,C=n(2).default||n(2),E=uni.getSystemInfoSync(),R=function(){function t(){a(this,t),this.self="",this._retry=0,this._platform="",this._query={},this._navigationBarTitle={config:"",page:"",report:"",lt:""},this._operatingTime=0,this._reportingRequestData={1:[],11:[]},this.__prevent_triggering=!1,this.__licationHide=!1,this.__licationShow=!1,this._lastPageRoute="",this.statData={uuid:f(),ut:_(),mpn:g(),ak:C.appid,usv:c,v:v(),ch:y(),cn:"",pn:"",ct:"",t:d(),tt:"",p:"android"===E.platform?"a":"i",brand:E.brand||"",md:E.model,sv:E.system.replace(/(Android|iOS)\s/,""),mpsdk:E.SDKVersion||"",mpv:E.version||"",lang:E.language,pr:E.pixelRatio,ww:E.windowWidth,wh:E.windowHeight,sw:E.screenWidth,sh:E.screenHeight}}return u(t,[{key:"_applicationShow",value:function(){if(this.__licationHide){if(O(),T("app").overtime){var t={path:this._lastPageRoute,scene:this.statData.sc};this._sendReportRequest(t)}this.__licationHide=!1}}},{key:"_applicationHide",value:function(t,e){this.__licationHide=!0,O();var n=T();k();var i=x(this);this._sendHideRequest({urlref:i,urlref_ts:n.residenceTime},e)}},{key:"_pageShow",value:function(){var t,e,n=x(this),i=(t=getCurrentPages(),e=t[t.length-1].$vm,"bd"===_()?e.$mp&&e.$mp.page.is:e.$scope&&e.$scope.route||e.$mp&&e.$mp.page.route);if(this._navigationBarTitle.config=j&&j.pages[i]&&j.pages[i].titleNView&&j.pages[i].titleNView.titleText||j&&j.pages[i]&&j.pages[i].navigationBarTitleText||"",this.__licationShow)return k(),this.__licationShow=!1,void(this._lastPageRoute=n);if(O(),this._lastPageRoute=n,T("page").overtime){var o={path:this._lastPageRoute,scene:this.statData.sc};this._sendReportRequest(o)}k()}},{key:"_pageHide",value:function(){if(!this.__licationHide){O();var t=T("page");return this._sendPageRequest({url:this._lastPageRoute,urlref:this._lastPageRoute,urlref_ts:t.residenceTime}),void(this._navigationBarTitle={config:"",page:"",report:"",lt:""})}}},{key:"_login",value:function(){this._sendEventRequest({key:"login"},0)}},{key:"_share",value:function(){this._sendEventRequest({key:"share"},0)}},{key:"_payment",value:function(t){this._sendEventRequest({key:t},0)}},{key:"_sendReportRequest",value:function(t){this._navigationBarTitle.lt="1";var e,n,i=t.query&&"{}"!==JSON.stringify(t.query)?"?"+JSON.stringify(t.query):"";this.statData.lt="1",this.statData.url=t.path+i||"",this.statData.t=d(),this.statData.sc=function(t){var e=_(),n="";return t||("wx"===e&&(n=uni.getLaunchOptionsSync().scene),n)}(t.scene),this.statData.fvts=(e=uni.getStorageSync("First__Visit__Time"),n=0,e?n=e:(n=d(),uni.setStorageSync("First__Visit__Time",n),uni.removeStorageSync("Last__Visit__Time")),n),this.statData.lvts=function(){var t=uni.getStorageSync("Last__Visit__Time"),e=0;return e=t||"",uni.setStorageSync("Last__Visit__Time",d()),e}(),this.statData.tvc=function(){var t=uni.getStorageSync("Total__Visit__Count"),e=1;return t&&(e=t,e++),uni.setStorageSync("Total__Visit__Count",e),e}(),"n"===_()?this.getProperty():this.getNetworkInfo()}},{key:"_sendPageRequest",value:function(t){var e=t.url,n=t.urlref,i=t.urlref_ts;this._navigationBarTitle.lt="11";var o={ak:this.statData.ak,uuid:this.statData.uuid,lt:"11",ut:this.statData.ut,url:e,tt:this.statData.tt,urlref:n,urlref_ts:i,ch:this.statData.ch,usv:this.statData.usv,t:d(),p:this.statData.p};this.request(o)}},{key:"_sendHideRequest",value:function(t,e){var n=t.urlref,i=t.urlref_ts,o={ak:this.statData.ak,uuid:this.statData.uuid,lt:"3",ut:this.statData.ut,urlref:n,urlref_ts:i,ch:this.statData.ch,usv:this.statData.usv,t:d(),p:this.statData.p};this.request(o,e)}},{key:"_sendEventRequest",value:function(){var t=arguments.length>0&&void 0!==arguments[0]?arguments[0]:{},e=t.key,n=void 0===e?"":e,i=t.value,o=void 0===i?"":i,r=this._lastPageRoute,a={ak:this.statData.ak,uuid:this.statData.uuid,lt:"21",ut:this.statData.ut,url:r,ch:this.statData.ch,e_n:n,e_v:"object"==typeof o?JSON.stringify(o):o.toString(),usv:this.statData.usv,t:d(),p:this.statData.p};this.request(a)}},{key:"getNetworkInfo",value:function(){var t=this;uni.getNetworkType({success:function(e){t.statData.net=e.networkType,t.getLocation()}})}},{key:"getProperty",value:function(){var t=this;plus.runtime.getProperty(plus.runtime.appid,function(e){t.statData.v=e.version||"",t.getNetworkInfo()})}},{key:"getLocation",value:function(){var t=this;C.getLocation?uni.getLocation({type:"wgs84",geocode:!0,success:function(e){e.address&&(t.statData.cn=e.address.country,t.statData.pn=e.address.province,t.statData.ct=e.address.city),t.statData.lat=e.latitude,t.statData.lng=e.longitude,t.request(t.statData)}}):(this.statData.lat=0,this.statData.lng=0,this.request(this.statData))}},{key:"request",value:function(t,e){var n=this,i=d(),o=this._navigationBarTitle;t.ttn=o.page,t.ttpj=o.config,t.ttc=o.report;var r=this._reportingRequestData;if("n"===_()&&(r=uni.getStorageSync("__UNI__STAT__DATA")||{}),r[t.lt]||(r[t.lt]=[]),r[t.lt].push(t),"n"===_()&&uni.setStorageSync("__UNI__STAT__DATA",r),b=d(),"n"===_()&&(m=uni.getStorageSync("__page__residence__time")),!(b-m<10)||e){var a=this._reportingRequestData;"n"===_()&&(a=uni.getStorageSync("__UNI__STAT__DATA")),S();var s=[],u=[],p=[],l=function(t){a[t].forEach(function(e){var n=function(t){var e="";for(var n in t)e+=n+"="+t[n]+"&";return e.substr(0,e.length-1)}(e);0===t?s.push(n):3===t?p.push(n):u.push(n)})};for(var f in a)l(f);s.push.apply(s,u.concat(p));var h={usv:c,t:i,requests:JSON.stringify(s)};this._reportingRequestData={},"n"===_()&&uni.removeStorageSync("__UNI__STAT__DATA"),"h5"!==t.ut?"n"!==_()||"a"!==this.statData.p?this._sendRequest(h):setTimeout(function(){n._sendRequest(h)},200):this.imageRequest(h)}}},{key:"_sendRequest",value:function(t){var e=this;uni.request({url:"https://tongji.dcloud.io/uni/stat",method:"POST",data:t,success:function(){},fail:function(n){++e._retry<3&&setTimeout(function(){e._sendRequest(t)},1e3)}})}},{key:"imageRequest",value:function(t){var e=new Image,n=function(t){var e=Object.keys(t).sort(),n={},i="";for(var o in e)n[e[o]]=t[e[o]],i+=e[o]+"="+t[e[o]]+"&";return{sign:"",options:i.substr(0,i.length-1)}}(function(t){var e={};for(var n in t)e[n]=encodeURIComponent(t[n]);return e}(t)).options;e.src="https://tongji.dcloud.io/uni/stat.gif?"+n}},{key:"sendEvent",value:function(t,e){var n,i;(i=e,(n=t)?"string"!=typeof n?(console.error("uni.report [eventName] 参数类型错误,只能为 String 类型"),1):n.length>255?(console.error("uni.report [eventName] 参数长度不能大于 255"),1):"string"!=typeof i&&"object"!=typeof i?(console.error("uni.report [options] 参数类型错误,只能为 String 或 Object 类型"),1):"string"==typeof i&&i.length>255?(console.error("uni.report [options] 参数长度不能大于 255"),1):"title"===n&&"string"!=typeof i?(console.error("uni.report [eventName] 参数为 title 时，[options] 参数只能为 String 类型"),1):void 0:(console.error("uni.report 缺少 [eventName] 参数"),1))||("title"!==t?this._sendEventRequest({key:t,value:"object"==typeof e?JSON.stringify(e):e},1):this._navigationBarTitle.report=e)}}]),t}(),q=function(t){function e(){var t;return a(this,e),(t=i(this,o(e).call(this))).instance=null,"function"==typeof uni.addInterceptor&&(t.addInterceptorInit(),t.interceptLogin(),t.interceptShare(!0),t.interceptRequestPayment()),t}return function(t,e){if("function"!=typeof e&&null!==e)throw new TypeError("Super expression must either be null or a function");t.prototype=Object.create(e&&e.prototype,{constructor:{value:t,writable:!0,configurable:!0}}),e&&r(t,e)}(e,R),u(e,null,[{key:"getInstance",value:function(){return this.instance||(this.instance=new e),this.instance}}]),u(e,[{key:"addInterceptorInit",value:function(){var t=this;uni.addInterceptor("setNavigationBarTitle",{invoke:function(e){t._navigationBarTitle.page=e.title}})}},{key:"interceptLogin",value:function(){var t=this;uni.addInterceptor("login",{complete:function(){t._login()}})}},{key:"interceptShare",value:function(t){var e=this;t?uni.addInterceptor("share",{success:function(){e._share()},fail:function(){e._share()}}):e._share()}},{key:"interceptRequestPayment",value:function(){var t=this;uni.addInterceptor("requestPayment",{success:function(){t._payment("pay_success")},fail:function(){t._payment("pay_fail")}})}},{key:"report",value:function(t,e){this.self=e,S(),this.__licationShow=!0,this._sendReportRequest(t,!0)}},{key:"load",value:function(t,e){if(!e.$scope&&!e.$mp){var n=getCurrentPages();e.$scope=n[n.length-1]}this.self=e,this._query=t}},{key:"show",value:function(t){this.self=t,$(t)?this._pageShow(t):this._applicationShow(t)}},{key:"ready",value:function(t){}},{key:"hide",value:function(t){this.self=t,$(t)?this._pageHide(t):this._applicationHide(t,!0)}},{key:"error",value:function(t){this._platform;var e="";e=t.message?t.stack:JSON.stringify(t);var n={ak:this.statData.ak,uuid:this.statData.uuid,lt:"31",ut:this.statData.ut,ch:this.statData.ch,mpsdk:this.statData.mpsdk,mpv:this.statData.mpv,v:this.statData.v,em:e,usv:this.statData.usv,t:d(),p:this.statData.p};this.request(n)}}]),e}().getInstance(),P=!1,I={onLaunch:function(t){q.report(t,this)},onReady:function(){q.ready(this)},onLoad:function(t){if(q.load(t,this),this.$scope&&this.$scope.onShareAppMessage){var e=this.$scope.onShareAppMessage;this.$scope.onShareAppMessage=function(t){return q.interceptShare(!1),e.call(this,t)}}},onShow:function(){P=!1,q.show(this)},onHide:function(){P=!0,q.hide(this)},onUnload:function(){P?P=!1:q.hide(this)},onError:function(t){q.error(t)}};((h=n(10)).default||h).mixin(I),uni.report=function(t,e){q.sendEvent(t,e)}},74:function(t,e,n){"use strict";var i=n(377),o=n(148),r=n(0);var a=Object(r.a)(o.default,i.b,i.c,!1,null,null,"2447a4f4",!1,i.a,void 0);(function(t){this.options.style||(this.options.style={}),Vue.prototype.__merge_style&&Vue.prototype.__$appStyle__&&Vue.prototype.__merge_style(Vue.prototype.__$appStyle__,this.options.style),Vue.prototype.__merge_style?Vue.prototype.__merge_style(n(451).default,this.options.style):Object.assign(this.options.style,n(451).default)}).call(a),e.default=a.exports},8:function(t){t.exports={_from:"@dcloudio/uni-stat@alpha",_id:"@dcloudio/uni-stat@2.0.0-alpha-25620200113001",_inBundle:!1,_integrity:"sha512-B+6wnrhG4pSZDJUYdDxHuQK1Z+K24eLmEgpEBMMxg0siZzixWSt0sHWVgAbcsD+lAGWnVtAdSgz9xUHIaS9KCQ==",_location:"/@dcloudio/uni-stat",_phantomChildren:{},_requested:{type:"tag",registry:!0,raw:"@dcloudio/uni-stat@alpha",name:"@dcloudio/uni-stat",escapedName:"@dcloudio%2funi-stat",scope:"@dcloudio",rawSpec:"alpha",saveSpec:null,fetchSpec:"alpha"},_requiredBy:["#USER","/","/@dcloudio/vue-cli-plugin-uni"],_resolved:"https://registry.npmjs.org/@dcloudio/uni-stat/-/uni-stat-2.0.0-alpha-25620200113001.tgz",_shasum:"4ab5fa11e38643b12eb0e674f4136bb37b99be54",_spec:"@dcloudio/uni-stat@alpha",_where:"/Users/guoshengqiang/Documents/dcloud-plugins/alpha/uniapp-cli",author:"",bugs:{url:"https://github.com/dcloudio/uni-app/issues"},bundleDependencies:!1,deprecated:!1,description:"",devDependencies:{"@babel/core":"^7.5.5","@babel/preset-env":"^7.5.5",eslint:"^6.1.0",rollup:"^1.19.3","rollup-plugin-babel":"^4.3.3","rollup-plugin-clear":"^2.0.7","rollup-plugin-commonjs":"^10.0.2","rollup-plugin-copy":"^3.1.0","rollup-plugin-eslint":"^7.0.0","rollup-plugin-json":"^4.0.0","rollup-plugin-node-resolve":"^5.2.0","rollup-plugin-replace":"^2.2.0","rollup-plugin-uglify":"^6.0.2"},files:["dist","package.json","LICENSE"],gitHead:"67558a1dca8b1f3681c6b7d21be53720870a1a82",homepage:"https://github.com/dcloudio/uni-app#readme",license:"Apache-2.0",main:"dist/index.js",name:"@dcloudio/uni-stat",repository:{type:"git",url:"git+https://github.com/dcloudio/uni-app.git",directory:"packages/uni-stat"},scripts:{build:"NODE_ENV=production rollup -c rollup.config.js",dev:"NODE_ENV=development rollup -w -c rollup.config.js"},version:"2.0.0-alpha-25620200113001"}},9:function(t,e,n){"use strict";n.r(e),e.default={pages:{},globalStyle:{}}}});