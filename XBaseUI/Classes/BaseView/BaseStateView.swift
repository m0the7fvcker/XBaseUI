//
//  BaseStateView.swift
//  BaseUI
//
//  Created by Poly.ma on 2018/7/11.
//

import UIKit
import XBaseUtils
import SnapKit

/////////////////////////////////////////////////////////////////////////////////////////////////////
public class BaseStateView: UIView {
    var image: UIImage?
    var offsetY: CGFloat = -1
    var font: UIFont?
    var title: String?
    var imageSize: CGSize = CGSize(width: 100, height: 100)
    
    var imageView: UIImageView
    var titleView: UILabel
    
    init(frame: CGRect, image: UIImage, offsetY: CGFloat, font: UIFont, imageSize: CGSize, title: String) {
        self.image = image
        self.offsetY = offsetY
        self.font = font
        self.imageSize = imageSize
        self.title = title
        
        // 注意初始化顺序
        imageView = UIImageView(image: image)
        titleView = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
        titleView.text = title
        titleView.font = font
        titleView.textColor = UIColor(hexValue: "666666")
        titleView.sizeToFit()
        
        super.init(frame: frame)
        
        backgroundColor = .white
        
        addSubview(imageView)
        addSubview(titleView)
        
        setupSubviews()
        setupConstraints()
    }
    
    open func setupSubviews() {}
    
    open func setupConstraints() {
        imageView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalTo(imageSize.width)
            make.height.equalTo(imageSize.height)
        }
        
        titleView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.height.equalTo(18)
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
    }
}
