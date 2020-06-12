//
//  JYTargetType+Extension.swift
//  JingYiWang-Seller
//
//  Created by Jxiongzz on 2019/10/17.
//  Copyright © 2019 Jxiongzz. All rights reserved.
//

import UIKit
import Moya
import Alamofire
 
extension TargetType{
    /// Provides stub data for use in testing.
    var sampleData: Data {
        return "Half measures are as bad as nothing at all.".data(using: String.Encoding.utf8)!
    }
    
    /// The target's base `URL`.
    var baseURL: URL {
        return PBaseUrl
    }
    
    var headers: [String: String]? {
        return ["Content-Type":"application/x-www-form-urlencoded"]
      //  return ["Authorization":ZYUser.share.token,"DeviceType":"1"]
    }
    
}

/// 自定义参数编码，用来上传数组 没有对应的key(比如;["1","2"]) 注意 使用这个编码的时候 把你要上传的数组这样传递进来["jsonArray":要上传的数组]
struct JSONArrayEncoding: ParameterEncoding {
   
    public static var `default`: JSONArrayEncoding { return JSONArrayEncoding() }
    
    func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var request = try urlRequest.asURLRequest()

        guard let json = parameters?["jsonArray"] else {
            return request
        }

        let data = try JSONSerialization.data(withJSONObject: json, options: [])

        if request.value(forHTTPHeaderField: "Content-Type") == nil {
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }

        request.httpBody = data

        return request
    }
}
