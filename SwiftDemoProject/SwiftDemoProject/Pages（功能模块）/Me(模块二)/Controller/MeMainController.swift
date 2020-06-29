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
   
        let  label = UITextField()
        view.addSubview(label);
        label.backgroundColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 12);
        label.frame = CGRect(x: 20, y: 100, width: 250, height: 60)
        label.placeholder = "你好啊"
        label.filter = UITextField.filterName.numberAndLetter
        label.maxLength = 15
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
