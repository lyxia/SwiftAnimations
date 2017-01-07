//
//  MainViewController.swift
//  LoginActionAnimation
//
//  Created by lyxia on 2017/1/7.
//  Copyright © 2017年 lyxia. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UIViewControllerTransitioningDelegate {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupViewController()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        setupViewController()
    }
    
    func setupViewController() {
        self.transitioningDelegate = self
    }
    
    //MARk: UIViewControllerTransitioningDelegate
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return FourPingTransition(transitionType: .present)
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return FourPingTransition(transitionType: .dismiss)
    }
}
