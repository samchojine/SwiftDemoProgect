//
//  PJTabBarController.swift
//  SwiftDemoProject
//
//  Created by champ on 2020/4/30.
//  Copyright © 2020 champ. All rights reserved.
//

import UIKit

class PJTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configSubControllers()
    }
    

    func configSubControllers(){
        
        //首页
        let home = HomeMainController();
        //框架
        let frame = ClassMainController();
        //我的
        let mine = MeMainController();

        let controllers = [home,frame,mine];

        let titles = ["库","框架","我的"];

        let selectedImageNames = ["tab_Item_icon_01_selected",
                                  "tab_Item_icon_01_selected",
                                  "tab_Item_icon_05_selected"];

        let normalImageNames = ["tab_Item_icon_01_normal",
                                "tab_Item_icon_01_selected",
                                "tab_Item_icon_05_normal"];
        
        var naviContainer : [PJNavigationController] = [];
        
        for i in 0..<titles.count{
            let controller = controllers[i];
            let baseNavi = PJNavigationController(rootViewController: controller);
            baseNavi.tabBarItem = self.createTabItem(title: titles[i], normalImgName:normalImageNames[i] , selectedImgName: selectedImageNames[i]);
            naviContainer.append(baseNavi);
        }
        
        self.setViewControllers(naviContainer, animated: false)
    }
    
    
    
    func createTabItem(title:String?,
                       normalImgName:String?,
                       selectedImgName:String?,
                       unselectTitleColor:UIColor = UIColor.lightGray,
                       selectedTitleColor:UIColor = UIColor.black) -> UITabBarItem {
        
        let normalImg = UIImage(named: normalImgName!)?.withRenderingMode(.alwaysOriginal)
        let selectImg = UIImage(named: selectedImgName!)?.withRenderingMode(.alwaysOriginal)
        let tabbar =  UITabBarItem(title: title, image:normalImg, selectedImage: selectImg);
        let normalAttri = [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 13),
                           NSAttributedString.Key.foregroundColor:unselectTitleColor]
        tabbar.setTitleTextAttributes(normalAttri, for: .normal)
        
        let selectedAttri = [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 13),
                             NSAttributedString.Key.foregroundColor:selectedTitleColor]
        tabbar.setTitleTextAttributes(selectedAttri, for: .selected)
        
        
        //iOS 13 badge value font 会变成17号字体
        tabbar.setBadgeTextAttributes([NSAttributedString.Key.font:UIFont.systemFont(ofSize: 13)], for: .normal)
        tabbar.setBadgeTextAttributes([NSAttributedString.Key.font:UIFont.systemFont(ofSize: 13)], for: .selected)
        
        //iOS 13 选中的颜色 需要调用如下
        tabBar.tintColor = UIColor.black
        
        return tabbar;
    }
    

    
}



