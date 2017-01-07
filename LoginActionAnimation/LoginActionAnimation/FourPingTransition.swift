//
//  FourPingTransition.swift
//  LoginActionAnimation
//
//  Created by lyxia on 2017/1/7.
//  Copyright © 2017年 lyxia. All rights reserved.
//

import UIKit

class FourPingTransition: NSObject, UIViewControllerAnimatedTransitioning, CAAnimationDelegate {
    enum TransitionType {
        case present
        case dismiss
    }
    
    let transitionType: TransitionType
    init(transitionType: TransitionType) {
        self.transitionType = transitionType
        super.init()
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.55
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        switch transitionType {
        case .present:
            presentAnimateTransition(using: transitionContext)
        case .dismiss:
            dismissAnimateTransition(using: transitionContext)
        }
    }
    
    func presentAnimateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let focusRect = (transitionContext.viewController(forKey: .from) as? AnimationTransitionFocusType)?.focusRect else {
            fatalError("\(transitionContext.viewController(forKey: .from)) must implement AnimationTransitionFocusType")
        }
        guard let toViewController = transitionContext.viewController(forKey: .to) else {
            fatalError(" must hava ViewControllers")
        }
        
        let containerView = transitionContext.containerView
        containerView.addSubview(toViewController.view)
        
        //画焦点的圆
        let startCycle = UIBezierPath(ovalIn: focusRect)
        //画结束的圆
        let containerRect = containerView.frame
        let x = max(focusRect.midX, containerRect.width - focusRect.midX)
        let y = max(focusRect.midY, containerRect.height - focusRect.midY)
        let radius = sqrtf(powf(Float(x), 2) + powf(Float(y), 2))
        let endCycle = UIBezierPath(arcCenter: containerView.center, radius: CGFloat(radius), startAngle: 0, endAngle: CGFloat(M_PI) * 2.0, clockwise: true)
        let maskLayer = CAShapeLayer()
        maskLayer.path = endCycle.cgPath
        toViewController.view.layer.mask = maskLayer
        
        //动画
        let maskLayerAnimation = CABasicAnimation()
        maskLayerAnimation.delegate = self
        maskLayerAnimation.fromValue = startCycle.cgPath
        maskLayerAnimation.toValue = endCycle.cgPath
        maskLayerAnimation.duration = transitionDuration(using: transitionContext)
        maskLayerAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        maskLayerAnimation.setValue(transitionContext, forKey: "transitionContext")
        maskLayer.add(maskLayerAnimation, forKey: "path")
    }
    
    func dismissAnimateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let focusRect = (transitionContext.viewController(forKey: .to) as? AnimationTransitionFocusType)?.focusRect else {
            fatalError("\(transitionContext.viewController(forKey: .to)) must implement AnimationTransitionFocusType")
        }
        guard let toViewController = transitionContext.viewController(forKey: .to), let fromViewController = transitionContext.viewController(forKey: .from) else {
            fatalError("must have fromViewController")
        }
        
        let containerView = transitionContext.containerView
        containerView.insertSubview(toViewController.view, at: 0)
        
        //画两个圆路径
        let containerRect = containerView.frame
        let radius = sqrtf(powf(Float(containerRect.width), 2) + powf(Float(containerRect.height), 2)) / 2
        let startCycle = UIBezierPath(arcCenter: containerView.center, radius: CGFloat(radius), startAngle: 0, endAngle: CGFloat(M_PI) * 2, clockwise: true)
        let endCycle = UIBezierPath(ovalIn: focusRect)
        let maskLayer = CAShapeLayer()
        maskLayer.fillColor = UIColor.green.cgColor
        maskLayer.path = endCycle.cgPath
        fromViewController.view.layer.mask = maskLayer
        
        //动画
        let masklayerAnimation = CABasicAnimation(keyPath: "path")
        masklayerAnimation.delegate = self
        masklayerAnimation.fromValue = startCycle.cgPath
        masklayerAnimation.toValue = endCycle.cgPath
        masklayerAnimation.duration = transitionDuration(using: transitionContext)
        masklayerAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        masklayerAnimation.setValue(transitionContext, forKey: "transitionContext")
        maskLayer.add(masklayerAnimation, forKey: "path")
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        switch transitionType {
        case .present:
            let transitionContext = anim.value(forKey: "transitionContext") as! UIViewControllerContextTransitioning
            transitionContext.completeTransition(true)
            transitionContext.viewController(forKey: .to)?.view.layer.mask = nil
        default:
            let transitionContext = anim.value(forKey: "transitionContext") as! UIViewControllerContextTransitioning
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            if transitionContext.transitionWasCancelled {
                transitionContext.viewController(forKey: .from)?.view.layer.mask = nil
            }
        }
    }
}
