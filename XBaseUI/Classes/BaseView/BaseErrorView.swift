//
//  BaseErrorView.swift
//  BaseUI
//
//  Created by Poly.ma on 2018/7/11.
//

import SnapKit

public typealias NetworkRefreshCallBack = (BaseErrorView) -> ()

/////////////////////////////////////////////////////////////////////////////////////////////////////
public class BaseErrorView: BaseStateView {
    var refreshButton: UIButton!
    var newworkCallBack: NetworkRefreshCallBack?
    
    init(frame: CGRect, image: UIImage, offsetY: CGFloat, font: UIFont, imageSize: CGSize, title: String, callBack: @escaping NetworkRefreshCallBack) {
        newworkCallBack = callBack
        
        super.init(frame: frame, image: image, offsetY: offsetY, font: font, imageSize: imageSize, title: title)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func setupSubviews() {
        
        refreshButton = UIButton(frame: .zero)
        refreshButton.addTarget(self, action: #selector(refreshButtonClick(sender:)), for: .touchUpInside)
        refreshButton.setTitle("点击刷新", for: .normal)
        refreshButton.titleLabel?.font = font
        refreshButton.titleLabel?.textAlignment = .center
        refreshButton.setTitleColor(.green, for: .normal)
        refreshButton.sizeToFit()
        
        addSubview(refreshButton)
    }
    
    public override func setupConstraints() {
        super.setupConstraints()
        
        titleView.snp.remakeConstraints { (make) in
            make.right.equalTo(imageView.snp.centerX)
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.height.equalTo(18)
        }
        
        refreshButton.snp.makeConstraints { (make) in
            make.left.equalTo(titleView.snp.right)
            make.height.equalTo(18)
            make.centerY.equalTo(titleView.snp.centerY)
        }
    }
    
    @objc private func refreshButtonClick(sender: UIButton) {
        guard let callBack = newworkCallBack else {
            return
        }
        callBack(self)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
    }
}
