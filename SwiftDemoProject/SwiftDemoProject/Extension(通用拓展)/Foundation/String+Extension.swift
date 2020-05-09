//
//  String+Extension.swift
//  TheOptimal
//
//  Created by Jxiongzz on 2020/2/17.
//  Copyright © 2020 ZhiYou. All rights reserved.
//

import UIKit

// MARK: ***********   获取文字高度    **********
extension String{
    
    /// 计算文字的size
    func calculateHeightWithFontSize(fontSize:CGFloat,width:CGFloat) -> CGSize{
        let size = (self as NSString).boundingRect(with: CGSize(width: width, height: CGFloat.greatestFiniteMagnitude), options: [.usesLineFragmentOrigin], attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: fontSize)], context: nil)
        return size.size
    }
    
    /// 计算文字的宽度
    func calculateWidthWithFont(_ font:UIFont) -> CGFloat {
        let size = (self as NSString).boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: 50), options: [.usesLineFragmentOrigin], attributes: [NSAttributedString.Key.font:font], context: nil)
        return size.width
    }
    
    /// 计算文字的高度
    func calculateHeightWithFontSize(_ fontSize:CGFloat,width:CGFloat) -> CGFloat {
        let size = (self as NSString).boundingRect(with: CGSize(width: width, height: CGFloat.greatestFiniteMagnitude), options: [.usesLineFragmentOrigin], attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: fontSize)], context: nil)
        return size.height
    }
    
}



