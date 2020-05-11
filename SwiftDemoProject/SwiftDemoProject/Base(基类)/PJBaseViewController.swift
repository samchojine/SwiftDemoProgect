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
           
            self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "navi_icon_back_black")?.imageWithTintColor(tintColor: .white), style: .plain, target: self, action: #selector(action_back))
        }
        
    }
    
    
     override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.barTintColor = UIColor.white
                self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.darkText]
        navigationController?.navigationBar.isTranslucent = false
       // self.navigationController!.navigationBar.tintColor = .black;
        
    }
    
    
    @objc func action_back() {
        
        self.navigationController?.popViewController(animated: true)
    }
    
}
