//
//  iOS11Adapter.swift
//  XBaseUI
//
//  Created by Poly.ma on 2018/7/16.
//  iOS11屏幕适配工具

import UIKit
import SnapKit

/////////////////////////////////////////////////////////////////////////////////////////////////////
public class iOS11Adapter: NSObject {
    
    @available(iOS 11.0, *)
    public class func adapt(view: UIView, for viewController: UIViewController, with insets: UIEdgeInsets) {
        view.translatesAutoresizingMaskIntoConstraints = false
   
        let constraints: [NSLayoutConstraint] = iOS11Adapter.createConstraint(for: view, to: viewController.view.safeAreaLayoutGuide, with: insets)
        constraints.forEach { (constraint) in
            constraint.isActive = true
        }
        viewController.view.addConstraints(constraints)
    }
    
    @available(iOS 11.0, *)
    public class func createConstraint(for view: UIView, to layoutGuide: UILayoutGuide, with insets: UIEdgeInsets) -> [NSLayoutConstraint] {
        let leftConstraint = NSLayoutConstraint(item: view, attribute: .left, relatedBy: .equal, toItem: layoutGuide, attribute: .left, multiplier: 1, constant: insets.left)
        let rightConstraint = NSLayoutConstraint(item: view, attribute: .right, relatedBy: .equal, toItem: layoutGuide, attribute: .right, multiplier: 1, constant: -insets.right)
        let topConstraint = NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: layoutGuide, attribute: .top, multiplier: 1, constant: insets.top)
        let bottomConstraint = NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal, toItem: layoutGuide, attribute: .bottom, multiplier: 1, constant: -insets.bottom)
        
        return [leftConstraint, rightConstraint, topConstraint, bottomConstraint]
    }
    
    @available(iOS 11.0, *)
    public class func adaptTableView(tableView: UITableView) {
        tableView.estimatedSectionFooterHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        tableView.contentInsetAdjustmentBehavior = .never
    }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////
fileprivate var safeAreaLayoutGuideViewKey = "safeAreaLayoutGuideViewKey"

extension UIViewController {
    
    public var safeAreaLayoutGuideView: UIView? {
        set {
            objc_setAssociatedObject(self, &safeAreaLayoutGuideViewKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &safeAreaLayoutGuideViewKey) as? UIView
        }
    }
    
    /// 生成safeAreaView，添加适配约束，在当前控制器View的safeAreaLayoutGuide内，
    /// 适配时，先调用generateSafeAreaLayoutGuideView()方法，然后再将子控件添加到
    /// safeAreaLayoutGuideView中
    /// eg: generateSafeAreaLayoutGuideView()
    ///     safeAreaLayoutGuideView!.addSubview(webView)
    /// 注意：生成后不要再使用view来添加
    public func generateSafeAreaLayoutGuideView() {
        if let safeView = self.safeAreaLayoutGuideView {
            safeView.removeFromSuperview()
        }
        
        let v = UIView(frame: .zero)
        view.addSubview(v)
        
        if #available(iOS 11.0, *) {
            iOS11Adapter.adapt(view: v, for: self, with: .zero)
        } else {
            v.snp.makeConstraints { (make) in
                make.left.right.equalToSuperview()
                make.top.equalTo(self.topLayoutGuide as! ConstraintRelatableTarget)
                make.bottom.equalTo(self.bottomLayoutGuide as! ConstraintRelatableTarget)
            }
        }
        self.safeAreaLayoutGuideView = v
        self.safeAreaLayoutGuideView?.backgroundColor = .red
    }
}
