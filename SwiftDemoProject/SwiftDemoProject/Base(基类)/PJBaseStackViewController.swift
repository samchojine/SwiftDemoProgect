//
//  PJBaseStackViewController.swift
//  SwiftDemoProject
//
//  Created by champ on 2020/5/11.
//  Copyright © 2020 champ. All rights reserved.
//

import UIKit

class ZYBaseStackViewController: PJBaseViewController {
    
    /// 底部距离
    var contenBottomSpace :CGFloat = 0.0 {
        
        didSet{
            self.zyScrollView.contentInset = UIEdgeInsets(top: self.contenTopSpace, left: 0, bottom:  contenBottomSpace + PBottomSafeInset, right: 0)
        }
    }
    
    // 顶部距离
    var contenTopSpace :CGFloat = 0.0 {
        didSet{
            self.zyScrollView.contentInset = UIEdgeInsets(top: contenTopSpace, left: 0, bottom:  contenBottomSpace, right: 0)
        }
    }
    
    lazy var stackV: UIStackView = {
        let sv = UIStackView();
        sv.distribution = .equalSpacing
        sv.axis = .vertical
        sv.spacing = 0
        return sv
    }()
    
    lazy var zyScrollView: UIScrollView = {
        let sv = UIScrollView();
        sv.backgroundColor = .groupTableViewBackground
        sv.alwaysBounceVertical = true
        return sv
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(zyScrollView)
        zyScrollView.addSubview(stackV)
        zyScrollView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        
        stackV.snp.makeConstraints { (make) in
            make.edges.equalTo(zyScrollView)
            make.width.equalTo(UIScreen.main.bounds.width)
        }
        
    }
    
}
