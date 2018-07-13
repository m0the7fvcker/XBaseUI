//
//  BaseImageTool.swift
//  XBaseUI
//
//  Created by Poly.ma on 2018/7/13.
//

import UIKit
import XResourceTool

class BundleClass: NSObject {
    
}

class BaseImageTool: YSImageManager {

    static let sharedManager: BaseImageTool = BaseImageTool()
    private override init() {
        let bundle = Bundle(for: BundleClass.init().classForCoder)
        super.init(bundle: bundle)
    }
    
    public override func imageNamed(_ imageName: String!) -> UIImage! {
        return super.imageNamed(imageName)
    }
}
