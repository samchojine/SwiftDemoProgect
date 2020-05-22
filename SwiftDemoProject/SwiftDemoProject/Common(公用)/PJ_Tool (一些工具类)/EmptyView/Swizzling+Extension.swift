//
//  Swizzling+Extension.swift
//  SwiftDemoProject
//
//  Created by champ on 2020/5/19.
//  Copyright © 2020 champ. All rights reserved.
//

import UIKit

/*
   swift 中 没有了 +load() 这个方法，现在给系统增加一个，方便runtime方法交换的时候使用
*/

protocol SelfAware: class {
    // 相当于 oc中的 +load()
    static func awake()
    static func swizzlingForClass(_ forClass: AnyClass, originalSelector: Selector, swizzledSelector: Selector)
}

extension SelfAware {
    // 添加交换方法
    static func swizzlingForClass(_ forClass: AnyClass, originalSelector: Selector, swizzledSelector: Selector) {
        let originalMethod = class_getInstanceMethod(forClass, originalSelector)
        let swizzledMethod = class_getInstanceMethod(forClass, swizzledSelector)
        guard (originalMethod != nil && swizzledMethod != nil) else {
            return
        }
        if class_addMethod(forClass, originalSelector, method_getImplementation(swizzledMethod!), method_getTypeEncoding(swizzledMethod!)) {
            class_replaceMethod(forClass, swizzledSelector, method_getImplementation(originalMethod!), method_getTypeEncoding(originalMethod!))
        } else {
            method_exchangeImplementations(originalMethod!, swizzledMethod!)
        }
    }
}

class NothingToSeeHere {
    static func harmlessFunction() {
        let typeCount = Int(objc_getClassList(nil, 0))
        let types = UnsafeMutablePointer<AnyClass>.allocate(capacity: typeCount)
        let autoreleasingTypes = AutoreleasingUnsafeMutablePointer<AnyClass>(types)
        objc_getClassList(autoreleasingTypes, Int32(typeCount))
        for index in 0 ..< typeCount {
            (types[index] as? SelfAware.Type)?.awake()
        }
        types.deallocate()
    }
}
extension UIApplication {
    private static let runOnce: Void = {
        NothingToSeeHere.harmlessFunction()
    }()
    override open var next: UIResponder? {
        UIApplication.runOnce
        return super.next
    }
}
