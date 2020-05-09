//
//  UILabel+Extension.swift
//  TheOptimal
//
//  Created by Jxiongzz on 2020/2/10.
//  Copyright © 2020 ZhiYou. All rights reserved.
//

import UIKit

extension UILabel{
    
    /// 创建一个默认的label
    ///
    /// - Parameters:
    ///   - text: 显示的内容
    ///   - font: 字体大小,默认14
    ///   - textColor: 字体颜色，默认K33COLOR
    ///   - textAlignment: 对齐方向，默认左对齐
    /// - Returns: label
    static func createNoamalLabel(text:String? = "",
                                  font:CGFloat? = 14,
                                  textColor:UIColor? = K33COLOR,
                                  textAlignment:NSTextAlignment? = .left) -> UILabel{
        let label = UILabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize: font!)
        label.textAlignment = textAlignment!
        label.textColor = textColor
        return label
    }
    
    //
    static func baseLabel(text:String? = "",
                                   font:CGFloat? = 14,
                                   fontWeight:UIFont.Weight? = .regular,
                                   textColor:UIColor? = K33COLOR,
                                   textAlignment:NSTextAlignment? = .left) -> UILabel{
        let label = UILabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize:font!, weight: fontWeight!)
        label.textAlignment = textAlignment!
        label.textColor = textColor
        return label
    }
    
    
    func addMoneyAttr(money:String? = "",color:UIColor? = KF6COLOR) {
        
        let attrStr = "¥".addAttributes(.font(.systemFont(ofSize: 12)), .color(color!)).append(money!.addAttributes(.color(color!),.font(UIFont.systemFont(ofSize: 16, weight: .bold))))
        self.attributedText = attrStr
    }
    
    func adddeleteLineAttr(money:String = "",color:UIColor? = K99COLOR){
        
        let attrStr = money.addAttributes(.font(.systemFont(ofSize: 10)), .color(color!),.strikethrough(.single))
        self.attributedText = attrStr
        
    }
    
    
}
