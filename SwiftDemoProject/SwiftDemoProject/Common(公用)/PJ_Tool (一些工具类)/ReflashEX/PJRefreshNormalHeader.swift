//
//  PJRefreshNormalHeader.swift
//  SwiftDemoProject
//
//  Created by champ on 2020/6/12.
//  Copyright © 2020 champ. All rights reserved.
//

import UIKit

class PJRefreshNormalHeader: MJRefreshNormalHeader {
    
    override func prepare() {
        super.prepare()
        setTitle("下拉刷新", for: .idle)
        setTitle("松开刷新", for: .pulling)
        setTitle("正在加载", for: .refreshing)
        
        lastUpdatedTimeLabel?.isHidden = true
        stateLabel?.font = UIFont.systemFont(ofSize: 13)
        stateLabel?.textColor = .lightGray;
    }

}
