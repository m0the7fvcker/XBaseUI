//
//  BaseViewController.swift
//  BaseUI
//
//  Created by Poly.ma on 2018/7/11.
//

import UIKit


struct BaseErrorViewDefaultConfig {
    var defaultOffsetY: CGFloat  = -1
    var defaultImageSize: CGSize = CGSize(width: 100, height: 100)
    var defaultImage: UIImage    = UIImage(named: "") ?? UIImage()
    var defaultErrorDes: String  = "网络亲爹爆炸了"
}

protocol BaseViewControllerPopProtocol {
    func shouldPop() -> Bool
    func willPop()
}

/////////////////////////////////////////////////////////////////////////////////////////////////////
open class BaseViewController: UIViewController {

    ///是否能手势返回
    public var panGestureBackable: Bool?
    
    ///返回事件处理
    public var backAction: ((_ vc: UIViewController) ->())?
    
    //MARK: 生命周期--------------------------------------------
    override open func viewDidLoad() {
        setupNavigationItem()
    }
    
    override open func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    //MARK: 无网络配置-------------------------------------------
    /// 配置
    private var baseErrorConfig = BaseErrorViewDefaultConfig()
    
    /// 是否需要显示错误页面
    ///
    /// - Returns: Bool
    open func shouldShowDefaultNetErrorPage() -> Bool {
        return false
    }
    
    /// 让需要显示网络错误页面显示
    ///
    /// - Parameter isShowing: Bool
    open func setDefualtNetErrorPageShowing(isShowing: Bool) {
        let shouldShowDefaultViews = viewsShouldShowDefaultNetErrorPage()
        
        shouldShowDefaultViews.forEach { (v) in
            
            v.configErrorView(imageSize: baseErrorConfig.defaultImageSize,
                                  image: baseErrorConfig.defaultImage,
                                offsetY: baseErrorConfig.defaultOffsetY,
                                   text: baseErrorConfig.defaultErrorDes,
                               callBack: { (errroView) in
                
                self.defaultNetErrorPageReloadActionForView(view: v)
            })
            
            if isShowing && shouldShowDefaultNetErrorPage() {
                v.showErroView()
            }else {
                v.hideErrorView()
            }
        }
    }
    
    /// 需要显示网络错误页面的View
    ///
    /// - Returns: views
    open func viewsShouldShowDefaultNetErrorPage() -> [UIView] {
        return []
    }
    
    open func defaultNetErrorPageReloadActionForView(view: UIView) {}
    
    //MARK: 是否需要页面统计--------------------------------------
    /// 是否需要页面统计
    open func needViewControllerTracking() -> Bool {
        return false
    }
    
    //MARK: 样式------------------------------------------------
    public func backButtonImage() -> UIImage? {
        return BaseImageTool.sharedManager.imageNamed("refresh_0")
    }
    
    override open var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    public func setupNavigationItem() {
        setupDefaultBackButton()
    }
    
    //MARK: 私有方法---------------------------------------------
    private func setupDefaultBackButton() {
        let backButton = BackDefaultButton(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        backButton.setImage(self.backButtonImage(), for: .normal)
        backButton.addTarget(self, action: #selector(defualtBackAction(sender:)), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    @objc private func defualtBackAction(sender: UIButton) {
        if let backAction = backAction {
            backAction(self)
        }else {
            navigationController?.popViewController(animated: true)
        }
    }
}

extension BaseViewController: BaseViewControllerPopProtocol {
    
    //MARK: 交互------------------------------------------------
    /// 将要返回
    public func willPop() {}
    
    /// 是否返回
    public func shouldPop() -> Bool {
        return true
    }
}
