//
//  UserManager.swift
//  SwiftDemoProject
//
//  Created by champ on 2020/6/9.
//  Copyright © 2020 champ. All rights reserved.
//

import UIKit

class UserManager: NSObject {
    
    static let userSaveKey = "userSaveKey"
    static let shared = UserManager()
    
    
    var user: UserModel?  {
        
        get{
          
          let model =  UserDefaults.standard.value(forKey: UserManager.userSaveKey)
            return model as? UserModel
        }
        set {
            
            let data = NSKeyedArchiver.archivedData(withRootObject: newValue as Any)
            UserDefaults.standard.set(data, forKey: UserManager.userSaveKey)
        }
    }
    
    // 存取token
    var token:String {
        
        get{
            return self.user?.token ?? ""
        }
        set {
           let model =  self.user
            model?.token = newValue
            self.user  = model
        }
    }
    
    


}
