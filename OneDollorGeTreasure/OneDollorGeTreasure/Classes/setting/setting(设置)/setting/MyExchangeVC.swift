//
//  MyExchangeVC.swift
//  Alili
//
//  Created by 郑东喜 on 2017/10/25.
//  Copyright © 2017年 郑东喜. All rights reserved.
//

import UIKit
import WebKit

class MyExchangeVC: WKBaseViewController {
    
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
        

            //加载URL
            self.url = couponReceive_URl
            
            if self.url.contains("?") {
                self.url = self.url + ("&token=") + (token)
            } else {
                self.url = self.url + ("?token=") + (token)
            }
            
            let url = URL.init(string: self.url)
            
            DispatchQueue.main.async {
                
                self.urlRequestCache = NSURLRequest.init(url: url!, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 0)
                self.webView.load(self.urlRequestCache as URLRequest)
            }
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        url = (navigationAction.request.url?.absoluteString)!
        
        XFLog(message: url)
        
        if navigationAction.navigationType == WKNavigationType.linkActivated {
            
            
            if self.url.contains("?") {
                self.url = self.url + ("&devtype=1&token=") + (token)
            } else {
                self.url = self.url + ("?devtype=1&token=") + (token)
            }
            
            aaa(str: self.url)
            
            
            decisionHandler(.cancel)
            
        } else {
            
            decisionHandler(.allow)
        }
    }
    
    func aaa(str : String) -> Void {
        
        let vvv = YHJMainVC()
        vvv.url = str
        self.navigationController?.pushViewController(vvv, animated: true)
        
    }
    
}


