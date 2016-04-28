//
//  CHFlowLayout.swift
//  PhotoBrowser
//
//  Created by nick on 16/4/28.
//  Copyright © 2016年 nick. All rights reserved.
//

import UIKit

class CHFlowLayout: UICollectionViewFlowLayout {

    override func prepareLayout() {
        super.prepareLayout()
        
        // 1.定义常量
        let cols : CGFloat = 3
        let margin : CGFloat = 10
        
        // 2.计算item的WH
        let itemWH = (UIScreen.mainScreen().bounds.width - (cols + 1) * margin) / cols
        
        // 3.设置布局内容
        itemSize = CGSize(width: itemWH, height: itemWH)
        minimumInteritemSpacing = 0
        minimumLineSpacing = margin
        
        // 4.设置collectionView的属性
        collectionView?.contentInset = UIEdgeInsets(top: margin + 64, left: margin, bottom: margin, right: margin)
    }
}
