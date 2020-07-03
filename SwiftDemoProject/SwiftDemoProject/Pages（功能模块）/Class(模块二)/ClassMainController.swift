//
//  ClassMainController.swift
//  SwiftDemoProject
//
//  Created by champ on 2020/7/2.
//  Copyright © 2020 champ. All rights reserved.
//

import UIKit


class  ClassMainController: HomeMainController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "框架"
        datas = [
             (title:"RxSwift的学习",         vc:RxSwiftController.self),
             
         ]
        
    }
}





