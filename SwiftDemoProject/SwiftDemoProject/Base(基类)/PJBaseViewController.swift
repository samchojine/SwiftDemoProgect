//
//  PJBaseViewController.swift
//  SwiftDemoProject
//
//  Created by champ on 2020/4/30.
//  Copyright © 2020 champ. All rights reserved.
//

import UIKit

class PJBaseViewController: UIViewController {
    
    enum NaviType {
        case typeDefaut    // 白底 黑字
        case typeDark      // 深色底 白字 (第二主题色)
    }
    
    enum NaviContentType {
        case white    // 子控件内容为  白色
        case black    // 子控件内容为  黑色
    }
    
    // MARK:-设置导航栏类型
    var naviType:NaviType = .typeDefaut

    // MARK:-设置状态栏文字颜色
    var statusBarStyle:UIStatusBarStyle = .default {
        didSet {
             self.setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    // MARK:-设置左按钮的颜色
    var leftItemColor:UIColor = .darkText {
        didSet {
            self.navigationItem.leftBarButtonItem?.tintColor = leftItemColor
        }
    }
    
    // MARK:-设置右按钮的颜色
    var rightItemColor:UIColor = .darkText {
        didSet {
            self.navigationItem.rightBarButtonItem?.tintColor = rightItemColor
        }
    }
    
    // MARK:-设置标题颜色
    var naviTitleColor:UIColor = .darkText {
        didSet {
            self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:naviTitleColor]
        }
    }
    
    // MARK:-设置导航栏背景色
    var naviBgColor:UIColor = .white {
        didSet {
            navigationController?.navigationBar.barTintColor = naviBgColor
        }
    }
    
    // MARK:-设置导航栏子控件整体内容颜色
    var naviContentType:NaviContentType = .black {
        
        didSet {
            if self.naviContentType == .white {
                self.statusBarStyle = .lightContent
                self.leftItemColor = .white
                self.rightItemColor = .white
                self.naviTitleColor = .white
            }else {
                self.statusBarStyle = .default
                self.leftItemColor = .darkText
                self.rightItemColor = .darkText
                self.naviTitleColor = .darkText
            }
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // 默认白色背景
        view.backgroundColor = UIColor.white
        
        // 设置返回图片
        if self.navigationController!.viewControllers.count > 1 {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "navi_icon_back_black"), style: .plain, target: self, action: #selector(action_back))
        }
    }
    
     override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 默认导航栏不透明
        navigationController?.navigationBar.isTranslucent = false
        // 默认导航栏不隐藏
        navigationController?.setNavigationBarHidden(false, animated: animated)
        
        // 设置导航栏样式
        if naviType == .typeDefaut {
            naviContentType = .black
            statusBarStyle  = .default
            naviBgColor     = .white
        }else if naviType == .typeDark {
            naviContentType = .white
            statusBarStyle = .lightContent
            naviBgColor    = .red
        }else{
            statusBarStyle = .default
            navigationController?.navigationBar.barTintColor  = naviBgColor
        }
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return statusBarStyle
    }
    
    @objc func action_back() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
