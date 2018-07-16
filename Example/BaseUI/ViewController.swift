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
import XResourceTool

class ViewController: BaseWebViewController {
    
    
    var view1: UIView!
    var view2: UIView!
    var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        test2()
        //        test3()
        test4()
    }
    
    func test4() {
        
    }
    
    func test3() {
        generateSafeAreaLayoutGuideView()
        safeAreaLayoutGuideView?.addSubview(UIButton(type: .contactAdd))
    }
    
    //    func test2() {
    //        view1 = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/2))
    //        view1.backgroundColor = .purple
    //        view.addSubview(view1)
    //
    //        view2 = UIView(frame: CGRect(x: 0, y: UIScreen.main.bounds.height/2, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/2))
    //        view2.backgroundColor = .gray
    //        view.addSubview(view2)
    //
    //
    //        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
    //            self.setDefualtNetErrorPageShowing(isShowing: true)
    //            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
    //                self.setDefualtNetErrorPageShowing(isShowing: false)
    //            }
    //        }
    //    }
    //
    //    func test1() {
    //        let image = ImageManager.sharedInstance.imageNamed("billcopy.png")
    //                tableView = UITableView(frame: view.bounds, style: .plain)
    //                tableView.configErrorView(imageSize: CGSize(width: 100, height: 100), image: image!, offsetY: -100, text: "测试文字") { (errorView) in
    //                    print("点击了重新加载")
    //                }
    //
    //                tableView.addHeader {
    //                    print("下拉刷新")
    //                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
    //                        self.tableView.refreshHeader?.endRefreshing()
    //                    }
    //                }
    //
    //
    //                tableView.addFooter {
    //                    print("上拉刷新")
    //                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
    //                        self.tableView.refreshFooter?.endRefreshing()
    //                    }
    //                }
    //
    //                view.addSubview(tableView)
    //
    //        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    //        button.backgroundColor = .red
    //        button.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
    //        view.addSubview(button)
    //
    //        let button2 = UIButton(frame: CGRect(x: 0, y: 500, width: 100, height: 100))
    //        button2.backgroundColor = .green
    //        button2.addTarget(self, action: #selector(button2Click), for: .touchUpInside)
    //        view.addSubview(button2)
    //    }
    //
    //    @objc func buttonClick() {
    //        tableView.showErroView()
    //    }
    //
    //    @objc func button2Click() {
    //        tableView.hideErrorView()
    //    }
    //
    //    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    //        tableView.showStateView()
    //    }
    //
    //    override func shouldShowDefaultNetErrorPage() -> Bool {
    //        return true
    //    }
    //
    //    override func viewsShouldShowDefaultNetErrorPage() -> [UIView] {
    //        return [view1, view2]
    //    }
    
}

