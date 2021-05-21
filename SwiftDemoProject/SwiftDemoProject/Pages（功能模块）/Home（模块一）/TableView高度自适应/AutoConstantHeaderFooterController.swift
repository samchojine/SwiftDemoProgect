//
//  AutoConstantHeaderFooterController.swift
//  SwiftDemoProject
//
//  Created by champ on 2020/7/15.
//  Copyright © 2020 champ. All rights reserved.
//

import UIKit

class AutoConstantHeaderFooterController: PJBaseTableViewController {
    
    lazy var tableHeaderV: HeaderView = {
        let hv = HeaderView()
        hv.superV = self.tableView;
        return hv
    }()

    var dataSource:[String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableHeaderView = self.tableHeaderV;
        self.requestData();
    }
    
    func requestData() {
        self.showLoading()
        DispatchQueue.main.asyncAfter(deadline: 1.5, execute: {
            self.dismissHud()
            self.dataSource = ["电风扇","老地方","老地方"]
            self.tableHeaderV.updataData();
            self.tableView .reloadData();
        })
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.cell(anyClass: UITableViewCell.self);
        cell.textLabel?.text = dataSource[indexPath.row]
        return cell
    }
}


class HeaderView:UIView {
    
    var superV:UITableView!
    
    lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.numberOfLines = 0;
        l.isUserInteractionEnabled = true
        l.addTapAction { (view) in
            l.numberOfLines = 2
            self.updateFrameWithAnimation()
        }
        return l
    }()
    
    lazy var imageV: UIImageView = {
        let l = UIImageView()
        l.backgroundColor = UIColor.red;
        l.addTapAction { (view) in
               l.snp.updateConstraints { (make) in
                    make.height.equalTo(150);
                }
            self.updateFrameWithAnimation()
            
        }
        return l
    }()
    
    lazy var stackV: UIStackView = {
        let v = UIStackView()
        v.distribution = .equalSpacing
        v.axis = .vertical
        v.spacing = 0
        return v
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configUI() {
        
        addSubview(self.titleLabel)
        addSubview(self.imageV)
        addSubview(self.stackV)
        
        self.snp.makeConstraints { (make) in
            make.width.equalTo(PScreenWidth);
        }

        self.titleLabel.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(self);
        };
        
        self.imageV.snp.makeConstraints { (make) in
            make.left.right.equalTo(self);
            make.top.equalTo(self.titleLabel.snp.bottom)
            make.height.equalTo(20);
        }
        
        self.stackV.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self)
            make.top.equalTo(imageV.snp.bottom);
        }
        
//        self.layoutIfNeeded()
//        print("---\(self.imageV.frame)")
    }
    
    
    func updataData()  {
        
        self.titleLabel.text = "斯洛伐克健身房拉丝粉家乐福建安里发酵法拉飞机阿里的房间爱砥砺奋进啊第三方落实到附近拉附近的水立方大连市附近拉司法解释的浪费进口量水电费 降落伞房加速度快拉法基水电费啦水电费家里的饭空数据代课老师"
        
        let label = UILabel();
        label.font = UIFont.systemFont(ofSize: 25);
        label.numberOfLines = 2;
        label.text = "斯洛伐克健身房拉丝粉家乐福建安里发酵法拉飞机阿里的房间爱砥砺奋进啊第三方落实到附近拉附近的水立方大连市附近拉司法解释的浪费进口量水电费 降落伞房加速度快拉法基水电费啦水电费家里的饭空数据代课老师"
        stackV.addArrangedSubview(label)
        
        label.isUserInteractionEnabled = true
        label.addTapAction { (view) in
            label.numberOfLines = 0;
            self.updateFrameWithAnimation()
        }

        let view = UIView();
        view.backgroundColor = UIColor.red;
        stackV.addArrangedSubview(view);
        view.snp.makeConstraints { (make) in
            make.height.equalTo(200);
        }
        view.isUserInteractionEnabled = true
        view.addTapAction { (view) in
            view.isHidden = true
            self.updateFrameWithAnimation()
        }
        
        stackV.addArrangedSubview(label)
        stackV.addArrangedSubview(view)
        
        self.layoutIfNeeded()
        
        self.superV.tableHeaderView = self
     
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        self.superV.tableHeaderView = self
//    }
    
    func updateFrameWithAnimation(){
        self.layoutIfNeeded()
        self.superV.beginUpdates()
        self.superV.tableHeaderView = self
        self.superV.endUpdates()
    }

}
