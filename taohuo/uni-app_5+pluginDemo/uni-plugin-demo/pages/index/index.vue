<template>
    <view>
        <button @click="pluginShow">PluginTestFunction</button>
		<button @click="pluginShowArrayArgu">PluginTestFunctionArrayArgu</button>
		<button @click="pluginGetString">PluginTestFunctionSync</button>
		<button @click="pluginGetStringArrayArgu">PluginTestFunctionSyncArrayArgu</button>
    </view>
</template>
<style>
	button {
		width: 94%;
		margin: 20upx auto;
	}
</style>
<script>
// 扩展的 js 文件的位置：common/plugins.js
var plugins = require('../../common/testplugin.js');
export default {
    data() {
        return {
            plugins: plugins
        };
    },
    methods: {
        pluginShow() {
            this.plugins.PluginTestFunction(
                'Html5',
                'Plus',
                'AsyncFunction',
                'MultiArgument!',
                function(result) {
					uni.showToast({title:JSON.stringify(result),icon:'none'});
                },
                function(result) {
					uni.showToast({title:result});
                }
            );
        },
        pluginShowArrayArgu() {
            this.plugins.PluginTestFunctionArrayArgu(
                ['Html5', 'Plus', 'AsyncFunction', 'ArrayArgument!'],
                function(result) {
                    uni.showToast({title:result,icon:'none'});
                },
                function(result) {
                    uni.showToast({title:result,icon:'none'});
                }
            );
        },
        pluginGetString() {
			uni.showToast({title:this.plugins.PluginTestFunctionSync('Html5', 'Plus', 'SyncFunction', 'MultiArgument!'),icon:'none'});
        },
        pluginGetStringArrayArgu() {
            var Argus = this.plugins.PluginTestFunctionSyncArrayArgu([
                'Html5',
                'Plus',
                'SyncFunction',
                'ArrayArgument!'
            ]);
			uni.showToast({title:Argus.RetArgu1 + '_' + Argus.RetArgu2 + '_' + Argus.RetArgu3 + '_' + Argus.RetArgu4,icon:'none'});
        }
    }
};
</script>
<style>
</style>
