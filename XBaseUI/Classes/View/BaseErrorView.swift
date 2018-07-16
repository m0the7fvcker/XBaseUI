//
//  BaseErrorView.swift
//  BaseUI
//
//  Created by Poly.ma on 2018/7/11.
//

public typealias NetworkRefreshCallBack = (BaseErrorView) -> ()

/////////////////////////////////////////////////////////////////////////////////////////////////////
public class BaseErrorView: BaseStateView {
    var refreshTitleView: UIView!
    var newworkCallBack: NetworkRefreshCallBack?
    
    init(frame: CGRect, image: UIImage, offsetY: CGFloat, imageSize: CGSize, title: String, callBack: @escaping NetworkRefreshCallBack) {
        newworkCallBack = callBack
        
        super.init(frame: frame, image: image, offsetY: offsetY, imageSize: imageSize, title: title)
        setupRefreshTitleView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupRefreshTitleView() {
        titleView.removeFromSuperview()
        
        refreshTitleView = UIView(frame: CGRect(x: 0, y: 0, width: 220, height: 20))
        refreshTitleView.backgroundColor = .green
        let desView = UILabel(frame: CGRect(x: 0,
                                            y: 0,
                                        width: refreshTitleView.frame.size.width / 2,
                                       height: refreshTitleView.frame.size.height))
        
        desView.text = "网络亲妈爆炸了～"
        desView.sizeToFit()
        
        let refreshButton = UIButton(frame: CGRect(x: refreshTitleView.frame.size.width / 2,
                                                   y: 0,
                                               width: refreshTitleView.frame.size.width / 2,
                                              height: refreshTitleView.frame.size.height))
        refreshButton.addTarget(self, action: #selector(refreshButtonClick(sender:)), for: .touchUpInside)
        refreshButton.setTitle("重新加载", for: .normal)
        refreshButton.setTitleColor(.green, for: .normal)
        
        refreshTitleView.addSubview(desView)
        refreshTitleView.addSubview(refreshButton)
        addSubview(refreshTitleView)
    }
    
    @objc private func refreshButtonClick(sender: UIButton) {
        guard let callBack = newworkCallBack else {
            return
        }
        callBack(self)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
            
        refreshTitleView.frame.origin.x = UIScreen.main.bounds.size.width / 2 - refreshTitleView.frame.size.width / 2
        refreshTitleView.frame.origin.y = imageView.frame.maxY + 10
        
    }
}
