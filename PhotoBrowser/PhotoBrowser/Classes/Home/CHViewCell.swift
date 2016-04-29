//
//  CHViewCell.swift
//  PhotoBrowser
//
//  Created by nick on 16/4/28.
//  Copyright © 2016年 nick. All rights reserved.
//

import UIKit
import SDWebImage

class CHViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var shop : Shop? {
        didSet {
            
            guard let urlString = shop?.q_pic_url else {
                return
            }
            
            let url = NSURL(string: urlString);
            
            imageView.sd_setImageWithURL(url, placeholderImage: UIImage(named: "empty_picture"))
        }
    } 
}
