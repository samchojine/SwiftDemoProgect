//
//  RxLabel_Controller.swift
//  SwiftDemoProject
//
//  Created by champ on 2020/7/2.
//  Copyright © 2020 champ. All rights reserved.
//

import UIKit


class RxLabel_Controller: PJBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let disposeBag = DisposeBag()
        
        //创建文本标签
        let label = UILabel(frame:CGRect(x:20, y:40, width:300, height:100))
        self.view.addSubview(label)
         
        //创建一个计时器（每0.1秒发送一个索引数）
        let timer = Observable<Int>.interval(0.1, scheduler: MainScheduler.instance)
         
        //将已过去的时间格式化成想要的字符串，并绑定到label上
        timer.map{ String(format: "%0.2d:%0.2d.%0.1d",
                          arguments: [($0 / 600) % 600, ($0 % 600 ) / 10, $0 % 10]) }
        .bind(to: label.rx.text)
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
