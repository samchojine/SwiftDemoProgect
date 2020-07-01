//
//  MeMainController.swift
//  SwiftDemoProject
//
//  Created by champ on 2020/4/30.
//  Copyright © 2020 champ. All rights reserved.
//

import UIKit



class MeMainController: PJBaseViewController,UITextFieldDelegate {


    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "我的";
   
        let  tf = UITextField()
        view.addSubview(tf);
        tf.backgroundColor = .lightGray
        tf.font = UIFont.systemFont(ofSize: 12);
        tf.frame = CGRect(x: 20, y: 100, width: 250, height: 60)
        tf.placeholder = "你好啊"
        tf.filter = UITextField.filterName.numberAndLetter
        tf.maxLength = 15
    }
    
   func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
     {
       print("-=-=-=-=\(string)")
        
        return true
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    
}
