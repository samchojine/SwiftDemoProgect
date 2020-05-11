//
//  View+Extension.swift
//  CustomPackageTool
//
//  Created by Emma Sun on 2019/8/2.
//  Copyright © 2019 Shushangyun. All rights reserved.
//

import UIKit

extension UIView {
    
    // MARK: -截图
    func captureToImage() -> UIImage {
        let view = self;
        if #available(iOS 10.0, *) {
            let renderer = UIGraphicsImageRenderer(bounds: view.bounds)
            return renderer.image { rendererContext in
                view.layer.render(in: rendererContext.cgContext)
            }
        } else {
            UIGraphicsBeginImageContext(view.frame.size)
            view.layer.render(in:UIGraphicsGetCurrentContext()!)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return image!
        }
    }
    
    // MARK: -获取当前view所在的控制器
    func viewController() -> UIViewController? {
        let view = self
        var responder = view.next
        while responder != nil {
            if let controller =  responder as? UIViewController {
                return controller
            }
            responder = responder?.next
        }
        return nil
    }
    
    // MARK: -加载XIB第一个视图
    func loadViewFromBundle1st(view nibName:String) -> UIView {
        return ((Bundle.main.loadNibNamed(nibName, owner: nil, options: nil))?.first) as! UIView
    }
    
}


// MARK: *********** 绘制 边框 阴影 圆角 **********
extension UIView {
    
    // MARK: -添加贝塞尔圆角
    var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.masksToBounds = true
            self.layer.cornerRadius = newValue
        }
    }
    
    // MARK: -添加阴影
    func drawShawdow(color:UIColor = UIColor.black.withAlphaComponent(0.7),
                    radius:CGFloat = 3,
                    offSet:CGSize = CGSize(width: 0, height: 0),
                    opacity:Float = 0.7){
        let view = self
        view.layer.shadowColor = color.cgColor
        view.layer.shadowRadius = radius
        view.layer.shadowOffset = offSet
        view.layer.shadowOpacity = opacity
    }
    
    // MARK: -边框
    func drawBorder(color:UIColor = UIColor.black,width:CGFloat = 1){
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }
    
    // MARK: -添加贝塞尔圆角
    func drawBeizierCorner(corners: UIRectCorner, radius: CGFloat) {
        DispatchQueue.main.asyncAfter(deadline: .now()+0, execute: {//延时0秒让进程进入下一个runloop获取到真正的frame（使用约束时也可以获取到真实的frame）
            let view = self;
            let maskPath = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let maskLayer = CAShapeLayer()
            maskLayer.frame = view.bounds
            maskLayer.path = maskPath.cgPath
            view.layer.mask = maskLayer
            
        })
    }
    
    // MARK: -整个tableview section 添加圆角
    func drawTableSectionCorner(radius: CGFloat = 8.0, indexPath:IndexPath, tableView:UITableView) {
        let count =  tableView.numberOfRows(inSection: indexPath.section)
        
        if count == 0 {
            return
        }
        
        if count == 1 {
            self.drawBeizierCorner(corners: UIRectCorner.allCorners, radius: radius)
            return;
        }
        
        if indexPath.row == 0 {
            self.drawBeizierCorner(corners: [.topLeft, .topRight], radius: radius)
        }else if indexPath.row == count - 1 {
            self.drawBeizierCorner(corners: [.bottomLeft,.bottomRight], radius: radius)
        }else{
            self.drawBeizierCorner(corners: UIRectCorner.allCorners, radius: 0)
        }
       
    }
    
    // MARK: -添加渐变色 startPoint & endPoint设置为(0,0)(1.0,0)代表水平方向渐变,(0,0)(0,1.0)代表竖直方向渐变
    func addGradientColor(colors:[CGColor],startPoint:CGPoint,endPoint:CGPoint){
        DispatchQueue.main.asyncAfter(deadline: .now()+0, execute: {//延时0秒让进程进入下一个runloop获取到真正的frame（使用约束时也可以获取到真实的frame）
            let colorLayer = CAGradientLayer()
            colorLayer.frame = self.bounds
            colorLayer.startPoint = startPoint
            colorLayer.endPoint = endPoint
            colorLayer.colors = colors
            self.layer.insertSublayer(colorLayer, at: 0)
        })
    }
    

}



extension UIView{
    
   typealias ViewTapActon = (_ view:UIView) -> Void
    
   private struct viewRuntimeKey {
       static let tapBlock = UnsafeRawPointer.init(bitPattern: "actionBlock".hashValue)
       /// ...其他Key声明
   }
   /// 运行时关联
   private var actionBlock: ViewTapActon? {
       set {
        objc_setAssociatedObject(self, UIView.viewRuntimeKey.tapBlock!, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
       }
       get {
        return objc_getAssociatedObject(self, UIView.viewRuntimeKey.tapBlock!) as? ViewTapActon
       }
   }

   /// 点击回调
   @objc private func action_tapped() {
       actionBlock?(self)

   }
    
   // MARK: -给view添加点击回调
   func addTapAction( action:@escaping ViewTapActon) {
    
    self.isUserInteractionEnabled = true
    let tap = UITapGestureRecognizer(target: self, action: #selector(action_tapped))
    self.addGestureRecognizer(tap)
    actionBlock = action
    
   }

}





