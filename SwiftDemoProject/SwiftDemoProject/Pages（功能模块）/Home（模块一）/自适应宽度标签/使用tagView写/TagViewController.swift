//
//  TagViewController.swift
//  SwiftDemoProject
//
//  Created by champ on 2020/6/22.
//  Copyright © 2020 champ. All rights reserved.
//

import UIKit
import TagListView

class TagViewController: PJBaseTableViewController {
    
    lazy var headerView: TagHeaderView = {
        let v = TagHeaderView()
        return v
    }()

    var datas:[String] = []
    
    var page = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
         tableView  header和cell分别嵌套了 tagView   这个只适合不重用只赋值一次的cell或者view使用，
         如果是多次赋值的还是用colloctionView那种方式实现
         */
        
        self.title = "tagView + tableViewCell"
        
        self.tableView.estimatedRowHeight = 500
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.tableHeaderView = self.headerView
        self.tableView.sectionHeaderHeight = 40;
        
        self.tableView.mj_header =  PJRefreshNormalHeader (refreshingBlock: {[weak self] in
             self?.page = 1
             self?.requestData()
         })
         
         self.tableView.mj_footer = PJRefreshAutoNormalFooter(refreshingBlock: {[weak self] in
             self?.page += 1
             self?.requestData()
         })
    }
    
    func requestData() {
        
        DispatchQueue.main.asyncAfter(deadline: 1, execute: {
            
            if self.page == 1 {
                self.datas.removeAll()
            }
            let arr = ["gdgsg","dfgdg","的分公司大股东广东省","的覆盖单身公害太皇太后让他如何","格","当官的风格","当官的风格","当风格","格","当官的风格","当官的风格"]
            
            self.datas += arr
            self.tableView.reloadData();

            self.headerView.datas = arr
            self.tableView.endRefresh(isLastPage: false)
        })
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
         
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.cell(anyClass: TagCell.self)
        cell.tagView.removeAllTags();
        cell.tagView.addTags(self.datas)
        return cell;
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "分区\(section)"
    }
    
}




class TagCell: UITableViewCell {
    
    lazy var tagView: TagListView = {
        let tagV = TagListView()
        tagV.textFont = UIFont.systemFont(ofSize: 12)
        tagV.layer.cornerRadius = 4
        tagV.paddingY = 5
        tagV.paddingX = 5
        tagV.marginX = 5
        tagV.marginY = 5
        return tagV
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(tagView)
        tagView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class TagHeaderView: UIView {
    
    lazy var topView: UIView = {
        let v = UIView()
        v.backgroundColor = .lightGray
        return v
    }()
    
    lazy var tagView: TagListView = {
        let tagV = TagListView()
        tagV.backgroundColor = .red
        tagV.textFont = UIFont.systemFont(ofSize: 12)
        tagV.layer.cornerRadius = 4
        tagV.paddingY = 5
        tagV.paddingX = 5
        tagV.marginX = 5
        tagV.marginY = 5
        return tagV
    }()
    
    var datas:[String] = [] {
        
        didSet {
            tagView.removeAllTags();
            tagView.addTags(datas)
            self.layoutIfNeeded()
            updateFrame()
            let tableview = self.superview as!UITableView
            tableview.tableHeaderView = self
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configUI() {
        
        backgroundColor = .yellow
        addSubview(topView)
        addSubview(tagView)
        
        topView.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(self)
            make.height.equalTo(80)
        }
        
        tagView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self)
            make.top.equalTo(topView.snp.bottom)
        }
        
        updateFrame()

    }
    
    func updateFrame() {
        
        let height = self.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
         var frame = self.frame;
         frame.size.height = height;
         self.frame = frame;
    }
    


}



