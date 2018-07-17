//
//  UIView+State.swift
//  BaseUI
//
//  Created by Poly.ma on 2018/7/11.
//

fileprivate var stateOffsetYKey         = "stateOffsetYKey"
fileprivate var stateImageSizeKey       = "stateImageSizeKey"
fileprivate var stateImageKey           = "stateImageKey"
fileprivate var stateTextKey            = "stateTextKey"
fileprivate var stateFontKey            = "stateFontKey"
fileprivate var stateNetworkCallBackKey = "stateNetworkCallBackKey"

fileprivate var stateCommonViewKey      = "stateCommonViewKey"
fileprivate var stateErrorViewKey       = "stateErrorViewKey"

fileprivate var stateCommonConfigKey    = "stateCommonConfigKey"
fileprivate var stateErrorConfigKey     = "stateErrorConfigKey"


/////////////////////////////////////////////////////////////////////////////////////////////////////
extension UIView {

    /// 配置状态显示
    ///
    /// - Parameters:
    ///   - imageSize: 图片大小
    ///   - image: 图片内容
    ///   - offsetY: 偏移
    ///   - text: 文字描述
    public func configSateView(imageSize: CGSize = CGSize(width: 100, height: 100),
                                   image: UIImage = BaseImage("base_state_noData"),
                                 offsetY: CGFloat = -1,
                                    font: UIFont = UIFont.systemFont(ofSize: 13),
                                    text: String = "这里空空如野") {
        commonConfig = [stateImageSizeKey : imageSize,
                            stateImageKey : image,
                          stateOffsetYKey : offsetY,
                              stateFontKey: font,
                             stateTextKey : text]
    }
    
    /// 配置网络错误显示
    ///
    /// - Parameters:
    ///   - imageSize: 图片大小
    ///   - image: 图片内容
    ///   - offsetY: 偏移
    ///   - text: 文字描述
    ///   - callBack: 刷新回调
    public func configErrorView(imageSize: CGSize = CGSize(width: 100, height: 100),
                                    image: UIImage = BaseImage("base_state_noConnect"),
                                  offsetY: CGFloat = -1,
                                     font: UIFont = UIFont.systemFont(ofSize: 13),
                                     text: String = "网络炸了",
                                 callBack: @escaping NetworkRefreshCallBack) {
        errorConfig = [stateImageSizeKey : imageSize,
                           stateImageKey : image,
                         stateOffsetYKey : offsetY,
                             stateFontKey: font,
                            stateTextKey : text,
                 stateNetworkCallBackKey : callBack]
    }
    
    /// 显示状态页面
    public func showStateView() {
        if let stateView = self.stateView {
            stateView.removeFromSuperview()
        }
        let stateView = BaseStateView(frame: bounds,
                                      image: commonConfig[stateImageKey] as! UIImage,
                                    offsetY: commonConfig[stateOffsetYKey] as! CGFloat,
                                       font: commonConfig[stateFontKey] as! UIFont,
                                  imageSize: commonConfig[stateImageSizeKey] as! CGSize,
                                      title: commonConfig[stateTextKey] as! String)
        self.stateView = stateView
        addSubview(stateView)
    }
    
    /// 隐藏状态页面
    public func hideStateView() {
        guard let stateView = stateView else {
            return
        }
        stateView.isHidden = true
        stateView.removeFromSuperview()
    }
    
    /// 显示错误页面
    public func showErroView() {
        if let errorView = self.errorView {
            errorView.removeFromSuperview()
        }
        let errorView = BaseErrorView(frame: bounds,
                                      image: errorConfig[stateImageKey] as! UIImage,
                                    offsetY: errorConfig[stateOffsetYKey] as! CGFloat,
                                       font: errorConfig[stateFontKey] as! UIFont,
                                  imageSize: errorConfig[stateImageSizeKey] as! CGSize,
                                      title: errorConfig[stateTextKey] as! String,
                                   callBack: errorConfig[stateNetworkCallBackKey] as! NetworkRefreshCallBack)
        self.errorView = errorView
        addSubview(errorView)
    }
    
    /// 隐藏错误页面
    public func hideErrorView() {
        guard let errorView = errorView else {
            return
        }
        errorView.isHidden = true
        errorView.removeFromSuperview()
    }
    
}

/////////////////////////////////////////////////////////////////////////////////////////////////////
extension UIView {
    
    private var commonConfig: Dictionary<String , Any> {
        set {
            objc_setAssociatedObject(self, &stateCommonConfigKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &stateCommonConfigKey) as! Dictionary<String, Any>
        }
    }
    
    private var errorConfig: Dictionary<String, Any> {
        set {
            objc_setAssociatedObject(self, &stateErrorConfigKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &stateErrorConfigKey) as! Dictionary<String, Any>
        }
    }
    
    private var stateView: BaseStateView? {
        set {
            objc_setAssociatedObject(self, &stateCommonViewKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &stateCommonViewKey) as? BaseStateView
        }
    }
    
    private var errorView: BaseErrorView? {
        set {
            objc_setAssociatedObject(self, &stateErrorViewKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &stateErrorViewKey) as? BaseErrorView
        }
    }
}
