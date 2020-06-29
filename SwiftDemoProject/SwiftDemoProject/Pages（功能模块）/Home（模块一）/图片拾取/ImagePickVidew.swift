//
//  ImagePickVidew.swift
//  SwiftDemoProject
//
//  Created by champ on 2020/6/28.
//  Copyright © 2020 champ. All rights reserved.
//

import UIKit
import TZImagePickerController


class ImagePickVidew: UIView {
    
    let itemWidth = (PScreenWidth - 12*5)/4
    
    let maxLimitCount = 20
    
    var imageArr:[UIImage] = []
    
    lazy var collectionView : UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
    
        layout.itemSize = CGSize.init(width: itemWidth, height: itemWidth)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 12
        layout.sectionInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
     
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCell(anyClass: ZYMeEvaluateCCell.self)
        
        return collectionView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configUI()
    }
    

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configUI() {
        
        self.backgroundColor = .white
        
        self.addSubview(collectionView)
       
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
            make.height.equalTo(itemWidth + 24)
        }
    
    }
}


extension ImagePickVidew : UICollectionViewDelegate,UICollectionViewDataSource {

    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imageArr.count >= maxLimitCount ? self.imageArr.count : self.imageArr.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.cell(anyClass: ZYMeEvaluateCCell.self, for: indexPath)
        cell.deleteBtn.tag = indexPath.row
        
        if indexPath.row == imageArr.count {
            cell.deleteBtn.isHidden = true
            cell.imageV.image = UIImage(named: "home_cell_add")
        }else {
            cell.deleteBtn.isHidden = false
            cell.imageV.image = self.imageArr[indexPath.row]
        }
        
        // 删除照片
        cell.deleteBlock = {[weak self] _ in
            self?.imageArr.remove(at: indexPath.item)
            self?.updateUI()
        }
        return cell
    }

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == imageArr.count {
  
            let count = maxLimitCount - imageArr.count
            let vc = TZImagePickerController(maxImagesCount: count, delegate: self)
            vc?.modalPresentationStyle = .currentContext
            vc?.allowTakeVideo = false
            vc?.allowPickingVideo = false
            vc?.allowPickingOriginalPhoto = false
            viewController()?.present(vc!, animated: true, completion: nil)
            // block方式的回调
//            vc?.didFinishPickingPhotosHandle = {photos,assets,isSelectOriginalPhoto in
//                self.imageArr += photos!
//                self.updateUI()
//            }
        }
      
    }
    

    func updateUI() {
        
        self.collectionView.reloadData()
        self.layoutIfNeeded()
        self.collectionView.snp.updateConstraints { (make) in
            make.height.equalTo(self.collectionView.contentSize.height)
        }
    }
}


extension ImagePickVidew : TZImagePickerControllerDelegate{
    func imagePickerController(_ picker: TZImagePickerController!, didFinishPickingPhotos photos: [UIImage]!, sourceAssets assets: [Any]!, isSelectOriginalPhoto: Bool) {
        self.imageArr += photos
        self.updateUI()
    }
}


// MARK: *********** 内部collectionViewCell **********
class ZYMeEvaluateCCell: UICollectionViewCell {
    
    var deleteBlock:((Int)->Void)?
    
    var index : Int = 0
    
    lazy var imageV: UIImageView = {
        let v = UIImageView()
        v.image = UIImage(named: "home_cell_add")
        v.layer.cornerRadius = 4
        v.clipsToBounds = true
        v.contentMode = .scaleAspectFill
        return v
    }()
    
    lazy var deleteBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("×", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 14)
        btn.addTarget(self, action: #selector(action_delete(sender:)), for: .touchUpInside)
        return btn
    }()
    
    @objc func action_delete(sender:UIButton) {
        
        self.deleteBlock?(self.index)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configUI()
        
    }
    

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configUI() {
        
        self.addSubview(imageV)
        self.addSubview(deleteBtn)
        
        imageV.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        
        deleteBtn.snp.makeConstraints { (make) in
            make.top.right.equalTo(self)
            make.height.width.equalTo(20)
        }
        
    }
    
}

