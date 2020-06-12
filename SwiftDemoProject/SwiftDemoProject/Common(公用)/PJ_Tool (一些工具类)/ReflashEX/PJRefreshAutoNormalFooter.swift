//
//  PJRefreshAutoNormalFooter.swift
//  SwiftDemoProject
//
//  Created by champ on 2020/6/12.
//  Copyright © 2020 champ. All rights reserved.
//

import UIKit

class PJRefreshAutoNormalFooter:  MJRefreshAutoNormalFooter {

    override func prepare() {
        super.prepare()
        setTitle("上拉加载", for: .idle)
        setTitle("松开加载", for: .pulling)
        setTitle("正在加载", for: .refreshing)
        setTitle("暂无更多数据", for: .noMoreData)
        stateLabel?.font = UIFont.systemFont(ofSize: 13)
        stateLabel?.textColor = .lightGray;
        
        stateLabel?.font = .systemFont(ofSize: 13);
        stateLabel?.textColor = .lightGray
    }
    
}


