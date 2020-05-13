//
//  PJCustomNaviBar.swift
//  SwiftDemoProject
//
//  Created by champ on 2020/5/13.
//  Copyright © 2020 champ. All rights reserved.
//

import UIKit

class PJCustomNaviBar: UIView {
    
    typealias BtnClickBlock = (_ btn:UIButton)->Void
    
    // MARK:- 导航栏标题
    var title :String? {
        didSet{
            self.titleLabel.text = title
        }
    }
    
    // MARK:- 导航栏标题颜色
    var titleColor :UIColor? {
        didSet{
            self.titleLabel.textColor = titleColor
        }
    }
    
    // MARK:- 导航栏标题字体大小
    var titleFont :UIFont? {
        didSet{
            self.titleLabel.font = titleFont
        }
    }
    
    // MARK:导航栏背景色
    var naviBGColor:UIColor = .white {
        didSet {
            self.naviBGView.backgroundColor = naviBGColor
        }
    }
    
    // MARK:导航栏是否透明 默认不透明
    var isTransparent:Bool = false {
        didSet {
            self.naviBGView.alpha = isTransparent == true ? 0: 1
        }
    }
    
    // MARK:- 是否显示底部线 默认 true
    var showBottomLine:Bool = true {
        didSet {
            self.bottomLine.isHidden = !showBottomLine
        }
    }
    
    // MARK:- 左按钮图片
    var leftItemImage :UIImage? {
        didSet{
            self.leftItem.setImage(leftItemImage, for: .normal)
        }
    }
    
    //  右按钮集合
    var rightItems:[UIButton]! {
        didSet {
            for btn in rightItems {
                self.rightStackV.addArrangedSubview(btn)
            }
        }
    }
    
    // MARK:- 左按钮颜色
    var leftItemColor :UIColor? {
        didSet{
            self.leftItem.tintColor = leftItemColor
        }
    }
    
    // MARK:- 左按钮
    var leftItem:UIButton!
    // MARK:- 左按钮点击回调
    var leftItemCallBack :BtnClickBlock?
    //  中间View
    var titleView:UIView!
    // 修改 背景色，透明度, 背景图片，请改变这个View
    var naviBGView:UIImageView!
    // 导航栏容器
    private var naviContentView:UIView!
    //  中间标题 Label
    private var titleLabel:UILabel!
    //  底部线
    private var bottomLine:UIView!
    // 右边按钮集合容器
    private lazy var rightStackV: UIStackView = {
        let sv = UIStackView();
        //sv.distribution = .fillEqually
        sv.axis = .horizontal
        sv.spacing = 5
        sv.setContentHuggingPriority(.required, for: .horizontal)
        sv.setContentCompressionResistancePriority(.required, for: .horizontal)
        return sv
    }()
    
    // MARK:- 添加右边按钮
    func addRightItem(title:String?,font:UIFont = UIFont.systemFont(ofSize: 14, weight: .regular),titleColor:UIColor = .darkText, image:String = "",callBack:BtnClickBlock?){
        let btn = UIButton()
        btn.setTitle(title, for: .normal)
        if image.isEmpty == false {
            btn.setImage(UIImage(named: image), for: .normal)
        }
        btn.setTitleColor(titleColor, for: .normal)
        btn.titleLabel?.font = font
        self.rightItems = [btn]
        btn.addClickAction { (btn) in
            callBack?(btn)
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
        
        // 默认背景色 白色
        self.naviBGColor = .white
        self.leftItem.setImage(UIImage(named: "navi_icon_back_black"), for: .normal)
        self.titleColor = .darkText;
        self.titleFont = UIFont.systemFont(ofSize: 18, weight:.medium)
        self.bottomLine.backgroundColor = .darkText
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configUI() {
        
        let screenWidth = UIScreen.main.bounds.size.width
        let statusHeight = UIApplication.shared.statusBarFrame.height
        let itemWidth:CGFloat  = 53
        let naviHeight:CGFloat = 44
        
        naviBGView = UIImageView()
        naviContentView = UIView()
        
        leftItem = UIButton()
        leftItem.setContentHuggingPriority(.required, for: .horizontal)
        
        titleLabel = UILabel()
        titleLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        titleView = UIView()
        bottomLine = UIView()
        
        addSubview(naviBGView)
        addSubview(naviContentView)
        naviContentView.addSubview(leftItem)
        naviContentView.addSubview(rightStackV)
        naviContentView.addSubview(titleLabel)
        naviContentView.addSubview(titleView)
        naviContentView.addSubview(bottomLine)
        
        leftItem.backgroundColor = .yellow;
        titleLabel.backgroundColor = .blue
        // let image = UIImage(named: "navi_icon_back_black")
        // self.leftItem.setImage(image, for: .normal)
        
        self.frame = CGRect(x: 0, y: 0, width: screenWidth, height: statusHeight + naviHeight)
        naviBGView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        
        naviContentView.snp.makeConstraints { (make) in
            make.left.bottom.right.equalTo(self)
            make.height.equalTo(44)
        }
        
        leftItem.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.top.bottom.equalTo(naviContentView)
            make.width.greaterThanOrEqualTo(itemWidth)
        }
        
        rightStackV.snp.makeConstraints { (make) in
            make.right.equalTo(-8)
            make.top.bottom.equalTo(naviContentView)
            make.width.greaterThanOrEqualTo(itemWidth)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(naviContentView.snp.centerX)
            make.right.equalTo(rightStackV.snp.left).offset(-10)
            make.top.bottom.equalTo(naviContentView)
        }
        
        titleView.snp.makeConstraints { (make) in
            make.edges.equalTo(titleLabel)
        }

        bottomLine.snp.makeConstraints { (make) in
            make.height.equalTo(1)
            make.top.right.bottom.equalTo(naviContentView)
        }
        
        leftItem.addTarget(self, action: #selector(action_left), for: .touchUpInside)
        
    }
    

     @objc private func action_left() {
        
        if (self.leftItemCallBack != nil) {
            self.leftItemCallBack!(self.leftItem)
            return;  // 如果外面实现了回调，就不走下面的默认返回的方法了
        }
        self.viewController()?.navigationController?.popViewController(animated: true)
    }
    
    
    // MARK: -添加渐变
    /// - Parameters:
    ///   - maxValue: 导航栏显示的最大距离
    ///   - offset: scollView ，这个在 didscroll的代理里面调用就可以
    func addGradualChange(maxValue:CGFloat, scollView:UIScrollView) {
        
        let offsetY = scollView.contentOffset.y
        var alpha:CGFloat = 1
        if offsetY >= maxValue {
            alpha = 1
            
        }else{
            alpha = -((maxValue - offsetY) / offsetY - 1)
            
        }
        
        self.naviBGView.alpha = alpha
        
    }

}
