//
//  File.swift
//  SwiftDemoProject
//
//  Created by champ on 2020/5/9.
//  Copyright © 2020 champ. All rights reserved.
//

import Foundation

// 标题
let PTitleFont = PJ_MediumFont(size:16)

// 详情
let PDetailFont = PJ_RegularFont(size:14)

// 输入框占位符
let PPlaceHolderFont = PJ_RegularFont(size:12)

///  常规
func PJ_RegularFont(size:CGFloat) -> UIFont {
    return UIFont.systemFont(ofSize: size, weight: .regular)
}

///  中
func PJ_MediumFont(size:CGFloat) -> UIFont {
    return UIFont.systemFont(ofSize: size, weight: .medium)
}

///  粗体
func PJ_BoldFont(size:CGFloat) -> UIFont {
    return UIFont.systemFont(ofSize: size, weight: .bold)
}
