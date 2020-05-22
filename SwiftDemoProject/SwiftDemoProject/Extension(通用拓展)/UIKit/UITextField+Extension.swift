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

// MARK: *********** 给textfield 最大输入个数 **********
extension UITextField{
    
   private struct textFieldFMaxCountKey {
       static let maxCountKey = UnsafeRawPointer.init(bitPattern: "maxCountKey".hashValue)
       /// ...其他Key声明
   }
   /// 最大输入个数
    var maxLength: Int? {
       set {
        objc_setAssociatedObject(self, UITextField.textFieldFMaxCountKey.maxCountKey!, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        
            self.addTarget(self, action: #selector(action_textEditChanged), for: .editingChanged)
       }
       get {
        return objc_getAssociatedObject(self, UITextField.textFieldFMaxCountKey.maxCountKey!) as? Int
       }
   }

   /// 点击编辑回调
   @objc private func action_textEditChanged() {
  
    //判断是不是在拼音状态,拼音状态不截取文本
    if let positionRange = self.markedTextRange{
        guard self.position(from: positionRange.start, offset: 0) != nil else {
            checkTextFieldText()
            return
        }
    }else {
        checkTextFieldText()
    }
    
   }
    
    /// 检测如果输入数高于设置最大输入数则截取
    private func checkTextFieldText(){
        guard (self.text?.utf16.count)! <= maxLength!  else {
            guard let text = self.text else {
                return
            }
            /// emoji的utf16.count是2，所以不能以maxTextNumber进行截取，改用text.count-1
            let sIndex = text.index(text
                .startIndex, offsetBy: text.count-1)
            self.text = String(text[..<sIndex])
            return
        }
    }
    
}

// MARK: *********** textfield 限制的枚举 **********
extension UITextField {
    
    enum LimitLType {
        case numberLetter  // 只能输入数字和字母
        case sum           // 输入金额
    }
    
    
    


}


