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
    
    /// finish  导航栏内容是否完成显示  alpha:导航栏当前的透明度
    typealias NaviChangeBlock = (_ finish:Bool, _ alpha:CGFloat )->Void
    
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
    
    // MARK:导航栏子控件内容颜色
    var naviTintColor:UIColor = .white {
        didSet {
         self .changeNaviTintColor(color: naviTintColor)
        }
    }
    
    // MARK:导航栏是否透明 默认不透明
    var isTransparent:Bool = false {
        didSet {
            self.naviBGView.alpha = isTransparent == false ? 1: 0
            self.titleLabel.alpha = self.naviBGView.alpha;
        }
    }
    
    // MARK:- 是否显示底部线 默认 true
    var showBottomLine:Bool = false {
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
    var rightItems:[UIButton] = [] {
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
    
    // 修改 背景色，透明度, 背景图片，请改变这个View
    var naviBGView:UIImageView!
    
    //  中间View
    var titleView:UIView!
    
    // 导航栏容器 外部如果要加控件，请在这个容器上添加
    var naviContentView:UIView!
    
    //  中间标题 Label
    var titleLabel:UILabel!
    
     // 左按钮点击回调
    private var leftItemCallBack :BtnClickBlock?
    
    //  渐变点击回调
    private var naviGradualChangeBlock :NaviChangeBlock?
    
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
    
    // MARK:- 修改导航栏所有子视图的文字和图片颜色
    private func changeNaviTintColor(color:UIColor){
        for view in self.naviContentView.allSubViews {
            
            if view.isMember(of: UIButton.classForCoder()) {
                let btn = view as!UIButton
                btn.setTitleImageColor(color: color)
            }
            
            if view.isMember(of: UILabel.classForCoder()) {
                let label = view as!UILabel
                label.textColor = color
            }
        }
    }
    
    // MARK:- 添加导航栏的透明度监听
    func naviGradualDidChange(callBack:NaviChangeBlock?){
        self.naviGradualChangeBlock = callBack
    }
    
    // MARK:- 添加导航栏的透明度监听
    func addLeftItemCallBack(callBack:BtnClickBlock?){
        self.leftItemCallBack = callBack
    }
    
    // MARK:- 添加右边按钮
    
    /// - Parameters:
    ///   - title: 标题
    ///   - callBack: 点击回调
    func addRightItemWithTitle(title:String?,callBack:BtnClickBlock?) {
        self.addRightItem(title: title, callBack: callBack)
    }
    
    /// - Parameters:
    ///   - image: 图片
    ///   - callBack: 点击回调
    func addRightItemWithImage(image:String = "",callBack:BtnClickBlock?) {
        self.addRightItem(normalImage: image, callBack: callBack)
    }
    
    
    /// - Parameters:
    ///   - title: 标题
    ///   - font: 字体大小
    ///   - titleColor: 字体颜色
    ///   - normalImage: 普通状态下的图片
    ///   - selecctImage: 渐变完成的图片
    ///   - followAlpha: 是否跟随导航栏渐变
    ///   - isShowEndChangeImage: 渐变完成时是否显示selecImage的图片
    ///   - callBack: 点击回调
    func addRightItem(title:String? = "",
                      font:UIFont = UIFont.systemFont(ofSize: 14, weight: .regular),
                      titleColor:UIColor = .darkText,
                      normalImage:String = "",
                      selecctImage:String = "",
                      followAlpha:Bool = false,
                      showEndChangeImage:Bool = false ,
                      callBack:BtnClickBlock?){
        let btn = UIButton()
        btn.setTitle(title, for: .normal)
        if normalImage.isEmpty == false {
            btn.setImage(UIImage(named: normalImage), for: .normal)
        }
        if selecctImage.isEmpty == false {
            btn.setImage(UIImage(named: selecctImage), for: .selected)
        }
        btn.setTitleColor(titleColor, for: .normal)
        btn.titleLabel?.font = font
        btn.isFollowNaviAlpha = followAlpha
        btn.isShowEndChangeImage = showEndChangeImage
        self.rightItems.append(btn)
        btn.addClickAction { (btn) in
            callBack?(btn)
        }
    }
    
    // MARK: -添加渐变
    /// - Parameters:
    ///   - scollView: scollView ，这个在 didscroll的代理里面调用就可以
    ///   - maxValue: 导航栏导航栏完全显示显示的最大距离
    ///   - endColor: 导航栏完全显示的子视图文字和图片颜色
    func addGradualChange( scollView:UIScrollView, maxValue:CGFloat = 150, endColor:UIColor? = nil) {
        
        let offsetY = scollView.contentOffset.y
        var alpha:CGFloat = 1
        if offsetY >= maxValue {
            alpha = 1
        }else{
            alpha = -((maxValue - offsetY) / maxValue - 1)
        }
        self.naviBGView.alpha = alpha
        
        // 滑动到此处时候内容颜色图片将会发生改变
        let finish:Bool = offsetY > maxValue*2/3

        for view in self.naviContentView.allSubViews {
            
            // 设置子控件内容颜色改变
            if endColor != nil {
                
                let changeColor = finish ? endColor : naviTintColor
                
                
                if view.isMember(of: UIButton.classForCoder()) {
                    let btn = view as!UIButton
                    
                    if btn.isShowEndChangeImage == true  {
                        // 只换按钮文字颜色，并设置结束的图片
                        btn.setTitleColor(changeColor, for: .normal)
                        btn.isSelected = finish
                    }else {
                        // 强制装换按钮文字颜色和图片颜色
                        btn.setTitleImageColor(color: changeColor!)
                    }
                    
                }
                
                if view.isMember(of: UILabel.classForCoder()) {
                    let label = view as!UILabel
                    label.textColor = changeColor
                }
            }
            
            // 设置子控件是否要跟随渐变
            if view.isFollowNaviAlpha == true {
                   self.titleLabel.alpha = alpha
               }
        }

       // print("-=-=-=-=-=:\(offsetY)")
        naviGradualChangeBlock?(finish, alpha)
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
        
        // 默认背景色 白色
        self.naviBGView.backgroundColor = .white
        self.naviTintColor = .darkText
        self.leftItem.setImage(UIImage(named: "navi_icon_back_black"), for: .normal)
        self.titleLabel.font = UIFont.systemFont(ofSize: 18, weight:.medium)
        self.bottomLine.backgroundColor = UIColor(hex: "e6e6e6")
        self.bottomLine.isHidden = true
        self.titleLabel.isFollowNaviAlpha = true;
        self.titleView.isFollowNaviAlpha = true;

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
            make.left.right.bottom.equalTo(naviContentView)
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
    

}


// 通过runtime加个isFollowNaviAlpha 属性，用来控制子view是不是跟随导航栏的一起渐变
extension UIView{
    
    private struct viewTransRuntimeKey {
        static let followNaviAlpa = UnsafeRawPointer.init(bitPattern: "followNaviAlpa".hashValue)
        /// ...其他Key声明
    }
    /// 运行时关联
    var isFollowNaviAlpha: Bool? {
        set {
            objc_setAssociatedObject(self, UIView.viewTransRuntimeKey.followNaviAlpa!, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, UIView.viewTransRuntimeKey.followNaviAlpa!) as? Bool
        }
    }
    
}

// 通过runtime加个属性，用来控制导航栏左右item完全显示的图片
extension UIButton{
    
    private struct buttonTransRuntimeKey {
        static let showEndChangeImage = UnsafeRawPointer.init(bitPattern: "showEndChangeImage".hashValue)
        /// ...其他Key声明
    }
    
    /// 运行时关联
    var isShowEndChangeImage: Bool? {
        set {
            objc_setAssociatedObject(self, UIButton.buttonTransRuntimeKey.showEndChangeImage!, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, UIButton.buttonTransRuntimeKey.showEndChangeImage!) as? Bool
        }
    }
    
}
