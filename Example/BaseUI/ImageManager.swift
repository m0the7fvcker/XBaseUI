//
//  ImageManager.swift
//  BaseUI_Example
//
//  Created by Poly.ma on 2018/7/13.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import UIKit
import XResourceTool

class BundleClass: NSObject {
    override init() {
        super.init()
    }
}

class ImageManager: YSImageManager {
    
    static var sharedInstance: ImageManager = ImageManager()
    
    private override init() {
        let bundle = Bundle(for: BundleClass.init().classForCoder)
        super.init(bundle: bundle)
    }
}
