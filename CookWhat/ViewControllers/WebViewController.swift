//
//  WebViewController.swift
//  CookWhat
//
//  Created by tsugita on 2017/01/16.
//  Copyright © 2017年 taose-deeplearning. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {
    
    var navigationTitle: String!
    var urlString: String!
    let wkWebView = WKWebView()
    
    convenience init(navigationTitle: String, urlString: String) {
        self.init()
        
        self.navigationTitle = navigationTitle
        self.urlString = urlString
    }
    
    // MARK: - View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setNavigationBar()
        self.setWebView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        wkWebView.frame = view.bounds
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        
        super.viewWillDisappear(animated)
    }
    
    // MARK: - Initialize
    
    fileprivate func setNavigationBar() {
        let titleLabel = UILabel()
        titleLabel.text = navigationTitle.substring(to: navigationTitle.index(navigationTitle.startIndex, offsetBy: 9)) + ".."
        titleLabel.font = UIFont(name: "HiraKakuProN-W6", size: 15)
        titleLabel.textColor = .white
        titleLabel.sizeToFit()
        
        navigationItem.titleView = titleLabel
    }
    
    fileprivate func setWebView() {
        self.view.addSubview(wkWebView)
        
        wkWebView.navigationDelegate = self
        
        guard let url: URL = URL(string: urlString) else {
            print("Error, check \(#function) \(#line)")
            return
        }
        
        let request: URLRequest = URLRequest(url: url)
        wkWebView.load(request)
    }
    
    // MARK: - WKNavigationDelegate
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}
