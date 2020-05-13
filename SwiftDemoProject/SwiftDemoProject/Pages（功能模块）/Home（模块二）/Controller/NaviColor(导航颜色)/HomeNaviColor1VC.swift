//
//  HomeNaviColor1VC.swift
//  SwiftDemoProject
//
//  Created by champ on 2020/5/11.
//  Copyright © 2020 champ. All rights reserved.
//

import UIKit

class HomeNaviColor1VC: PJBaseTableViewController {
    
    /// 设置渐变完成的最大距离
    var offsetHeight:CGFloat = 100
    
    lazy var navi: PJCustomNaviBar = {
        let v = PJCustomNaviBar()
        v.title = "渐变的控制器发绿山咖啡就撒了看"
        v.addRightItem(title: "发表") { (_) in
            print("13565656")
        }
        v.addRightItem(title: "不好") { (_) in
            print("13565656")
        }
        
        v.addRightItem(title: "dsfsdf") { (_) in
            
        }
        return v
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        //title = "渐变"
        //naviType = .typeDark
        
        
        let btn =   UIButton()
        btn.setTitle("下一页", for: .normal)
        btn.addClickAction { (_) in
            self.navigationController?.pushViewController(HomeNaviColor2VC(), animated: true)
        }
        self.navigationItem.rightBarButtonItem =  UIBarButtonItem.init(customView: btn)
        
        let  headerView = UIView()
        headerView.frame = CGRect(x: 0, y: 0, width: PScreenWidth, height: 200);
        headerView.backgroundColor = .red
        tableView.tableHeaderView = headerView;
        
        fixTableViewOffsetWhenNaviHide()
        
        
        let v = UIView()
        v.backgroundColor = .green
        self.view .addSubview(v)
        
        v.snp.makeConstraints { (make) in
            make.top.equalTo(0);
            make.left.equalTo(0)
            make.width.height.equalTo(100)
        }
      
        view.addSubview(navi)
        
        navi.isTranslucent = true;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        self.naviBgColor = UIColor.white.withAlphaComponent(0)
//        self.navigationController?.navigationBar.isTranslucent = true
//        // 4.设置导航栏背景图片
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
//
//        // 5.设置导航栏阴影图片
//        self.navigationController?.navigationBar.shadowImage = UIImage()
    self.navigationController?.setNavigationBarHidden(true, animated: animated)
        
        print("\(view.frame)")
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {

        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self))
        cell?.textLabel?.text = "sdfsdfsfsf"
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          self.navigationController?.pushViewController(HomeNaviColor2VC(), animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        self.navi.addGradualChange(maxValue: 300, scollView: scrollView);
        

    
    }
  


}
