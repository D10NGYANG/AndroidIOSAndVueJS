//
//  ContentView.swift
//  VueTest
//
//  Created by 杨迪龙 on 2020/9/3.
//  Copyright © 2020 杨迪龙. All rights reserved.
//

import SwiftUI
import WebKit

struct ContentView: View {
    
    // JS消息接受器
    var handler = JsMessageHandler()
    // WebViewStore
    var webViewStore: WebViewStore? = nil
    // 弹窗显示标记
    @State var isShowAlert = false
    // 弹窗文本内容
    @State var alertMessage = ""
    
    init() {
        // 设置偏好设置
        let config = WKWebViewConfiguration()
        config.preferences = WKPreferences()
        // 开启JS
        config.preferences.javaScriptEnabled = true
        // 注入JS操作对象
        config.userContentController = WKUserContentController()
        config.userContentController.add(handler, name: "AppJsFunction")
        // 初始化WebViewStore
        webViewStore = WebViewStore(webView: WKWebView.init(frame: CGRect.init(x: 0, y: 0, width:  UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), configuration: config))
    }
    
    var body: some View {
      NavigationView {
        WebView(webView: webViewStore!.webView)
      }
      .alert(isPresented: $isShowAlert, content: { () -> Alert in
        Alert(title: Text("提示"),
        message: Text(alertMessage),
        dismissButton: .default(Text("OK")))
      })
      .onAppear {
        // JS消息接受器注入当前ContentView，使得其可以调用回当前组件的变量
        self.handler.contentView = self
        // 新建一个请求
        let req = URLRequest(url: URL(string: "http://192.168.1.124:8081/#/pages/index/index")!)
        // 加载页面请求
        self.webViewStore!.webView.load(req)
      }
    }
}

/// JS消息接受器
class JsMessageHandler: UIViewController, WKScriptMessageHandler {
    
    // WebView所在的组件
    var contentView: ContentView? = nil
    
    
    /// JS触发回调
    /// - Parameters:
    ///   - userContentController:
    ///   - message:
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        // 获取网页传递过来的文本内容
        contentView!.alertMessage = message.body as! String
        // 显示弹窗
        contentView!.isShowAlert = true
        // 修改网页文本，也就是原生代码调用JS
        contentView!.webViewStore?.webView.evaluateJavaScript("javascript:changeTitle('来自IOS更换文本')", completionHandler: nil)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
