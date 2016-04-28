//
//  AFNTool.swift
//  PhotoBrowser
//
//  Created by nick on 16/4/28.
//  Copyright © 2016年 nick. All rights reserved.
//

import UIKit
import AFNetworking

enum requstType {
    case GET
    case POST
}

class AFNTool: AFHTTPSessionManager {
    //单例AFNTool
    static let shareAFN : AFNTool = {
        
        let tools = AFNTool()
        tools.responseSerializer.acceptableContentTypes?.insert("text/html")
        
        return tools
    }()
}
//封装AFN
extension AFNTool {
    
    func requst(type:requstType, URLString:String, parameters:[String : AnyObject], finished:(resoult : AnyObject?, error : NSError?)->()) {
        
        let successRequst = { (task: NSURLSessionDataTask, resoult: AnyObject?) in
            finished(resoult: resoult, error: nil)
        }
        let failureRequst = { (task: NSURLSessionDataTask?, error: NSError) in
            finished(resoult: nil, error: error)
        }
        
        //判断类型
        switch type {
            case .GET:
                GET(URLString, parameters: parameters, progress: nil, success: successRequst, failure: failureRequst)
            case .POST:
                 POST(URLString, parameters: parameters, progress: nil, success: successRequst,failure: failureRequst)
        }
    }
}
//请求首页数据
extension AFNTool {

    func loadHomeData(offSet : Int, finished:(resoult : [[String : AnyObject]]?, error : NSError?)->()) {
        // 1.获取请求的URLString
        let urlString = "http://mobapi.meilishuo.com/2.0/twitter/popular.json"
        
        // 2.获取请求的参数
        let parameters = ["offset" : "\(offSet)", "limit" : "30", "access_token" : "b92e0c6fd3ca919d3e7547d446d9a8c2"]
        
        // 3. 发送请求
        requst(.GET, URLString: urlString, parameters: parameters) { (resoult, error) -> () in
            if error != nil {
                finished(resoult: nil, error: error)
            }
            //获取结果
            guard let resoult = resoult as? [String : AnyObject] else {
                finished(resoult: nil, error: NSError(domain: "data - error", code: -1101, userInfo: nil))
                return
            }
            finished(resoult: resoult["data"] as? [[String : AnyObject]], error: nil)
            
        }
    }
}






