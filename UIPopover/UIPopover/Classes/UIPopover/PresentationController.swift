//
//  PresentationController.swift
//  UIPopover
//
//  Created by corepress on 2018/9/10.
//  Copyright © 2018年 corepress. All rights reserved.
//

import UIKit

class PresentationController: UIPresentationController {
    var presentedViewFrame = CGRect.zero
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        containerView?.frame = presentedViewFrame
        setUpCorverView()
    }
    
}

extension PresentationController {
    
    //添加模糊遮盖
    func setUpCorverView() {
        
        let coverView = UIView(frame: containerView!.bounds)
        let color = UIColor(white: 0.5, alpha: 0.2)
        coverView.backgroundColor = color
        containerView?.insertSubview(coverView, aboveSubview: presentedView!)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(coverViewTaped))
        tap.numberOfTapsRequired = 1
        coverView.addGestureRecognizer(tap)
    }
    
}

//MARK:事件监听
extension PresentationController {
    @objc private func coverViewTaped() {
        presentedViewController.dismiss(animated: true, completion: nil)
    }
    
}
