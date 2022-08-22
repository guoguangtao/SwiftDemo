//
//  LBScanQRCodeController.swift
//  Runner
//
//  Created by guogt on 2022/5/13.
//

import UIKit
import AVFoundation

/// 二维码扫描
class LBScanQRCodeController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {

    // MARK: - Property

    /// 扫描
    private let scanView: LBScanView = LBScanView()

    private var captureDevice: AVCaptureDevice?
    private var deviceInput: AVCaptureDeviceInput?
    private var metaDataOutput: AVCaptureMetadataOutput?
    private var videoDataOutput: AVCaptureVideoDataOutput?
    private var captureSession: AVCaptureSession?
    private var previewLayer: AVCaptureVideoPreviewLayer?

    /// 是否在变焦放大动画
    private var isZoomAnming: Bool = false

    private var beginGestureZoom: CGFloat = 1
    private var recogniserScale: CGFloat = 1

    // MARK: - Lazy

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupConstraints()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationController?.isNavigationBarHidden = true
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            self.p_authenicaScan()
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        self.navigationController?.isNavigationBarHidden = false
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        self.p_stopScan()
    }

    // MARK: - Custom Accessors(Setter 与 Getter 方法)

    // MARK: - IBActions

    @objc func back() -> Void {
        self.navigationController?.popViewController(animated: true)
    }

    /// 缩放手势
    @objc func pinchGestureRecognizer(recogniser: UIPinchGestureRecognizer) {

        if (recogniser.state == .began) {
            self.beginGestureZoom = self.captureDevice?.videoZoomFactor ?? 1
            self.recogniserScale = recogniser.scale
        }
        do {
            try self.captureDevice?.lockForConfiguration()
            var zoomFactor: CGFloat
            let scale: CGFloat = recogniser.scale
            if (scale < self.recogniserScale) {
                zoomFactor = self.beginGestureZoom * (1.0 - (self.recogniserScale - scale) / 1.0)
            } else {
                zoomFactor = self.beginGestureZoom * (1.0 + (scale - self.recogniserScale) / 1.0)
            }
            zoomFactor = min(min(self.captureDevice?.activeFormat.videoMaxZoomFactor ?? 0, 10.0), zoomFactor)
            zoomFactor = max(1.0, zoomFactor)
            self.captureDevice?.videoZoomFactor = zoomFactor
            self.captureDevice?.unlockForConfiguration()
        } catch _ {
        }
    }

    /// 点击手势
    @objc func tapGestureRecognizer(recogniser: UITapGestureRecognizer) {

        let videoZoomFactor = self.captureDevice?.videoZoomFactor ?? 0
        if (videoZoomFactor <= 2.0 && self.isZoomAnming == false) {
            self.p_videoZoomFactorAnmChange(factor: 5.0)
        } else if (videoZoomFactor > 2.0 && self.isZoomAnming == false) {
            self.p_videoZoomFactorAnmChange(factor: 1.0)
        }
    }

    // MARK: - Public

    // MARK: - Private

    /// 获取摄像头权限
    private func p_authenicaScan() {
        let status: AVAuthorizationStatus = LBScanTools.getAuthorizationStatus()
        if (status == .notDetermined) {
            // 请求授权
            LBScanTools.requestAuthorization { success in
                if (success == true) {
                    // 开始扫描
                    self.p_startScan()
                }
            }
        } else if (status == .authorized) {
            // 已经授权
            self.p_startScan()
        } else if (status == .restricted || status == .denied) {
            // 权限限制
            let alert: UIAlertController = UIAlertController.init(title: "扫一扫", message: "相机权限未打开,扫码不能用,前往设置", preferredStyle: .alert)
            alert.addAction(UIAlertAction.init(title: "取消", style: .default))
            alert.addAction(UIAlertAction.init(title: "确定", style: .default, handler: { action in
                LBScanTools.jumpSystemSelfAppAccessSettings()
            }))
        }
    }

    /// 开始扫描
    private func p_startScan() {
        self.p_configCaptureDevice()
    }

    /// 开始初始化设备
    private func p_configCaptureDevice() {
        if (self.captureDevice != nil) {
            return
        }

        self.captureDevice = AVCaptureDevice.default(for: .video)

        do {
            try self.captureDevice?.lockForConfiguration()
            if (self.captureDevice?.isSmoothAutoFocusSupported == true &&
                self.captureDevice?.isSmoothAutoFocusEnabled == false) {
                self.captureDevice?.isSmoothAutoFocusEnabled = true
            }
            if (self.captureDevice?.isAutoFocusRangeRestrictionSupported == true) {
                self.captureDevice?.autoFocusRangeRestriction = .far
            }
            if (self.captureDevice?.isFocusModeSupported(.autoFocus) == true &&
                self.captureDevice?.focusMode != .autoFocus) {
                self.captureDevice?.focusMode = .autoFocus
            }
            if (self.captureDevice?.isExposureModeSupported(.continuousAutoExposure) == true) {
                self.captureDevice?.exposureMode = .continuousAutoExposure
            }
            self.captureDevice?.unlockForConfiguration()
        } catch let error {
            print("self.captureDevice lockForConfiguration error:\(error)")
        }

        do {
            self.deviceInput = try AVCaptureDeviceInput.init(device: self.captureDevice!)
        } catch let error {
            print("deviceInput 创建失败\(error)")
            return
        }

        self.metaDataOutput = AVCaptureMetadataOutput()
        self.metaDataOutput?.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)

        self.videoDataOutput = AVCaptureVideoDataOutput()
        self.videoDataOutput?.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String : kCVPixelFormatType_32BGRA]
        self.videoDataOutput?.alwaysDiscardsLateVideoFrames = true

        self.captureSession = AVCaptureSession()
        self.captureSession?.sessionPreset = .high
        if (self.captureSession?.canAddInput(self.deviceInput!) == true) {
            self.captureSession?.addInput(self.deviceInput!)
        }
        if (self.captureSession?.canAddOutput(self.metaDataOutput!) == true) {
            self.captureSession?.addOutput(self.metaDataOutput!)
        }
        if (self.captureSession?.canAddOutput(self.videoDataOutput!) == true) {
            self.captureSession?.addOutput(self.videoDataOutput!)
        }

        self.previewLayer = AVCaptureVideoPreviewLayer.init(session: self.captureSession!)
        self.previewLayer?.videoGravity = .resizeAspectFill
        DispatchQueue.main.async {
            self.view.backgroundColor = .clear
            self.previewLayer?.frame = self.view.layer.bounds
            self.view.layer.insertSublayer(self.previewLayer!, at: 0)
            self.captureSession?.startRunning()
            self.scanView.startAnimation()
            #if TARGET_IPHONE_SIMULATOR
            #else
            self.metaDataOutput?.metadataObjectTypes = [.qr]
            #endif
        }
    }

    /// 停止扫描
    private func p_stopScan() {
        self.scanView.stopAnimation()
        if (self.captureSession != nil) {
            self.captureSession?.stopRunning()
            self.captureSession = nil
        }

        self.captureDevice = nil
        self.deviceInput = nil
        self.metaDataOutput = nil
        self.videoDataOutput = nil
        self.captureSession = nil
    }

    /// 变焦动画
    private func p_videoZoomFactorAnmChange(factor: CGFloat) {
        DispatchQueue.main.async {
            self.isZoomAnming = true
            do {
                try self.captureDevice?.lockForConfiguration()
                if (factor >= 1.0 && factor <= (self.captureDevice?.activeFormat.videoMaxZoomFactor)!) {
                    self.captureDevice?.ramp(toVideoZoomFactor: factor, withRate: 5)
                    self.captureDevice?.unlockForConfiguration()
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.isZoomAnming = false;
                }
            } catch _ {
            }
        }
    }

    // MARK: - Protocol

    // MARK: - AVCaptureMetadataOutputObjectsDelegate

    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        var stringValue: String?
        if (metadataObjects.count > 0) {
            let metaDataObject: AVMetadataMachineReadableCodeObject = metadataObjects.first as! AVMetadataMachineReadableCodeObject
            stringValue = metaDataObject.stringValue
            if (stringValue != nil && (stringValue?.count ?? 0 > 0)) {
                print("二维码扫描结果:\(stringValue!)")
                self.p_stopScan()
            }
        }
    }

    // MARK: - UI

    func setupUI() {

        self.view.backgroundColor = .black
        self.view.addSubview(self.scanView)
        self.scanView.addBackAction(target: self, action: #selector(back))

        // 添加手势
        let pinchGes: UIPinchGestureRecognizer = UIPinchGestureRecognizer.init(target: self, action: #selector(pinchGestureRecognizer(recogniser:)))
        self.scanView.addGestureRecognizer(pinchGes)

        // 双击手势
        let tapGes: UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(tapGestureRecognizer(recogniser:)))
        tapGes.numberOfTapsRequired = 2
        self.scanView.addGestureRecognizer(tapGes)
    }

    // MARK: - Constraints

    func setupConstraints() {

        self.scanView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
