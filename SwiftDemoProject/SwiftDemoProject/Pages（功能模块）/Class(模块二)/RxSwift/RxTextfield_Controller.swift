//
//  RxTextfield_Controller.swift
//  SwiftDemoProject
//
//  Created by champ on 2020/7/2.
//  Copyright © 2020 champ. All rights reserved.
//

import UIKit

class RxTextfield_Controller: PJBaseViewController {

    let disposeBag = DisposeBag()
    
    var textField1:UITextField!
    var textField2:UITextField!
    var label:UILabel!
    var btn:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //创建文本输入框
        textField1 = UITextField(frame: CGRect(x:10, y:80, width:200, height:30))
        textField1.borderStyle = UITextField.BorderStyle.roundedRect
        view.addSubview(textField1)
        
        textField2 = UITextField(frame: CGRect(x:10, y:130, width:200, height:30))
        textField2.borderStyle = UITextField.BorderStyle.roundedRect
        view.addSubview(textField2)
        
        label = UILabel(frame: CGRect(x: 10, y: 180, width: 300, height: 30))
        view.addSubview(label)
        
        btn = UIButton(frame: CGRect(x: 10, y: 230, width: 300, height: 40))
        btn.backgroundColor = .blue
        btn.setTitle("提交", for: .normal)
        btn .setBackgroundImage(UIImage(color: .blue), for: .selected)
        btn.setBackgroundImage(UIImage(color: .gray), for: .normal)
        view.addSubview(btn)
        

        
        printfLog()
        
       // followChange()
        
       // conbine()
        
       // obseverEvent()
    }
    
    
    // MARK: *******  当文本框内容改变时，将内容输出到控制台上  ****************
    func printfLog() {
        // 方法一
        textField1.rx.text.orEmpty.asObservable()
            .subscribe(onNext: {
                print("您输入的是：\($0)")
            })
            .disposed(by: disposeBag)
        
        // 方法二
        //        textField1.rx.text.orEmpty.changed
        //            .subscribe(onNext: {
        //                print("您输入的是：\($0)")
        //            })
        //        .disposed(by: disposeBag)
        
    }
    
    
    func followChange() {
        //当文本框内容改变
        let input = textField1.rx.text.orEmpty.asDriver() // 将普通序列转换为 Driver
            .throttle(0.3) //在主线程中操作，0.3秒内值若多次改变，取最后一次
        input.drive(textField2.rx.text).disposed(by: disposeBag)
        input.map{ "当前字数：\($0.count)" }
            .drive(label.rx.text)
            .disposed(by: disposeBag)
        
        //根据内容字数决定按钮是否可用
        input.map{ $0.count > 5 }
            .drive(btn.rx.isSelected)
            .disposed(by: disposeBag)
    }
    
    func conbine() {
        
        // MARK: ******* 同时监听两个textField ****************
        Observable.combineLatest(textField1.rx.text.orEmpty, textField2.rx.text.orEmpty) {
            textValue1, textValue2 -> String in
            return "你输入的号码是：\(textValue1)-\(textValue2)"
        }
        .map { $0 }
        .bind(to: label.rx.text)
        .disposed(by: disposeBag)
    }
    
    
    // MARK: *******  事件监听  **************
    func obseverEvent() {
        
         /*
          editingDidBegin：开始编辑（开始输入内容）
          editingChanged：输入内容发生改变
          editingDidEnd：结束编辑
          editingDidEndOnExit：按下 return 键结束编辑
          allEditingEvents：包含前面的所有编辑相关事件
          */
         
         //在用户名输入框中按下 return 键
         textField1.rx.controlEvent(.editingDidBegin).subscribe(onNext: {
            print("开始编辑")
         }).disposed(by: disposeBag)
          
          //在密码输入框中按下 return 键
        textField2.rx.controlEvent(.editingChanged).subscribe(onNext: {
            print("正在编辑\($0)")
         }).disposed(by: disposeBag)
    }



}
