//
//  YXCCAReplicatorLayerController.swift
//  SwiftDemo
//
//  Created by lbkj on 2021/10/27.
//  Copyright © 2021 GGT. All rights reserved.
//

import UIKit

class YXCCAReplicatorLayerController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white;
        
        volumnBars()
        activityIndicator()
        activityIndicator_01()
    }
    
    /// 播放器播放动效
    private func volumnBars() {
        // 创建一个 CAReplicatorLayer 容器
        let replicatorLayer = CAReplicatorLayer()
        replicatorLayer.bounds = CGRect(x: 0, y: 0, width: 30, height: 30)
        replicatorLayer.position = CGPoint(x: self.view.yxc_centerX, y: 100)
        replicatorLayer.masksToBounds = true
        self.view.layer.addSublayer(replicatorLayer)
        
        // 创建一个 CALayer 作为播放器一个播放的上下移动动效
        let calayer = CALayer()
        calayer.bounds = CGRect(x: 0, y: 0, width: 5, height: 30)
        calayer.position = CGPoint(x: 3, y: 40)
        calayer.cornerRadius = 1.0
        calayer.backgroundColor = UIColor.red.cgColor
        replicatorLayer.addSublayer(calayer)
        
        // 创建一个 CABasicAnimation
        let animation = CABasicAnimation(keyPath: "position.y")
        animation.toValue = calayer.position.y - 20
        animation.duration = 0.3
        animation.autoreverses = true
        animation.repeatCount = Float.infinity
        calayer.add(animation, forKey: nil)
        
        replicatorLayer.instanceCount = 4
        replicatorLayer.instanceTransform = CATransform3DMakeTranslation(10, 0, 0)
        replicatorLayer.instanceDelay = 0.25
    }
    
    /// 加载动画
    private func activityIndicator() {
        // 创建一个 CAReplicatorLayer 容器
        let replicatorLayer = CAReplicatorLayer()
        replicatorLayer.backgroundColor = UIColor.lightGray.cgColor
        replicatorLayer.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
        replicatorLayer.position = CGPoint(x: self.view.yxc_centerX, y: 200)
        self.view.layer.addSublayer(replicatorLayer)
        
        let calayer = CALayer()
        calayer.bounds = CGRect(x: 0, y: 0, width: 3, height: 3)
        calayer.position = CGPoint(x: 50, y: 20)
        calayer.backgroundColor = UIColor.white.cgColor
        calayer.cornerRadius = 2.5
        calayer.transform = CATransform3DMakeScale(0.01, 0.01, 0.01)
        replicatorLayer.addSublayer(calayer)
        
        let duration = 1.5
        
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.fromValue = 1.0
        animation.toValue = 0.0
        animation.duration = duration
        animation.repeatCount = Float.infinity
        calayer.add(animation, forKey: nil)
        
        let count = 200
        replicatorLayer.instanceCount = count;
        let angle = CGFloat(2 * Double.pi) / CGFloat(count)
        replicatorLayer.instanceTransform = CATransform3DMakeRotation(angle, 0, 0, 1.0)
        replicatorLayer.instanceDelay = duration / Double(count)
        replicatorLayer.instanceColor = UIColor.white.cgColor
    }
    
    /// 加载动画
    private func activityIndicator_01() {
        let _ = YXCActivityView.show(inView: self.view)
    }
    
    @objc func injected() {
        
        self.view.yxc_removeAllSubViews()
        self.view.layer.sublayers?.removeAll()
        
        volumnBars()
        activityIndicator()
        activityIndicator_01()
    }
}
