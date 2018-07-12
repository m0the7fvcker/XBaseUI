//
//  BackDefaultButton.swift
//  BaseUI
//
//  Created by Poly.ma on 2018/7/11.
//

import UIKit

class BackDefaultButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView?.contentMode = .left
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let bounds = self.bounds
        let widthDelta = max(55 - bounds.width, 0)
        let heightDelta = max(44 - bounds.height, 0)
        
        return UIEdgeInsetsInsetRect(bounds, UIEdgeInsets(top: -0.5 * heightDelta,
                                                         left: -0.5 * widthDelta,
                                                       bottom: -0.5 * heightDelta,
                                                        right: -0.5 * widthDelta)).contains(point)
    }
}
