//
//  RxSwiftController.swift
//  SwiftDemoProject
//
//  Created by champ on 2020/7/2.
//  Copyright © 2020 champ. All rights reserved.
//

import UIKit

class RxSwiftController:  HomeMainController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "RxSwift的学习"
       datas = [
           (title:"label的应用",             vc:RxLabel_Controller.self),
           (title:"textField的应用",         vc:RxTextfield_Controller.self),
           (title:"textView的应用",          vc:RxTextView_Controller.self),
           (title:"button,slider,segment",   vc:RxButton_Controller.self),
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
