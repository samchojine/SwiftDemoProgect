//
//  UICollectionView+Extension.swift
//  SwiftDemoProject
//
//  Created by champ on 2020/6/17.
//  Copyright © 2020 champ. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    // MARK: - 注册手写代码cell
    func registerCell<T: UICollectionViewCell>(anyClass: T.Type) {
        let className = "\(String(describing: anyClass))"
        register(anyClass, forCellWithReuseIdentifier: className)
    }
   // MARK: - 注册xibCell
    func registerCell<T: UICollectionViewCell>(nibClass: T.Type) {
        //let bundle = Bundle(for: nibClass)
        let nibName = "\(String(describing: nibClass))"
        let nib = UINib(nibName: nibName, bundle: nil)
        register(nib, forCellWithReuseIdentifier: nibName)
    }
    
    // MARK: - 注册手写代码Header
    func registerHeader<T: UICollectionReusableView>(anyClass: T.Type) {
        let className = "\(String(describing: anyClass))"
        register(anyClass, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: className)
    }
    
    // MARK: - 注册手写代码Fooder
    func registerFooter<T: UICollectionReusableView>(anyClass: T.Type) {
        let className = "\(String(describing: anyClass))"
        register(anyClass, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: className)
    }
    // MARK: - 注册xib HeaderFooder
    func registerHeaderFooter<T: UICollectionReusableView>(nibClass: T.Type, forSupplementaryViewOfKind elementKind: String)  {
        //let bundle = Bundle(for: T.self)
        let nibName = "\(String(describing: nibClass))"
        let nib = UINib(nibName: nibName, bundle: nil)
        register(nib, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: nibName)
    }

    // MARK: - 生成cell
    func cell<T: UICollectionViewCell>(anyClass: T.Type, for indexPath: IndexPath) -> T {
        
        let className = "\(String(describing: anyClass))"
        guard let cell = dequeueReusableCell(withReuseIdentifier: className, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier '\(className)'")
        }

        return cell
    }

    // MARK: - 生成Header
    func header<T: UICollectionReusableView>(anyClass: T.Type, for indexPath: IndexPath) -> T  {
        
        let className = "\(String(describing: anyClass))"
        guard let supplementaryView = dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: className, for: indexPath) as? T else {
            fatalError("Could not dequeue supplementary view of kind '\(UICollectionView.elementKindSectionHeader)' with identifier '\(className)'")
        }

        return supplementaryView
    }
    
    
    // MARK: - 生成Fooder
    func Footer<T: UICollectionReusableView>(anyClass: T.Type, for indexPath: IndexPath) -> T  {
        
        let className = "\(String(describing: anyClass))"
        guard let supplementaryView = dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: className, for: indexPath) as? T else {
            fatalError("Could not dequeue supplementary view of kind '\(UICollectionView.elementKindSectionFooter)' with identifier '\(className)'")
        }

        return supplementaryView
    }
    
    
    
    
    
    
    
    
}
