//
//  Date+Extension.swift
//  TheOptimal
//
//  Created by Jxiongzz on 2020/4/3.
//  Copyright © 2020 ZhiYou. All rights reserved.
//

import Foundation

extension Date {
    
    /// 获取当前时间戳 秒级 10位
    func getTimeStamp() -> Int{
        let timeInterval: TimeInterval = self.timeIntervalSince1970
        return Int(timeInterval)
    }
    
    /// 获取当前时间戳 毫秒级 13位
    func getMilliStamp() -> CLongLong{
        let timeInterval: TimeInterval = self.timeIntervalSince1970
        let millisecond = CLongLong(round(timeInterval*1000))
        return millisecond
    }
}
