//
//  PhotoBrowserController.swift
//  SwiftDemoProject
//
//  Created by champ on 2020/6/28.
//  Copyright © 2020 champ. All rights reserved.
//

import UIKit
import JXPhotoBrowser

class PhotoBrowserController: UIViewController {

    
    let itemWidth = (PScreenWidth - 10*4)/3
    
    let maxLimitCount = 20
    
    var imageArr:[String] = ["https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3295687100,3726371607&fm=26&gp=0.jpg",
                             "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=196881328,4100744446&fm=26&gp=0.jpg",
                             "https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3506283033,3580251386&fm=26&gp=0.jpg",
                             "https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=126217670,2727859500&fm=26&gp=0.jpg",
                             "https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3798808225,2865358769&fm=26&gp=0.jpg",
    ]
    
    lazy var collectionView : UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
    
        layout.itemSize = CGSize.init(width: itemWidth, height: itemWidth)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
     
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCell(anyClass: ZYMeEvaluateCCell.self)
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
    }
    

}

extension PhotoBrowserController : UICollectionViewDelegate,UICollectionViewDataSource {

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.cell(anyClass: ZYMeEvaluateCCell.self, for: indexPath)
        cell.imageV.kf.setImage(with: URL(string: imageArr[indexPath.row]))
        cell.deleteBtn.isHidden = true
        return cell
    }

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // 图片浏览
        let browser = JXPhotoBrowser()
        browser.numberOfItems = {
            self.imageArr.count
        }
        browser.reloadCellAtIndex = {[weak self] context in
            
            let cell = context.cell as? JXPhotoBrowserImageCell
            cell?.imageView.kf.setImage(with: URL(string: self?.imageArr[context.currentIndex] ?? ""))
        }
        browser.pageIndex = indexPath.item
        
        browser.show()
    }



}
