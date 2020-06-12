//
//  MJRefreshController.swift
//  SwiftDemoProject
//
//  Created by champ on 2020/6/12.
//  Copyright © 2020 champ. All rights reserved.
//

import UIKit

class MJRefreshController: PJBaseTableViewController {
    
    var dataSource:[String] = []
    var page = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.mj_header =  PJRefreshNormalHeader (refreshingBlock: {[weak self] in
            self?.page = 1
            self?.requestData()
        })
        
        self.tableView.mj_footer = PJRefreshAutoNormalFooter(refreshingBlock: {[weak self] in
            self?.page += 1
            self?.requestData()
        })
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
        self.tableView.mj_header?.beginRefreshing()
    }
    
    func requestData() {
        
        DispatchQueue.main.asyncAfter(deadline: 1.5, execute: {
            
            if self.page == 1 {
                self.dataSource.removeAll()
            }
            self.dataSource += ["","","",""]
            self.tableView.reloadData();
            let isLast = self.page == 2
            self.tableView.endRefresh(isLastPage: isLast)
        })
        
    }
    
}



extension MJRefreshController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.cell(anyClass: UITableViewCell.self)!
        cell.textLabel?.text = "+++++++\(indexPath.row)"
        return cell
    }
    
}
