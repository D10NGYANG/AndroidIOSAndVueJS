package com.dlong.vuetest

import android.annotation.SuppressLint
import android.os.Bundle
import android.webkit.JavascriptInterface
import androidx.appcompat.app.AlertDialog
import androidx.appcompat.app.AppCompatActivity
import androidx.databinding.DataBindingUtil
import com.dlong.vuetest.databinding.ActivityMainBinding

class MainActivity : AppCompatActivity() {

    lateinit var binding: ActivityMainBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = DataBindingUtil.setContentView(this, R.layout.activity_main)

        initWeb()
        binding.web.loadUrl("http://192.168.1.124:8081/#/pages/index/index")
    }

    /** 初始化网页浏览器 */
    @SuppressLint("SetJavaScriptEnabled")
    private fun initWeb() {
        // 配置web
        binding.web.apply {
            // 启用JS
            settings.javaScriptEnabled = true
            // 设置JS调用接口
            addJavascriptInterface(JSFunction(this@MainActivity), "AppJsFunction")
        }
    }

    /**
     * JS调用原生
     * @property activity Activity
     * @constructor
     */
    class JSFunction constructor(private val activity: MainActivity) {

        @JavascriptInterface
        fun showDialog(message: String) {
            AlertDialog.Builder(activity)
                .setTitle("提示")
                .setMessage(message)
                .setPositiveButton("OK") { _, _ -> }
                .create()
                .show()

            // 原生调用JS
            activity.binding.web.post {
                activity.binding.web.evaluateJavascript("javascript:changeTitle('来自Android更换文本')", null)
            }
        }
    }
}