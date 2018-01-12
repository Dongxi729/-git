//
//  ChangedRecordVC.swift
//  DollBuy
//
//  Created by 郑东喜 on 2016/11/30.
//  Copyright © 2016年 郑东喜. All rights reserved.
//  兑换记录changeRocordURL

import UIKit

import WebKit

class ChangedRecordVC: WKBaseViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if (self.navigationController?.viewControllers.count)! > 0 {
            self.navigationController?.navigationBar.barTintColor = UIColor.white
            
            //文字颜色
            self.navigationController?.navigationBar.titleTextAttributes =
                [NSAttributedStringKey.foregroundColor: UIColor.black]
            
            UIApplication.shared.statusBarStyle = .default
            
        } else {
            
            self.navigationController?.navigationBar.barTintColor = commonBtnColor
            
            //文字颜色
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
            
            UIApplication.shared.statusBarStyle = .lightContent
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        token = localSave.object(forKey: userToken) as? String ?? ""
        
        if (navigationController?.viewControllers.count)! > 2 {
            self.webView.load(URLRequest.init(url: URL.init(string: self.url)!))
        } else {
            //加载URL
            self.url = changeRocordURL
            
            if self.url.contains("?") {
                self.url = self.url + ("&token=") + (token)
            } else {
                self.url = self.url + ("?token=") + (token)
            }
            
            let url = URL.init(string: self.url)
            
            DispatchQueue.main.async {
                
                self.urlRequestCache = NSURLRequest.init(url: url!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 0)
                self.webView.load(self.urlRequestCache as URLRequest)
            }
        }
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        url = (navigationAction.request.url?.absoluteString)!
        
        XFLog(message: url)
        
        if navigationAction.navigationType == WKNavigationType.linkActivated || self.url.contains("orderdetail.aspx?tId") {
            if self.url.contains("user_dhjl.aspx?state=1") || self.url.contains("user_dhjl.aspx?state=2") || self.url.contains("user_dhjl.aspx") {
                
                if !self.url.contains("token") {
                    if self.url.contains("?") {
                        self.url = self.url + ("&devtype=1&token=") + (token)
                    } else {
                        self.url = self.url + ("?devtype=1&token=") + (token)
                    }
                }
                
                webView.load(URLRequest.init(url: URL.init(string: self.url)!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 5.0))
            }

            if self.url.contains("orderdetail.aspx?tId") {
                if !self.url.contains("token") {
                    CCog(message: "未处理的" + self.url)
                    
                    if self.url.contains("?") {
                        self.url = self.url + ("&devtype=1&token=") + (token)
                        CCog(message: self.url)
                    } else {
                        self.url = self.url + ("?devtype=1&token=") + (token)
                    }
                    
                    bbb(str: self.url)
                }
            }
            
            decisionHandler(.cancel)
            
        } else {
            decisionHandler(.allow)
        }
    }
    
    /// 页面跳转
    ///
    /// - Parameter str: 跳转的链接
    func aaa(str : String) -> Void {
        
        let vvv = ChangedRecordVC()
        vvv.url = str
        self.navigationController?.pushViewController(vvv, animated: true)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    /// 页面跳转
    ///
    /// - Parameter str: 跳转的链接
    func bbb(str : String) -> Void {
        
        let vvv = ChangeReplaceVC()
        vvv.url = str
        self.navigationController?.pushViewController(vvv, animated: true)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

class ChangeReplaceVC : WKBaseViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if (self.navigationController?.viewControllers.count)! > 0 {
            self.navigationController?.navigationBar.barTintColor = UIColor.white
            
            //文字颜色
            self.navigationController?.navigationBar.titleTextAttributes =
                [NSAttributedStringKey.foregroundColor: UIColor.black]
            
            UIApplication.shared.statusBarStyle = .default
            
        } else {
            
            self.navigationController?.navigationBar.barTintColor = commonBtnColor
            
            //文字颜色
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
            
            UIApplication.shared.statusBarStyle = .lightContent
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        self.webView.load(URLRequest.init(url: URL.init(string: self.url)!))
    }
}


