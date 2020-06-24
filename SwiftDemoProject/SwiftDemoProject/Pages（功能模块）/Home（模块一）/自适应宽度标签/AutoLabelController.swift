//
//  AutoLabelController.swift
//  SwiftDemoProject
//
//  Created by champ on 2020/6/22.
//  Copyright © 2020 champ. All rights reserved.
//

import UIKit

class AutoLabelController: PJBaseTableViewController {

    let datas:[(title: String, vc: UIViewController.Type)] = [
        (title:"tagView + tableViewCell",vc:TagViewController.self),
        (title:"使用collectionView",vc:collectionTagController.self),
         ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "自适应宽度标签"
       
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
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
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
