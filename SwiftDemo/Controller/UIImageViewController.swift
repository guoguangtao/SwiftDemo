//
//  UIImageViewController.swift
//  SwiftDemo
//
//  Created by GGT on 2021/8/20.
//

import UIKit
import Kingfisher

class UIImageViewController: UIViewController {

    // MARK: - Property
    let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        let url = URL(string: "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimg95.699pic.com%2Fphoto%2F40190%2F8136.gif_wh300.gif%21%2Fgifto%2Ftrue&refer=http%3A%2F%2Fimg95.699pic.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1632064520&t=6a19049620e405ecc92244c36ad89555")
        $0.kf.setImage(with: url)
    }
    
    // MARK: - Lazy
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        
        setupUI()
        setupConstraints()
    }
    
    // MARK: - IBActions
    
    @objc func injected() {
        
        self.view.yxc_removeAllSubViews()
        setupUI()
        setupConstraints()
    }
    
    // MARK: - Public
    
    // MARK: - Private
    
    // MARK: - Procotol
    
    // MARK: - UI
    func setupUI() {
        
        self.view.addSubview(imageView)
    }
    
    // MARK: - Constraints
    func setupConstraints() {
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

}
