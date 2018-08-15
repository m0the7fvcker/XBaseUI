# XBaseUI

[![CI Status](https://img.shields.io/travis/Poly.ma/BaseUI.svg?style=flat)](https://travis-ci.org/Poly.ma/XBaseUI)
[![Version](https://img.shields.io/cocoapods/v/BaseUI.svg?style=flat)](https://cocoapods.org/pods/XBaseUI)
[![License](https://img.shields.io/cocoapods/l/BaseUI.svg?style=flat)](https://cocoapods.org/pods/XBaseUI)
[![Platform](https://img.shields.io/cocoapods/p/BaseUI.svg?style=flat)](https://cocoapods.org/pods/XBaseUI)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

XBaseUI is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'XBaseUI'
```  

## 模块整体结构

BaseView:

- BackDefaultButton：自定义导航栏返回按钮

- BaseErrorView：自定义错误页面遮照

- BaseRefreshFooter：自定义上拉刷新Footer（未做）

- BaseRefreshHeader：自定义下拉刷新Header（未做）

- BaseStateView：自定义状态页面，如无数据等状态

Controller：

- BaseNavigationController：自定义导航栏，可以按需扩展

- BaseViewController：自定义VC，包含页面埋点统计，统一配置子View，自定义返回等等功能，按需重写使用

- BaseWebViewController：自定义包含WKWebView的VC，能监听加载进度，包含jsBridge，方便使用

- BaseTabBarController: 自定义TabBarVC，可以按需扩展

Extension:

- UIScrollView+Refresh:下拉刷新相关Extension

- UIView+HUD：HUD遮照

- UIView+State:页面状态相关Extension

- UIView+Toast:Toast提示

Tools:

- BaseImageTool：当前模块图片资源工具

- iOS11Adapter：iOS11适配工具

UIComponents:

- ActionSheet:表单提示

- HudProcessView： 自定义HUD遮照

- ImageViewer：自定义图片浏览器

- SegmentBar:自定义SegmentBar

## Author

ge3kxm@gmail.com

## License

XBaseUI is available under the MIT license. See the LICENSE file for more info.
