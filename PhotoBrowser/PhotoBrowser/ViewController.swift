//
//  ViewController.swift
//  PhotoBrowser
//
//  Created by nick on 16/4/28.
//  Copyright © 2016年 nick. All rights reserved.
//

import UIKit

private let ID = "cell"

//collectionView
class ViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //注册cell
        collectionView?.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: ID)
    }
}


// MARK:- 数据源方法
extension ViewController {
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(ID, forIndexPath: indexPath)
        
        cell.backgroundColor = UIColor.grayColor()
        
        return cell
    }
}

