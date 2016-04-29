//
//  common.swift
//  PhotoBrowser
//
//  Created by nick on 16/4/29.
//  Copyright © 2016年 nick. All rights reserved.
//

import UIKit

func currentImageFrame(image : UIImage) -> CGRect {
        
    let x : CGFloat = 0
    let width = UIScreen.mainScreen().bounds.width
    let height = width * image.size.height / image.size.width
    let y = (UIScreen.mainScreen().bounds.height - height) * 0.5
    
    return CGRect(x: x, y: y, width: width, height: height)
}

