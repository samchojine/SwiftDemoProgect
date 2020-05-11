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

// MARK: *********** 给textfield 添加输入框文字改变的时候的回调 **********
extension UITextField{
    
   typealias TFDidEditChanged = (_ textfield:UITextField) -> Void
    
   private struct tFRuntimeKey {
       static let editChangeBlock = UnsafeRawPointer.init(bitPattern: "editChangeBlock".hashValue)
       /// ...其他Key声明
   }
   /// 运行时关联
   private var tfEditChangeBlock: TFDidEditChanged? {
       set {
        objc_setAssociatedObject(self, UITextField.tFRuntimeKey.editChangeBlock!, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
       }
       get {
        return objc_getAssociatedObject(self, UITextField.tFRuntimeKey.editChangeBlock!) as? TFDidEditChanged
       }
   }

   /// 点击编辑回调
   @objc private func action_editChanged() {
      tfEditChangeBlock?(self)

   }
    
   /// 添加点击事件
   func textDidEditChanged( action:@escaping TFDidEditChanged ) {
    self.addTarget(self, action: #selector(action_editChanged), for: .editingChanged)
    tfEditChangeBlock = action
    
   }

}

