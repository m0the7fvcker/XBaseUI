//
//  BaseNavigationController.swift
//  BaseUI
//
//  Created by Poly.ma on 2018/7/11.
//

import UIKit

public class BaseNavigationController: UINavigationController {

    public override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        if childViewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        
        if let vc = childViewControllers.last as? BaseViewController {
            if vc.shouldHideNavBar() {
                setNavigationBarHidden(true, animated: true)
            }
            setNavigationBarHidden(false, animated: true)
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    public override func popViewController(animated: Bool) -> UIViewController? {
        
        if let vc = childViewControllers.last as? BaseViewController {
            guard !vc.shouldPop() else {
                return nil
            }
            vc.willPop()
        }
        return super.popViewController(animated: animated)
    }
}
