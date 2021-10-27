//
//  ViewController.swift
//  SwiftDemo
//
//  Created by GGT on 2021/8/9.
//

import UIKit
import SnapKit


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Property
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor.systemBackground
        tableView.dataSource = self
        tableView.delegate = self
        YXCTableViewCell.yxc_registerCell(tableView)
        
        return tableView
    }()
    
    private lazy var dataSources: [YXCItemModel] = {
        var array: [YXCItemModel] = [
            YXCItemModel(titleString: "UIButton", pushViewController: "UIButtonController", parameter: nil),
            YXCItemModel(titleString: "UILabel", pushViewController: "UILabelController", parameter: nil),
            YXCItemModel(titleString: "UICollectionView", pushViewController: "UICollectionController", parameter: nil),
            YXCItemModel(titleString: "UITextField", pushViewController: "UITextFieldController", parameter: nil),
            YXCItemModel(titleString: "UITextView", pushViewController: "UITextViewController", parameter: nil),
            YXCItemModel(titleString: "UIImageView", pushViewController: "UIImageViewController", parameter: nil),
            YXCItemModel(titleString: "UseMoya", pushViewController: "YXCUseMoyaController", parameter: nil),
            YXCItemModel(titleString: "原生解析 Json", pushViewController: "YXCJsonParsingController", parameter: nil),
            YXCItemModel(titleString: "SwityJson 使用", pushViewController: "YXCSwityJsonController", parameter: nil),
            YXCItemModel(titleString: "测试界面", pushViewController: "YXCTestController", parameter: nil),
            YXCItemModel(titleString: "AReplicatorLayer的使用", pushViewController: "YXCCAReplicatorLayerController", parameter: nil)
        ]
        return array
    }()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupConstraints()
        setupNavigation()
    }
    
    
    // MARK: - Custom Accessors (Setter 与 Getter 方法)
    
    
    // MARK: - IBActions
    
    
    // MARK: - Public
    
    
    // MARK: - Private
    
    @objc func injected() {
        
        setupUI()
        setupNavigation()
    }
    
    
    // MARK: - Protocol
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSources.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: YXCTableViewCell = YXCTableViewCell.yxc_dequeueReusableCell(forTableView: tableView, atIndexPath: indexPath)
        cell.titleString = self.dataSources[indexPath.row].titleString
        return cell
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let nameSpace = Bundle.main.infoDictionary!["CFBundleExecutable"] as? String else {
            yxc_debugPrintf("没有获取到命名空间")
            return
        }
        let model: YXCItemModel = self.dataSources[indexPath.row]
        guard let controller: AnyObject.Type = NSClassFromString("\(nameSpace).\(model.pushViewController)")  else {
            yxc_debugPrintf("没有获取到类")
            return
        }
        
        guard let vc = controller as? UIViewController.Type  else {
            yxc_debugPrintf("不是 UIViewController")
            return
        }
        
        let con = vc.init()
        con.hidesBottomBarWhenPushed = false
        self.navigationController?.pushViewController(con, animated: true)
    }
    
    
    // MARK: - UI
    
    func setupUI() -> Void {
        
        self.view.addSubview(tableView)
    }
    
    func setupNavigation() {
        
    }
    
    
    // MARK: - Constraints
    
    func setupConstraints() {
        
        tableView.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(self.view)
        }
    }
    
    // MARK: - Class
    struct YXCItemModel {
        let titleString: String
        let pushViewController: String
        let parameter: [String : AnyObject]?
    }
}

class YXCTableViewCell: UITableViewCell {
    
    var titleString: String {
        didSet {
            self.textLabel?.text = titleString
        }
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        titleString = ""
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        titleString = ""
        super.init(coder: coder)
    }
    
    func setupUI() {
        
    }
}

