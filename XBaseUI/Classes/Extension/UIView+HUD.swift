//
//  UIView+HUD.swift
//  XBaseUI
//
//  Created by Poly.ma on 2018/7/17.
//

import UIKit
import PKHUD

/////////////////////////////////////////////////////////////////////////////////////////////////////
extension UIView {

    /// 根据需求自定义HUD
    ///
    /// - Parameters:
    ///   - tip: tip
    ///   - subTitle: subTitle
    ///   - delay: delay
    ///   - completion: completion
    public func showCustomProgress(tip: String? = "",
                              subTitle: String? = "",
                                 delay: TimeInterval = 1,
                            completion: ((Bool) -> ())? = nil) {
        
        let contentView = PKHUDProgressView(title: tip, subtitle: subTitle)
        
        PKHUD.sharedHUD.contentView = contentView
        PKHUD.sharedHUD.show(onView: self)
        PKHUD.sharedHUD.hide(afterDelay: delay, completion: completion)
    }
    
    
    /// 显示成功
    public func showSuccess() {
        HUD.flash(.success, onView: self, delay: 1, completion: nil)
    }
    
    /// 显示错误
    public func showError() {
        HUD.flash(.error, onView: self, delay: 1, completion: nil)
    }
    
    // 转菊花
    public func showProgressing() {
        HUD.show(.progress, onView: self)
    }
    
    // 隐藏菊花
    public func hideProgressing() {
        HUD.hide()
    }
}
