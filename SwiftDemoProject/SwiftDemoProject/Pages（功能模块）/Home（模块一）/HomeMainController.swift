//
//  HomeMainController.swift
//  SwiftDemoProject
//
//  Created by champ on 2020/4/30.
//  Copyright © 2020 champ. All rights reserved.
//

import UIKit


class HomeMainController: PJBaseTableViewController {
    
    var value:String? = "abc"


    let datas:[(title: String, vc: UIViewController.Type)] = [
        (title:"自定义导航栏",         vc:HomeNaviColor1VC.self),
        (title:"MJRefresh封装",      vc:MJRefreshController.self),
        (title:"富文本及点击",         vc:AttributeController.self),
        (title:"适配UI宽高，字体大小",  vc:AutoSizeController.self),
        (title:"宽度自适应标签",       vc:AutoLabelController.self),
        (title:"瀑布流",              vc:WaterFlowController.self),
        (title:"图片拾取",            vc:ImagePickController.self),
        (title:"图片浏览",            vc:PhotoBrowserController.self),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "主页";
      
    }
    
}

extension HomeMainController {
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.datas.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.cell(anyClass: UITableViewCell.self)
        let tuple = datas[indexPath.row]
        cell.textLabel?.text = tuple.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let tuple = datas[indexPath.row]
        let vc = tuple.vc.init()
        vc.title = tuple.title
        self.navigationController?.pushViewController(vc,animated: true);
        
    }
    
}




