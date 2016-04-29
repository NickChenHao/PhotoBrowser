//
//  UIButton-Extenstion.swift
//  PhotoBrowser
//
//  Created by nick on 16/4/28.
//  Copyright © 2016年 nick. All rights reserved.
//

import UIKit

extension UIButton {
    
    convenience init(title: String ,bkColor: UIColor ,fontSize: CGFloat){
        self.init()
        
        setTitle(title, forState: .Normal)
        backgroundColor = bkColor
        titleLabel?.font = UIFont.systemFontOfSize(fontSize)
    }
    
}