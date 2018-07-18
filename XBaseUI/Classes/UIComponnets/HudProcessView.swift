//
//  HudProcessView.swift
//  OA
//
//  Created by anyeler.zhang on 16/8/11.
//  Copyright © 2016年 to8to. All rights reserved.
//

import UIKit
import PKHUD
import XBaseUtils

public enum HUDProcessType: Int {
    case flash = 0
    case tip
}

//@objc protocol PKHUDAnimating {
//
//    func startAnimation()
//    optional func stopAnimation()
//}
class HudProcessView: UIView {
    
    /*
     // Only override drawRect: if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func drawRect(rect: CGRect) {
     // Drawing code
     }
     */
    
    //MARK: - 私有变量
    let flashViewWidth: CGFloat = 72.0
    var tipViewHeight: CGFloat = 41
    var tipViewWidth: CGFloat = 100
    let leftTipMargin: CGFloat = 20
    let topTipMargin: CGFloat = 20
    
    let tipSize: CGSize?
//    let tipSize: CGRect?
    
    fileprivate lazy var activityView = UIActivityIndicatorView.init(activityIndicatorStyle: .white)
    
    init(type: HUDProcessType, tip: String) {
        
        tipSize = tip.getTextSize(limitSize: CGSize(width: SCREEN_WIDTH * 0.75, height: CGFloat.greatestFiniteMagnitude))
        
//        tipSize = tip.getTextSize(font: UIFont.systemFont(ofSize: 15.0), size: CGSize.init(width: SCREEN_WIDTH*0.75, height: CGFloat.greatestFiniteMagnitude))
        
        self.tipViewWidth = tipSize!.width + leftTipMargin * 2
        self.tipViewHeight = tipSize!.height > 18 ? tipSize!.height + topTipMargin*2 : tipViewHeight
        
        switch type {
        case .flash:
            super.init(frame: CGRect(x: 0, y: 0, width: flashViewWidth, height: flashViewWidth))
            self.showindView()
        case .tip:
            super.init(frame: CGRect(x: 0, y: 0, width: tipViewWidth, height: tipViewHeight))
            self.showlable(tip)
        }
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.74)
    }
    
    fileprivate func showindView() {
        self.activityView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        self.activityView.center = self.center
        self.activityView.activityIndicatorViewStyle = .whiteLarge
        self.addSubview(self.activityView)
        
        self.activityView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.activityView.startAnimating()
    }
    
    fileprivate func showlable(_ str: String) {
        
//        let label = UILabel(frame: CGRect(x: 0, y: 0, width: (tipSize?.width)!, height: tipSize!.height), color: UIColor.white, str: str, font: UIFont.systemFont(ofSize: 15))
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: (tipSize?.width)!, height: tipSize!.height),title: str, titleFont: UIFont.systemFont(ofSize: 15), color: .white)
        label.textAlignment = .center
        label.sizeToFit()
        label.center = self.center
        self.addSubview(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func isHide(_ state: Bool) {
        if state {
            self.activityView.stopAnimating()
        }
    }
}
