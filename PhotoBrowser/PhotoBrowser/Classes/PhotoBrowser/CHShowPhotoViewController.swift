//
//  CHShowPhotoViewController.swift
//  PhotoBrowser
//
//  Created by nick on 16/4/28.
//  Copyright © 2016年 nick. All rights reserved.
//

import UIKit


class CHShowPhotoViewController: UIViewController {
    // MARK:- 定义属性
    let PhotoId = "cell"
    var shops : [Shop]?
    var indexPath : NSIndexPath?
    
    
    // MARK:- 懒加载
    private lazy var saveBtn : UIButton = UIButton(title: "保存", bkColor: UIColor.darkGrayColor(), fontSize: 14)
    private lazy var backBtn : UIButton = UIButton(title: "返回", bkColor: UIColor.darkGrayColor(), fontSize: 14)
    private lazy var showPhotoView : UICollectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: CHPhotoFlowlayout())
    
    override func loadView() {
        super.loadView()
        
        view.frame.size.width += 15
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        //滚动到对应的图片
        showPhotoView.scrollToItemAtIndexPath(indexPath!, atScrollPosition: .Left, animated: false)
    }
}

extension CHShowPhotoViewController {
    
    
}

extension CHShowPhotoViewController {
    // MARK:- 添加子控件
    private func setupUI() {
        
        view.addSubview(showPhotoView)
        view.addSubview(saveBtn)
        view.addSubview(backBtn)
        
        // MARK:- 设置子控件的frame
        showPhotoView.frame = view.bounds
        let BtnW : CGFloat = 90
        let BtnH : CGFloat = 32
        let BtnY : CGFloat = UIScreen.mainScreen().bounds.height - BtnH - 20
        let saveX : CGFloat = UIScreen.mainScreen().bounds.width - BtnW - 20
        backBtn.frame = CGRect(x: 20, y: BtnY, width: BtnW, height: BtnH)
        saveBtn.frame = CGRect(x: saveX, y: BtnY, width: BtnW, height: BtnH)
        
        //监听按钮的点击
        saveBtn.addTarget(self, action: #selector(CHShowPhotoViewController.saveBtnClick), forControlEvents: .TouchUpInside)
        backBtn.addTarget(self, action: #selector(CHShowPhotoViewController.backBtnClick), forControlEvents: .TouchUpInside)
        //注册
        showPhotoView.registerClass(CHPhotoCell.self, forCellWithReuseIdentifier: PhotoId)
        showPhotoView.dataSource = self
        
    }
}

// MARK:- 实现dimissDelegat中的方法
extension CHShowPhotoViewController : DisMissDelegate {
    func currentIndexPath() -> NSIndexPath {
        // 1.获取正在显示的cell
        let cell = showPhotoView.visibleCells().first!
        
        // 2.获取indexPath
        return showPhotoView.indexPathForCell(cell)!
    }
    
    func imageView() -> UIImageView {
        // 1.创建UIImageView对象
        let imageView = UIImageView()
        
        // 2.设置对象的图片
        // 2.1.获取正在显示的cell
        let cell = showPhotoView.visibleCells().first as! CHPhotoCell
        
        // 2.2.取出图片
        imageView.image = cell.imageView.image
        
        // 3.设置imageView的属性
        imageView.contentMode = .ScaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }
}


// MARK:- 按钮的点击
extension CHShowPhotoViewController {
    @objc private func saveBtnClick() {
        
        //取出当前显示的cell
        let cell = showPhotoView.visibleCells().first as! CHPhotoCell
        
        let image = cell.imageView.image
        //保存到系统相册
        UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
    }
    @objc private func backBtnClick() {
        dismissViewControllerAnimated(true, completion: nil)
    }
}

extension CHShowPhotoViewController : UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shops?.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(PhotoId, forIndexPath: indexPath)
        as! CHPhotoCell
        
        cell.shop = shops?[indexPath.item]
        return cell
    }
}