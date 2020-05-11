//
//  PJ_WKWebViewExtension.swift
//  SwiftDemoProject
//
//  Created by champ on 2020/5/7.
//  Copyright © 2020 champ. All rights reserved.
//

import UIKit
import WebKit

extension WKWebView{
    
    /// 创建一个默认的wkwebview
    static func pj_normalWKWebView() -> WKWebView{
        let jScript = "var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);"
        let wkUScript = WKUserScript.init(source: jScript, injectionTime:.atDocumentEnd, forMainFrameOnly: true)
        let wkUController = WKUserContentController()
        wkUController.addUserScript(wkUScript)
        let wkWebConfig = WKWebViewConfiguration()
        wkWebConfig.userContentController = wkUController
        
        let webView = WKWebView(frame: CGRect.zero, configuration: wkWebConfig)
        return webView
    }
}
