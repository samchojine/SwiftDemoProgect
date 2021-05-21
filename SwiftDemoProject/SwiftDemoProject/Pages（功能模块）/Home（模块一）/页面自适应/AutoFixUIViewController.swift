//
//  AutoFixUIViewController.swift
//  SwiftDemoProject
//
//  Created by fwn on 2021/1/5.
//  Copyright © 2021 champ. All rights reserved.
//

import UIKit

class AutoFixUIViewController: ZYBaseStackViewController {

    lazy var headerV: AutoFixView = {
       let v = AutoFixView()
        return v
    }()
    
    lazy var tagV: AutoFixTagView = {
       let v = AutoFixTagView()
        return v
    }()
    
    lazy var answerV: AutoFixanswerView = {
       let v = AutoFixanswerView()
        return v
    }()
    
    lazy var hidBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("隐藏/显示", for: .normal)
        btn.backgroundColor = UIColor.blue
        btn.addClickAction { (btn) in
            btn.isSelected = !btn.isSelected
            
            self.tagV.isHidden = btn.isSelected
 
            
        }
        return btn
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()


        // 添加头部
        self.stackV.addArrangedSubview(headerV)
        
        // 添加tag
        self.stackV.addArrangedSubview(tagV)
        
        // 添加答复
        self.stackV.addArrangedSubview(answerV)
        
        view.addSubview(self.hidBtn);
        self.hidBtn.snp.makeConstraints { (make) in
            make.bottom.equalTo(-100);
            make.right.equalTo(-10);
            make.height.equalTo(50);
            make.width.equalTo(80)
        }
        
        // 模仿网络请求
        showLoading()
        DispatchQueue.main.asyncAfter(deadline: 1.5, execute: { [weak self] in
            self?.dismissHud()
            
            let arr = ["gdgsg","dfgdg","的分公司大股东广东省","的覆盖单身公害太皇太后让他如何","格","当官的风格","当官的风格","当风格","格","当官的风格","当官的风格"]
            self?.tagV.configData(arr)
            self?.answerV.configData(["当官的风格","风格","当官格","当官的风格"]);
            
        })
        
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
