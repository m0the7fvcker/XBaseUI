//
//  BaseImageTool.swift
//  XBaseUI
//
//  Created by Poly.ma on 2018/7/13.
//

import UIKit
import XResourceTool


/// 提供简便方法，类似宏功能，方便使用
///
/// - Parameter imageName: name
/// - Returns: UIImage
public func BaseImage(_ imageName: String) -> UIImage {
    return BaseImageTool.sharedManager.imageNamed(imageName) ?? UIImage()
}

/////////////////////////////////////////////////////////////////////////////////////////////////////
fileprivate class BundleClass: NSObject {
    
}

public class BaseImageTool: YSImageManager {

    static public let sharedManager: BaseImageTool = BaseImageTool()
    private override init() {
        let bundle = Bundle(for: BundleClass.init().classForCoder)
        super.init(bundle: bundle)
    }
    
    public override func imageNamed(_ imageName: String!) -> UIImage! {
        return super.imageNamed(imageName)
    }
}
