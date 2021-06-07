import LangCn from './zh_CN.js'
import LangEn from './en_US.js'
import LangRu from './ru.js'
import LangPh from './ph.js'
import LangKr from './kr.js'
import LangMy from './my.js'
import LangPt from './pt.js'
import LangTr from './tr.js'
import LangEs from './es.js'
import LangIn from './in.js'
import LangIdsa from './idsa.js'
import LangVn from './vn.js'
import LangTh from './th.js'
import LangSa from './sa.js'
import Vue from 'vue'
import VueI18n from './vue-i18n'
Vue.use(VueI18n)
const system_info = uni.getStorageSync('system_info')
if (!system_info) {
    // 获取设备信息
    uni.getSystemInfo({
        success: function (res) {
            console.log('设备信息'+res)
            uni.setStorageSync('system_info', res);
        }
    })
}
    const cur_lang = system_info.language == 'en' ? 'en' : 'zh'
    const i18n = new VueI18n({
        locale: cur_lang || 'zh',  // 默认选择的语言
        messages: {  
                'sa': LangSa,
                'th': LangTh,
                'vn': LangVn,
                'idsa': LangIdsa,
                'in': LangIn,
                'es': LangEs,
                'tr': LangTr,
                'pt': LangPt,
                'my': LangMy,
                'kr': LangKr,
                'ph': LangPh,
                'ru': LangRu,
                'en': LangEn,
                'zh': LangCn
            }
    })
    export default i18n