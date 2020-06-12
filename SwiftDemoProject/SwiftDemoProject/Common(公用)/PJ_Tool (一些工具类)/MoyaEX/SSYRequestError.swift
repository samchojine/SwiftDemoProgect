//
//  SSYRequestError.swift
//  DaiYanZhenXuan
//
//  Created by sun on 2019/1/8.
//  Copyright © 2019年 ShuShangYun. All rights reserved.
//

import Foundation

//自定义的error 包含一下MoyaError

enum SSYRequestError:Error {
    static let moyaMapDataError  = "moya Map Data Error"
    static let moyaUnkownError  = "moya Error not kown"
    static let jsonObjcToArrayError = "服务端数据不能转成数组"
    static let jsonObjcToDictionaryError = "服务端数据不能转成字典"

    //500 400等错误 在这里包含掉MoyaError的error
    case requestFailed(response:Any?,desc:String)
    //虽然有moyaerror中有这个error,但是在其他手动解析的时候,有时候[可能]会有类型转换等错误出现例如 dict -> Array
    case reponseDataTypeMappingError(response:Any?,desc:String?)
    //其他错误 例如服务器请求成功了,但是返回的errorMsg
    case reponseOtherError(desc:String)
    
    var localizedDescription: String {
        get {
            var errorDesc = "";
            switch self {
            case .requestFailed(response: _, desc: let description):
                errorDesc = description;
            case .reponseOtherError(desc: let description):
                errorDesc = description;
            case .reponseDataTypeMappingError(response: _, let description):
                errorDesc = description ?? ""
            }
            return errorDesc;
        }
    }
}
