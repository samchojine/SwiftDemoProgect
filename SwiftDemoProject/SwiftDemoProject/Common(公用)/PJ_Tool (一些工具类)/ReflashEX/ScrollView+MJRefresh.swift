//
//  ScrollView+MJRefresh.swift
//  SwiftDemoProject
//
//  Created by champ on 2020/6/12.
//  Copyright © 2020 champ. All rights reserved.
//

import UIKit



extension UIScrollView {
    
    
    /// 网络加载成功和失败的时候调用
    /// - Parameter isLastPage: 在成功的回调里面传，失败的回调里面不用传
    func endRefresh(isLastPage: Bool = false){
        if self.mj_header != nil,self.mj_header!.isRefreshing {
            self.mj_header!.endRefreshing()
        }
        guard self.mj_footer != nil else {
            return
        }
        if self.mj_footer!.isRefreshing {
            self.mj_footer!.endRefreshing()
        }
        if isLastPage {
            self.mj_footer!.endRefreshingWithNoMoreData()
        }
        else {
            self.mj_footer!.resetNoMoreData()
        }
        self.mj_footer!.isHidden = false
    }
    

}
