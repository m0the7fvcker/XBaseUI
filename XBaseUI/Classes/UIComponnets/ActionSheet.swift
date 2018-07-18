//
//  ActionSheet.swift
//  OA
//
//  Created by jerry.jiang on 16/6/6.
//  Copyright © 2016年 to8to. All rights reserved.
//

import UIKit
import XBaseUtils

private let ITEM_HEIGHT: CGFloat = 48.0

open class ActionSheet: UIView {

    var onPressIndex:((Int)->Void)?

    fileprivate var _title: String?

    required public init(title:String?, items: [String]) {
        var i = items
        super.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: CGFloat(items.count+1)*ITEM_HEIGHT+10.0+(title==nil ? 0.0 : ITEM_HEIGHT)))
        self.backgroundColor = UIColor(hexValue: "d6d6e0")

        var buttonOffset: CGFloat = 0
        if let t = title {
            buttonOffset += ITEM_HEIGHT
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: ITEM_HEIGHT-0.5))
            label.text = t
            label.textColor = UIColor(hexValue: "666666")
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 14)
            label.backgroundColor = UIColor.white

            self.addSubview(label)
        }

        i.append("取消")
        for (index, string) in i.enumerated() {
            let btn = UIButton(frame: CGRect(x: 0, y: CGFloat(index)*ITEM_HEIGHT+buttonOffset, width: SCREEN_WIDTH, height: ITEM_HEIGHT-0.5))
            btn.tag = index+1
            btn.setTitle(string, for: UIControlState())
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
            btn.setTitleColor(UIColor(hexValue: "333333"), for: UIControlState())
            btn.backgroundColor = UIColor.white
            btn.setBackgroundImage(UIImage(color: UIColor(hexValue: "eeeeee"), rect: CGRect(x: 0, y: 0, width: btn.width, height: btn.height)), for: .highlighted)
            btn.addTarget(self, action: #selector(ActionSheet.onButtonPress(_:)), for: .touchUpInside)

            if index == i.count-1 {
                btn.frame.origin.y += 10
                btn.tag = 0
            }
            self.addSubview(btn)
        }
    }

    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open func show() {
        self.modalShowInView(CURRENT_WINDOW(), animated: true)
    }

    @objc fileprivate func onButtonPress(_ btn: UIButton) {
        self.onPressIndex?(btn.tag)
        self.modalDismiss(animated: true)
    }
}
