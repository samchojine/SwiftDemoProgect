//
//  WaterFlowController.swift
//  SwiftDemoProject
//
//  Created by champ on 2020/6/28.
//  Copyright © 2020 champ. All rights reserved.
//

import UIKit

class WaterFlowController: PJBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "瀑布流"
        view.addSubview(collectView)
        collectView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
    }
    lazy var collectView: UICollectionView = {
        
        let layout = WaterfallLayout()
        layout.headerReferenceSize = CGSize(width: PScreenWidth, height: 120)
        layout.minimumLineSpacing = 6
        layout.minimumInteritemSpacing = 6
        layout.sectionInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        layout.scrollDirection = .vertical
        let v = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        v.backgroundColor = .groupTableViewBackground
        v.delegate = self
        v.dataSource = self
        
        v.registerHeader(anyClass: WaterHeaderView.self)
        v.registerCell(anyClass: WaterCell.self)
        v.alwaysBounceVertical = true
        return v
    }()
    
       private var picWidth  = (PScreenWidth - 12*2 - 6)/2


}


extension WaterFlowController :UICollectionViewDelegate,UICollectionViewDataSource,WaterfallLayoutDelegate{
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.cell(anyClass: WaterCell.self, for: indexPath)
        cell.titleLabel.text = "\(indexPath.row)"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let randomHeight = (100 + (arc4random() % (300 - 100 + 1)))
        return CGSize(width: picWidth, height:CGFloat(randomHeight))
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.header(anyClass: WaterHeaderView.self, for: indexPath)
            return headerView
        }
        return UICollectionReusableView()
    }
    
    
    
}





