//
//  AttributeController.swift
//  SwiftDemoProject
//
//  Created by champ on 2020/6/22.
//  Copyright © 2020 champ. All rights reserved.
//

import UIKit


class AttributeController: PJBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "富文本以及富文本点击"
        let  label = UILabel()

        view.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.left.top.equalTo(50);
            make.bottom.right.equalTo(-50);
        };

        let a: AttributedString = .init("123",
                                        .background(.blue),
                                        .color(.white),
                                        .font(.systemFont(ofSize: 29))
        )
        let b: AttributedString = .init("456", .background(.red))
        let c: AttributedString = .init("链接",
                                        .color(.blue),
                                        .underline(.single),
                                        .action {
                                            print("点击了l链接")
            }
        )

        label.attributed.text = a+b+c
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
