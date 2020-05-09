//
//  View+Extension.swift
//  CustomPackageTool
//
//  Created by Emma Sun on 2019/8/2.
//  Copyright © 2019 Shushangyun. All rights reserved.
//

import UIKit

extension UIView {
    //截图
    func klc_captureToImage() -> UIImage {
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
    
    //获取当前view所在的控制器
    func klc_getController() -> UIViewController? {
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
    
    //获取superView
    func klc_findSuperViewWithCondition(_ condition:(UIView?) -> Bool) -> UIView? {
        if condition(superview){
            return superview
        }
        return self.superview?.klc_findSuperViewWithCondition(condition)
    }
    
    //获取superView
    func klc_firstSuperViewWithClass<T:UIView>(className:T.Type) -> T?{
        return self.klc_findSuperViewWithCondition({ (view) -> Bool in
            return (view is T)
        }) as? T
    }
    
}


//MARK: Draw
extension UIView {
    //添加圆角
    func klc_cornerbyRoundingCorners(corners: UIRectCorner, radii: CGFloat) {
        DispatchQueue.main.asyncAfter(deadline: .now()+0, execute: {//延时0秒让进程进入下一个runloop获取到真正的frame（使用约束时也可以获取到真实的frame）
            let view = self;
            let maskPath = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radii, height: radii))
            let maskLayer = CAShapeLayer()
            maskLayer.frame = view.bounds
            maskLayer.path = maskPath.cgPath
            view.layer.mask = maskLayer
            
        })
    }
    
    
    ///  整个tableview section 添加圆角
    func addCornerbyRoundingCorners(radii: CGFloat = 8.0, indexPath:IndexPath, tableView:UITableView) {
        let count =  tableView.numberOfRows(inSection: indexPath.section)
        
        if count == 0 {
            return
        }
        
        if count == 1 {
            self.klc_cornerbyRoundingCorners(corners: UIRectCorner.allCorners, radii: radii)
            return;
        }
        
        if indexPath.row == 0 {
            self.klc_cornerbyRoundingCorners(corners: [.topLeft, .topRight], radii: radii)
        }else if indexPath.row == count - 1 {
            self.klc_cornerbyRoundingCorners(corners: [.bottomLeft,.bottomRight], radii: radii)
        }else{
            self.klc_cornerbyRoundingCorners(corners: UIRectCorner.allCorners, radii: 0)
        }
       
    }
    
    /// 添加渐变色 startPoint & endPoint设置为(0,0)(1.0,0)代表水平方向渐变,(0,0)(0,1.0)代表竖直方向渐变
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
    
    //添加阴影
    func klc_addShawdow(color:UIColor = UIColor.black.withAlphaComponent(0.7),
                    radius:CGFloat = 3,
                    offSet:CGSize = CGSize(width: 0, height: 0),
                    opacity:Float = 0.7){
        let view = self
        view.layer.shadowColor = color.cgColor
        view.layer.shadowRadius = radius
        view.layer.shadowOffset = offSet
        view.layer.shadowOpacity = opacity
    }
    
    //边框
    func klc_addBorder(color:UIColor = UIColor.black,width:CGFloat = 1){
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }
}

//MARK: Layout-Perproties
extension UIView {
    
    var klc_height : CGFloat {
        set {
            frame.size.height = newValue
        }
        get {
            return frame.size.height
        }
    }
    
    var klc_width : CGFloat {
        set {
            frame.size.width = newValue
        }
        get {
            return frame.size.width
        }
    }
    
    var klc_size: CGSize {
        get {
            return frame.size
        }
        set {
            klc_width = newValue.width
            klc_height = newValue.height
        }
    }
    
    var klc_x: CGFloat {
        get {
            return frame.origin.x
        }
        set {
            frame.origin.x = newValue
        }
    }
    
    var klc_y: CGFloat {
        get {
            return frame.origin.y
        }
        set {
            frame.origin.y = newValue
        }
    }
    
    var klc_centerX : CGFloat {
        get {
            return self.klc_x + self.klc_width * 0.5
        }
        set {
            self.klc_x = newValue - self.klc_width * 0.5
        }
    }
    
    var klc_centerY : CGFloat {
        get {
            return self.klc_y + self.klc_height * 0.5
        }
        set {
            self.klc_y = newValue - self.klc_height * 0.5
        }
    }
    
    var klc_centerPoint : CGPoint {
        get {
            return CGPoint.init(x: self.klc_x + self.klc_width * 0.5, y: self.klc_y + self.klc_height * 0.5)
        }
        set {
            self.klc_x = newValue.x - self.klc_width * 0.5
            self.klc_y = newValue.y - self.klc_height * 0.5
        }
    }
    
}

//MARK: Layout-Method
extension UIView {
    /// get safeAreaInsets
    ///
    /// CGFloat height = kDefaultTopViewHeight; // 导航栏原本的高度，通常是44.0
    /// height += safeAreaInsets.top > 0 ? safeAreaInsets.top : 20.0; // 20.0是statusbar的高度
    /// notice:when controller`s view not load , the safeAreaInsets could be zero
    func klc_getSafeAreaInsets() -> UIEdgeInsets{
        let view = self
        if #available(iOS 11.0, *){
            return view.safeAreaInsets;
        }
        return .zero;
    }
    
    func klc_insureAddToController(_ controller : UIViewController){
        if self.superview == nil {
            controller.view.addSubview(self)
        }
        else if self.superview! != controller.view {
            self.removeFromSuperview()
            controller.view.addSubview(self)
        }
    }
    
    /// 将一个view加到controller.view上, 并且铺满整个controller
    func klc_coverController(_ controller:UIViewController,
                             inset:UIEdgeInsets = .zero,
                             extendBottom:Bool = false,
                             extendTop:Bool = false)
    {
        let subView = self;
        subView.klc_insureAddToController(controller)
        subView.translatesAutoresizingMaskIntoConstraints = false;
        let left = NSLayoutConstraint.init(item: subView, attribute: .left, relatedBy: .equal, toItem: controller.view, attribute: .left, multiplier: 1, constant: inset.left)
        let right = NSLayoutConstraint.init(item: subView, attribute: .right, relatedBy: .equal, toItem: controller.view, attribute: .right, multiplier: 1, constant: -inset.right)
        self.klc_addConstraintToControllerBottom(controller,extend:extendBottom)
        self.klc_addConstraintsToControllerTop(controller,extend:extendTop)
        controller.view.addConstraints([left,right])
    }
    
    /// 将一个view加到controller.view上, 并且铺满整个controller
    ///
    /// - Parameters:
    ///   - controller:
    ///   - inset: 边距padding
    ///   - extendBottom: 是否延伸出safeArea 默认false
    ///   - topAnchor: 顶部参照，需要已经布局到底部，如果存在，会以该view的bottom作为参照。
    ///   最常见的应用场景就是页面顶部上有一个segment选择，要根据这个控件来铺满余下的
    ///   使用的时候请先布局好topAnchor , 将自身加入到controller的view中
    func klc_coverControllerWithTopAnchor(controller:UIViewController,
                             inset:UIEdgeInsets = .zero,
                             extendBottom:Bool = false,
                             topAnchor:UIView)
    {
        let subView = self;
        subView.klc_insureAddToController(controller)
        subView.translatesAutoresizingMaskIntoConstraints = false;
        let left = NSLayoutConstraint.init(item: subView, attribute: .left, relatedBy: .equal, toItem: controller.view, attribute: .left, multiplier: 1, constant: inset.left)
        let right = NSLayoutConstraint.init(item: subView, attribute: .right, relatedBy: .equal, toItem: controller.view, attribute: .right, multiplier: 1, constant: -inset.right)
        let top = NSLayoutConstraint(item: subView, attribute: .top, relatedBy: .equal, toItem: topAnchor, attribute: .bottom, multiplier: 1, constant: inset.top)
        
        //make bottom constraint
        self.klc_addConstraintToControllerBottom(controller,extend:extendBottom)
        
        controller.view.addConstraints([left,right,top])
    }
    
    
    /// 将一个view加到controller.view上, 并且铺满整个controller
    ///
    /// - Parameters:
    ///   - controller:
    ///   - inset: 边距padding
    ///   - extendTop: 是否延伸出safeArea 默认false
    ///   - bottomAnchor: 底部参照，需要已经布局到底部，如果存在，会以该view的top作为参照
    ///   最常见的应用场景就是页面最底下有一个按钮，要根据这个按钮来布局
    ///   使用的时候请先布局好bottomAnchor , 将自身加入到controller的view中
    func klc_coverControllerWithBottomAnchor(controller:UIViewController,
                         inset:UIEdgeInsets = .zero,
                         extendTop:Bool = false,
                         bottomAnchor:UIView)
    {
        let subView = self;
        subView.klc_insureAddToController(controller)
        subView.translatesAutoresizingMaskIntoConstraints = false;
        let left = NSLayoutConstraint.init(item: subView, attribute: .left, relatedBy: .equal, toItem: controller.view, attribute: .left, multiplier: 1, constant: inset.left)
        let right = NSLayoutConstraint.init(item: subView, attribute: .right, relatedBy: .equal, toItem: controller.view, attribute: .right, multiplier: 1, constant: -inset.right)
        let bottom = NSLayoutConstraint.init(item: subView, attribute: .bottom, relatedBy: .equal, toItem: bottomAnchor, attribute: .top, multiplier: 1, constant: -inset.bottom)
        //make top constraint
        self.klc_addConstraintsToControllerTop(controller,extend:extendTop)
       
        controller.view.addConstraints([left,right,bottom])
    }
    
    
    //跟顶部加一个约束
    func klc_addConstraintsToControllerTop(_ controller:UIViewController,space:CGFloat = 0,extend:Bool = false){
        let view = self;
        if view.superview != controller.view{
            return
        }
        
        view.translatesAutoresizingMaskIntoConstraints = false;
        var top : NSLayoutConstraint
        if extend {
            top =  NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: controller.view, attribute: .top, multiplier: 1, constant: space)
        }
        else {
            if #available(iOS 11.0, *) {
                top =  NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: controller.view.safeAreaLayoutGuide, attribute: .top, multiplier: 1, constant: space)
            }
            else {
                top =  NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: controller.topLayoutGuide, attribute: .bottom, multiplier: 1, constant: space)
            }
        }
        controller.view.addConstraint(top);
    }
    
    //跟底部加一个约束
    func klc_addConstraintToControllerBottom(_ controller:UIViewController,
                                             space:CGFloat = 0,
                                             extend:Bool = false)
    {
        let view = self;
        if view.superview != controller.view{
            return
        }
        view.translatesAutoresizingMaskIntoConstraints = false;
        var bottomConstraint : NSLayoutConstraint

        if extend {
            bottomConstraint = NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal, toItem: controller.view, attribute: .bottom, multiplier: 1, constant: space)
        }
        else {
            /*
             if #available(iOS 11.0, *){
             maker.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottomMargin)
             }
             else {
             maker.bottom.equalTo(self.bottomLayoutGuide.snp.top)
             }
             */
            if #available(iOS 11.0, *) {
                bottomConstraint =  NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal, toItem: controller.view.safeAreaLayoutGuide, attribute: .bottom, multiplier: 1, constant: space)
            }
            else {
                bottomConstraint =  NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal, toItem: controller.bottomLayoutGuide, attribute: .top, multiplier: 1, constant: space)
            }
        }
        controller.view.addConstraint(bottomConstraint);
    }
    
    
    
    @available(iOS 9, *)
    
    /// 铺满父视图
    ///
    /// - Parameter inset: inset
    func klc_coverToSuperView(inset:UIEdgeInsets = .zero){
        if let superview = self.superview {
            self.translatesAutoresizingMaskIntoConstraints = false
            let left = leftAnchor.constraint(equalTo: superview.leftAnchor,constant: inset.left)
            let right = rightAnchor.constraint(equalTo: superview.rightAnchor,constant: -inset.right)
            let top = topAnchor.constraint(equalTo: superview.topAnchor,constant: inset.top)
            let bottom = bottomAnchor.constraint(equalTo: superview.bottomAnchor,constant: -inset.bottom)
            NSLayoutConstraint.activate([left, right, top, bottom])
        }
    }

    
}
