//
//  UITextView+ Extension.swift
//  SwiftDemoProject
//
//  Created by champ on 2020/5/9.
//  Copyright © 2020 champ. All rights reserved.
//

import UIKit


// MARK: *********** 给textView 添加 placeholder **********
extension UITextView : NSTextStorageDelegate{
    
    @IBInspectable
    // 给 textView 添加 placeHolder
    var placeholder: String {
        get {
            return subviews.compactMap( { $0 as? PlaceholderLabel }).first?.text ?? ""
        }
        set {
            let placeholderLabel = self.placeholderLabel
            placeholderLabel.text = newValue
            placeholderLabel.numberOfLines = 0
            let width = frame.width - textContainer.lineFragmentPadding * 2
            let size = placeholderLabel.sizeThatFits(CGSize(width: width, height: .greatestFiniteMagnitude))
            placeholderLabel.frame.size.height = size.height
            placeholderLabel.frame.size.width = width
            placeholderLabel.frame.origin = CGPoint(x: textContainer.lineFragmentPadding, y: textContainerInset.top)

            textStorage.delegate = self
        }
    }
    
    // 给 textView 添加 placeHolder 颜色
    var placeholderColor: UIColor {
        
        get {
            return subviews.compactMap( { $0 as? PlaceholderLabel }).first?.textColor ?? UIColor(displayP3Red: 204/256.0, green: 204/256.0, blue: 204/256.0, alpha: 1)
        }
        set {
            self.placeholderLabel.textColor = newValue
        }
    }
    
    
    private class PlaceholderLabel: UILabel { }

    private var placeholderLabel: PlaceholderLabel {
        if let label = subviews.compactMap( { $0 as? PlaceholderLabel }).first {
            return label
        } else {
            let label = PlaceholderLabel(frame: .zero)
            label.font = self.font ?? UIFont.systemFont(ofSize: 10)
            if #available(iOS 13.0, *) {
                label.textColor =  .placeholderText
            } else {
                label.textColor =  UIColor(displayP3Red: 204/256.0, green: 204/256.0, blue: 204/256.0, alpha: 1)
            }
            addSubview(label)
            return label
        }
    }

    
    public func textStorage(_ textStorage: NSTextStorage, didProcessEditing editedMask: NSTextStorage.EditActions, range editedRange: NSRange, changeInLength delta: Int) {
        if editedMask.contains(.editedCharacters) {
            placeholderLabel.isHidden = !text.isEmpty
        }
    }
    
    open override func layoutSubviews() {
        
        let width = frame.width - textContainer.lineFragmentPadding * 2
            let size = placeholderLabel.sizeThatFits(CGSize(width: width, height: .greatestFiniteMagnitude))
            placeholderLabel.frame.size.height = size.height
            placeholderLabel.frame.size.width = width
            placeholderLabel.frame.origin = CGPoint(x: textContainer.lineFragmentPadding, y: textContainerInset.top)
    }

}


// MARK: *********** 给textView 添加输入框文字改变的时候的回调 **********
extension UITextView:UITextViewDelegate{
    
   typealias TVEditChangedBlock = (_ textView:UITextView) -> Void
    
   private struct tVRuntimeKey {
       static let editChangeBlock = UnsafeRawPointer.init(bitPattern: "editChangeBlock".hashValue)
       /// ...其他Key声明
   }
   /// 运行时关联
   private var tvEditChangeBlock: TVEditChangedBlock? {
       set {
        objc_setAssociatedObject(self, UITextView.tVRuntimeKey.editChangeBlock!, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
       }
       get {
        return objc_getAssociatedObject(self, UITextView.tVRuntimeKey.editChangeBlock!) as? TVEditChangedBlock
       }
   }


   /// 添加j监听回调
   func textDidEditChanged( action:@escaping TVEditChangedBlock ) {
    self.delegate = self
    tvEditChangeBlock = action
    
   }
    
    public func textViewDidChange(_ textView: UITextView) {
        tvEditChangeBlock?(textView)
    }

}
