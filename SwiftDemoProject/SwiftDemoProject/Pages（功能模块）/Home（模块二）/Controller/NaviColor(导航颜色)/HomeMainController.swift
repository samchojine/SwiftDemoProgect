//
//  HomeMainController.swift
//  SwiftDemoProject
//
//  Created by champ on 2020/4/30.
//  Copyright © 2020 champ. All rights reserved.
//

import UIKit


class HomeMainController: PJBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "主页";
    
    }
    
}

extension HomeMainController {
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.cell(anyClass: HomeMainTableViewCell.self)as!HomeMainTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            self.navigationController?.pushViewController(HomeNaviColor1VC(),
                                                          animated: true);
        default: break
            
        }
    }
    
}


class HomeMainTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let label = UILabel()
        label.text = "理发师付律师费"
        addSubview(label)
        label.snp.makeConstraints { (make) in
            make.edges.equalTo(self);
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}

