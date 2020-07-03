//
//  AutoLabelController.swift
//  SwiftDemoProject
//
//  Created by champ on 2020/6/22.
//  Copyright © 2020 champ. All rights reserved.
//

import UIKit

class AutoLabelController:  HomeMainController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "自适应宽度标签"
        datas = [
            (title:"tagView + tableViewCell",vc:TagViewController.self),
            (title:"使用collectionView",vc:collectionTagController.self),
        ]
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
