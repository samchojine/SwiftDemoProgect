//
//  UITextField+Extension.swift
//  TheOptimal
//
//  Created by Jxiongzz on 2020/2/11.
//  Copyright © 2020 ZhiYou. All rights reserved.
//

import UIKit

extension UITextField {
   
    /// 设置holder颜色  请在设置完placeholder后再设置颜色
    var placeholderColor: UIColor {
        get {
            if #available(iOS 13.0, *) {
                return .placeholderText
            } else {
                return .lightText
            }
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "",attributes: [
                NSAttributedString.Key.foregroundColor:newValue])
        }
    }
    
}
