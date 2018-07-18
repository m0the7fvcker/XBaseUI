//
//  SegmentBar.swift
//  OA
//
//  Created by jerry.jiang on 16/5/26.
//  Copyright © 2016年 to8to. All rights reserved.
//

import UIKit
import XBaseUtils

private let H:CGFloat = 45.0

class SegmentBar: UIControl {

    var selectedIndex: Int {
        didSet {
            let old = arrButton[oldValue]
            old.isSelected = false
            old.isUserInteractionEnabled = true

            let new = arrButton[selectedIndex]
            new.isSelected = true
            new.isUserInteractionEnabled = false

            UIView.animate(withDuration: 0.25, animations: {
                self.slider.frame.origin.x = self.buttonWidth * CGFloat(self.selectedIndex)
            }) 
        }
    }

    fileprivate var arrButton:[UIButton] = []
    fileprivate var buttonWidth: CGFloat
    fileprivate let slider: UIView

    init(titles: [String], initialIndex: Int = 0) {

        selectedIndex = initialIndex
        buttonWidth = titles.count > 0 ? SCREEN_WIDTH/CGFloat(titles.count) : 0
        slider = UIView(frame: CGRect(x: CGFloat(selectedIndex)*buttonWidth, y: H-1.5, width: buttonWidth, height: 1.5))
        slider.backgroundColor = UIColor(hexValue: "06C792")

        super.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: H))

        arrButton = titles.map({ (t) -> UIButton in
            let index = titles.index(of: t)

            let btn = UIButton(frame: CGRect(x: CGFloat(index!) * buttonWidth, y: 0, width: buttonWidth, height: H))
            btn.setTitle(t, for: UIControlState())
            btn.setTitleColor(UIColor(hexValue:"666666"), for: UIControlState())
            btn.setTitleColor(UIColor(hexValue:"06C792"), for: .selected)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            btn.tag = index!
            btn.isSelected = index == selectedIndex
            btn.isUserInteractionEnabled = !btn.isSelected
            btn.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
            self.addSubview(btn)

            return btn
        })
        self.addSubview(slider)
        self.backgroundColor = UIColor.white
    }

    public func setTitleFont (font : UIFont){
        for btn in arrButton{
            btn.titleLabel?.font = font
        }
    }
    public func setViewHeight(height:CGFloat){
//        self.height = height
        self.frame.size.height = height
        slider.frame = CGRect(x: CGFloat(selectedIndex)*buttonWidth, y: height-1.5, width: buttonWidth, height: 1.5)
        for btn in arrButton{
            btn.frame.size.height = height
//            btn.height = height
        }
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    @objc fileprivate func buttonAction(_ button: UIButton) {
        self.selectedIndex = button.tag
        self.sendActions(for: .valueChanged)
    }
}
