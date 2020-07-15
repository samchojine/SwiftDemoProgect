//
//  CollectionTagFlowLayout.swift
//  SwiftDemoProject
//
//  Created by champ on 2020/6/28.
//  Copyright © 2020 champ. All rights reserved.
//

import UIKit

class CollectionTagFlowLayout: UICollectionViewFlowLayout {
    
    private var delegate:UICollectionViewDelegateFlowLayout?
    private var itemLayoutAttributes:[[UICollectionViewLayoutAttributes]] = []
    private var headerLayoutAttributes:[UICollectionViewLayoutAttributes] = []
    private var footerLayoutAttributes:[UICollectionViewLayoutAttributes] = []
    private var heightOfSections:[CGFloat] = []
    private var contentHeight:CGFloat = 0.0
    private var contentMaxY:CGFloat = 0.0
    private var currentSectionMinY:CGFloat = 0.0
    private var currentSectionMaxY:CGFloat = 0.0
    private var contentWidth:CGFloat = 0.0
    private var numberOfLine = 0
    private var footerHeight:CGFloat = 0.0
    private var headerHeight:CGFloat = 0.0
    private var contentInset:UIEdgeInsets = UIEdgeInsets.zero
    private var preAttrs:UICollectionViewLayoutAttributes?
    

    override func prepare() {
        super.prepare()
        
        self.delegate = self.collectionView?.delegate as?UICollectionViewDelegateFlowLayout
        
        if self.collectionView!.isDecelerating || self.collectionView!.isDragging {
            return
        }
        
        contentMaxY            = 0.0;
        currentSectionMaxY     = 0;
        itemLayoutAttributes   = [];
        headerLayoutAttributes = [];
        footerLayoutAttributes = [];
                
        let collectionView = self.collectionView!;
        //有多少个 sections
        let numberOfSections = collectionView.numberOfSections;
        //内边距
        contentInset = collectionView.contentInset;
        //content的宽度
        contentWidth = collectionView.bounds.size.width - contentInset.left - contentInset.right
        var totalHeight:CGFloat = 0.0;
        
        for section in 0 ..< numberOfSections {
            self.numberOfLine = 0
            self.preAttrs = nil
            
            // 每个 section 中有多少个 item
            let numberOfItems = collectionView.numberOfItems(inSection: section);
 
//            if (numberOfItems <= 0) {
//                 continue;
//             }
            
            //section 头视图
            headerHeight = self.setupHeaderView(collectionView, section: section, contentWidth: contentWidth, pointY: currentSectionMaxY)
            
            var layoutAttributeOfSection:[UICollectionViewLayoutAttributes] = [];
            
            for item in 0 ..< numberOfItems {
                let indextPath = IndexPath(item: item, section: section)
                let attes = self.layoutAttributesForItem(at: indextPath)
                let layoutAttbiture  = UICollectionViewLayoutAttributes(forCellWith: indextPath)
                layoutAttbiture.frame = attes!.frame;
                layoutAttributeOfSection.append(layoutAttbiture)
            }
            
            itemLayoutAttributes.append(layoutAttributeOfSection)
            
            currentSectionMinY = (layoutAttributeOfSection.first?.frame.minY ?? 0.0) - self.sectionInset.top - headerHeight
            if numberOfItems == 0 {
                currentSectionMinY = 0
            }
            var  currentSectionLastItemMaxY = (layoutAttributeOfSection.last?.frame.maxY ?? 0.0) + self.sectionInset.bottom
            
            if numberOfItems == 0 {
                let lastHeaderlayoutAttibute = headerLayoutAttributes.last
                currentSectionLastItemMaxY =  lastHeaderlayoutAttibute?.frame.maxY ?? 0.0
            }
            
            footerHeight = self.setupFooterView(collectionView, section: section, contentWidth: contentWidth, pointY: currentSectionLastItemMaxY)
            
            currentSectionMaxY = currentSectionLastItemMaxY + footerHeight;
            let currentSectionHeight = currentSectionMaxY - currentSectionMinY;
            totalHeight += currentSectionHeight;
            contentMaxY = footerLayoutAttributes.last?.frame.maxY ?? 0.0;
           // print("每个 section 的高度\(section) _________\(currentSectionMaxY)")
            heightOfSections.append(currentSectionHeight)
            
        }
        
       // print("\(totalHeight) __________ \(currentSectionMaxY)");
        self.itemSize = CGSize(contentWidth-self.sectionInset.left-self.sectionInset.right, contentMaxY)
    }
    
    private func setupHeaderView(_ collectionView:UICollectionView, section:Int, contentWidth:CGFloat, pointY:CGFloat) -> CGFloat{
        let  headerSize = self.delegate?.collectionView?(collectionView, layout: self, referenceSizeForHeaderInSection: section)
        let  headerHeight = headerSize?.height ?? self.headerReferenceSize.height
        let headerLayoutAttribute = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, with: IndexPath(item: 0, section: section))
        headerLayoutAttribute.frame = CGRect(0.0, pointY, contentWidth, headerHeight)
        headerLayoutAttributes.append(headerLayoutAttribute)
        return headerHeight
    }
    
    private func setupFooterView(_ collectionView:UICollectionView, section:Int, contentWidth:CGFloat, pointY:CGFloat) -> CGFloat{
        let  footerSize = self.delegate?.collectionView?(collectionView, layout: self, referenceSizeForFooterInSection: section)
        let  footerHeight = footerSize?.height ?? self.footerReferenceSize.height
        let footerLayoutAttribute = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, with: IndexPath(item: 0, section: section))
        footerLayoutAttribute.frame = CGRect(0.0, pointY, contentWidth, footerHeight)
        footerLayoutAttributes.append(footerLayoutAttribute)
        return footerHeight
    }
    
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        
        let itemSize  = self.delegate?.collectionView?(self.collectionView!, layout: self, sizeForItemAt: indexPath) ?? self.itemSize
        let sectionWidth = contentWidth - self.sectionInset.left - self.sectionInset.right;
        var x = self.sectionInset.left;
        var y = self.sectionInset.top;
        //重新计算每个 item 的布局
        
        if preAttrs == nil  {
            //创建布局属性
             let attrs = UICollectionViewLayoutAttributes(forCellWith: indexPath);
            //更新item的frame
            attrs.frame = CGRect(x, currentSectionMaxY + headerHeight + self.sectionInset.top,  itemSize.width, itemSize.height)
            self.preAttrs = attrs
            return attrs;
        }
        
        x = (self.preAttrs?.frame.maxX ?? 0) + self.minimumInteritemSpacing;
        if x+itemSize.width > sectionWidth {
            self.numberOfLine += 1;
            x = self.sectionInset.left
            y = (self.preAttrs?.frame.maxY ?? 0)+self.minimumLineSpacing;
        }else {
            y = self.preAttrs?.frame.origin.y ?? 0
        }

        //创建布局属性
        let attrs = UICollectionViewLayoutAttributes(forCellWith: indexPath);
        //更新item的frame
        attrs.frame = CGRect(x, y,  itemSize.width, itemSize.height);
        self.preAttrs = attrs;
        return attrs;
    }
    
    
    override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        
        if elementKind ==  UICollectionView.elementKindSectionHeader {
            return headerLayoutAttributes[indexPath.item]
        }
        
        if elementKind ==  UICollectionView.elementKindSectionFooter {
            return footerLayoutAttributes[indexPath.item]
        }
        
       return headerLayoutAttributes[indexPath.item];
        
    }
    
    override var collectionViewContentSize: CGSize {
        
        let contentInset = self.collectionView!.contentInset;
        let width = self.collectionView!.bounds.width - contentInset.left - contentInset.right;
        let height = max(self.collectionView!.bounds.height, contentMaxY);
        return CGSize(width, height);
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {

        var result:[UICollectionViewLayoutAttributes] = []

        itemLayoutAttributes.forEach { (attributeArr) in
            attributeArr.forEach { ( attribute) in
                if rect.intersects(attribute.frame) {
                    result.append(attribute)
                }
            }
        }

        headerLayoutAttributes.forEach { (attribute) in
            if attribute.frame.size.height > 0 && rect.intersects(attribute.frame) {
                result.append(attribute)
            }
        }

        footerLayoutAttributes.forEach { (attribute) in
            if attribute.frame.size.height > 0 && rect.intersects(attribute.frame) {
                result.append(attribute)
            }
        }
        if !self.sectionHeadersPinToVisibleBounds{
            return result;
        }

         return result;
    }
    
    
}
