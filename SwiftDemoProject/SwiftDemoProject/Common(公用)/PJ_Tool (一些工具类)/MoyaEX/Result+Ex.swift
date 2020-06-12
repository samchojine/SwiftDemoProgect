//
//  Result+Ex.swift
//  TheOptimal
//
//  Created by Jxiongzz on 2020/3/9.
//  Copyright © 2020 ZhiYou. All rights reserved.
//

import Foundation
import Moya
import Result

//服务器返回数据有错(statusCode,errorMsg等等都算) rawJSON
typealias RespErrBlk = ((SSYRequestError)->Void)?

//服务器返回的未做处理的数据  rawJSON
typealias RespSucRawBlk = ([String:Any])->Void

//服务器返回的数据是否正常
typealias RespIsSucBlk = (String)->Void

//服务器返回的data字段数据是arr[Any]  dataArray
typealias RespSucDataArr = ([Any])->Void

//服务器返回的data字段数据是arr[String:Any]  dataArray
typealias RespSucDataArrInfo = ([[String:Any]])->Void

//服务器返回的data字段数据是JSON dataJSON
typealias RespSucDataJSON = ([String:Any])->Void

let RespFieldSuc = "success";
let RespFieldData = "data";
let RespFieldCode = "code";
let RespFieldMsg = "msg";
let RespSucCheckCodes : Set<Int> = [200]
let RespNoLoginCheckCode : Int = 401

// ------------------------- Note in 2019 10 31 -------------------------------
// 考虑到Result的设计,本来就很棒👍,特别是map以及flatMap等的变换。
// 但是仍然改成了如下的方式，可以说又把Result封装的改回来了,原因有如下几点。
// 1- 不习惯用switch进行后续多个语句的处理
// 2- block连在一起的设计，也自己区分了success和failed，不必要再次进行解包

// 假如你想用回Result，那么根据服务端返回的数据进行封装几个变换后，返回自定义的Result.Value和Result.Error也是可行的
// -----------------------------------klc---------------------------------------


//用来解析常用的数据
extension Result where Value : Response , Error == MoyaError{
    
    private func checkIsSucStatus(_ rawJsonObjc : [String:Any]) -> Bool{
        if let code = rawJsonObjc[RespFieldCode] as? Int , RespSucCheckCodes.contains(code) {
            return true
        }
        return false
    }
    
    private func checkIsNoLoginStatus(_ rawJsonObjc : [String:Any]) -> Bool{
        if let code = rawJsonObjc[RespFieldCode] as? Int , RespNoLoginCheckCode == code {
            return true
        }
        return false
    }
    
    ///基础解析:获得最原本的从服务端返回的json
    func getRaw(success : RespSucRawBlk , failed : RespErrBlk){
        switch self {
        case .success(let moyaResponse):
            do {
                let jsonObjc = try moyaResponse.mapJSON();
                if let jsonObjc = jsonObjc as? [String : Any]{
                    success(jsonObjc);
                }
                else {
                    failed?(SSYRequestError.reponseDataTypeMappingError(response: moyaResponse, desc: SSYRequestError.jsonObjcToArrayError));
                }
            }
            catch {
                let moyaError = error as! MoyaError
                failed?(SSYRequestError.reponseDataTypeMappingError(response: moyaResponse, desc:moyaError.errorDescription ?? SSYRequestError.moyaMapDataError));
            }
        case .failure(let moyaError):
            let requestError = SSYRequestError.requestFailed(response: moyaError.response, desc: moyaError.errorDescription ?? SSYRequestError.moyaUnkownError)
            failed?(requestError);
        }
    }
    
    ///解析是否正确
    func getIsSuccess(isSuccess:RespIsSucBlk,failed:RespErrBlk){
        self.getRaw(success: { (rawJSON) in
            //判断是正确状态码再解析data，这个接口没有返回 success 是否是false 还是 true
            if self.checkIsSucStatus(rawJSON){
                isSuccess((rawJSON[RespFieldMsg] as? String) ?? "")
            }
            else {
                if self.checkIsNoLoginStatus(rawJSON) {
                    //这里先不做处理 交给了其他的插件做了
                }
                else {
                    let error = SSYRequestError.requestFailed(response:self,desc:rawJSON[RespFieldMsg] as? String ?? "返回错误")
                    failed?(error)
                }
            }
        }, failed: failed)
    }
    
    //后续的便捷解析看接口再做
    ///如果是success那么获取json中的data字段(Any类型)
    func getDataAny(success:(Any)->Void,failed : RespErrBlk){
        self.getRaw(success: { (rawJSON) in
            //判断是正确状态码再解析data，这个接口没有返回 success 是否是false 还是 true
            if self.checkIsSucStatus(rawJSON){
                if let data = rawJSON[RespFieldData]{
                    success(data);
                }
                else{
                    failed?(SSYRequestError.reponseOtherError(desc: "没有data字段"));
                }
            }
            else {
                let error = SSYRequestError.reponseDataTypeMappingError(response:self,desc:rawJSON[RespFieldMsg] as? String ?? "返回错误");
                failed?(error);
            }
        }, failed: failed)
    }

    ///如果是success获取json中的data字段,转化为arr[Any]
    func getDataArr(success:RespSucDataArr,failed : RespErrBlk){
        self.getDataAny(success: { (data) in
            if let dataArr = data as? Array<Any> {
                success(dataArr)
            }
            else {
                failed?(SSYRequestError.reponseDataTypeMappingError(response: self, desc: SSYRequestError.moyaMapDataError));
            }
        }, failed: failed)
    }
    
    ///如果是success获取json中的data字段,转化为arr[[String:Any]]
    func getDataArrInfo(success:RespSucDataArrInfo,failed : RespErrBlk){
        self.getDataAny(success: { (data) in
            if let dataArr = data as? [[String:Any]] {
                success(dataArr)
            }
            else {
                failed?(SSYRequestError.reponseDataTypeMappingError(response: self, desc: SSYRequestError.moyaMapDataError));
            }
        }, failed: failed)
    }

    ///如果是success获取json中的data字段,转化为dictionary
    func getDataDictionary(success:RespSucDataJSON,failed : RespErrBlk){
        self.getDataAny(success: { (data) in
            if let dataJson = data as? Dictionary<String,Any> {
                success(dataJson)
            }
            else {
                failed?(SSYRequestError.reponseDataTypeMappingError(response: self, desc: SSYRequestError.moyaMapDataError));
            }
        }, failed: failed)
    }

    /// 获取data 中的list 数组
    func getArrayFromDataWithKey(_ key:String,success:RespSucDataArr,failed : RespErrBlk){
        self.getDataDictionary(success: { (dataInfo) in
            if let list = dataInfo[key] as? [[String:Any]] {
                success(list);
            }
            else {
                failed?(SSYRequestError.reponseOtherError(desc: "data中获取不到list"));
            }
        }, failed: failed)
    }
}

