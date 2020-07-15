//
//  AutoConstantHeaderFooterController.swift
//  SwiftDemoProject
//
//  Created by champ on 2020/7/15.
//  Copyright © 2020 champ. All rights reserved.
//

import UIKit

class AutoConstantHeaderFooterController: PJBaseTableViewController {
    
    lazy var tableHeaderV: HeaderView = {
        let hv = HeaderView()
        return hv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
}


class HeaderView:UIView {
    
    lazy var titleLabel: UILabel = {
        let l = UILabel()
        return l
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configUI() {
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        
    }
    
    
}
