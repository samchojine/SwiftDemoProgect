//
//  SSYLoginDetectMoyaPlugin.swift
//  TheOptimal
//
//  Created by Jxiongzz on 2020/3/9.
//  Copyright © 2020 ZhiYou. All rights reserved.
//

import UIKit
import Moya
import Result

class SSYLoginDetectMoyaPlugin: PluginType {
    
    func willSend(_ request: RequestType, target: TargetType) {
    }
    
    func didReceive(_ result: Result<Moya.Response, MoyaError>, target: TargetType) {
        switch result {
        case .failure(_):
            break
        case .success(let result):
            let data = result.data
            let dic = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? Dictionary<String, Any> ?? [:]
            if let code = dic?["code"] as? Int{
                switch code {
                case RespNoLoginCheckCode:
                    setNeedLogin()
                default:
                    break
                }
            }
        }
    }
    
    func setNeedLogin(){
//        AMBUser.share.clearLoginStatus()
//        if let current = UIViewController.klc_currentViewController() {
//            AMBLoginVC.presentLoginFrom(current)
//        }
    }
}

