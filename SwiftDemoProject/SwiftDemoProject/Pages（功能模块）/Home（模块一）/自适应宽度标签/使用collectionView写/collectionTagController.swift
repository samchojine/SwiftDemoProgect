//
//  collectionTagController.swift
//  SwiftDemoProject
//
//  Created by champ on 2020/6/22.
//  Copyright © 2020 champ. All rights reserved.
//

import UIKit


class collectionTagController: UIViewController {
    
    var dataArr:[String] = ["sdflsjflsf","熟练度附近","分类是打飞机","大幅度","鼎折覆餗"," 水电费","佛挡杀佛","水电费第三方士大夫","是","是"]
    var widthArr:[CGFloat] = []
    
    lazy var collectionView : UICollectionView = {
        
        let layout = CollectionTagFlowLayout()
        layout.headerReferenceSize = CGSize(PScreenWidth, 30)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCell(anyClass:TagCCell.self)
        collectionView.registerHeader(anyClass: TagSectionHeader.self)
        collectionView.registerFooter(anyClass: UICollectionReusableView.self)
        collectionView.alwaysBounceVertical = true
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataArr.forEach { (str) in
            let width = str .calculateWidthWithFont(UIFont.systemFont(ofSize: 14))
            widthArr.append(width + 20)
        }
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
    }
    
    
}

extension collectionTagController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.cell(anyClass: TagCCell.self, for: indexPath)
        cell.titleLabel.text = self.dataArr[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(widthArr[indexPath.row],30)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader {
            let headerV = collectionView.header(anyClass: TagSectionHeader.self, for: indexPath)
             headerV.titleLabel .text = "sdfsfsfsdfsdfsdf\(indexPath.section)"
            return headerV
        }
        return  collectionView.Footer(anyClass: UICollectionReusableView.self, for: indexPath)
    }
}

class TagCCell: UICollectionViewCell {
    
    lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.backgroundColor = .groupTableViewBackground
        l.textAlignment = .center
        l.font = UIFont.systemFont(ofSize: 14)
        l.cornerRadius = 15
        
        return l
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class TagSectionHeader: UICollectionReusableView {
    
    lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.backgroundColor = .groupTableViewBackground
        l.textAlignment = .center
        l.font = UIFont.systemFont(ofSize: 14)
        l.cornerRadius = 15
        
        return l
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
