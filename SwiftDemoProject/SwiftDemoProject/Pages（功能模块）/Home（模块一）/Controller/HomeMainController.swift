//
//  HomeMainController.swift
//  SwiftDemoProject
//
//  Created by champ on 2020/4/30.
//  Copyright © 2020 champ. All rights reserved.
//

import UIKit


class HomeMainController: PJBaseTableViewController {

    let datas:[(title: String, vc: UIViewController)] = [
        (title:"自定义导航栏",vc:HomeNaviColor1VC()),
        (title:"MJRefresh封装",vc:MJRefreshController())
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
        let cell = tableView.cell(anyClass: UITableViewCell.self)!
        let tuple = datas[indexPath.row]
        cell.textLabel?.text = tuple.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let tuple = datas[indexPath.row]
        tuple.vc.title = title
        self.navigationController?.pushViewController(tuple.vc,animated: true);
        
    }
    
}




