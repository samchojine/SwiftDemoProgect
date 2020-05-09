//
//  PJLabel+Extension.swift
//  SwiftDemoProject
//
//  Created by champ on 2020/5/7.
//  Copyright © 2020 champ. All rights reserved.
//

import UIKit

extension UILabel{
    
    /// 创建一个默认的label

    static func baseLabel(text:String? = "",
                                   font:CGFloat? = 14,
                                   fontWeight:UIFont.Weight? = .regular,
                                   textColor:UIColor? = .darkText,
                                   textAlignment:NSTextAlignment? = .left) -> UILabel{
        let label = UILabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize:font!, weight: fontWeight!)
        label.textAlignment = textAlignment!
        label.textColor = textColor
        return label
    }
    
    

    
    
}
