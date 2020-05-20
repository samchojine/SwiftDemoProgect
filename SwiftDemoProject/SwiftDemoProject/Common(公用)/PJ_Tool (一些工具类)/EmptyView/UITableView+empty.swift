//
//  UITableView+empty.swift
//  SwiftDemoProject
//
//  Created by champ on 2020/5/18.
//  Copyright © 2020 champ. All rights reserved.
//

import UIKit

// MARK:- 添加empty属性
extension UITableView:SelfAware {
    
    private struct tvEmptyRuntimeKey {
        static let emptyKey = UnsafeRawPointer.init(bitPattern: "emptyKey".hashValue)
        static let isFirstTimeKey = UnsafeRawPointer.init(bitPattern: "isFirstTimeKey".hashValue)
        /// ...其他Key声明
    }
    
    /// 空视图属性
    var emptyView:UIView? {
        set {
            objc_setAssociatedObject(self, UITableView.tvEmptyRuntimeKey.emptyKey!, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, UITableView.tvEmptyRuntimeKey.emptyKey!) as? UIView
        }
    }
    
    /// 是不是第一次加载 初始化tableView的时候会reload一次
    var isfinish:Bool? {
        set {
            objc_setAssociatedObject(self, UITableView.tvEmptyRuntimeKey.isFirstTimeKey!, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
        get {
            return (objc_getAssociatedObject(self, UITableView.tvEmptyRuntimeKey.isFirstTimeKey!)as? Bool?)!
        }
    }
    
    // 与 reload data 交换的方法
    @objc func empty_reloadData() {
    self.empty_reloadData()
    self.checkEmpty()
    }
    
    private func checkEmpty() {
        // 如果没有设置空视图是不会加载的
        if emptyView == nil {
            return
        }
        
        // 初始化tableview 后系统会默认调用一次reload，但是数据没有下来，会导致提前出线空视图，所以要过滤掉第一次reload
        if (isfinish == nil) {
            isfinish = true
            return ;
        }
        
        DispatchQueue.main.async {
              
            let numberOfSection = self.numberOfSections
            var havingData:Bool = false
            
            for i in 0 ..< numberOfSection {
                if self.numberOfRows(inSection: i) > 0 {
                   havingData = true
                   break
                }
            }
            // tableView 调用reload之后，有分区有值就加，无值就remove
            if havingData == false {
                self.emptyView?.removeFromSuperview()
                self.addSubview(self.emptyView!)
            }else {
                self.emptyView?.removeFromSuperview()
            }
          }
    }
    
    
    // 进行方法交换
    static func awake() {
        UITableView.takeOnceTime
    }
    private static let takeOnceTime: Void = {
        let originalSelector = #selector(reloadData)
        let swizzledSelector = #selector(empty_reloadData)

        swizzlingForClass(UITableView.self, originalSelector: originalSelector, swizzledSelector: swizzledSelector)
    }()
    

}
