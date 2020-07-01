//
//  ImagePickController.swift
//  SwiftDemoProject
//
//  Created by champ on 2020/6/28.
//  Copyright © 2020 champ. All rights reserved.
//

import UIKit

class ImagePickController: ZYBaseStackViewController{
    
    lazy var collectionImageV: ImagePickVidew = {
        let v = ImagePickVidew()
        return v
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "图片拾取"
    
        stackV.addArrangedSubview(self.collectionImageV)
        
    }
    
}
