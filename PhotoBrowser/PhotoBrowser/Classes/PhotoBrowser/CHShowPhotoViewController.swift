//
//  CHShowPhotoViewController.swift
//  PhotoBrowser
//
//  Created by nick on 16/4/28.
//  Copyright © 2016年 nick. All rights reserved.
//

import UIKit

let PhotoId = "cell"
class CHShowPhotoViewController: UIViewController {
    // MARK:- 定义属性
    var shop : [Shop]?
    var indexPath : NSIndexPath?
    
    
    // MARK:- 懒加载
    private lazy var saveBtn : UIButton = UIButton(title: "保存", bkColor: UIColor.darkGrayColor(), fontSize: 14)
    private lazy var backBtn : UIButton = UIButton(title: "返回", bkColor: UIColor.darkGrayColor(), fontSize: 14)
    private lazy var showPhotoView : UICollectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: CHPhotoFlowlayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }

}

extension CHShowPhotoViewController {
    // MARK:- 添加子控件
    private func setupUI() {
        
        view.addSubview(showPhotoView)
        view.addSubview(saveBtn)
        view.addSubview(backBtn)
        //监听按钮的点击
        saveBtn.addTarget(self, action: #selector(CHShowPhotoViewController.saveBtnClick), forControlEvents: .TouchUpInside)
        backBtn.addTarget(self, action: #selector(CHShowPhotoViewController.backBtnClick), forControlEvents: .TouchUpInside)
        //注册
        showPhotoView.registerClass(CHPhotoCell.self, forCellWithReuseIdentifier: PhotoId)
        showPhotoView.dataSource = self
        
    }
    
    // MARK:- 设置子控件的frame
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        showPhotoView.frame = view.bounds
        let BtnW : CGFloat = 90
        let BtnH : CGFloat = 32
        let BtnY : CGFloat = UIScreen.mainScreen().bounds.height - BtnH - 20
        let saveX : CGFloat = UIScreen.mainScreen().bounds.width - BtnW - 20
        backBtn.frame = CGRect(x: 20, y: BtnY, width: BtnW, height: BtnH)
        saveBtn.frame = CGRect(x: saveX, y: BtnY, width: BtnW, height: BtnH)
    }
}
// MARK:- 按钮的点击
extension CHShowPhotoViewController {
    @objc private func saveBtnClick() {
        print("save")
    }
    @objc private func backBtnClick() {
        dismissViewControllerAnimated(true, completion: nil)
    }
}

extension CHShowPhotoViewController : UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shop?.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(PhotoId, forIndexPath: indexPath)
        as! CHPhotoCell
        
        return cell
    }
    
    
    
}