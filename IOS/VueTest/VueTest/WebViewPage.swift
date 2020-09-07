//
//  WebViewPage.swift
//  VueTest
//
//  Created by 杨迪龙 on 2020/9/5.
//  Copyright © 2020 杨迪龙. All rights reserved.
//

import SwiftUI
import WebKit

struct WebViewPage : UIViewRepresentable {
    let webView = WKWebView()
    func makeUIView(context: Context) -> WKWebView  {
        return webView
    }
    func updateUIView(_ uiView: WKWebView, context: Context) {
        //let req = URLRequest(url: URL(string: "https://www.apple.com")!)
        //uiView.load(req)
    }
    func loadUrl(url: String) -> Void {
        let req = URLRequest(url: URL(string: url)!)
        webView.load(req)
    }
}

struct WebViewPage_Previews: PreviewProvider {
    static var previews: some View {
        WebViewPage()
    }
}
