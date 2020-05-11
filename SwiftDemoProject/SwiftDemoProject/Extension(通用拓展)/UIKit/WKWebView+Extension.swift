//
//  WKWebView+Extension.swift
//  JingYiWang-Seller
//
//  Created by Jxiongzz on 2020/1/3.
//  Copyright © 2020 Jxiongzz. All rights reserved.
//

import Foundation
import WebKit

extension WKWebView{
    
    static func normalWKWebView() -> WKWebView{
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
