//
//  LBScanView.swift
//  Runner
//
//  Created by guogt on 2022/5/13.
//

import UIKit
import Then

class LBScanView: UIView {

    // MARK: - Property

    /// 返回按钮
    private let backButton: UIButton = UIButton().then {
        $0.setImage(UIImage.init(named: "navigation_back_white"), for: .normal)
    }

    /// 导航栏标题
    private let titleLabel: UILabel = UILabel().then {
        $0.font = .systemFont(ofSize: 18, weight: .medium)
        $0.text = "连接设备"
        $0.textColor = .white
    }

    /// 相册访问按钮
    private let photoButton: UIButton = UIButton().then {
        $0.setImage(UIImage.init(named: "scan_photo_btn"), for: .normal)
        $0.backgroundColor = UIColor.init(white: 0, alpha: 0.3)
        $0.layer.cornerRadius = 24
        $0.layer.masksToBounds = true
    }

    /// 描述
    private let descLabel: UILabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16)
        $0.textColor = .white
        $0.text = "请扫描「投屏二维码」"
    }

    /// 扫码横线图片
    private let lineImageView: UIImageView = UIImageView().then {
        $0.image = .init(named: "scan_line_image")
        $0.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 75)
        $0.center = CGPoint(x: UIScreen.main.bounds.midX, y: 193 * scaleY)
        $0.isHidden = true
    }

    /// 横线是否向上动画
    private var isLineUp: Bool = false

    /// 定时器
    private var timer: Timer?

    // MARK: - Lazy

    // MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - Custom Accessors(Setter 与 Getter 方法)

    // MARK: - IBActions

    // MARK: - Public

    /// 扫描动画开始
    public func startAnimation() {
        self.p_startTimer()
    }

    /// 扫描动画暂停
    public func pauseAnimation() {
        self.stopAnimation()
    }

    /// 扫描动画结束
    public func stopAnimation() {
        self.lineImageView.isHidden = true
        self.p_stopTimer()
    }

    /// 返回按钮事件
    public func addBackAction(target: Any, action: Selector) {
        self.backButton.addTarget(target, action: action, for: .touchUpInside)
    }

    // MARK: - Private

    /// 开启定时器
    private func p_startTimer() {
        self.p_stopTimer()

        self.timer = Timer.scheduledTimer(timeInterval: 0.02, target: self, selector: #selector(p_changeLineImageView), userInfo: nil, repeats: true)
        RunLoop.current.add(self.timer!, forMode: .common)
        self.timer?.fire()
    }

    /// 停止定时器
    private func p_stopTimer() {
        if (self.timer != nil) {
            self.timer?.invalidate()
            self.timer = nil
        }
    }

    /// 横线上下动画
    @objc private func p_changeLineImageView() {
        self.lineImageView.isHidden = false
        var center: CGPoint = self.lineImageView.center
        if (self.isLineUp == true) {
            center.y -= 2
            if (center.y <= 110 * scaleY) {
                self.isLineUp = false
            }
        } else {
            center.y += 2
            if (center.y >= 385.5 * scaleY) {
//                self.isLineUp = true
                center.y = 110 * scaleY
            }
        }
        self.lineImageView.center = center
    }


    // MARK: - Protocol

    // MARK: - UI

    private func setupUI() {

        self.backgroundColor = .clear

        self.addSubview(self.backButton)
        self.addSubview(self.titleLabel)
        self.addSubview(self.photoButton)
        self.addSubview(self.descLabel)
        self.addSubview(self.lineImageView)
    }

    // MARK: - Constraints

    private func setupConstraints() {

        /// 返回按钮
        self.backButton.snp.makeConstraints {
            $0.left.equalToSuperview().offset(16)
            $0.top.equalToSuperview().offset(statusBarHeight)
            $0.height.equalTo(44)
        }

        /// 标题
        self.titleLabel.snp.makeConstraints {
            $0.centerY.equalTo(self.backButton)
            $0.centerX.equalToSuperview()
        }

        /// 访问相册按钮
        self.photoButton.snp.makeConstraints {
            $0.right.equalToSuperview().offset(-16)
            $0.width.height.equalTo(48)
            $0.bottom.equalToSuperview().offset(-(110 + safeBottomHeight))
        }

        self.descLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(self.photoButton)
        }
    }
}
