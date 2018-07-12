//
//  BaseStateView.swift
//  BaseUI
//
//  Created by Poly.ma on 2018/7/11.
//

import UIKit

fileprivate let margin: CGFloat = 10

/////////////////////////////////////////////////////////////////////////////////////////////////////
public class BaseStateView: UIView {
    var image: UIImage?
    var offsetY: CGFloat = -1
    var imageSize: CGSize = CGSize(width: 100, height: 100)
    
    var imageView: UIImageView
    var titleView: UILabel
    
    init(frame: CGRect, image: UIImage, offsetY: CGFloat, imageSize: CGSize, title: String) {
        self.image = image
        self.offsetY = offsetY
        self.imageSize = imageSize
        
        imageView = UIImageView(image: image)
        titleView = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
        titleView.text = title
        titleView.sizeToFit()
        
        super.init(frame: frame)
        
        backgroundColor = .white
        
        self.addSubview(imageView)
        self.addSubview(titleView)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.frame = CGRect(x: self.frame.size.width / 2 - imageSize.width / 2, y: 0, width: imageSize.width, height: imageSize.width)
        imageView.frame.origin.y = self.frame.size.height / 2 - imageView.frame.size.height / 2 + offsetY
        
        titleView.frame.origin.x = self.frame.size.width / 2 - titleView.frame.size.width / 2
        titleView.frame.origin.y = imageView.frame.maxY + margin
        
    }
}
