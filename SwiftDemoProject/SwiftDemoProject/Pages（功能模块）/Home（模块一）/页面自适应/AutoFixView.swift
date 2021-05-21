//
//  AutoFixView.swift
//  SwiftDemoProject
//
//  Created by fwn on 2021/1/5.
//  Copyright © 2021 champ. All rights reserved.
//

import UIKit


// MARK: - 头部
class AutoFixView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    
    func configUI() {
        
        let imagV = UIImageView()
        imagV.backgroundColor = UIColor.red
        imagV.cornerRadius = 5;
        addSubview(imagV);
        
        imagV.snp.makeConstraints { (make) in
            make.left.top.equalTo(10);
            make.height.equalTo(200);
            make.bottom.right.equalTo(-10);
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


// MARK: - tagView
class AutoFixTagView: UIView {

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
    
    func configData(_ arr:[String]){
        tagView.addTags(arr);
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(tagView)
        tagView.snp.makeConstraints { (make) in
            make.top.equalTo(10);
            make.bottom.equalTo(-10);
            make.left.equalTo(10);
            make.right.equalTo(-10);
        }
    }
    

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}



// MARK: - 答复view
class AutoFixanswerView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    
    lazy var stackV: UIStackView = {
        let sv = UIStackView();
        sv.distribution = .equalSpacing
        sv.axis = .vertical
        sv.spacing = 10
        return sv
    }()
    
    func configUI() {
        addSubview(stackV)
        stackV.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        
    }
    
    
    func configData(_ arr:[String]){
        
        arr.forEach { (str) in
            
            let item = AutoFixanswerInsideView()
            item.titlLabel.text = str;
            self.stackV.addArrangedSubview(item)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


// MARK: 答复内部view
class AutoFixanswerInsideView: UIView {

    lazy var titlLabel: UILabel = {
        let lab = UILabel();
        return lab
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    
    func configUI() {
        self.backgroundColor = UIColor.white
        self.titlLabel.layer.borderWidth = 1;
        self.titlLabel.layer.borderColor = UIColor.lightGray.cgColor;
        self.titlLabel.cornerRadius = 10;
        
        addSubview(titlLabel)
        titlLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self);
            make.left.equalTo(10);
            make.right.equalTo(-10);
            make.height.equalTo(70);
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
