//
//  ViewController.swift
//  BaseUI
//
//  Created by Poly.ma on 07/11/2018.
//  Copyright (c) 2018 Poly.ma. All rights reserved.
//

import UIKit
import TBaseUtilsSwift
import XResourceTool
import TBaseUISwift

class ViewController: BaseViewController {
    
    
    var view1: UIView!
    var view2: UIView!
    var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //        test0()
        test1()
        //                test2()
        //        test3()
        //        test4()
        //        test5()
        test6()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        
    }
    
    //测试alertView
    func test5() {
        let avc = UIAlertController()
        avc.add(actions: UIAlertAction(title: "11", style: .default, handler: nil),
                UIAlertAction(title: "2", style: .default, handler: nil),
                UIAlertAction(title: "3", style: .default, handler: nil))
        
        present(avc, animated: true, completion: nil)
    }
    
    //测试HUD
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
    
    //测试iOS11适配
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
    
    //测试统一配置无网络状态
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
    
    //测试下拉刷新
    func test1() {
        let image = ImageManager.sharedInstance.imageNamed("base_state_noData")
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
    
    
    //测试统一配置错误状态
    override func shouldShowDefaultNetErrorPage() -> Bool {
        return true
    }
    
    override func viewsShouldShowDefaultNetErrorPage() -> [UIView] {
        return [view1, view2]
    }
    
    //测试扩大响应范围
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
    
    //测试服务类
    func test6() {
        let mw = Midwaer<WorkProtocol>()
        
        let s1 = Server(name: "WorkProtocol", ser: WorkProtocol.self, imp:Person.self)
        
        mw.register(server: s1, forKey: "WorkProtocol")
        
        let s2 = mw.getServer(forKey: "WorkProtocol")
        
        s2!.getService().rest()
    }
    
}

/////////////////////////////////////////////////////////////////////////////////////////////////////
protocol WorkProtocol {
    func work()
    func rest()
}

protocol Initable {
    init()
}

class Person: WorkProtocol, Initable {
    var name: String?
    var age: Int?
    var sex: String?
    
    public required init() {}
    
    func work() {
        print("start working...")
    }
    
    func rest() {
        print("start resting...")
    }
}

class Server<Interface> {
    
    public init(name: String, ser: Interface.Type, imp: Initable.Type) {
        self.name = name
        self.ser = ser
        self.imp = imp
    }
    
    var name: String
    var imp: Initable.Type
    var ser: Interface.Type
    
    func getService() -> Interface {
        let s = imp.init()
        return s as! Interface
    }
}

class Midwaer<Interface> {
    
    public init() {
        self.map = Dictionary(minimumCapacity: 1)
    }
    
    private var map: [String: Server<Interface>] = Dictionary(minimumCapacity: 1)
    
    public func register(server: Server<Interface>, forKey key: String) {
        map[key] = server
    }
    
    public func getServer(forKey key: String) -> Server<Interface>? {
        if let ser = map[key] {
            return ser
        }
        return nil
    }
}

