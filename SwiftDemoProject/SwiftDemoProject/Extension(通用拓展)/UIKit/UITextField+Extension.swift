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
    
    /// 设置左边间距
    func addLeftPadding(_ space:CGFloat = 10) {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: space, height: 1))
        self.leftViewMode = .always
        self.leftView = view
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


// MARK: *********** 给textfield 添加过滤器 **********
extension UITextField{
    
    enum LimitType:Int {
        // 电话号码
        case phone = 1
        // 密码
        case psw
        // 金额
        case amount
    }
    
    struct TextFieldfitterName{
        // 键盘只能输入纯数字
        static let number = ""
        // 键盘只能输入数字和字母
        static let numberAndLetter = ""
        // 键盘输入金额
        static let amount = ""
    }
    
    private struct tfFitterRuntimeKey {
        static let tfFitter = UnsafeRawPointer.init(bitPattern: "tfFitter".hashValue)
        static let tfFitterLimit = UnsafeRawPointer.init(bitPattern: "tfFitterLimit".hashValue)
        /// ...其他Key声明
    }
    
    var fitter: String? {
        
        set {
            objc_setAssociatedObject(self, UITextField.tfFitterRuntimeKey.tfFitter!, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, UITextField.tfFitterRuntimeKey.tfFitter!) as? String
        }
    }
    
    var limitType: LimitType? {
        
        set {
            objc_setAssociatedObject(self, UITextField.tfFitterRuntimeKey.tfFitterLimit!, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, UITextField.tfFitterRuntimeKey.tfFitterLimit!) as? LimitType
        }
    }
    
    
}

