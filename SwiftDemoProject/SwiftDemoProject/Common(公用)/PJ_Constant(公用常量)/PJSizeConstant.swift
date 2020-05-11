//
//  PJSizeConstant.swift
//  SwiftDemoProject
//
//  Created by champ on 2020/5/8.
//  Copyright © 2020 champ. All rights reserved.
//

import Foundation

///Screen
let PScreenBounds = UIScreen.main.bounds
let PScreenWidth = UIScreen.main.bounds.size.width
let PScreenHeight = UIScreen.main.bounds.size.height

///比例 已6s的4.7尺寸的屏幕为基准
let PWidthRatio = PScreenWidth / 375.0
let PHeightRatio = PScreenHeight / 667.0

///导航栏高度
let PNaviHeight : CGFloat = 44

///状态栏高度
let PStatusHeight = UIApplication.shared.statusBarFrame.height

/// 头部高度
let PTopHeight = (PNaviHeight + PStatusHeight)

/// tabebar高度
let PTabebarHeight = 49 + PBottomSafeInset

/// 底部安全距离
var PBottomSafeInset :CGFloat {
    
    var bottomH: CGFloat = 0.0
    if #available(iOS 11.0, *) {
        bottomH = CGFloat((UIApplication.shared.delegate?.window?!.safeAreaInsets.bottom)!)
    }
    return bottomH
}


///  修复约束，适配尺寸
func PFixWidth(value:CGFloat) -> CGFloat {
    
    return value*PWidthRatio

}
