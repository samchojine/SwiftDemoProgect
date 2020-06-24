//
//  SSYNetworkLoggerPlugin.swift
//  TheOptimal
//
//  Created by Jxiongzz on 2020/3/9.
//  Copyright © 2020 ZhiYou. All rights reserved.
//

import UIKit
import Moya
//import Result

class SSYNetworkLoggerPlugin: PluginType {
    func jPrint(_ items: Any, file: String = #file, line: Int = #line, function: String = #function) {
        #if DEBUG
        print("==============================================")
        print("\((file as NSString).lastPathComponent)[\(line)], \(function)\n\(items)\n")
        #endif
    }

    func willSend(_ request: RequestType, target: TargetType) {
        jPrint("willSend: \(request.request?.url?.absoluteString ?? "") , target:\(target)")
    }
    
    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        print("=========================== Network start ============================")
        
        switch result {
        case .success(let response):
            outputItems(logNetworkRequest(response.request))
            outputItems(logNetworkResponse(response.response, data: response.data, target: target))
        case .failure(let error):
            print("errorDescription: \(error.errorDescription ?? "")")
            outputItems(logNetworkRequest(error.response?.request))
            outputItems(logNetworkResponse(nil, data: nil, target: target))
        }
        
        print("============================ Network End =============================")
    }
    
    fileprivate func outputItems(_ items: [String]) {
        for string in items {
            print("\(string)\n")
        }
    }
}

private extension SSYNetworkLoggerPlugin {
    
    func format(identifier: String, message: String) -> String {
        return "\(identifier): \(message)"
    }
    
    func logNetworkRequest(_ request: URLRequest?) -> [String] {
        
        var output = [String]()
        
        output += [format(identifier: "Request URL", message: request?.url?.absoluteString ?? "(invalid request)")]
        
        if let httpMethod = request?.httpMethod {
            output += [format(identifier: "HTTP Request Method", message: httpMethod)]
        }
        
        if let headers = request?.allHTTPHeaderFields {
            output += [format(identifier: "Request Headers", message: headers.description)]
        }
        
        if let bodyStream = request?.httpBodyStream {
            output += [format(identifier: "Request Body Stream", message: bodyStream.description)]
        }
        
        if let body = request?.httpBody, let stringOutput = String(data: body, encoding: .utf8) {
            output += [format(identifier: "Request Body", message: stringOutput)]
        }
        
        return output
    }
    
    func logNetworkResponse(_ response: HTTPURLResponse?, data: Data?, target: TargetType) -> [String] {
        if response == nil {
            return [format(identifier: "Response", message: "Received empty network response for \(target).")]
        }
        
        var output = [String]()
        
        if let datajson = data {
            
            let dic = try? JSONSerialization.jsonObject(with: datajson, options: .mutableContainers) as? [String : Any] ?? [:]
            
            //判断是否JSon格式
            if !JSONSerialization.isValidJSONObject(dic!) {
                print("不是一个正确的json对象")
                return output
            }
            
            let json = try?JSONSerialization.data(withJSONObject: dic!, options: .prettyPrinted)
            let jsonstr = String(data: json!, encoding: .utf8) ?? ""
            output += [format(identifier: "ResponseData", message: jsonstr)]

        }
        
        return output
    }
}

