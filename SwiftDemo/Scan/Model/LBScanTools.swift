//
//  LBScanTools.swift
//  SwiftDemo
//
//  Created by guogt on 2022/5/16.
//  Copyright © 2022 GGT. All rights reserved.
//

import UIKit
import AVFoundation

typealias LBAVAuthorizationSuccess = (Bool) -> (Void)

class LBScanTools: NSObject {

    // MARK: - Property

    // MARK: - Lazy

    // MARK: - Lifecycle

    // MARK: - Custom Accessors(Setter 与 Getter 方法)

    // MARK: - IBActions

    // MARK: - Public

    /// 获取授权状态
    static func getAuthorizationStatus() -> AVAuthorizationStatus {
        return AVCaptureDevice.authorizationStatus(for: .video)
    }

    /// 请求授权
    static func requestAuthorization(success: @escaping LBAVAuthorizationSuccess) {
        let status = self.getAuthorizationStatus()
        if (status == .notDetermined) {
            AVCaptureDevice.requestAccess(for: .video) { granted in
                success(granted)
            }
        } else if (status == .authorized) {
            success(true)
        } else {
            success(false)
        }
    }

    /// 跳转到设置界面
    static func jumpSystemSelfAppAccessSettings() {
        let url = NSURL.init(string: UIApplication.openSettingsURLString)
        if (UIApplication.shared.canOpenURL(url! as URL)) {
            UIApplication.shared.open(url! as URL)
        }
    }

    // MARK: - Protocol

}
