
var isReady=false;var onReadyCallbacks=[];
var isServiceReady=false;var onServiceReadyCallbacks=[];
var __uniConfig = {"pages":["pages/index/start","pages/task/get","pages/index/index","pages/user/index","pages/task/liuliang","pages/user/credit","pages/task/index","pages/task/goodpj","pages/user/gzh","pages/task/bindindex","pages/task/taskdetail","pages/task/taskdetailliuliang","pages/task/taskpro","pages/task/taskproshow","pages/task/orderpay","pages/task/orderliuliang","pages/task/bind","pages/money/index","pages/money/recharge","pages/money/rechargelog","pages/money/tixianlog","pages/money/yijialog","pages/money/invitemoneylog","pages/money/timelog","pages/money/rolelog","pages/money/change","pages/money/tixian","pages/money/zijinlog","pages/money/tasklog","pages/user/agreement","pages/user/edit","pages/user/invite","pages/user/invitelist","pages/user/invitedetail","pages/user/inviteindex","pages/index/punish","pages/index/xtchat","pages/index/chatcate","pages/user/shangbao","pages/user/kefu","pages/user/helpcate","pages/user/helpdetail","pages/user/helplist","pages/user/adlist","pages/user/addetail","pages/user/applyindex","pages/user/apply","pages/user/applydetail","pages/user/buyerlist","pages/user/set","pages/user/applyshoudao","pages/user/pingjia","pages/renzheng/index","pages/renzheng/idcard","pages/renzheng/bank","pages/renzheng/phone","pages/passport/rules","pages/passport/pay","pages/passport/password","pages/passport/phone","pages/passport/down","pages/passport/login","pages/index/home","uni_modules/uni-upgrade-center-app/pages/upgrade-popup","shops/pages/shops/index","shops/pages/index/area","shops/pages/activity/limitedtime","shops/pages/activity/assemble","shops/pages/activity/fullreduction","shops/pages/activity/orderbuy","shops/pages/shops/detail","shops/pages/shops/shops","shops/pages/shops/search","shops/pages/shops/couponlist","shops/pages/shops/shopsinfo","shops/pages/shops/tuijian","shops/pages/shops/cate","shops/pages/chat/chat","shops/pages/chat/index","shops/pages/shops/onceorderbuy","shops/pages/shops/orderbuy","shops/pages/shops/orderdetail","shops/pages/shops/paytype","shops/pages/shops/paysuc","shops/pages/index/index","shops/pages/user/address","shops/pages/user/addaddress","shops/pages/user/coupon","shops/pages/user/drawback","shops/pages/user/drawbacklist","shops/pages/user/edit","shops/pages/user/fenxiaolist","shops/pages/user/moneylist","shops/pages/user/buy","shops/pages/user/buylog","shops/pages/user/like","shops/pages/map/index","shops/pages/user/advice","shops/pages/passport/pay","shops/pages/passport/login","shops/pages/cart/index","shops/pages/user/joinshops","shops/pages/user/order","shops/pages/user/helplist","shops/pages/user/pjlist","shops/pages/user/pingjia","shops/pages/user/pingjiadetail","shops/pages/user/index","shops/pages/user/shops/index","shops/pages/user/shops/vip","shops/pages/user/shops/goods","shops/pages/user/shops/order","shops/pages/user/shops/edit","shops/pages/user/shops/pjlist","shops/pages/user/shops/limitedtime","shops/pages/user/shops/fullreduction","shops/pages/user/shops/assemble","shops/pages/user/shops/couponlist","shops/pages/user/shops/creatactivity"],"window":{"navigationBarTextStyle":"black","navigationBarTitleText":"","navigationBarBackgroundColor":"#FFFFFF","backgroundColor":"#F0EFF5"},"tabBar":{"color":"#383838","selectedColor":"#DA2A1C","borderStyle":"black","backgroundColor":"#ffffff","fontSize":"13px","list":[{"pagePath":"pages/task/get","iconPath":"/static/tab_gettask.png","selectedIconPath":"/static/tab_gettask_on.png","text":"一键接单"},{"pagePath":"pages/task/liuliang","iconPath":"/static/tab_liuliang.png","selectedIconPath":"/static/tab_liuliang_on.png","text":"浏览任务"},{"pagePath":"pages/task/index","iconPath":"/static/tab_task.png","selectedIconPath":"/static/tab_task_on.png","text":"我的任务"},{"pagePath":"pages/user/index","iconPath":"/static/tab_user.png","selectedIconPath":"/static/tab_user_on.png","text":"我的"}]},"nvueCompiler":"uni-app","nvueStyleCompiler":"weex","renderer":"auto","splashscreen":{"alwaysShowBeforeRender":true,"autoclose":false},"appname":"吃瓜君","compilerVersion":"3.1.18","entryPagePath":"pages/index/start","networkTimeout":{"request":60000,"connectSocket":60000,"uploadFile":60000,"downloadFile":60000}};
var __uniRoutes = [{"path":"/pages/index/start","meta":{"isQuit":true},"window":{"navigationStyle":"custom","bottom":"0","contentAdjust":"false","bounce":"none","safearea":{"bottom":"none"}}},{"path":"/pages/task/get","meta":{"isQuit":true,"isTabBar":true},"window":{"navigationBarTitleText":"一键接单","backgroundColor":"#fff","enablePullDownRefresh":true,"onReachBottomDistance":200,"pullToRefresh":{"support":true,"style":"circle","color":"#DA2B1D"}}},{"path":"/pages/index/index","meta":{},"window":{"navigationStyle":"custom","enablePullDownRefresh":true,"onReachBottomDistance":200,"pullToRefresh":{"support":true,"style":"circle","color":"#DA2B1D"}}},{"path":"/pages/user/index","meta":{"isQuit":true,"isTabBar":true},"window":{"navigationStyle":"custom","enablePullDownRefresh":true,"onReachBottomDistance":200,"pullToRefresh":{"support":true,"style":"circle","color":"#DA2B1D"}}},{"path":"/pages/task/liuliang","meta":{"isQuit":true,"isTabBar":true},"window":{"navigationStyle":"custom","enablePullDownRefresh":true,"onReachBottomDistance":200,"pullToRefresh":{"support":true,"style":"circle","color":"#DA2B1D"}}},{"path":"/pages/user/credit","meta":{},"window":{"navigationStyle":"custom"}},{"path":"/pages/task/index","meta":{"isQuit":true,"isTabBar":true},"window":{"navigationStyle":"custom"}},{"path":"/pages/task/goodpj","meta":{},"window":{"navigationBarTitleText":"签收好评"}},{"path":"/pages/user/gzh","meta":{},"window":{"navigationBarTitleText":"关注公众号"}},{"path":"/pages/task/bindindex","meta":{},"window":{"navigationBarTitleText":"选择电商平台"}},{"path":"/pages/task/taskdetail","meta":{},"window":{"navigationBarTitleText":"任务详情"}},{"path":"/pages/task/taskdetailliuliang","meta":{},"window":{"navigationBarTitleText":"浏览任务详情"}},{"path":"/pages/task/taskpro","meta":{},"window":{"navigationBarTitleText":"任务流程"}},{"path":"/pages/task/taskproshow","meta":{},"window":{"navigationBarTitleText":"任务流程"}},{"path":"/pages/task/orderpay","meta":{},"window":{"navigationBarTitleText":"我的垫付任务"}},{"path":"/pages/task/orderliuliang","meta":{},"window":{"navigationBarTitleText":"我的浏览任务"}},{"path":"/pages/task/bind","meta":{},"window":{"navigationBarTitleText":"绑定账号"}},{"path":"/pages/money/index","meta":{},"window":{"navigationBarTitleText":"财务中心"}},{"path":"/pages/money/recharge","meta":{},"window":{"navigationBarTitleText":"账户充值"}},{"path":"/pages/money/rechargelog","meta":{},"window":{"navigationBarTitleText":"充值记录"}},{"path":"/pages/money/tixianlog","meta":{},"window":{"navigationBarTitleText":"提现明细"}},{"path":"/pages/money/yijialog","meta":{},"window":{"navigationBarTitleText":"任务溢价明细"}},{"path":"/pages/money/invitemoneylog","meta":{},"window":{"navigationBarTitleText":"佣金明细"}},{"path":"/pages/money/timelog","meta":{},"window":{"navigationBarTitleText":"有效期明细"}},{"path":"/pages/money/rolelog","meta":{},"window":{"navigationBarTitleText":"积分明细"}},{"path":"/pages/money/change","meta":{},"window":{"navigationBarTitleText":"兑换资金"}},{"path":"/pages/money/tixian","meta":{},"window":{"navigationBarTitleText":"余额提现"}},{"path":"/pages/money/zijinlog","meta":{},"window":{"navigationBarTitleText":"资金明细"}},{"path":"/pages/money/tasklog","meta":{},"window":{"navigationBarTitleText":"任务佣金明细"}},{"path":"/pages/user/agreement","meta":{},"window":{"navigationBarTitleText":"协议"}},{"path":"/pages/user/edit","meta":{},"window":{"navigationBarTitleText":"修改个人信息"}},{"path":"/pages/user/invite","meta":{},"window":{"navigationBarTitleText":"轻松赚钱"}},{"path":"/pages/user/invitelist","meta":{},"window":{"navigationBarTitleText":"推广明细"}},{"path":"/pages/user/invitedetail","meta":{},"window":{"navigationBarTitleText":"用户资料"}},{"path":"/pages/user/inviteindex","meta":{},"window":{"navigationBarTitleText":"我推广的用户"}},{"path":"/pages/index/punish","meta":{},"window":{"navigationBarTitleText":"处罚列表"}},{"path":"/pages/index/xtchat","meta":{},"window":{"navigationBarTitleText":"系统消息"}},{"path":"/pages/index/chatcate","meta":{},"window":{"navigationBarTitleText":"站内信"}},{"path":"/pages/user/shangbao","meta":{},"window":{"navigationBarTitleText":"商保服务"}},{"path":"/pages/user/kefu","meta":{},"window":{"navigationBarTitleText":"联系客服"}},{"path":"/pages/user/helpcate","meta":{},"window":{"navigationBarTitleText":"帮助分类"}},{"path":"/pages/user/helpdetail","meta":{},"window":{"navigationBarTitleText":"帮助详情"}},{"path":"/pages/user/helplist","meta":{},"window":{"navigationBarTitleText":"使用帮助"}},{"path":"/pages/user/adlist","meta":{},"window":{"navigationBarTitleText":"公告列表"}},{"path":"/pages/user/addetail","meta":{},"window":{"navigationBarTitleText":"公告内容"}},{"path":"/pages/user/applyindex","meta":{},"window":{"navigationBarTitleText":"申诉服务"}},{"path":"/pages/user/apply","meta":{},"window":{"navigationBarTitleText":"填写申诉表单"}},{"path":"/pages/user/applydetail","meta":{},"window":{"navigationBarTitleText":"申诉详情"}},{"path":"/pages/user/buyerlist","meta":{},"window":{"navigationBarTitleText":"买号列表"}},{"path":"/pages/user/set","meta":{},"window":{"navigationBarTitleText":"账号安全"}},{"path":"/pages/user/applyshoudao","meta":{},"window":{"navigationBarTitleText":"我收到的申诉"}},{"path":"/pages/user/pingjia","meta":{},"window":{"navigationBarTitleText":"对本次交易做个评价呗"}},{"path":"/pages/renzheng/index","meta":{},"window":{"navigationBarTitleText":"认证中心"}},{"path":"/pages/renzheng/idcard","meta":{},"window":{"navigationBarTitleText":"实名认证"}},{"path":"/pages/renzheng/bank","meta":{},"window":{"navigationBarTitleText":"银行认证"}},{"path":"/pages/renzheng/phone","meta":{},"window":{"navigationBarTitleText":"手机认证"}},{"path":"/pages/passport/rules","meta":{},"window":{"navigationBarTitleText":"隐私政策"}},{"path":"/pages/passport/pay","meta":{},"window":{"navigationBarTitleText":"修改支付密码"}},{"path":"/pages/passport/password","meta":{},"window":{"navigationBarTitleText":"修改登录密码"}},{"path":"/pages/passport/phone","meta":{},"window":{"navigationBarTitleText":"修改手机号"}},{"path":"/pages/passport/down","meta":{},"window":{"navigationStyle":"custom"}},{"path":"/pages/passport/login","meta":{},"window":{"navigationStyle":"custom"}},{"path":"/pages/index/home","meta":{},"window":{"navigationStyle":"custom"}},{"path":"/uni_modules/uni-upgrade-center-app/pages/upgrade-popup","meta":{},"window":{"disableScroll":true,"backgroundColorTop":"transparent","background":"transparent","titleNView":false,"scrollIndicator":false,"popGesture":"none","animationType":"fade-in","animationDuration":200}},{"path":"/shops/pages/shops/index","meta":{},"window":{"navigationStyle":"custom","enablePullDownRefresh":true,"backgroundTextStyle":"dark"}},{"path":"/shops/pages/index/area","meta":{},"window":{"navigationBarTitleText":"选择城市"}},{"path":"/shops/pages/activity/limitedtime","meta":{},"window":{"navigationBarTitleText":"秒杀活动"}},{"path":"/shops/pages/activity/assemble","meta":{},"window":{"navigationBarTitleText":"团购活动"}},{"path":"/shops/pages/activity/fullreduction","meta":{},"window":{"navigationBarTitleText":"满减活动"}},{"path":"/shops/pages/activity/orderbuy","meta":{},"window":{"navigationBarTitleText":"下单详情"}},{"path":"/shops/pages/shops/detail","meta":{},"window":{"navigationStyle":"custom"}},{"path":"/shops/pages/shops/shops","meta":{},"window":{"navigationStyle":"custom"}},{"path":"/shops/pages/shops/search","meta":{},"window":{"navigationStyle":"custom"}},{"path":"/shops/pages/shops/couponlist","meta":{},"window":{"navigationBarTitleText":"优惠券"}},{"path":"/shops/pages/shops/shopsinfo","meta":{},"window":{"navigationStyle":"custom"}},{"path":"/shops/pages/shops/tuijian","meta":{},"window":{"navigationStyle":"custom"}},{"path":"/shops/pages/shops/cate","meta":{},"window":{"navigationStyle":"custom"}},{"path":"/shops/pages/chat/chat","meta":{},"window":{"navigationBarTitleText":"小此项"}},{"path":"/shops/pages/chat/index","meta":{},"window":{"navigationBarTitleText":"消息"}},{"path":"/shops/pages/shops/onceorderbuy","meta":{},"window":{"navigationBarTitleText":"确认订单"}},{"path":"/shops/pages/shops/orderbuy","meta":{},"window":{"navigationBarTitleText":"确认订单"}},{"path":"/shops/pages/shops/orderdetail","meta":{},"window":{"navigationBarTitleText":"订单详情"}},{"path":"/shops/pages/shops/paytype","meta":{},"window":{"navigationBarTitleText":"收银台"}},{"path":"/shops/pages/shops/paysuc","meta":{},"window":{"navigationBarTitleText":"收银台"}},{"path":"/shops/pages/index/index","meta":{},"window":{}},{"path":"/shops/pages/user/address","meta":{},"window":{"navigationBarTitleText":"地址管理"}},{"path":"/shops/pages/user/addaddress","meta":{},"window":{"navigationBarTitleText":"添加地址"}},{"path":"/shops/pages/user/coupon","meta":{},"window":{"navigationBarTitleText":"优惠券"}},{"path":"/shops/pages/user/drawback","meta":{},"window":{"navigationBarTitleText":"申请退货/退款"}},{"path":"/shops/pages/user/drawbacklist","meta":{},"window":{"navigationBarTitleText":"退货/退款"}},{"path":"/shops/pages/user/edit","meta":{},"window":{"navigationBarTitleText":"个人资料"}},{"path":"/shops/pages/user/fenxiaolist","meta":{},"window":{"navigationBarTitleText":"分销明细"}},{"path":"/shops/pages/user/moneylist","meta":{},"window":{"navigationBarTitleText":"收支明细","enablePullDownRefresh":true}},{"path":"/shops/pages/user/buy","meta":{},"window":{"navigationBarTitleText":"我要充值"}},{"path":"/shops/pages/user/buylog","meta":{},"window":{"navigationBarTitleText":"购买记录"}},{"path":"/shops/pages/user/like","meta":{},"window":{"navigationBarTitleText":"我的收藏"}},{"path":"/shops/pages/map/index","meta":{},"window":{"navigationBarTitleText":"选择地址"}},{"path":"/shops/pages/user/advice","meta":{},"window":{"navigationBarTitleText":"意见反馈"}},{"path":"/shops/pages/passport/pay","meta":{},"window":{"navigationBarTitleText":"支付密码"}},{"path":"/shops/pages/passport/login","meta":{},"window":{"navigationStyle":"custom"}},{"path":"/shops/pages/cart/index","meta":{},"window":{"navigationStyle":"custom"}},{"path":"/shops/pages/user/joinshops","meta":{},"window":{"navigationBarTitleText":"商家入驻"}},{"path":"/shops/pages/user/order","meta":{},"window":{"navigationBarTitleText":"我的订单"}},{"path":"/shops/pages/user/helplist","meta":{},"window":{"navigationBarTitleText":"帮助中心"}},{"path":"/shops/pages/user/pjlist","meta":{},"window":{"navigationBarTitleText":"评价列表"}},{"path":"/shops/pages/user/pingjia","meta":{},"window":{"navigationBarTitleText":"填写评价"}},{"path":"/shops/pages/user/pingjiadetail","meta":{},"window":{"navigationBarTitleText":"评价详情"}},{"path":"/shops/pages/user/index","meta":{},"window":{"navigationStyle":"custom"}},{"path":"/shops/pages/user/shops/index","meta":{},"window":{"navigationStyle":"custom"}},{"path":"/shops/pages/user/shops/vip","meta":{},"window":{"navigationStyle":"custom"}},{"path":"/shops/pages/user/shops/goods","meta":{},"window":{"navigationStyle":"custom"}},{"path":"/shops/pages/user/shops/order","meta":{},"window":{"navigationStyle":"custom"}},{"path":"/shops/pages/user/shops/edit","meta":{},"window":{"navigationBarTitleText":"商家管理"}},{"path":"/shops/pages/user/shops/pjlist","meta":{},"window":{"navigationStyle":"custom"}},{"path":"/shops/pages/user/shops/limitedtime","meta":{},"window":{"navigationStyle":"custom"}},{"path":"/shops/pages/user/shops/fullreduction","meta":{},"window":{"navigationStyle":"custom"}},{"path":"/shops/pages/user/shops/assemble","meta":{},"window":{"navigationStyle":"custom"}},{"path":"/shops/pages/user/shops/couponlist","meta":{},"window":{"navigationStyle":"custom"}},{"path":"/shops/pages/user/shops/creatactivity","meta":{},"window":{"navigationStyle":"custom"}}];
__uniConfig.onReady=function(callback){if(__uniConfig.ready){callback()}else{onReadyCallbacks.push(callback)}};Object.defineProperty(__uniConfig,"ready",{get:function(){return isReady},set:function(val){isReady=val;if(!isReady){return}const callbacks=onReadyCallbacks.slice(0);onReadyCallbacks.length=0;callbacks.forEach(function(callback){callback()})}});
__uniConfig.onServiceReady=function(callback){if(__uniConfig.serviceReady){callback()}else{onServiceReadyCallbacks.push(callback)}};Object.defineProperty(__uniConfig,"serviceReady",{get:function(){return isServiceReady},set:function(val){isServiceReady=val;if(!isServiceReady){return}const callbacks=onServiceReadyCallbacks.slice(0);onServiceReadyCallbacks.length=0;callbacks.forEach(function(callback){callback()})}});
service.register("uni-app-config",{create(a,b,c){if(!__uniConfig.viewport){var d=b.weex.config.env.scale,e=b.weex.config.env.deviceWidth,f=Math.ceil(e/d);Object.assign(__uniConfig,{viewport:f,defaultFontSize:Math.round(f/20)})}return{instance:{__uniConfig:__uniConfig,__uniRoutes:__uniRoutes,global:void 0,window:void 0,document:void 0,frames:void 0,self:void 0,location:void 0,navigator:void 0,localStorage:void 0,history:void 0,Caches:void 0,screen:void 0,alert:void 0,confirm:void 0,prompt:void 0,fetch:void 0,XMLHttpRequest:void 0,WebSocket:void 0,webkit:void 0,print:void 0}}}});
