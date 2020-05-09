//
//  HomeMainController.swift
//  SwiftDemoProject
//
//  Created by champ on 2020/4/30.
//  Copyright © 2020 champ. All rights reserved.
//

import UIKit


class HomeMainController: PJBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "主页";
        view.backgroundColor = UIColor.lightGray;
        navigationItem.rightBarButtonItem =  UIBarButtonItem(title: "随机色", style: .plain, target: self, action: #selector(action_goNext))
      
        
    }
    
    @objc func action_goNext() {
        
        self.navigationController?.pushViewController(PJCustomNaviColorController(),
                                                      animated: true);
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
