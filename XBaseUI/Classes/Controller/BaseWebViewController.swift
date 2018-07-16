//
//  BaseWebViewController.swift
//  BaseUI
//
//  Created by Poly.ma on 2018/7/11.
//

import UIKit
import WebKit
import WebViewJavascriptBridge

open class BaseWebViewController: BaseViewController {
    
    /// 加载的URL
    open var url: String = "https://www.baidu.com"
    open var webView: WKWebView!
    open var jsBridge: WebViewJavascriptBridge!
    
    /// 是否需要回调H5，用于点击返回按钮时是否需要回调H5
    private var isListening: Bool?
    
    private var wvConfig: WKWebViewConfiguration = WKWebViewConfiguration()
    private var progressView: UIProgressView!
    
    //MARK:生命周期--------------------------------------------------------------------
    override open func viewDidLoad() {
        super.viewDidLoad()

        setupSubviews()
        setupConstraints()
        loadRequest()
    }
    
    //MARK: 初始化---------------------------------------------------------------------
    private func setupSubviews() {
        automaticallyAdjustsScrollViewInsets = false
        
        webView = WKWebView(frame: .zero, configuration: wvConfig)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        
        progressView = UIProgressView(frame: .zero)
        progressView.progressTintColor = .green
        webView.addSubview(progressView)
        
        generateSafeAreaLayoutGuideView()
        safeAreaLayoutGuideView!.addSubview(webView)
        
        jsBridge = WebViewJavascriptBridge(forWebView: webView)
        handleBridge()
    }
    
    private func setupConstraints() {
        webView.snp.makeConstraints({ (make) in
            make.left.right.top.bottom.equalToSuperview()
        })
        
        progressView.snp.makeConstraints({ (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(1.5)
        })
    }
    
    private func handleBridge() {
        jsBridge.registerHandler("setReturnListening") { (data, responseCallback) in
            guard let param = data as? Dictionary<String, Any> else {
                return
            }
            self.isListening = param["listening"] as? Bool
        }
    }
    
    private func loadRequest() {
         webView.load(URLRequest(url: URL(string: url)!))
    }
    
    //MARK:override----------------------------------------------------------------
    override open func setBackAction(backAction: @escaping BaseBackAction) {
        if webView.canGoBack {
            webView.goBack()
        } else {
            if let navVC = navigationController {
                navVC.popViewController(animated: true)
            } else {
                dismiss(animated: true, completion: nil)
            }
        }
    }
    
    //MARK:监听进度-----------------------------------------------------------------
    open override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            guard let progress = change?[.newKey] as? Float else {
                return
            }
            progressView.progress = progress
            progressView.isHidden = progressView.progress == 1
        }
    }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////
extension BaseWebViewController: WKUIDelegate {
    
    public func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        let alertVC = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: nil, style: .default, handler: nil))
        present(alertVC, animated: true, completion: nil)
        completionHandler()
    }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////
extension BaseWebViewController: WKNavigationDelegate {
    
    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url!
        if url.scheme == "tel" ||
           url.scheme == "sms" ||
           url.scheme == "mailto" ||
           url.scheme == "itunes.apple.com" {
            DispatchQueue.main.async {
                UIApplication.shared.openURL(url)
            }
            decisionHandler(.cancel)
            return
        }
        decisionHandler(.allow)
    }
}
