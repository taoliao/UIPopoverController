//
//  ViewController.swift
//  UIPopover
//
//  Created by corepress on 2018/9/10.
//  Copyright © 2018年 corepress. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
 
    lazy var popoverAnimator : UIPopoverAnimator = UIPopoverAnimator { (ispresentedFinish) in
        if ispresentedFinish {
            print("modal弹出")
        }else {
            print("modal消失")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
    }

    @IBAction func modalAction(_ sender: UIButton) {
        
        let popoverVC = PopoverViewController()
        
        //modalPresentationStyle=.custom modal出来之后 之前的视图不会消失
        popoverVC.modalPresentationStyle = .custom
        
        popoverVC.transitioningDelegate = popoverAnimator
        
        switch sender.tag {
        case 0:
            popoverAnimator.animatorType = .Boom
            popoverAnimator.presentedViewFrame = self.view.bounds
        case 1:
            popoverAnimator.animatorType = .Center
            popoverAnimator.presentedViewFrame = CGRect(x: (self.view.bounds.width-300)*0.5, y: (self.view.bounds.height-500)*0.5, width: 300, height: 400)
        case 2:
            popoverAnimator.animatorType = .Top
            popoverAnimator.presentedViewFrame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height*0.5)
        default:
            break
        }
        
        self.present(popoverVC, animated: true, completion: nil)
    }
    
}

