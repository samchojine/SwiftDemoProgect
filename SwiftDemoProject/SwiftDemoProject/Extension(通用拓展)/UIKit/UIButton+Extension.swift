//
//  UIButton+Extension.swift
//  TheOptimal
//
//  Created by Jxiongzz on 2020/2/10.
//  Copyright © 2020 ZhiYou. All rights reserved.
//

import UIKit



extension UIButton{
    
     // MARK: -调整按钮图片的上左下右
    enum LCButtonEdgeInsetsStyle {
        case Top  //图片上
        case Left
        case Right
        case Bottom
    }
    
    func positionTitleAndImage(style: LCButtonEdgeInsetsStyle, imageTitleSpace: CGFloat) {
        DispatchQueue.main.asyncAfter(deadline: .now()+0, execute: {
            let button = self;
            //得到imageView和titleLabel的宽高
            let imageWidth = button.imageView?.frame.size.width
            let imageHeight = button.imageView?.frame.size.height
            
            var labelWidth: CGFloat! = 0.0
            var labelHeight: CGFloat! = 0.0
            if  let versionNumber = Double(UIDevice.current.systemVersion) , versionNumber > 8.0 {
                // 由于iOS8中titleLabel的size为0，用下面的这种设置
                labelWidth = button.titleLabel?.intrinsicContentSize.width
                labelHeight = button.titleLabel?.intrinsicContentSize.height
            }
            else {
                labelWidth = button.titleLabel?.frame.size.width
                labelHeight = button.titleLabel?.frame.size.height
            }
            
            //初始化imageEdgeInsets和labelEdgeInsets
            var imageEdgeInsets = UIEdgeInsets.zero
            var labelEdgeInsets = UIEdgeInsets.zero
            
            //根据style和space得到imageEdgeInsets和labelEdgeInsets的值
            switch style {
            case .Top:
                //上 左 下 右
                imageEdgeInsets = UIEdgeInsets(top: -labelHeight-imageTitleSpace/2, left: 0, bottom: 0, right: -labelWidth)
                labelEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth!, bottom: -imageHeight!-imageTitleSpace/2, right: 0)
                break;
                
            case .Left:
                imageEdgeInsets = UIEdgeInsets(top: 0, left: -imageTitleSpace/2, bottom: 0, right: imageTitleSpace)
                labelEdgeInsets = UIEdgeInsets(top: 0, left: imageTitleSpace/2, bottom: 0, right: -imageTitleSpace/2)
                break;
                
            case .Bottom:
                imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: -labelHeight!-imageTitleSpace/2, right: -labelWidth)
                labelEdgeInsets = UIEdgeInsets(top: -imageHeight!-imageTitleSpace/2, left: -imageWidth!, bottom: 0, right: 0)
                break;
                
            case .Right:
                imageEdgeInsets = UIEdgeInsets(top: 0, left: labelWidth+imageTitleSpace/2, bottom: 0, right: -labelWidth-imageTitleSpace/2)
                labelEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth!-imageTitleSpace/2, bottom: 0, right: imageWidth!+imageTitleSpace/2)
                break;
                
            }
            
            button.titleEdgeInsets = labelEdgeInsets
            button.imageEdgeInsets = imageEdgeInsets
        })
    }
    
    // MARK: -按钮倒计时
    public func startCountDown(count: Int,countDownBgColor:UIColor){
           // 倒计时开始,禁止点击事件
           isEnabled = false
           // 保存当前的背景颜色
           let defaultColor = self.backgroundColor
           // 设置倒计时,按钮背景颜色
           backgroundColor = countDownBgColor
           var remainingCount: Int = count {
               willSet {
                   titleLabel?.text = "\(newValue)s"
                   setTitle("\(newValue)s", for: .normal)
                   if newValue <= 0 {
                       titleLabel?.text = "发送验证码"
                       setTitle("发送验证码", for: .normal)
                   }
               }
           }
           // 在global线程里创建一个时间源
           let codeTimer = DispatchSource.makeTimerSource(queue:DispatchQueue.global())
           // 设定这个时间源是每秒循环一次，立即开始
           codeTimer.schedule(deadline: .now(), repeating: .seconds(1))
           // 设定时间源的触发事件
           codeTimer.setEventHandler(handler: {
               // 返回主线程处理一些事件，更新UI等等
               DispatchQueue.main.async {
                   // 每秒计时一次
                   remainingCount -= 1
                   // 时间到了取消时间源
                   if remainingCount <= 0 {
                       self.backgroundColor = defaultColor
                       self.isEnabled = true
                       codeTimer.cancel()
                   }
               }
           })
           // 启动时间源
           codeTimer.resume()
       }
    
    // MARK: -设置统一按钮的图片和文字颜色
    func setTitleImageColor(color:UIColor) {
        let image = self.imageView?.image
        self.setImage(image?.withRenderingMode(.alwaysTemplate), for: .normal)
        self.imageView?.tintColor = color
        self.setTitleColor(color, for: .normal)
    }
    
}


// MARK: *********** 给button添加点击回调 **********
extension UIButton{
    
    typealias buttonClick = (_ btn:UIButton) -> Void
    
   private struct HWRuntimeKey {
       static let actionBlock = UnsafeRawPointer.init(bitPattern: "actionBlock".hashValue)
       /// ...其他Key声明
   }
   /// 运行时关联
   private var actionBlock: buttonClick? {
       set {
           objc_setAssociatedObject(self, UIButton.HWRuntimeKey.actionBlock!, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
       }
       get {
           return objc_getAssociatedObject(self, UIButton.HWRuntimeKey.actionBlock!) as? buttonClick
       }
   }

   /// 点击回调
   @objc private func tapped(button:UIButton) {
       actionBlock?(button)

   }
   /// 添加点击事件
   func addClickAction( action:@escaping buttonClick) {
       addTarget(self, action:#selector(tapped(button:)) , for:.touchUpInside)
       actionBlock = action
   }

}


