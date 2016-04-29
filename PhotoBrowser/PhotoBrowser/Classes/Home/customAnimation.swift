//
//  customAnimation.swift
//  PhotoBrowser
//
//  Created by nick on 16/4/29.
//  Copyright © 2016年 nick. All rights reserved.
//

import UIKit

class customAnimation: NSObject {
    
    var isPresented : Bool = false
}

// MARK:- 转场动画的代理
extension customAnimation : UIViewControllerTransitioningDelegate {
    //弹出动画交给谁管理
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        isPresented = true
        return self
    }
    //消失动画交给谁管理
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        isPresented = false
        return self
    }
}
// MARK:- 设置协议
extension customAnimation : UIViewControllerAnimatedTransitioning {
    //获取动画时间
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 2
    }
    
    // 可以获取转场的上下文:可以通过上下文获取到执行动画的View
    // UITransitionContextFromViewKey : 取出是消失的View,是在做消失动画时会使用
    // UITransitionContextToViewKey : 取出是弹出的View,是在做弹出动画时会使用
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        
    }
    
    
}
