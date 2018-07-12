//
//  UIView+State.swift
//  BaseUI
//
//  Created by Poly.ma on 2018/7/11.
//

fileprivate var stateOffsetYKey = "stateOffsetYKey"
fileprivate var stateImageSizeKey = "stateImageSizeKey"
fileprivate var stateImageKey = "stateImageKey"
fileprivate var stateTextKey = "stateTextKey"
fileprivate var stateNetworkCallBackKey = "stateNetworkCallBackKey"

fileprivate var stateCommonViewKey = "stateCommonViewKey"
fileprivate var stateErrorViewKey = "stateErrorViewKey"

fileprivate var stateCommonConfigKey = "stateCommonConfigKey"
fileprivate var stateErrorConfigKey = "stateErrorConfigKey"


/////////////////////////////////////////////////////////////////////////////////////////////////////
extension UIView {

    /// 配置状态显示
    ///
    /// - Parameters:
    ///   - imageSize: 图片大小
    ///   - image: 图片内容
    ///   - offsetY: 偏移
    ///   - text: 文字描述
    public func configSateView(imageSize: CGSize, image: UIImage, offsetY: CGFloat, text: String) {
        commonConfig = [stateImageSizeKey : imageSize,
                            stateImageKey : image,
                          stateOffsetYKey : offsetY,
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
    public func configErrorView(imageSize: CGSize, image: UIImage, offsetY: CGFloat, text: String, callBack: @escaping NetworkCallBack) {
        errorConfig = [stateImageSizeKey : imageSize,
                           stateImageKey : image,
                         stateOffsetYKey : offsetY,
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
                                  imageSize: errorConfig[stateImageSizeKey] as! CGSize,
                                      title: errorConfig[stateTextKey] as! String,
                                   callBack: errorConfig[stateNetworkCallBackKey] as! NetworkCallBack)
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

extension UIView {
    
    private var commonConfig: Dictionary<String , Any> {
        set {
            objc_setAssociatedObject(self, &stateCommonConfigKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            guard let commonConfig = objc_getAssociatedObject(self, &stateCommonConfigKey) as? Dictionary<String, Any> else {
                return
                    [stateImageSizeKey : CGSize(width: 100, height: 100),
                         stateImageKey : UIImage(),
                       stateOffsetYKey : -1,
                          stateTextKey : "这里空空如野",
                     ]
            }
            return commonConfig
        }
    }
    
    private var errorConfig: Dictionary<String, Any> {
        set {
            objc_setAssociatedObject(self, &stateErrorConfigKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            guard let errorConfig = objc_getAssociatedObject(self, &stateErrorConfigKey) as? Dictionary<String, Any> else {
                return
                    [stateImageSizeKey : CGSize(width: 100, height: 100),
                     stateImageKey : UIImage(),
                     stateOffsetYKey : -1,
                     stateTextKey : "网络炸了",
                     stateNetworkCallBackKey : {}]
            }
            return errorConfig
        }
    }
    
    private var stateView: BaseStateView? {
        set {
            objc_setAssociatedObject(self, &stateCommonViewKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            guard let stateView = objc_getAssociatedObject(self, &stateCommonViewKey) as? BaseStateView else {
                return nil
            }
            return stateView
        }
    }
    
    private var errorView: BaseErrorView? {
        set {
            objc_setAssociatedObject(self, &stateErrorViewKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            guard let errorView = objc_getAssociatedObject(self, &stateErrorViewKey) as? BaseErrorView else {
                return nil
            }
            return errorView
        }
    }
}
