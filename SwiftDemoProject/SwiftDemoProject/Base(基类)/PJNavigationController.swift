//
//  PJNavigationController.swift
//  SwiftDemoProject
//
//  Created by champ on 2020/4/30.
//  Copyright © 2020 champ. All rights reserved.
//

import UIKit

class PJNavigationController: UINavigationController {

        override func viewDidLoad() {
            super.viewDidLoad()

            // 设置左右item的颜色
            let item = UIBarButtonItem.appearance()
            item.tintColor = UIColor.darkText;
            
            // 设置导航栏背景的颜色
            let  naviBar = UINavigationBar.appearance();
            naviBar.barTintColor = UIColor.white;
            naviBar.isTranslucent = false;
            
            // 设置导航栏标题颜色
            naviBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.darkText,
                                           NSAttributedString.Key.font:UIFont .systemFont(ofSize: 20, weight: .medium)]
            // 隐藏分割线
            naviBar.shadowImage = UIImage()
            
            // 设置手势代理
            self.interactivePopGestureRecognizer!.delegate = self;
            
        }
        
        
       // 在重写pop的方法设置push后隐藏底部栏
        override func pushViewController(_ viewController: UIViewController, animated: Bool) {
            
            if self.viewControllers.count > 0 {
                viewController.hidesBottomBarWhenPushed = true;
            }
            
            super.pushViewController(viewController, animated: animated)
        }
    
    
    // 重写这两个方法 不然状态栏设置不了颜色
    override var childForStatusBarHidden: UIViewController? {
        return self.topViewController
    }
    
    override var childForStatusBarStyle: UIViewController? {
        return self.topViewController
    }
    

        
    }


    extension PJNavigationController: UIGestureRecognizerDelegate {
        
        
        func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
            
            if self.viewControllers.count <= 1 {
                return false
            }
            
            return true;
        }
        
    }

