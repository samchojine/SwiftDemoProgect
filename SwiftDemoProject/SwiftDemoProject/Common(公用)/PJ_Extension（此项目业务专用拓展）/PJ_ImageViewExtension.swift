//
//  PJ_ImageViewExtension.swift
//  SwiftDemoProject
//
//  Created by champ on 2020/5/7.
//  Copyright © 2020 champ. All rights reserved.
//

import UIKit

extension UIImageView {
    
    /// 创建图片
    static func pj_imageView( rad:CGFloat = 0, color:UIColor = .white) ->UIImageView{
        let imageV = UIImageView()
        imageV.backgroundColor = color
        imageV.contentMode = .scaleAspectFill
        if rad > 0 {
            imageV.layer.cornerRadius = rad
        }
        imageV.clipsToBounds = true
        return imageV
    }
    
}
