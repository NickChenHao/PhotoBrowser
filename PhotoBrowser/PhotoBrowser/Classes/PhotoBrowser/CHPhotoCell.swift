//
//  CHPhotoCell.swift
//  PhotoBrowser
//
//  Created by nick on 16/4/28.
//  Copyright © 2016年 nick. All rights reserved.
//

import UIKit
import SDWebImage

class CHPhotoCell: UICollectionViewCell {

    // MARK:- 懒加载属性
    lazy var imageView : UIImageView = UIImageView()
    
    var shop :Shop? {
        didSet {
            //nil值校验
            guard let urlString = shop?.q_pic_url else {
                return
            }
            //获取小图
            var smallImage = SDWebImageManager.sharedManager().imageCache.imageFromMemoryCacheForKey(urlString)
            if smallImage == nil {
                smallImage = UIImage(named: "empty_picture")
            }
            //设置imageView的frame
            imageView.frame = currentImageFrame(smallImage)
            
            //nil值校验
            guard let BigUrlString = shop?.z_pic_url else {
                return
            }
            //获取大图
            let url = NSURL(string: BigUrlString)
            imageView.sd_setImageWithURL(url, placeholderImage: smallImage) { (image, error, type, url) in
                //设置设置imageView的frame
                self.imageView.frame = currentImageFrame(image)
            }
        }
    }
    
    //添加子控件
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}















