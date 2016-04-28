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
    
    private lazy var shops : [Shop] = [Shop]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //请求数据
        loadData(0)
    
    }
}
//请求数据
extension ViewController {
    
    private func loadData(offSet : Int) {
        AFNTool.shareAFN.loadHomeData(offSet) { (resoult, error) in
            if error != nil {
                print(error)
                return
            }
            
            guard let resoultArray = resoult else {
                print("数据不正确")
                return
            }
            for resoultDict in resoultArray {
                let shop = Shop(dict: resoultDict)
                self.shops.append(shop)
                
            }
            self.collectionView?.reloadData()
        }
    }
}

// MARK:- 数据源方法
extension ViewController {
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.shops.count
     
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(ID, forIndexPath: indexPath) as! CHViewCell
        
        cell.shop = shops[indexPath.item]
        
        if indexPath.item == self.shops.count - 1 {
            loadData(self.shops.count)
        }
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        showPhotoBrowser(indexPath)
    }
    
}
//点击图片modal
extension ViewController {
    func showPhotoBrowser(indexPath : NSIndexPath) {
        
        let vc = CHShowPhotoViewController()
        
        vc.shop = shops
        vc.indexPath = indexPath
        
        presentViewController(vc, animated: true, completion: nil)
        
    }
    
}



