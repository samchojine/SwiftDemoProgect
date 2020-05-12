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

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "渐变"
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
        
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }

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
        
//        let offsetY = scrollView.contentOffset.y
//
//        var alpha:CGFloat = 1
//        if offsetY >= offsetHeight {
//            alpha = 1
//
//        }else{
//            alpha = -((offsetHeight - offsetY) / offsetY - 1)
//
//        }
//
//        self.naviBgColor = UIColor.white
        
        
//        if offsetY > 100 {
//            self.navi.naviType = .black
//
//        }else{
//            self.navi.naviType = .white
//        }
//        self.setNeedsStatusBarAppearanceUpdate()
    
    }
  


}
