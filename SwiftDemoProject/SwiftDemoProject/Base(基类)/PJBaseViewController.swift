//
//  PJBaseViewController.swift
//  SwiftDemoProject
//
//  Created by champ on 2020/4/30.
//  Copyright © 2020 champ. All rights reserved.
//

import UIKit

class PJBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 默认白色背景
        view.backgroundColor = UIColor.white
        
        // 设置返回图片
        if self.navigationController!.viewControllers.count > 1 {
           
            self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "navi_icon_back_black"), style: .plain, target: self, action: #selector(action_back))
        }
        
    }
    
    @objc func action_back() {
        
        self.navigationController?.popViewController(animated: true)
    }
    
}
