//
//  UserModel.swift
//  SwiftDemoProject
//
//  Created by champ on 2020/6/9.
//  Copyright © 2020 champ. All rights reserved.
//

import UIKit
import HandyJSON

class UserModel:NSObject, HandyJSON,NSCoding{

    struct modelKey {
        static let userName    = "userName"
        static let imagePath   = "imagePath"
        static let phone       = "phone"
        static let token       = "token"
    }
    
    var userName:String  = ""
    var imagePath:String = ""
    var phone:String = ""
    var token:String = ""
    
    
    init(dict: [String: Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
    func encode(with coder: NSCoder) {
        coder.encode(userName, forKey: modelKey.userName)
        coder.encode(imagePath, forKey: modelKey.imagePath)
        coder.encode(phone, forKey: modelKey.phone)
        coder.encode(token, forKey: modelKey.token)
    }
    
    required init?(coder: NSCoder) {
        userName = coder.decodeObject(forKey: modelKey.userName) as! String
        imagePath = coder.decodeObject(forKey: modelKey.imagePath) as! String
        phone = coder.decodeObject(forKey: modelKey.phone) as! String
        token = coder.decodeObject(forKey: modelKey.token) as! String
    }
    
    required override init() {
        super.init()
    }

}
