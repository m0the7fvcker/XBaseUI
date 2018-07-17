//
//  UIView+Toast.swift
//  XBaseUI
//
//  Created by Poly.ma on 2018/7/17.
//

import UIKit
import Toast_Swift

extension UIView {
    
    /// 根据需求自定义ToastView
    ///
    /// - Parameters:
    ///   - tip: 提示
    ///   - duration: duration
    ///   - completion: completion
    public func showCustomToast(_ tip: String?,
                             duration: TimeInterval,
                           completion: ((Bool) -> ())?) {
        
        let customToast = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        showToast(customToast, duration: duration, position: .center, completion: completion)
    }
    
}
