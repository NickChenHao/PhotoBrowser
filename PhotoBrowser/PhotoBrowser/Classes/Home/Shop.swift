//
//  shop.swift
//  PhotoBrowser
//
//  Created by nick on 16/4/28.
//  Copyright © 2016年 nick. All rights reserved.
//

import UIKit

class Shop: NSObject {

    var q_pic_url : String = ""
    var z_pic_url : String = ""
    
    init(dict : [String : AnyObject]) {
        super.init()
        //KVC
        setValuesForKeysWithDictionary(dict)
    }
    //重写系统方法解决模型与字典key不对应产生报错
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
}
