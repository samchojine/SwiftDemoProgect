//
//  PJ_ViewExtension.swift
//  SwiftDemoProject
//
//  Created by champ on 2020/5/7.
//  Copyright © 2020 champ. All rights reserved.
//

import UIKit

extension UIView {
    
    /// 创建背景view
    static func pj_bgView(color:UIColor? = .white) -> UIView{
        let view = UIView()
        view.backgroundColor = color
        return view
    }
    
    
    
    
}



// MARK: *********** 计算属性 **********

extension UIView {
    
    var pj_height : CGFloat {
        set {
            frame.size.height = newValue
        }
        get {
            return frame.size.height
        }
    }
    
    var pj_width : CGFloat {
        set {
            frame.size.width = newValue
        }
        get {
            return frame.size.width
        }
    }
    
    var pj_size: CGSize {
        get {
            return frame.size
        }
        set {
            pj_width = newValue.width
            pj_height = newValue.height
        }
    }
    
    var pj_x: CGFloat {
        get {
            return frame.origin.x
        }
        set {
            frame.origin.x = newValue
        }
    }
    
    var pj_y: CGFloat {
        get {
            return frame.origin.y
        }
        set {
            frame.origin.y = newValue
        }
    }
    
    var pj_centerX : CGFloat {
        get {
            return self.pj_x + self.pj_width * 0.5
        }
        set {
            self.pj_x = newValue - self.pj_width * 0.5
        }
    }
    
    var pj_centerY : CGFloat {
        get {
            return self.pj_y + self.pj_height * 0.5
        }
        set {
            self.pj_y = newValue - self.pj_height * 0.5
        }
    }
    
    var pj_centerPoint : CGPoint {
        get {
            return CGPoint.init(x: self.pj_x + self.pj_width * 0.5, y: self.pj_y + self.pj_height * 0.5)
        }
        set {
            self.pj_x = newValue.x - self.pj_width * 0.5
            self.pj_y = newValue.y - self.pj_height * 0.5
        }
    }
    
}




