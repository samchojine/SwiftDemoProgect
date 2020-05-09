//
//  Color+Extension.swift
//  TheOptimal
//
//  Created by Jxiongzz on 2020/2/10.
//  Copyright © 2020 ZhiYou. All rights reserved.
//

import UIKit

extension UIColor {
    
    /// 16进制颜色
    /// hexColor: 0x333333
    static func colorWithHex(hexColor:Int64) -> UIColor {
        let red = ((CGFloat)((hexColor & 0xFF0000) >> 16))/255.0;
        let green = ((CGFloat)((hexColor & 0xFF00) >> 8))/255.0;
        let blue = ((CGFloat)(hexColor & 0xFF))/255.0;
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
    
    /// 16进制颜色
    /// hexColor: 0x333333
    /// alpha: 透明度
    static func colorWithHex(hexColor:Int64,alpha:CGFloat) -> UIColor {
        let red = ((CGFloat)((hexColor & 0xFF0000) >> 16))/255.0;
        let green = ((CGFloat)((hexColor & 0xFF00) >> 8))/255.0;
        let blue = ((CGFloat)(hexColor & 0xFF))/255.0;
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    
    /// 返回随机颜色
     class var randomColor: UIColor {
         get {
             let red = CGFloat(arc4random()%256)/255.0
             let green = CGFloat(arc4random()%256)/255.0
             let blue = CGFloat(arc4random()%256)/255.0
             return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
         }
     }
}
