
var isReady=false;var onReadyCallbacks=[];
var isServiceReady=false;var onServiceReadyCallbacks=[];
var __uniConfig = {"pages":["pages/index/index","pages/index/sign","pages/index/nonet","pages/index/perinfo","pages/index/poster","pages/index/posteruser","pages/index/ad","pages/user/about","pages/user/tixian","pages/user/zijinlist","pages/user/bank","pages/user/redcard","pages/user/rules","pages/user/timelist","pages/user/timeedit","pages/user/edit","pages/user/advice","pages/user/shouyi","pages/user/invite","pages/user/invitelist","pages/user/balance","pages/user/pay","pages/user/help","pages/user/helpdetail","pages/service/creat","pages/service/area","pages/service/map","pages/service/service","pages/service/edit","pages/renzheng/health","pages/renzheng/suc","pages/renzheng/zizhi","pages/renzheng/idcard","pages/order/index","pages/order/detail","pages/time/index","pages/time/edit","pages/user/index","pages/passport/login","pages/passport/password","pages/passport/pay","pages/passport/register"],"window":{"navigationBarTextStyle":"black","navigationBarTitleText":"大象按摩计师端","navigationBarBackgroundColor":"#FFFFFF","backgroundColor":"#F0EFF5"},"tabBar":{"custom":true,"color":"#383838","selectedColor":"#DA2A1C","borderStyle":"black","backgroundColor":"#ffffff","fontSize":"13px","list":[{"pagePath":"pages/index/index","iconPath":"/static/images/tab_index.png","selectedIconPath":"/static/images/tab_index.png","text":"一键接单"},{"pagePath":"pages/time/index","iconPath":"/static/images/tab_index.png","selectedIconPath":"/static/images/tab_index.png","text":"浏览任务"},{"pagePath":"pages/order/index","iconPath":"/static/images/tab_index.png","selectedIconPath":"/static/images/tab_index.png","text":"我的任务"},{"pagePath":"pages/user/index","iconPath":"/static/images/tab_index.png","selectedIconPath":"/static/images/tab_index.png","text":"我的"}]},"nvueCompiler":"uni-app","nvueStyleCompiler":"uni-app","renderer":"auto","splashscreen":{"alwaysShowBeforeRender":true,"autoclose":false},"appname":"大象按摩技师端","compilerVersion":"3.1.18","entryPagePath":"pages/index/index","networkTimeout":{"request":60000,"connectSocket":60000,"uploadFile":60000,"downloadFile":60000}};
var __uniRoutes = [{"path":"/pages/index/index","meta":{"isQuit":true,"isTabBar":true},"window":{"navigationStyle":"custom"}},{"path":"/pages/index/sign","meta":{},"window":{"navigationStyle":"custom"}},{"path":"/pages/index/nonet","meta":{},"window":{"navigationStyle":"custom"}},{"path":"/pages/index/perinfo","meta":{},"window":{"navigationStyle":"custom"}},{"path":"/pages/index/poster","meta":{},"window":{"navigationStyle":"custom"}},{"path":"/pages/index/posteruser","meta":{},"window":{"navigationStyle":"custom"}},{"path":"/pages/index/ad","meta":{},"window":{"navigationStyle":"custom"}},{"path":"/pages/user/about","meta":{},"window":{"navigationStyle":"custom"}},{"path":"/pages/user/tixian","meta":{},"window":{"navigationStyle":"custom"}},{"path":"/pages/user/zijinlist","meta":{},"window":{"navigationStyle":"custom"}},{"path":"/pages/user/bank","meta":{},"window":{"navigationStyle":"custom"}},{"path":"/pages/user/redcard","meta":{},"window":{"navigationStyle":"custom"}},{"path":"/pages/user/rules","meta":{},"window":{}},{"path":"/pages/user/timelist","meta":{},"window":{"navigationStyle":"custom"}},{"path":"/pages/user/timeedit","meta":{},"window":{"navigationStyle":"custom"}},{"path":"/pages/user/edit","meta":{},"window":{"navigationStyle":"custom"}},{"path":"/pages/user/advice","meta":{},"window":{"navigationStyle":"custom"}},{"path":"/pages/user/shouyi","meta":{},"window":{"navigationStyle":"custom"}},{"path":"/pages/user/invite","meta":{},"window":{"navigationStyle":"custom"}},{"path":"/pages/user/invitelist","meta":{},"window":{"navigationStyle":"custom"}},{"path":"/pages/user/balance","meta":{},"window":{"navigationStyle":"custom"}},{"path":"/pages/user/pay","meta":{},"window":{"navigationStyle":"custom"}},{"path":"/pages/user/help","meta":{},"window":{"navigationStyle":"custom"}},{"path":"/pages/user/helpdetail","meta":{},"window":{"navigationStyle":"custom"}},{"path":"/pages/service/creat","meta":{},"window":{"navigationStyle":"custom"}},{"path":"/pages/service/area","meta":{},"window":{"navigationStyle":"custom"}},{"path":"/pages/service/map","meta":{},"window":{"navigationStyle":"custom"}},{"path":"/pages/service/service","meta":{},"window":{"navigationStyle":"custom"}},{"path":"/pages/service/edit","meta":{},"window":{"navigationStyle":"custom"}},{"path":"/pages/renzheng/health","meta":{},"window":{"navigationStyle":"custom"}},{"path":"/pages/renzheng/suc","meta":{},"window":{"navigationStyle":"custom"}},{"path":"/pages/renzheng/zizhi","meta":{},"window":{"navigationStyle":"custom"}},{"path":"/pages/renzheng/idcard","meta":{},"window":{"navigationStyle":"custom"}},{"path":"/pages/order/index","meta":{"isQuit":true,"isTabBar":true},"window":{"navigationStyle":"custom"}},{"path":"/pages/order/detail","meta":{},"window":{"navigationStyle":"custom"}},{"path":"/pages/time/index","meta":{"isQuit":true,"isTabBar":true},"window":{"navigationStyle":"custom"}},{"path":"/pages/time/edit","meta":{},"window":{"navigationStyle":"custom"}},{"path":"/pages/user/index","meta":{"isQuit":true,"isTabBar":true},"window":{"navigationStyle":"custom"}},{"path":"/pages/passport/login","meta":{},"window":{"navigationStyle":"custom"}},{"path":"/pages/passport/password","meta":{},"window":{"navigationStyle":"custom"}},{"path":"/pages/passport/pay","meta":{},"window":{"navigationBarTitleText":"支付密码"}},{"path":"/pages/passport/register","meta":{},"window":{"navigationStyle":"custom"}}];
__uniConfig.onReady=function(callback){if(__uniConfig.ready){callback()}else{onReadyCallbacks.push(callback)}};Object.defineProperty(__uniConfig,"ready",{get:function(){return isReady},set:function(val){isReady=val;if(!isReady){return}const callbacks=onReadyCallbacks.slice(0);onReadyCallbacks.length=0;callbacks.forEach(function(callback){callback()})}});
__uniConfig.onServiceReady=function(callback){if(__uniConfig.serviceReady){callback()}else{onServiceReadyCallbacks.push(callback)}};Object.defineProperty(__uniConfig,"serviceReady",{get:function(){return isServiceReady},set:function(val){isServiceReady=val;if(!isServiceReady){return}const callbacks=onServiceReadyCallbacks.slice(0);onServiceReadyCallbacks.length=0;callbacks.forEach(function(callback){callback()})}});
service.register("uni-app-config",{create(a,b,c){if(!__uniConfig.viewport){var d=b.weex.config.env.scale,e=b.weex.config.env.deviceWidth,f=Math.ceil(e/d);Object.assign(__uniConfig,{viewport:f,defaultFontSize:Math.round(f/20)})}return{instance:{__uniConfig:__uniConfig,__uniRoutes:__uniRoutes,global:void 0,window:void 0,document:void 0,frames:void 0,self:void 0,location:void 0,navigator:void 0,localStorage:void 0,history:void 0,Caches:void 0,screen:void 0,alert:void 0,confirm:void 0,prompt:void 0,fetch:void 0,XMLHttpRequest:void 0,WebSocket:void 0,webkit:void 0,print:void 0}}}});
