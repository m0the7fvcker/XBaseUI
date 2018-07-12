//
//  ViewController.swift
//  BaseUI
//
//  Created by Poly.ma on 07/11/2018.
//  Copyright (c) 2018 Poly.ma. All rights reserved.
//

import UIKit
import XBaseUI
import XBaseUtils

class ViewController: BaseViewController {

    var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView(frame: view.bounds, style: .plain)
//        tableView.configSateView(imageSize: CGSize(width: 100, height: 100), image: UIImage(color: UIColor.red, rect: CGRect(x: 0, y: 0, width: 100, height: 100)), offsetY: -100, text: "测试文字")
        tableView.configErrorView(imageSize: CGSize(width: 100, height: 100), image: UIImage(color: UIColor.red, rect: CGRect(x: 0, y: 0, width: 100, height: 100)), offsetY: -100, text: "测试文字") { (errorView) in
            print("点击了重新加载")
        }
        
        view.addSubview(tableView)
        
        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        button.backgroundColor = .red
        button.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
        view.addSubview(button)
        
        let button2 = UIButton(frame: CGRect(x: 0, y: 500, width: 100, height: 100))
        button2.backgroundColor = .green
        button2.addTarget(self, action: #selector(button2Click), for: .touchUpInside)
        view.addSubview(button2)
    }
    
    @objc func buttonClick() {
        tableView.showErroView()
    }

    @objc func button2Click() {
        tableView.hideErrorView()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        tableView.showStateView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

