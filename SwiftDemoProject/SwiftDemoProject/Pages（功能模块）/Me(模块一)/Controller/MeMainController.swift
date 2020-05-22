//
//  MeMainController.swift
//  SwiftDemoProject
//
//  Created by champ on 2020/4/30.
//  Copyright © 2020 champ. All rights reserved.
//

import UIKit

<<<<<<< HEAD
class MeMainController: PJBaseViewController{
=======
class MeMainController: PJBaseViewController,UITextFieldDelegate {
>>>>>>> ce08e318a74ac0c94ebaaae3e3c6a12834aa392c

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "我的";
   
        let  label = UITextField()
        view.addSubview(label);
        label.backgroundColor = .red
        label.font = UIFont.systemFont(ofSize: 12);
        label.frame = CGRect(x: 20, y: 100, width: 250, height: 60)
        label.placeholder = "你好啊"
<<<<<<< HEAD
//        label.placeholderColor = .red
//        label.delegate = self


        
        
        label.textDidEditChanged { (tf) in
            print("tf-=-=-=-=\(tf.text)")
        }
=======
        //label.placeholderColor = .red
        
        label.limitType = .psw
        label.maxLength = 15
        
       // label.delegate = self
        
    }
    
   func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
     {
       print("-=-=-=-=\(string)")
        return true
>>>>>>> ce08e318a74ac0c94ebaaae3e3c6a12834aa392c
    }
    

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    
}
