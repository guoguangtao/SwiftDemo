//
//  YXCScreenToSwitchController.swift
//  SwiftDemo
//
//  Created by guogt on 2022/6/2.
//  Copyright © 2022 GGT. All rights reserved.
//

import UIKit

class YXCScreenToSwitchController: UIViewController {

    // MARK: - Property

    let App_Delegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate

    let portraitButton: UIButton = UIButton().then {
        $0.setTitle("竖屏", for: .normal)
        $0.backgroundColor = .orange
    }

    let landscapeRightButton: UIButton = UIButton().then {
        $0.setTitle("横屏", for: .normal)
        $0.backgroundColor = .orange
    }

    // MARK: - Lazy

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupConstraints()
    }

    // MARK: - Custom Accessors(Setter 与 Getter 方法)

    // MARK: - IBActions

    @objc func buttonClicked(button: UIButton) {
        self.p_witchScreen(isPortrait: button == self.portraitButton)
    }


    // MARK: - Public

    // MARK: - Private

    func p_witchScreen(isPortrait: Bool) -> Void {
        let rotation = isPortrait ? 4 : 2
        App_Delegate.allowRotation = rotation
        p_setNewOrientation(fullScreen: !isPortrait)
    }

    func p_setNewOrientation(fullScreen: Bool) {
        if fullScreen { //横屏
            let resetOrientationTargert = NSNumber(integerLiteral: UIInterfaceOrientation.unknown.rawValue)
            UIDevice.current.setValue(resetOrientationTargert, forKey: "orientation")
            
            let orientationTarget = NSNumber(integerLiteral: UIInterfaceOrientation.landscapeRight.rawValue)
            UIDevice.current.setValue(orientationTarget, forKey: "orientation")
            
        } else { //竖屏
            let resetOrientationTargert = NSNumber(integerLiteral: UIInterfaceOrientation.unknown.rawValue)
            UIDevice.current.setValue(resetOrientationTargert, forKey: "orientation")
            
            let orientationTarget = NSNumber(integerLiteral: UIInterfaceOrientation.portrait.rawValue)
            UIDevice.current.setValue(orientationTarget, forKey: "orientation")
        }
    }

    // MARK: - Protocol

    // MARK: - UI

    func setupUI() {

        self.view.backgroundColor = .white
        self.view.addSubview(self.portraitButton)
        self.portraitButton.addTarget(self, action: #selector(buttonClicked(button:)), for: .touchUpInside)
        self.view.addSubview(self.landscapeRightButton)
        self.landscapeRightButton.addTarget(self, action: #selector(buttonClicked(button:)), for: .touchUpInside)
    }

    // MARK: - Constraints

    func setupConstraints() {

        self.portraitButton.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(50)
            make.centerY.equalToSuperview().offset(-30)
            make.centerX.equalToSuperview()
        }

        self.landscapeRightButton.snp.makeConstraints { make in
            make.width.height.centerX.equalTo(self.portraitButton)
            make.centerY.equalToSuperview().offset(30)
        }
    }
}
