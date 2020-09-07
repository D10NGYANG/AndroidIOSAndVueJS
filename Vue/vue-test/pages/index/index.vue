<template>
	<view style="margin: auto;">
		<text>当前平台为{{platform}}</text>
		<view style="width: 100%;background-color: #555555;text-align: center;">
			<text style="color: #FFFFFF;font-size: 40rpx;">{{title}}</text>
		</view>
		<button v-on:click="clickBtn">点击我触发调用原生方法</button>
		<button v-on:click="clickBack">点击我还原文本</button>
	</view>
</template>

<script>
	export default {
		mounted() {
			window.changeTitle = this.changeTitle
		},
		data() {
			return {
				title: 'Hello world!',
				platform: uni.getSystemInfoSync().platform
			}
		},
		onLoad() {
			console.debug(uni.getSystemInfoSync().platform)
		},
		methods: {
			clickBtn: function() {
				switch(this.$data.platform) {
					case "android":
					    AppJsFunction.showDialog(this.$data.title);
					    break
				    case "ios":
					    window.webkit.messageHandlers.AppJsFunction.postMessage(this.$data.title);
					    break
				}
			},
			clickBack: function(){
				this.$data.title = "Hello world!";
			},
			changeTitle(value) {
				this.$data.title = value;
				return "调用成功";
			}
		}
	}
</script>

<style>
</style>
<template>
	<view style="margin: auto;">
		<text>当前平台为{{platform}}</text>
		<view style="width: 100%;background-color: #555555;text-align: center;">
			<text style="color: #FFFFFF;font-size: 40rpx;">{{title}}</text>
		</view>
		<button v-on:click="clickBtn">点击我触发调用原生方法</button>
		<button v-on:click="clickBack">点击我还原文本</button>
	</view>
</template>

<script>
	export default {
		mounted() {
			window.changeTitle = this.changeTitle
		},
		data() {
			return {
				title: 'Hello world!',
				platform: uni.getSystemInfoSync().platform
			}
		},
		onLoad() {
			console.debug(uni.getSystemInfoSync().platform)
		},
		methods: {
			clickBtn: function() {
				switch(this.$data.platform) {
					case "android":
					    AppJsFunction.showDialog(this.$data.title);
					    break
				    case "ios":
					    window.webkit.messageHandlers.AppJsFunction.postMessage(this.$data.title);
					    break
				}
			},
			clickBack: function(){
				this.$data.title = "Hello world!";
			},
			changeTitle(value) {
				this.$data.title = value;
				return "调用成功";
			}
		}
	}
</script>

<style>
</style>