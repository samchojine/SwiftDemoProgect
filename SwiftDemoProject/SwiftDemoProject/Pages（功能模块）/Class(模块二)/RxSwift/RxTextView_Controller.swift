//
//  RxTextView_Controller.swift
//  SwiftDemoProject
//
//  Created by champ on 2020/7/2.
//  Copyright © 2020 champ. All rights reserved.
//

import UIKit

class RxTextView_Controller: PJBaseViewController {

    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let textView = UITextView()
        textView.backgroundColor = .lightText
        textView.placeholder = "请输入内容"
        
        view.addSubview(textView)
        textView.snp.makeConstraints { (make) in
             make.left.equalTo(10)
             make.top.equalTo(100)
             make.width.equalTo(200)
             make.height.equalTo(150)
         }
        
        
        //开始编辑响应
        textView.rx.didBeginEditing
            .subscribe(onNext: {
                print("开始编辑")
            })
            .disposed(by: disposeBag)

        //结束编辑响应
        textView.rx.didEndEditing
            .subscribe(onNext: {
                print("结束编辑")
            })
            .disposed(by: disposeBag)

        //内容发生变化响应
        textView.rx.didChange
            .subscribe(onNext: {

                print("内容发生改变:\(textView.text!)")
            })
            .disposed(by: disposeBag)

        //选中部分变化响应
        textView.rx.didChangeSelection
            .subscribe(onNext: {
                print("选中部分发生变化")
            })
            .disposed(by: disposeBag)
        
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
