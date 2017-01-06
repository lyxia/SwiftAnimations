//
//  WaveView.swift
//  LYXWaveAnimation
//
//  Created by lyxia on 2017/1/6.
//  Copyright © 2017年 lyxia. All rights reserved.
//

import Foundation
import UIKit

class WaveView: UIView {
    
    // MARK: life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        configView()
    }
    
    private func configView() {
        
    }
    
    deinit {
        if self.waveShapeLayer != nil {
            self.waveShapeLayer?.path = nil
            self.waveShapeLayer = nil
        }
        removeWaveDisplayLink()
    }
    
    // MARK: public property
    //角速度
    public var angularSpeed: CGFloat = 0.015 {
        didSet {
            drawWave()
        }
    }
    //初相
    public var offsetX: CGFloat = 0 {
        didSet {
            drawWave()
        }
    }
    //移动速度
    public var waveSpeed: CGFloat = 0.1
    //波纹填充颜色
    public var waveColor: UIColor = UIColor.white
    //动画时间
    public var waveTime: TimeInterval = 1.5
    
    // MARK: private property
    //波浪图层
    private var waveShapeLayer: CAShapeLayer?
    //波浪帧率
    private var waveDisplayLink: CADisplayLink?
    
    //MARK: public function
    func wave() {
        guard self.waveShapeLayer?.path == nil else {
            return
        }
        self.waveShapeLayer = CAShapeLayer()
        self.waveShapeLayer!.fillColor = self.waveColor.cgColor
        self.layer.addSublayer(self.waveShapeLayer!)
        
        self.waveDisplayLink = CADisplayLink(target: self, selector: #selector(currentWave))
        self.waveDisplayLink!.add(to: RunLoop.main, forMode: .commonModes)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + waveTime) {
            self.stop()
        }
    }
    
    // MARk: private function
    private func stop () {
        UIView.animate(withDuration: 1.0, animations: {
            self.alpha = 0
        }, completion: { finished in
            self.alpha = 1
            self.removeWaveDisplayLink()
            self.waveShapeLayer?.path = nil
        })
    }
    
    private func drawWave(){
        self.waveShapeLayer?.fillColor = waveColor.cgColor
        
        var x: CGFloat = 0.0
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: self.frame.height/2))
        while x < self.frame.width{
            let y = self.frame.height * sin(self.angularSpeed * x + self.offsetX)
            path.addLine(to: CGPoint(x: x, y: y))
            x += 1
        }
        path.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height))
        path.addLine(to: CGPoint(x: 0, y: self.frame.height))
        path.close()
        
        waveShapeLayer?.path = path.cgPath
    }
    
    @objc private func currentWave () {
        self.offsetX -= self.waveSpeed
    }
    
    private func removeWaveDisplayLink() {
        if (self.waveDisplayLink != nil) {
            self.waveDisplayLink?.invalidate()
            self.waveDisplayLink = nil
        }
    }
}
