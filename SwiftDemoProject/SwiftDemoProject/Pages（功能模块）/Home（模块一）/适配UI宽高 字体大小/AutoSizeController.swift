//
//  AutoSizeController.swift
//  SwiftDemoProject
//
//  Created by champ on 2020/6/22.
//  Copyright © 2020 champ. All rights reserved.
//

import UIKit

class AutoSizeController: PJBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "适配UI宽高，字体大小"
        
        print("this is " +
            "default"
            .i35("3.5 inches (iPhone 4, 4s)")
            .i40("3.5 inches (iPhone 5, 5s, SE)")
            .i47("3.5 inches (iPhone 6, 7, 8)")
            .i55("3.5 inches (iPhone 6, 7, 8 Plus)")
            .ifull("full screen (iPhone X, Xs, XsMax)")
            .i58full("5.8 inches (iPhone X, Xs)")
            .i61full("6.1 inches (iPhone XR)")
            .i65full("6.5 inches (iPhone XsMax)")
        )

        view.addSubview(label1)
        view.addSubview(label2)
        view.addSubview(label3)
        
        label1.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.top.equalTo(50)
            make.height.equalTo(80.auto())
        }
        
        label2.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.top.equalTo(label1.snp.bottom).offset(1.auto())
            make.height.equalTo(label1)
        }
        
        label3.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.top.equalTo(label2.snp.bottom).offset(1.auto())
            make.height.equalTo(80.i35(80).i55(200))
        }
    
    }
    
    
    lazy var label1: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14.auto())
        label.text = "测试文字大小适配"
        label.cornerRadius = 10.auto()
        label.backgroundColor = .randomColor
        return label
    }()
    
    lazy var label2: UILabel = {
        let label = UILabel()
         label.backgroundColor = .randomColor
        return label
    }()
    
    lazy var label3: UILabel = {
        let label = UILabel()
        label.backgroundColor = .randomColor
        return label
    }()
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
