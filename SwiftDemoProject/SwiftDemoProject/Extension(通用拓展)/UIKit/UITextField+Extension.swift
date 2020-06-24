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
extension UITextField :UITextFieldDelegate{
    
    enum LimitType:Int {
        // 电话号码
        case phone = 1
        // 密码
        case psw
        // 金额
        case amount
    }
    
    struct filterName{
        // 键盘只能输入纯数字
        static let onlyNumber = "^[0-9]+$"
        // 键盘只能输入中文
        static let onlyChinese = "^[\\u4e00-\\u9fa5]{0,}$"
        // 键盘只能输入字母
        static let onlyLetter = "^[A-Za-z]+$"
        // 键盘只能输入数字和字母
        static let numberAndLetter = "^[0-9A-Za-z]+$"
        // 键盘输入金额
        static let amount = "(^(0??|[1-9]\\d{0,19})([.]\\d{0,2})?)$"
    }
    
    private struct tfFitterRuntimeKey {
        static let tfFitter = UnsafeRawPointer.init(bitPattern: "tfFitter".hashValue)
        static let tfFitterLimit = UnsafeRawPointer.init(bitPattern: "tfFitterLimit".hashValue)
        static let tfFitterLength = UnsafeRawPointer.init(bitPattern: "tfFitterLength".hashValue)
        /// ...其他Key声明
    }
    
    // 过滤器，填入正则
    var filter: String? {
        
        set {
            objc_setAssociatedObject(self, UITextField.tfFitterRuntimeKey.tfFitter!, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
            self.delegate = self
        }
        get {
            return objc_getAssociatedObject(self, UITextField.tfFitterRuntimeKey.tfFitter!) as? String
        }
    }
    
    // 输入框类型
    var limitType: LimitType? {
        
        set {
            objc_setAssociatedObject(self, UITextField.tfFitterRuntimeKey.tfFitterLimit!, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
            self.delegate = self
            self.limitConfig(type: limitType)
        }
        get {
            return objc_getAssociatedObject(self, UITextField.tfFitterRuntimeKey.tfFitterLimit!) as? LimitType
        }
    }
    
    // 最大输入长度
    var maxLength: Int? {
        
        set {
            objc_setAssociatedObject(self, UITextField.tfFitterRuntimeKey.tfFitterLength!, newValue, .OBJC_ASSOCIATION_ASSIGN)
            self.delegate = self
        }
        get {
            return objc_getAssociatedObject(self, UITextField.tfFitterRuntimeKey.tfFitterLength!) as? Int
        }
    }
    
    private func limitConfig(type:LimitType?){
        
        if (type != nil) {
            
            if type == .phone {
                self.keyboardType = .numberPad
                self.maxLength = 11
            }else if type  == .psw {
                self.keyboardType = .asciiCapable
                self.filter = UITextField.filterName.numberAndLetter
            }else if type  == .amount {
                self.keyboardType = .decimalPad
                self.filter = UITextField.filterName.amount
            }
        
        }
        
    }
    
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        
        let str = (textField.text! as NSString).replacingCharacters(in: range, with: string)//获取输入框接收到的文字
        
        //限制长度
        var boolArr:[Bool] = [];
        if self.maxLength != nil {
          let lengthBool = authWithLength(textField, range: range, string: string)
          boolArr.append(lengthBool)
        }
        
        /// 优先判断输入框类型
        if (self.limitType != nil) {
           let limitTypeBool = authWithFitter(filter: self.filter!, getStr: str)
            boolArr.append(limitTypeBool)
        }
        
        /// 在判断是否有过滤器l
        if (self.filter != nil) {
          let filterBool = authWithFitter(filter: self.filter!, getStr: str)
            boolArr.append(filterBool)
        }
        
        var canThrough = true
        // 只要有一个条件不满足就不通过
        for b in boolArr {
            if b == false {
                canThrough = false
                break
            }
        }
        
        return canThrough
    }
    
    
    
    private func authWithLength(_ textField: UITextField, range: NSRange, string: String) ->Bool {
        let proposeLength = (textField.text?.lengthOfBytes(using: String.Encoding.utf8))! - range.length + string.lengthOfBytes(using: String.Encoding.utf8)
        if proposeLength > self.maxLength! {
            return false
        }
        return true
    }
    
    private func authWithFitter(filter:String, getStr:String) ->Bool {
        let regex = try! NSRegularExpression(pattern: filter, options: .allowCommentsAndWhitespace)//生成NSRegularExpression实例
        let numberOfMatches = regex.numberOfMatches(in: getStr, options:.reportProgress, range: NSMakeRange(0, (getStr as NSString).length))//获取匹配的个数
        return numberOfMatches != 0//如果匹配数量为0则表示不符合输入要求
    }
    
}

