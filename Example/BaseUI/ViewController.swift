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

class ViewController: BaseViewController {
    
    
    var view1: UIView!
    var view2: UIView!
    var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        test0()
        //        test1()
        //        test2()
        //        test3()
        //        test4()
        //        test5()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        let avc = UIAlertController()
        avc.add(actions: UIAlertAction(title: "11", style: .default, handler: nil),
                UIAlertAction(title: "2", style: .default, handler: nil),
                UIAlertAction(title: "3", style: .default, handler: nil))
        
        present(avc, animated: true, completion: nil)
    }
    
    func test5() {
        
    }
    
    func test4() {
        view.showCustomProgress()
        //        view.showCustomProgress(tip: "正在加载", content: .success)
        view.showSuccess()
        view.showError()
        view.showProgressing()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.view.hideProgressing()
        }
        view.makeToast("你好")
        view.showCustomProgress()
        //        view.showToast(")
        
    }
    
    func test3() {
        generateSafeAreaLayoutGuideView()
        safeAreaLayoutGuideView?.addSubview(UIButton(type: .contactAdd))
        let subview = UIView(frame: CGRect(x: 0, y: 100, width: 200, height: 200))
        //        subview.configSateView(imageSize: CGSize(width: 100, height: 100), image: UIImage(), offsetY: 1, text: "无状态")
        //        subview.configSateView()
        subview.configErrorView() { (v) in
            print("点击了刷新")
        }
        
        subview.backgroundColor = .yellow
        safeAreaLayoutGuideView?.addSubview(subview)
        
        subview.showErroView()
    }
    
    func test2() {
        view1 = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/2))
        view1.backgroundColor = .purple
        view.addSubview(view1)
        
        view2 = UIView(frame: CGRect(x: 0, y: UIScreen.main.bounds.height/2, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/2))
        view2.backgroundColor = .gray
        view.addSubview(view2)
        
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            self.setDefualtNetErrorPageShowing(isShowing: true)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                self.setDefualtNetErrorPageShowing(isShowing: false)
            }
        }
    }
    
    func test1() {
        let image = ImageManager.sharedInstance.imageNamed("billcopy.png")
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.configErrorView(imageSize: CGSize(width: 100, height: 100), image: image!, offsetY: -100, text: "测试文字") { (errorView) in
            print("点击了重新加载")
        }
        
        tableView.addHeader {
            print("下拉刷新")
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                self.tableView.refreshHeader?.endRefreshing()
            }
        }
        
        
        tableView.addFooter {
            print("上拉刷新")
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                self.tableView.refreshFooter?.endRefreshing()
            }
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
    
    //    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    //        tableView.showStateView()
    //    }
    
    override func shouldShowDefaultNetErrorPage() -> Bool {
        return true
    }
    
    override func viewsShouldShowDefaultNetErrorPage() -> [UIView] {
        return [view1, view2]
    }
    
    func test0() {
        let btn =  UIButton(frame: CGRect(x: 0, y: 100, width: 50, height: 50))
        btn.backgroundColor = .red
        btn.addTarget(self, action: #selector(expandBtnClick), for: .touchUpInside)
        btn.expandTouchArea = UIButtonExpandArea(left: 0, right: 20, top: 20, bottom: 0)
        view.addSubview(btn)
    }
    
    @objc func expandBtnClick() {
        print("expand")
    }
    
}

