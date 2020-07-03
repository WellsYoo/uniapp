
var isReady=false;var onReadyCallbacks=[];
var isServiceReady=false;var onServiceReadyCallbacks=[];
var __uniConfig = {"pages":["pages/index/index","pages/index/shops","pages/index/search","pages/index/pinpailist","pages/index/detail","pages/index/buydetail","pages/index/buylist","pages/index/issue","pages/chat/index","pages/chat/chat","pages/chat/pinglunlist","pages/chat/zanlist","pages/chat/xtchat","pages/user/center","pages/user/about","pages/user/advice","pages/user/issue","pages/user/like","pages/user/pinglunlist","pages/user/fans","pages/user/shoucang","pages/user/zanlist","pages/user/viewlog","pages/user/set","pages/user/helpdetail","pages/user/helplist","pages/user/quanyi","pages/passport/rules","pages/user/edit","pages/passport/login"],"window":{"navigationBarTextStyle":"black","navigationBarTitleText":"淘货","navigationBarBackgroundColor":"#F3F1F2","backgroundColor":"#F3F1F2"},"tabBar":{"custom":true,"color":"#D8D8D8","selectedColor":"#FF533B","borderStyle":"black","backgroundColor":"#ffffff","list":[{"pagePath":"pages/index/index","iconPath":"image/index.png","selectedIconPath":"image/index.png","text":"淘货"},{"pagePath":"pages/index/buylist","iconPath":"image/index.png","selectedIconPath":"image/index.png","text":"求购"},{"pagePath":"pages/index/issue","iconPath":"image/index.png","selectedIconPath":"image/index.png","text":"最新揭晓"},{"pagePath":"pages/chat/index","iconPath":"image/index.png","selectedIconPath":"image/index.png","text":"消息"},{"pagePath":"pages/user/center","iconPath":"image/index.png","selectedIconPath":"image/index.png","text":"我的"}]},"nvueCompiler":"uni-app","renderer":"auto","splashscreen":{"alwaysShowBeforeRender":true,"autoclose":false},"appname":"淘货","compilerVersion":"2.7.14","entryPagePath":"pages/index/index","networkTimeout":{"request":60000,"connectSocket":60000,"uploadFile":60000,"downloadFile":60000}};
var __uniRoutes = [{"path":"/pages/index/index","meta":{"isQuit":true,"isTabBar":true},"window":{"navigationStyle":"custom","enablePullDownRefresh":true,"onReachBottomDistance":200,"pullToRefresh":{"support":true,"style":"circle","color":"#f00"}}},{"path":"/pages/index/shops","meta":{},"window":{"navigationStyle":"custom"}},{"path":"/pages/index/search","meta":{},"window":{"navigationStyle":"custom"}},{"path":"/pages/index/pinpailist","meta":{},"window":{"navigationBarTitleText":"详情"}},{"path":"/pages/index/detail","meta":{},"window":{"navigationBarTitleText":"详情"}},{"path":"/pages/index/buydetail","meta":{},"window":{"navigationBarTitleText":"详情"}},{"path":"/pages/index/buylist","meta":{"isQuit":true,"isTabBar":true},"window":{"navigationStyle":"custom","enablePullDownRefresh":true,"pullToRefresh":{"support":true,"style":"circle","color":"#f00"},"scrollIndicator":"none"}},{"path":"/pages/index/issue","meta":{"isQuit":true,"isTabBar":true},"window":{"navigationStyle":"custom"}},{"path":"/pages/chat/index","meta":{"isQuit":true,"isTabBar":true},"window":{"navigationStyle":"custom"}},{"path":"/pages/chat/chat","meta":{},"window":{"navigationBarTitleText":""}},{"path":"/pages/chat/pinglunlist","meta":{},"window":{"navigationBarTitleText":"收到的评论"}},{"path":"/pages/chat/zanlist","meta":{},"window":{"navigationBarTitleText":"收到的点赞"}},{"path":"/pages/chat/xtchat","meta":{},"window":{"navigationBarTitleText":"系统消息"}},{"path":"/pages/user/center","meta":{"isQuit":true,"isTabBar":true},"window":{"navigationStyle":"custom","enablePullDownRefresh":true,"pullToRefresh":{"support":true,"style":"circle","color":"#f00"},"scrollIndicator":"none"}},{"path":"/pages/user/about","meta":{},"window":{"navigationStyle":"custom"}},{"path":"/pages/user/advice","meta":{},"window":{"navigationBarTitleText":"意见反馈"}},{"path":"/pages/user/issue","meta":{},"window":{"navigationBarTitleText":"我发布的"}},{"path":"/pages/user/like","meta":{},"window":{"navigationBarTitleText":"我关注的"}},{"path":"/pages/user/pinglunlist","meta":{},"window":{"navigationBarTitleText":"我的评论"}},{"path":"/pages/user/fans","meta":{},"window":{"navigationBarTitleText":"我的粉丝"}},{"path":"/pages/user/shoucang","meta":{},"window":{"navigationBarTitleText":"我收藏的"}},{"path":"/pages/user/zanlist","meta":{},"window":{"navigationBarTitleText":"我的点赞"}},{"path":"/pages/user/viewlog","meta":{},"window":{"navigationBarTitleText":"浏览历史"}},{"path":"/pages/user/set","meta":{},"window":{"navigationBarTitleText":"设置"}},{"path":"/pages/user/helpdetail","meta":{},"window":{"navigationBarTitleText":"帮助详情"}},{"path":"/pages/user/helplist","meta":{},"window":{"navigationBarTitleText":"使用帮助"}},{"path":"/pages/user/quanyi","meta":{},"window":{"navigationBarTitleText":"平台权益"}},{"path":"/pages/passport/rules","meta":{},"window":{"navigationBarTitleText":"隐私政策"}},{"path":"/pages/user/edit","meta":{},"window":{"navigationBarTitleText":"编辑"}},{"path":"/pages/passport/login","meta":{},"window":{"navigationStyle":"custom"}}];
__uniConfig.onReady=function(callback){if(__uniConfig.ready){callback()}else{onReadyCallbacks.push(callback)}};Object.defineProperty(__uniConfig,"ready",{get:function(){return isReady},set:function(val){isReady=val;if(!isReady){return}const callbacks=onReadyCallbacks.slice(0);onReadyCallbacks.length=0;callbacks.forEach(function(callback){callback()})}});
__uniConfig.onServiceReady=function(callback){if(__uniConfig.serviceReady){callback()}else{onServiceReadyCallbacks.push(callback)}};Object.defineProperty(__uniConfig,"serviceReady",{get:function(){return isServiceReady},set:function(val){isServiceReady=val;if(!isServiceReady){return}const callbacks=onServiceReadyCallbacks.slice(0);onServiceReadyCallbacks.length=0;callbacks.forEach(function(callback){callback()})}});
service.register("uni-app-config",{create(a,b,c){if(!__uniConfig.viewport){var d=b.weex.config.env.scale,e=b.weex.config.env.deviceWidth,f=Math.ceil(e/d);Object.assign(__uniConfig,{viewport:f,defaultFontSize:Math.round(f/20)})}return{instance:{__uniConfig:__uniConfig,__uniRoutes:__uniRoutes,global:void 0,window:void 0,document:void 0,frames:void 0,self:void 0,location:void 0,navigator:void 0,localStorage:void 0,history:void 0,Caches:void 0,screen:void 0,alert:void 0,confirm:void 0,prompt:void 0,fetch:void 0,XMLHttpRequest:void 0,WebSocket:void 0,webkit:void 0,print:void 0}}}});
