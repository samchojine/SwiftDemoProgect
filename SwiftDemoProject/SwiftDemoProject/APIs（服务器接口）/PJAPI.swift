//
//  PJAPI.swift
//  SwiftDemoProject
//
//  Created by champ on 2020/6/10.
//  Copyright © 2020 champ. All rights reserved.
//

import UIKit
import Moya


let GoodsProvider = MoyaProvider<PJAPI>(plugins: [SSYNetworkLoggerPlugin(),SSYLoginDetectMoyaPlugin()])

enum PJAPI{
    /// 获取商品详情
    case getGoodsDetails(parameters:[String:Any])
    /// 获取商品评论
    case getGoodsComment(parameters:[String:Any])
    /// 获取商品评论数量
    case getGoodsCommentCount(parameters:[String:Any])
    /// 收藏商品
    case collectGoods(parameters:[String:Any])
    /// 取消收藏
    case cancelCollectGoods(parameters:[String:Any])
    /// 判断用户是否收藏了该商品
    case judgeUserCollectGoods(parameters:[String:Any])
    /// 添加商品评价
    case addGoodsComment(parameters:[String:Any])
    /// 获取优豆商品列表
    case getBeanGoodsList(parameters:[String:Any])
}

extension PJAPI : TargetType{
    
    var task: Task {
        switch self {
        case .getGoodsDetails(let parameters),
             .getGoodsComment(let parameters),
             .getGoodsCommentCount(let parameters),
             .collectGoods(let parameters),
             .cancelCollectGoods(let parameters),
             .judgeUserCollectGoods(let parameters),
             .getBeanGoodsList(let parameters):
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default) ///JSONEncoding
        case .addGoodsComment(let parameters):
            return .requestParameters(parameters: parameters, encoding: JSONArrayEncoding.default)
            
        default:
            return .requestPlain
        }
    }
        
    
    var path: String {
        switch self {
        case .getGoodsDetails:
            return "/api/goodsInfo/getById"
        case .getGoodsComment:
            return "/api/goodsComment/page"
        case .getGoodsCommentCount:
            return "/api/goodsComment/count"
        case .collectGoods:
            return "/api/goodsCollect/save"
        case .cancelCollectGoods:
            return "/api/goodsCollect/delete"
        case .judgeUserCollectGoods:
            return "/api/goodsCollect/isCollect"
        case .addGoodsComment:
            return "/api/goodsComment/save"
        case .getBeanGoodsList:
            return "/api/beanGoods/page"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .collectGoods,
             .addGoodsComment:
            return .post
        default:
            return .get
        }
    }
}
