//
//  UIScrollView+Refresh.swift
//  BaseUI
//
//  Created by Poly.ma on 2018/7/12.
//


fileprivate var BaseRefreshHeaderKey  = "BaseRefreshHeaderKey"
fileprivate var BaseRefreshFooterKey  = "BaseRefreshFooterKey"

fileprivate var BaseHeaderCallbackKey = "BaseHeaderCallbackKey"
fileprivate var BaseFooterCallbackKey = "BaseFooterCallbackKey"

typealias BaseRefreshCallback = () -> ()

/////////////////////////////////////////////////////////////////////////////////////////////////////
import MJRefresh

extension UIScrollView {
    
    public var refreshHeader: BaseRefreshHeader? {
        set {
            objc_setAssociatedObject(self, &BaseRefreshHeaderKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            mj_header = newValue
        }
        get {
            return objc_getAssociatedObject(self, &BaseRefreshHeaderKey) as? BaseRefreshHeader
        }
    }
    
    public var refreshFooter: BaseRefreshFooter? {
        set {
            objc_setAssociatedObject(self, &BaseRefreshFooterKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            mj_footer = newValue
        }
        get {
            return objc_getAssociatedObject(self, &BaseRefreshFooterKey) as? BaseRefreshFooter
        }
    }
    
    private var baseHeaderCallback: BaseRefreshCallback? {
        set {
            objc_setAssociatedObject(self, &BaseHeaderCallbackKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &BaseHeaderCallbackKey) as? BaseRefreshCallback
        }
    }
    
    private var baseFooterCallback: BaseRefreshCallback? {
        set {
            objc_setAssociatedObject(self, &BaseFooterCallbackKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &BaseFooterCallbackKey) as? BaseRefreshCallback
        }
    }
    
    /// 开始头部刷新
    public func beginHeaderRefreshing() {
        refreshHeader?.beginRefreshing()
    }
    
    /// 停止头部刷新
    public func endHeaderRefreshing() {
        refreshHeader?.endRefreshing()
    }
    
    /// 开始地步刷新
    public func beginFooterRefreshing() {
        refreshFooter?.beginRefreshing()
    }
    
    /// 停止底部刷新
    public func endFooterRefreshing() {
        refreshFooter?.endRefreshing()
    }
    
    
    /// 添加刷新头部
    ///
    /// - Parameters:
    ///   - target: target
    ///   - action: action
    public func addHeder(for target: Any, action: Selector) {
        let header = BaseRefreshHeader(refreshingTarget: target, refreshingAction: action)
        refreshHeader = header
    }
    
    
    /// 添加刷新头部
    ///
    /// - Parameter callBack: block
    public func addHeader(callBack: @escaping () -> ()) {
        let header = BaseRefreshHeader(refreshingTarget: self, refreshingAction: #selector(baseHeaderAction))
        baseHeaderCallback = callBack
        refreshHeader = header
    }
    
    
    /// 添加刷新底部
    ///
    /// - Parameters:
    ///   - target: target
    ///   - action: action
    public func addFooter(for target: Any, action: Selector) {
        let footer = BaseRefreshFooter(refreshingTarget: target, refreshingAction: action)
        refreshFooter = footer
    }
    
    
    /// 添加刷新底部
    ///
    /// - Parameter callBack: block
    public func addFooter(callBack: @escaping () -> ()) {
        let footer = BaseRefreshFooter(refreshingTarget: self, refreshingAction: #selector(baseFooterAction))
        baseFooterCallback = callBack
        refreshFooter = footer
    }
    
    @objc private func baseHeaderAction() {
        guard let headerCallback = baseHeaderCallback else {
            return
        }
        headerCallback()
    }
    
    @objc private func baseFooterAction() {
        guard let footerCallback = baseFooterCallback else {
            return
        }
        footerCallback()
    }
}
