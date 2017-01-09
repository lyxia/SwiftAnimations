//
//  LYXButtonAnimation.swift
//  LYXButtonAnimation
//
//  Created by lyxia on 2017/1/9.
//  Copyright © 2017年 lyxia. All rights reserved.
//

import UIKit

class LYXButtonAnimation: UIView {
    // MARK: lift cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        configView()
    }
    
    private func configView() {
        self.backgroundColor = .clear
        
        shapeLayer.path = drawBezierPath(x: self.bounds.height / 2).cgPath
        self.layer.addSublayer(shapeLayer)
        
        self.addSubview(button)
        
        configLayout()
    }
    
    private func configLayout() {
        button.frame = self.bounds
        button.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
    }
    
    // MARK: property
    public lazy var button: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 13)
        btn.addTarget(self, action: #selector(clickBtnHandler(_:)), for: .touchUpInside)
        return btn
    }()
    
    private lazy var shapeLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.strokeColor = UIColor.white.cgColor
        layer.lineWidth = 2
        return layer
    }()
    
    // MARK: action
    @objc private func clickBtnHandler(_ btn: UIButton) {
        btn.isEnabled = false
        
        smallCricleToBigCricle()
    }
    
    //小圆变大圆
    private var cricleAnimationLayer: CAShapeLayer?
    fileprivate func smallCricleToBigCricle() {
        let animationLayer = CAShapeLayer()
        animationLayer.fillColor = UIColor.white.cgColor
        animationLayer.frame = CGRect(x: self.bounds.width / 2, y: self.bounds.height / 2, width: 5, height: 5)
        self.layer.addSublayer(animationLayer)
        
        let startCricle = UIBezierPath(arcCenter: CGPoint.zero, radius: 0, startAngle: 0, endAngle: CGFloat(M_PI)*2, clockwise: true)
        let endCricle = UIBezierPath(arcCenter: CGPoint.zero, radius: (self.bounds.height / 2) - 10, startAngle: 0, endAngle: CGFloat(M_PI)*2, clockwise: true)
        
        let animation = CABasicAnimation()
        animation.fromValue = startCricle.cgPath
        animation.toValue = endCricle.cgPath
        animation.duration = 0.5
        animation.keyPath = "path"
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        animation.delegate = self
        animation.setValue("smallCricleToBigCricle", forKey: "key")
        animationLayer.add(animation, forKey: nil)
        
        cricleAnimationLayer = animationLayer
    }
    
    //小环变大环
    fileprivate func smallRingToBigRing() {
        cricleAnimationLayer?.fillColor = UIColor.clear.cgColor
        cricleAnimationLayer?.strokeColor = UIColor.white.cgColor
        cricleAnimationLayer?.lineWidth = 10
        
        let endCricle = UIBezierPath(arcCenter: CGPoint.zero, radius: self.bounds.height - 20, startAngle: 0, endAngle: CGFloat(M_PI)*2, clockwise: true)
        
        let pathAnimation = CABasicAnimation()
        pathAnimation.toValue = endCricle.cgPath
        pathAnimation.keyPath = "path"
        pathAnimation.duration = 0.5
        pathAnimation.isRemovedOnCompletion = false
        pathAnimation.fillMode = kCAFillModeForwards
        
        let opacityAnimation = CABasicAnimation()
        opacityAnimation.toValue = 0.0
        opacityAnimation.keyPath = "opacity"
        opacityAnimation.beginTime = 0.1
        opacityAnimation.duration = 0.5
        opacityAnimation.isRemovedOnCompletion = false
        opacityAnimation.fillMode = kCAFillModeForwards
        
        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [pathAnimation, opacityAnimation]
        groupAnimation.duration = max(pathAnimation.duration + pathAnimation.beginTime, opacityAnimation.duration + opacityAnimation.beginTime)
        groupAnimation.isRemovedOnCompletion = false
        groupAnimation.fillMode = kCAFillModeForwards
        groupAnimation.delegate = self
        groupAnimation.setValue("smallRingToBigRing", forKey: "key")
        
        cricleAnimationLayer?.add(groupAnimation, forKey: nil)
    }
    
    //填充背景
    private var maskLayer: CALayer!
    fileprivate func fillBackGround() {
        let maskAnimationLayer = CAShapeLayer()
        maskAnimationLayer.fillColor = UIColor.white.cgColor
        maskAnimationLayer.opacity = 0.5
        self.layer.addSublayer(maskAnimationLayer)
        
        maskAnimationLayer.path = drawBezierPath(x: self.bounds.width / 2).cgPath
        
        let endPath = drawBezierPath(x: self.bounds.height / 2).cgPath
        
        let animation = CABasicAnimation()
        animation.keyPath = "path"
        animation.toValue = endPath
        animation.duration = 0.25
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        animation.delegate = self
        animation.setValue("fillBackGround", forKey: "key")
        maskAnimationLayer.add(animation, forKey: nil)
        
        maskLayer = maskAnimationLayer
    }
    
    //合拢并消失
    fileprivate func dismissAnimation() {
        button.isHidden = true
        cricleAnimationLayer?.removeFromSuperlayer()
        cricleAnimationLayer = nil
        maskLayer?.removeFromSuperlayer()
        maskLayer = nil
        
        let endPath = drawBezierPath(x: self.bounds.width / 2).cgPath
        
        let toSmallAnimation = CABasicAnimation()
        toSmallAnimation.keyPath = "path"
        toSmallAnimation.toValue = endPath
        toSmallAnimation.duration = 0.2
        toSmallAnimation.fillMode = kCAFillModeForwards
        toSmallAnimation.isRemovedOnCompletion = false
        
        let opacityAnimation = CABasicAnimation()
        opacityAnimation.keyPath = "opacity"
        opacityAnimation.toValue = 0.0
        opacityAnimation.beginTime = 0.1
        opacityAnimation.duration = 0.2
        opacityAnimation.fillMode = kCAFillModeForwards
        opacityAnimation.isRemovedOnCompletion = false
        
        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [toSmallAnimation, opacityAnimation]
        groupAnimation.duration = max(toSmallAnimation.duration + toSmallAnimation.beginTime, opacityAnimation.duration + opacityAnimation.beginTime)
        groupAnimation.fillMode = kCAFillModeForwards
        groupAnimation.isRemovedOnCompletion = false
        groupAnimation.delegate = self
        groupAnimation.setValue("dismissAnimation", forKey: "key")
        shapeLayer.add(groupAnimation, forKey: nil)
    }
    
    //菊花
    fileprivate func loadingAnimation() {
        let loadingLayer = CAShapeLayer()
        loadingLayer.strokeColor = UIColor.white.cgColor
        loadingLayer.lineWidth = 3
        loadingLayer.frame = CGRect(x: self.bounds.width / 2, y: self.bounds.height / 2, width: 5, height: 5)
        loadingLayer.path = UIBezierPath(arcCenter: CGPoint.zero, radius: self.bounds.height/2 - 10, startAngle: CGFloat(M_PI)/2, endAngle: CGFloat(M_PI), clockwise: true).cgPath
        self.layer.addSublayer(loadingLayer)
        
        let animation = CABasicAnimation()
        animation.fromValue = CGFloat(0)
        animation.toValue = CGFloat(M_PI) * 2
        animation.duration = 0.5
        animation.repeatCount = Float(Int.max)
        animation.keyPath = "transform.rotation.z"
        loadingLayer.add(animation, forKey: nil)
    }
    
    // MARI: util function
    private func drawBezierPath(x: CGFloat) -> UIBezierPath {
        let radius = self.bounds.height / 2 - 3
        let right = self.bounds.width - x
        let left: CGFloat = x
        
        let bezierPath = UIBezierPath()
        bezierPath.lineJoinStyle = .round
        bezierPath.lineCapStyle = .round
        //右边圆弧
        bezierPath.addArc(withCenter: CGPoint(x: right, y:self.bounds.height/2), radius: radius, startAngle: CGFloat(-M_PI)/2, endAngle: CGFloat(M_PI)/2, clockwise: true)
        //左边圆弧
        bezierPath.addArc(withCenter: CGPoint(x: left, y:self.bounds.height/2), radius: radius, startAngle: CGFloat(M_PI)/2, endAngle: CGFloat(-M_PI)/2, clockwise: true)
        bezierPath.close()
        return bezierPath
    }
}

extension LYXButtonAnimation: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        switch anim.value(forKey: "key") as! String {
        case "smallCricleToBigCricle":
            smallRingToBigRing()
        case "smallRingToBigRing":
            fillBackGround()
        case "fillBackGround":
            dismissAnimation()
        case "dismissAnimation":
            loadingAnimation()
        default:
            break
        }
    }
}


