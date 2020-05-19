//
//  EmptyView.swift
//  SwiftDemoProject
//
//  Created by champ on 2020/5/18.
//  Copyright © 2020 champ. All rights reserved.
//

import UIKit

class EmptyView: UIView {
    
    
    typealias TapCallBack = ()->Void
    
    enum EmptyType :Int {
        case normal  = 1  // 数据为空,通用
        case search      // 搜索不到相关结果
        case netWork     // 暂无网络
        case service     // 服务器崩溃
    }
    
    var type :EmptyType = .normal {
       // 初始化的时候不调用didset 所以加个方法
        didSet {
           configDataWithType(type: type)
        }
    }
    
    private var callBack: TapCallBack?
    
   private lazy var scrollView: UIScrollView = {
        let v = UIScrollView()
        v.backgroundColor = .groupTableViewBackground
        return v
    }()
    
    private  lazy var container: UIView = {
        let v = UIView()
        return v
    }()
    
     private  lazy var tipsLabel: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        l.textColor = .lightGray
        return l
    }()
    
    lazy var iconImageV: UIImageView = {
        let v = UIImageView()
        return v
    }()
    
    private  lazy var confirmBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("再试一下", for: .normal)
        btn.setTitleColor(.lightText, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        btn.layer.borderColor = UIColor.lightText.cgColor
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 16
        btn.clipsToBounds = true
        btn.addTarget(self, action: #selector(action_confirm), for: .touchUpInside)
        btn.isHidden = true
        return btn
    }()
    
    func configDataWithType(type:EmptyType?){
        
        switch type {
        case .normal:
            tipsLabel.text = "空空如也"
            iconImageV.image = UIImage(named:"empty_icon_normal")
        case .search:
            tipsLabel.text = "搜索不到相关结果"
            iconImageV.image = UIImage(named:"empty_icon_search")
        case .netWork:
            tipsLabel.text = "服务器崩溃了"
            iconImageV.image = UIImage(named:"empty_icon_no_service")
            confirmBtn.isHidden = false
        case .service:
            tipsLabel.text = "无法连接到网络"
            iconImageV.image = UIImage(named:"empty_icon_no_wifi")
            confirmBtn.isHidden = false
        default: break

        }
    }
    
    @objc func action_confirm() {
        
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
        self.configDataWithType(type: .normal)  // 默认是normal
    }
    
    convenience init(type:EmptyType = .normal) {
        self.init()
        self.configDataWithType(type: .normal)  // 默认是normal
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        var frame = self.frame
        frame.size.width = self.superview?.frame.size.width ?? UIScreen.main.bounds.size.width
        frame.size.height = self.superview?.frame.size.height ?? UIScreen.main.bounds.size.height
        self.frame = frame
    }
    
    func configUI() {
        
        self.frame = UIScreen.main.bounds;
        
        addSubview(scrollView)
        addSubview(container)
        addSubview(iconImageV)
        addSubview(tipsLabel)
        addSubview(confirmBtn)
        
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        
        container.snp.makeConstraints { (make) in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView)
        }
        
        iconImageV.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.container)
            make.bottom.equalTo(self.container.snp.centerY)
            make.width.equalTo(78);
            make.height.equalTo(65);
        }
        
        tipsLabel.snp.makeConstraints { (make) in
            make.top.equalTo(iconImageV.snp.bottom).offset(14)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(30)
        }
        
        confirmBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(container.snp.centerX)
            make.top.equalTo(tipsLabel.snp.bottom).offset(30)
            make.width.equalTo(120)
            make.height.equalTo(34)
        }
        
    }

}
