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
        tableView.register(YXCTableViewCell.self, forCellReuseIdentifier: "Cell")
        
        return tableView
    }()
    
    private lazy var dataSources: [YXCItemModel] = {
        var array: [YXCItemModel] = [
            YXCItemModel(titleString: "UIButton", pushViewController: "UIButtonController", parameter: nil)
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
        let cell: YXCTableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! YXCTableViewCell
        cell.titleString = self.dataSources[indexPath.row].titleString
        return cell
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let nameSpace = Bundle.main.infoDictionary!["CFBundleExecutable"] as? String else {
            print("没有获取到命名空间")
            return
        }
        let model: YXCItemModel = self.dataSources[indexPath.row]
        guard let controller: AnyObject.Type = NSClassFromString("\(nameSpace).\(model.pushViewController)")  else {
            print("没有获取到类")
            return
        }
        
        guard let vc = controller as? UIViewController.Type  else {
            print("不是 UIViewController")
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
