//
//  RxButton_Controller.swift
//  SwiftDemoProject
//
//  Created by champ on 2020/7/3.
//  Copyright © 2020 champ. All rights reserved.
//

import UIKit

class RxButton_Controller: PJBaseViewController {
    
    let disposeBag = DisposeBag()
    
    var btn:UIButton!
    var switchBtn:UISwitch!
    var segment:UISegmentedControl!
    var slider:UISlider!
    var label:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        creatUI()
        rx_btn()
        rx_switch()
        rx_segment()
        rx_slider()
        rx_Recognizer()
        
    }
    
    
    func creatUI() {
        
        btn = UIButton(frame: CGRect(10, 100, 100, 30))
        btn.backgroundColor = .red
        btn.setTitle("按钮", for: .normal)
        view.addSubview(btn)
        
        switchBtn = UISwitch()
        switchBtn.frame = CGRect(x: 10, y: btn.pj_bottom + 10, width: 100, height: 50)
        view.addSubview(switchBtn)
        
        segment = UISegmentedControl(items: ["1","2","3"])
        segment.frame = CGRect(x: 10, y: switchBtn.pj_bottom + 10, width: 100, height: 50)
        view.addSubview(segment)
        
        slider = UISlider()
        slider.frame = CGRect(10, segment.pj_bottom + 10, 100, 50)
        view.addSubview(slider)
        
        label = UILabel()
        label.frame = CGRect(10, slider.pj_bottom + 10, 100, 50)
        label.text = "sfsdfsfsfsdfsd"
        view.addSubview(label)
    }
    
    
    func rx_btn() {
        
        // 方法一
        btn.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.showText(text: "按钮被点击")
            })
            .disposed(by: disposeBag)
        
        
        // 方法二
        //        btn.rx.tap
        //            .bind { [weak self] in
        //                self?.showText(text: "按钮被点击")
        //        }
        //        .disposed(by: disposeBag)
        
        // 方法三
        btn.rx.controlEvent(.touchUpInside)
            .subscribe(onNext: { [weak self] in
                self?.showText(text: "按钮被点击")
            })
            .disposed(by: disposeBag)
        
    }
    
    func rx_switch() {
        
        switchBtn.rx.isOn.asObservable()
            .subscribe(onNext: {
                print("当前开关状态：\($0)")
            })
            .disposed(by: disposeBag)
    }
    
    func rx_segment() {
        
        //        segment.rx.selectedSegmentIndex.asObservable()
        //            .subscribe(onNext: {[weak self] (index) in
        //                self?.showText(text: "当选选择\(index)")
        //            })
        //        .disposed(by: disposeBag)
        
        segment.rx.controlEvent(.valueChanged).asObservable()
            .subscribe(onNext: {[weak self] in
                self?.showText(text: "当选选择\(self!.segment.selectedSegmentIndex)")
            })
            .disposed(by: disposeBag)
    }
    
    func rx_slider() {
        
        slider.rx.value.asObservable()
            .subscribe(onNext: { [weak self](value) in
                self?.showText(text: "当前的数组是\(value)")
            })
            .disposed(by: disposeBag)
           
        
        //        slider.rx.controlEvent(.valueChanged)
        //            .subscribe(onNext: { [weak self](value) in
        //
        //                self?.showText(text: "当前的数组是\(self?.slider.value ?? 0.0)")
        //            })
        //        .disposed(by: disposeBag)
    }
    
    func rx_Recognizer() {
        
        label.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer()
        label.addGestureRecognizer(tap)
        
//        tap.rx.event.asObservable()
//            .subscribe(onNext: { [weak self](tap) in
//                self?.showText(text: "点击了Label")
//            })
//        .disposed(by: disposeBag)
        
        tap.rx.event
            .bind { [weak self] recognizer in
                self?.showText(text: "点击了Label")
        }
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
