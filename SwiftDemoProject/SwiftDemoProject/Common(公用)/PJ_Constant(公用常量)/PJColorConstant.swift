//
//  PJColorConstant.swift
//  SwiftDemoProject
//
//  Created by champ on 2020/5/8.
//  Copyright © 2020 champ. All rights reserved.
//

import Foundation

// 白色
let PwhiteColor = UIColor.colorWithHex(hexColor: 0xFFFFFF)

// scrollView 的背景色
let PBackgroudColor = UIColor.colorWithHex(hexColor: 0xF2F4F6)

let P33COLOR = UIColor.colorWithHex(hexColor: 0x333333)

let P66COLOR = UIColor.colorWithHex(hexColor: 0x666666)

let P99COLOR = UIColor.colorWithHex(hexColor: 0x999999)

let PEECOLOR = UIColor.colorWithHex(hexColor: 0xEEEEEE)

let PF5COLOR = UIColor.colorWithHex(hexColor: 0xF5F5F5)

let PFBCOLOR = UIColor.colorWithHex(hexColor: 0xFBC02D)

let P24COLOR = UIColor.colorWithHex(hexColor: 0x247FB6)

let PF6COLOR = UIColor.colorWithHex(hexColor: 0xF6AC19)

let P98COLOR = UIColor.colorWithHex(hexColor: 0x9B711D)

/// 设置颜色
/// - Parameter color: 0x333333
func PJ_Color(color:Int64) -> UIColor {
    return UIColor.colorWithHex(hexColor: color)
}

