//
//  UIPopoverAnimator.swift
//  UIPopover
//
//  Created by corepress on 2018/9/10.
//  Copyright © 2018年 corepress. All rights reserved.
//

import UIKit

enum PopoverAnimatorType: Int {
    case Boom = 0  //默认底部弹出
    case Center = 1
    case Top = 2
}

class UIPopoverAnimator: NSObject {

    var ispresented = false
    var animatorType : PopoverAnimatorType = PopoverAnimatorType.Boom
    var presentedViewFrame = CGRect.zero
    
    var callBack : ((_ presentedFinish : Bool) -> ())?
    
    init(callBack : @escaping (_ presentedFinish : Bool) -> ()) {
        self.callBack = callBack
    }
    
}

extension UIPopoverAnimator:UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let presentationController = PresentationController(presentedViewController: presented, presenting: presenting)
        presentationController.presentedViewFrame = self.presentedViewFrame
        return presentationController
    }
   
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        ispresented = true
        callBack!(true)
        return (self as UIViewControllerAnimatedTransitioning)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        ispresented = false
        callBack!(false)
        return (self as UIViewControllerAnimatedTransitioning)
    }
    
}

extension UIPopoverAnimator: UIViewControllerAnimatedTransitioning {

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        ispresented ? setAnimateForPresented(using: transitionContext):setAnimateForDissmiss(using: transitionContext)
    }
    
    //自定义弹出动画 presentedView dismissView指针指向同一地址
    func setAnimateForPresented(using transitionContext: UIViewControllerContextTransitioning) {
        
        let presentedView = transitionContext.view(forKey: UITransitionContextViewKey.to)!
        transitionContext.containerView.addSubview(presentedView)
        
        switch animatorType {
        case .Boom:
             presentedView.transform = CGAffineTransform(translationX: 0, y: (presentedView.bounds.size.height))
        case .Center:
             presentedView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
        case .Top:
             presentedView.transform = CGAffineTransform(translationX: 0, y: -(transitionContext.containerView.bounds.size.height))
        }
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            presentedView.transform = .identity
        }) { (_) in
            transitionContext.completeTransition(true)
        }
    }
    
    //自定义消失动画
    func setAnimateForDissmiss(using transitionContext: UIViewControllerContextTransitioning) {
        
        let dismissView = transitionContext.view(forKey: UITransitionContextViewKey.from)!
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            
            switch self.animatorType {
            case .Boom:
                dismissView.transform = CGAffineTransform(translationX: 0, y: (dismissView.bounds.size.height))
            case .Center:
                dismissView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
            case .Top:
                dismissView.transform = CGAffineTransform(translationX: 0, y: -(transitionContext.containerView.bounds.size.height))
            }

        }) { (_) in
            dismissView.removeFromSuperview()
            transitionContext.completeTransition(true)
        }
        
    }
}
