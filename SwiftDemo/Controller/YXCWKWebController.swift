//
//  YXCWKWebController.swift
//  SwiftDemo
//
//  Created by lbkj on 2021/11/18.
//  Copyright © 2021 GGT. All rights reserved.
//

import UIKit
import WebKit

class YXCWKWebController: UIViewController {
    
    lazy var webView: WKWebView = {
        let configuration = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: configuration)
        return webView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "http://h5.hpplay.com.cn/webapps/h5/meeting/#/login")

        self.view.addSubview(self.webView)
        self.webView.backgroundColor = .darkGray
        let request = NSURLRequest(url: url!)
        self.webView.load(request as URLRequest)
        self.webView.snp.makeConstraints {
            $0.top.equalTo(self.view.snp_topMargin)
            $0.left.bottom.right.equalToSuperview()
        }
    }
}
