//
//  customAnimation.swift
//  PhotoBrowser
//
//  Created by nick on 16/4/29.
//  Copyright © 2016年 nick. All rights reserved.
//

import UIKit

// MARK:- 定义弹出View的协议
protocol PresentDelegate : class{
    
    func homeRect(indexPath : NSIndexPath) -> CGRect
    func photoBrowserRect(indexPath : NSIndexPath) -> CGRect
    func imageView(indexPath : NSIndexPath) -> UIImageView
}

class CustomAnimation: NSObject {
    ///是否弹出
    var isPresented : Bool = false
    ///代理属性
    weak var presentDelegate : PresentDelegate?
    var indexPath : NSIndexPath?
}

// MARK:- 转场动画的代理
extension CustomAnimation : UIViewControllerTransitioningDelegate {
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
extension CustomAnimation : UIViewControllerAnimatedTransitioning {
    //获取动画时间
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 1.0
    }
    
    /*
      可以获取转场的上下文:可以通过上下文获取到执行动画的View
      UITransitionContextFromViewKey : 取出是消失的View,是在做消失动画时会使用
      UITransitionContextToViewKey : 取出是弹出的View,是在做弹出动画时会使用
     */
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        isPresented ? animationForPresentedView(transitionContext) : animationForDismissedView(transitionContext)
    }
    
    //弹出的view
    func animationForPresentedView(transitionContext: UIViewControllerContextTransitioning) {
        //取出弹出的View
        let presentedView = transitionContext.viewForKey(UITransitionContextToViewKey)!
        //加到containerVie中w
        transitionContext.containerView()?.addSubview(presentedView)
        
        guard let presentDelegate = presentDelegate else {
            return
        }
        guard let indexPath = indexPath else {
            return
        }
        //创建imageView
        let imageView = presentDelegate.imageView(indexPath)
        //将imageVIew添加的父控件上
        transitionContext.containerView()?.addSubview(imageView)
        //设置imageView的的起始位置
        imageView.frame = presentDelegate.homeRect(indexPath)
        //执行动画
        presentedView.alpha = 0.0
        transitionContext.containerView()?.backgroundColor = UIColor.blackColor()
        UIView.animateWithDuration(transitionDuration(transitionContext), animations: { 
            //设置最终位置
            imageView.frame = presentDelegate.photoBrowserRect(indexPath)
            
            }) { (_) in
                presentedView.alpha = 1.0
                //移除iamgeView
                imageView.removeFromSuperview()
                transitionContext.containerView()?.backgroundColor = UIColor.clearColor()
                //需要说明完成
                transitionContext.completeTransition(true)
        }
        
    }
    
    //消失的view
    func animationForDismissedView(transitionContext: UIViewControllerContextTransitioning) {
        //取出消失的View
        let dismissedView = transitionContext.viewForKey(UITransitionContextFromViewKey)!
        //执行动画
        UIView.animateWithDuration(transitionDuration(transitionContext), animations: { 
           
            dismissedView.alpha = 0.0
            
            }) { (_) in
                //移除dismissedView
                dismissedView.removeFromSuperview()
                transitionContext.completeTransition(true)
        }
        
    }
}
