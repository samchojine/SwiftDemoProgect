//
//  MeMainController.swift
//  SwiftDemoProject
//
//  Created by champ on 2020/4/30.
//  Copyright © 2020 champ. All rights reserved.
//

import UIKit

class MeMainController: PJBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "我的";
   
        let  label = UITextView()
        view.addSubview(label);
        label.backgroundColor = .white
        label.font = UIFont.systemFont(ofSize: 12);
        label.frame = CGRect(x: 20, y: 100, width: 100, height: 60)
        label.placeholder = "你好啊"
        label.placeholderColor = .red
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    
}
