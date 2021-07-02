//
//  View+MBHUD.swift
//  TheOptimal
//
//  Created by champ on 2020/3/9.
//  Copyright © 2020 ZhiYou. All rights reserved.
//

import UIKit
import MBProgressHUD


extension UIView {
    
    typealias Completion = ()->Void
    
    /// 只加载文字
    func showText(text:String){
        self.showHud(text:text)
    }
    
    /// 只加菊花
    func showLoading(){
        self.showHud(load:true)
    }
    
    /// 只加菊花 +不透明背景
    func showOpacityLoading(){
        self.showHud(maskColor: .white, load:true)
    }
    
    /// 只加菊花 +文字
    func showLoadingAndText(text:String){
        self.showHud(text:text,load:true)
    }
    
    /// 只加菊花 +不透明背景 +不透明背景
    func showOpacityLoadingAndText(text:String){
        self.showHud(text:text,maskColor: .white,load:true)
    }
    
    /// 成功 + 消失后的回调
    func showSuccess(text:String,compete:Completion? = nil){
        self.showHud(text:text,icon:"hud_icon_success", compelete:compete)
    }
    
    /// 失败+ 消失后的回调
    func showError(text:String,compete:Completion? = nil){
        self.showHud(text:text,icon:"hud_icon_error", compelete:compete)
    }
    /// 警示 + 消失后的回调
    func showInfo(text:String,compete:Completion? = nil){
        self.showHud(text:text,icon:"hud_icon_info", compelete:compete)
    }

    // 消失
    func dismissHud() {
        MBProgressHUD.hide(for: self, animated: false)
    }
    
    private  func showHud(text:String? = "",icon:String = "",maskColor:UIColor? = .clear,delay:CGFloat = 1.5,load:Bool? = false,compelete:Completion? = nil){
        
        MBProgressHUD.hide(for: self, animated: false)
        let hud =  MBProgressHUD.showAdded(to: self, animated: true)
        hud.detailsLabel.font = UIFont.systemFont(ofSize: 16)
        hud.removeFromSuperViewOnHide = true
        hud.detailsLabel.text = text
        hud.backgroundColor = maskColor
        hud.bezelView.style = .solidColor
        hud.bezelView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        
        UIActivityIndicatorView.appearance(whenContainedInInstancesOf:
            [MBProgressHUD.self]).color = UIColor.white
        
        if load == false {
            hud.mode = .text
        }
        
        if !icon.isEmpty {
            hud.customView = UIImageView(image: UIImage(named: icon))
            hud.mode = .customView
        }
        
        hud.detailsLabel.textColor = UIColor.white
    
        if delay > 0.0 && load == false {
            hud.hide(animated: true, afterDelay: TimeInterval(delay))
        }
        
        hud.completionBlock = {
            compelete?()
        }
    }
}
