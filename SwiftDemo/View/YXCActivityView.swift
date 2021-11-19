//
//  YXCActivityView.swift
//  SwiftDemo
//
//  Created by lbkj on 2021/10/27.
//  Copyright © 2021 GGT. All rights reserved.
//

import UIKit

class YXCActivityView: UIView {
    /// 定时器
    lazy private var displayLink: CADisplayLink = {
        var link = CADisplayLink(target: self, selector: #selector(displayLinkAction))
        link.add(to: .main, forMode: .default)
        return link
    }()
    
    /// 显示圆环
    private let animationLayer = CAShapeLayer().then {
        $0.bounds = CGRect(x: 0, y: 0, width: 60, height: 60)
        $0.fillColor = UIColor.clear.cgColor
        $0.strokeColor = UIColor.white.cgColor
        $0.lineWidth = 4.0
        $0.lineCap = .round
        $0.lineJoin = .bevel
        let maskLayer = CALayer()
        maskLayer.frame = $0.bounds
//        $0.mask = maskLayer
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.fromValue = 0
        animation.toValue = Double.pi * 2
        animation.duration = 1;
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        animation.isRemovedOnCompletion = false
        animation.repeatCount = Float(CGFloat.infinity)
        animation.fillMode = .forwards
        animation.autoreverses = false
        maskLayer.add(animation, forKey: "rotate")
    }
    
    /// 开始角度
    private var startAngle: CGFloat = 0.0
    
    ///  结束角度
    private var endAngle: CGFloat = 0.0
    
    /// 当前动画进度
    private var progress: CGFloat = 0.0

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .lightGray
        animationLayer.position = CGPoint(x: self.yxc_width / 2.0, y: self.yxc_height / 2.0)
        self.layer.addSublayer(animationLayer)
        displayLink.isPaused = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    /// 定时器响应方法
    @objc private func displayLinkAction() {
        progress += speed()
        if progress >= 1 {
            progress = 0
        }
        updateAnimationLayer()
    }
    
    private func speed() -> CGFloat {
        if endAngle > Double.pi {
            return 0.1 / 60.0
        }
        return 2 / 60.0
    }
    
    /// 刷新动画
    private func updateAnimationLayer() {
        startAngle = -Double.pi / 2;
        endAngle = -Double.pi / 2 + progress * Double.pi * 2;
        
        if endAngle > Double.pi {
            let progress_01 = 1 - (1 - progress) / 0.25
            startAngle = -Double.pi / 2 + progress_01 * Double.pi * 2
        }
        
        let radius = animationLayer.bounds.size.width / 2.0 - animationLayer.lineWidth;
        let centerX = animationLayer.bounds.size.width * 0.5
        let centerY = animationLayer.bounds.size.height * 0.5
        let path = UIBezierPath(arcCenter: CGPoint(x: centerX, y: centerY), radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        path.lineCapStyle = .round
        animationLayer.path = path.cgPath
    }
    
    private func start() {
        displayLink.isPaused = false
    }
    
    private func pause() {
        displayLink.isPaused = true;
    }
    
    private func hide() {
        displayLink.isPaused = true
        progress = 0
    }
    
    public class func show(inView view: UIView) -> YXCActivityView {
        self .hidden(fromView: view)
        let activityView = YXCActivityView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        activityView.start()
        activityView.center = view.center
        view.addSubview(activityView)
        return activityView
    }
    
    public class func hidden(fromView view: UIView) {
        for subView in view.subviews {
            if subView.isKind(of: self) == true {
                let activityView: YXCActivityView = subView as! YXCActivityView
                activityView.pause()
            }
        }
    }
}
