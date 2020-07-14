//
//  HYPopView.swift
//  SwiftDemoProject
//
//  Created by champ on 2020/7/13.
//  Copyright © 2020 champ. All rights reserved.
//

import UIKit

class HYPopView: UIView {
    
    enum SlideDirection {
        case up
        case down
    }
    
    var containterHeight: CGFloat = 400
    var removeWhenHide: Bool = false
    var panGestureIsEnable: Bool = true
    
    private var scrollview:UIScrollView?
    
    private var slideDirection:SlideDirection?
    
    private lazy var panGesture: UIPanGestureRecognizer = {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(action_pan(_:)))
        pan.delegate = self
        return pan
    }()
    
    private lazy var maskV: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        v.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(action_tap))
        v.addGestureRecognizer(tap)
        return v
    }()
    
     lazy var containerView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.white
        v.isUserInteractionEnabled = true
        v.addGestureRecognizer(self.panGesture)
        return v
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        configSubView()
        
        for view in self.containerView.subviews {
            if view .isKind(of: UIScrollView.classForCoder()) {
                if let sv = view as?UIScrollView {
                    self.scrollview = sv
                }
            }
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        
        self.maskV.alpha = 0;
        
        addSubview(self.maskV)
        addSubview(self.containerView)
        
        self.maskV.frame = UIScreen.main.bounds
        self.containerView.frame = CGRect(x: 0, y: UIScreen.main.bounds.size.height, width: UIScreen.main.bounds.size.width, height:containterHeight)
    }
    
    func configSubView() {
        
        
    }
    
    func starShow() {
        
        var frame = self.containerView.frame
        frame.origin.y = self.frame.size.height - containterHeight;
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
            self.containerView.frame = frame;
            self.maskV.alpha = 1
        }, completion: { (finish) in
            
        })
    }
    
    func hide() {
        
        var frame = self.containerView.frame
        frame.origin.y = self.frame.size.height;
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
            self.containerView.frame = frame;
            self.maskV.alpha = 0
        }, completion: { (finish) in
            
            self.isHidden = true
            if self.removeWhenHide == true {
                self.removeFromSuperview()
            }
        })
        
    }
    
    @objc private func action_tap() {
        hide()
    }
    
    @objc private func action_pan(_ pan:UIPanGestureRecognizer) {
        
        if self.panGestureIsEnable == false {
            return
        }
        
        let offsetPoint = pan.translation(in: self)
        let velocity = pan.velocity(in: pan.view)
        let offsetX = abs(offsetPoint.x)
        let offsetY = abs(offsetPoint.y)
        
        if pan.state == .began {
            if velocity.y > 0 {
                slideDirection = .down
            }else {
                slideDirection = .up
            }
            
            
        }else if pan.state == .changed {
            
            if scrollview != nil && scrollview!.contentOffset.y <= 0 {
                self.scrollview?.contentOffset = CGPoint.zero
                self.scrollview?.panGestureRecognizer.isEnabled = false
            }
            
            // 如果手势是上下滑动，整个 View 才会跟着手势动
            if offsetY > offsetX {
                
                
                if scrollview != nil && scrollview!.contentOffset.y != 0 {
                    // 如果子类View存在scorllView, 必须回到顶部才能响应外部手势页面整体滑动
                    return
                }
                NSLog("_+_+_+_+_+%f", offsetPoint.y)
                var  frame = self.containerView.frame
                frame.origin.y += offsetPoint.y
                if frame.origin.y <= self.frame.size.height - containterHeight {
                    frame.origin.y = self.frame.size.height - containterHeight
                }
                self.containerView.frame = frame
               
               // 遮罩用渐变
                let alpha = (self.frame.size.height - frame.origin.y)/containterHeight
                self.maskV.alpha = alpha
            }
            
            pan.setTranslation(CGPoint.zero, in: self)
            
        }else if pan.state == .ended || pan.state == .cancelled {
            
            if velocity.y > 400 {
                if self.slideDirection == .down {
                    if scrollview != nil && scrollview?.contentOffset.y != 0  {
                        return;
                    }
                    hide()
                    return
                }
            }

            self.scrollview?.panGestureRecognizer.isEnabled = true
            // view的y值小于总高度的 ,直接hide
            if self.containerView.frame.origin.y >= self.frame.size.height - self.containterHeight + 200 {
                hide()
            }else {
                starShow()
            }
        }
    }
    
    
}


extension HYPopView:UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == self.panGesture {
            if otherGestureRecognizer.isKind(of: NSClassFromString("UIScrollViewPanGestureRecognizer")!) ||
                otherGestureRecognizer.isKind(of: UIPanGestureRecognizer.classForCoder()){
                if let view = otherGestureRecognizer.view {
                    if view.isKind(of: UIScrollView.classForCoder()) {
                        return true
                    }
                }
            }
        }
        return false
    }
    
}
