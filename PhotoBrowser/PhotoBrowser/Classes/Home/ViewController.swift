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
    private lazy var customAnimation = CustomAnimation()
    
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
//点击图片modal
            loadData(self.shops.count)
        }
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        showPhotoBrowser(indexPath)
    }
    
}
extension ViewController {
    func showPhotoBrowser(indexPath : NSIndexPath) {
        
        let vc = CHShowPhotoViewController()
        
        vc.indexPath = indexPath
        vc.shops = shops
        
        //3d翻转modal
//        vc.modalTransitionStyle = .FlipHorizontal
        
        //不让背景为黑色
//        vc.modalPresentationStyle = .Custom
        //设置代理(自定义动画)
        vc.transitioningDelegate = customAnimation
        
        customAnimation.indexPath = indexPath
        customAnimation.presentDelegate = self

        presentViewController(vc, animated: true, completion: nil)
    }
}
// MARK:- 实现协议
extension ViewController : PresentDelegate {
    func homeRect(indexPath: NSIndexPath) -> CGRect {
        //取出cell
        let cell = (collectionView?.cellForItemAtIndexPath(indexPath))!
        
        //将cell的frame转成window的
        let homeFrame = collectionView!.convertRect(cell.frame, toCoordinateSpace: UIApplication.sharedApplication().keyWindow!)
        
        return homeFrame
    }
    
    func photoBrowserRect(indexPath: NSIndexPath) -> CGRect {
        //取出cell
        let cell =  (collectionView?.cellForItemAtIndexPath(indexPath))! as! CHViewCell
        
        //取出cell中显示的图片
        let image = cell.imageView.image
        
        //返回计算好的image的尺寸
        return  currentImageFrame(image!)
    }
    
    func imageView(indexPath: NSIndexPath) -> UIImageView {
        // 1.创建imageView对象
        let imageView = UIImageView()
        
        // 2.设置显示的图片
        // 2.1.取出cell
        let cell = (collectionView?.cellForItemAtIndexPath(indexPath))! as! CHViewCell
        
        // 2.2.取出cell中显示的图片
        let image = cell.imageView.image
        
        // 2.3.设置图片
        imageView.image = image
        
        // 3.设置imageView的属性
        imageView.contentMode = .ScaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }
}


