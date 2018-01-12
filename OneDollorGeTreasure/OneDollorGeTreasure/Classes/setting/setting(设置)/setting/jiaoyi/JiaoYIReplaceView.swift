//
//  JiaoYIReplaceView.swift
//  DollBuy
//
//  Created by 郑东喜 on 2016/12/11.
//  Copyright © 2016年 郑东喜. All rights reserved.
//  交易明细

import UIKit
import WebKit


class JiaoYIReplaceView: WKBaseViewController {
    
    //设置导航栏样式
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

        let urlStr = jiaoYIArray.lastObject
        
        let url = URL.init(string: urlStr as! String)
        
        
        DispatchQueue.main.async {
            
            if self.netThrough {
                DispatchQueue.main.async {
                    
                    self.urlRequestCache = NSURLRequest.init(url: url!, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 0)
                    self.webView.load(self.urlRequestCache as URLRequest)
                    
                }
            } else {
                
                DispatchQueue.main.async {
                    
                    self.urlRequestCache = NSURLRequest(url: url!, cachePolicy: NSURLRequest.CachePolicy.useProtocolCachePolicy, timeoutInterval: 10)
                    self.webView.load(self.urlRequestCache as URLRequest)
                    
                }
                
            }
        }

    }
    
    
 
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        url = (navigationAction.request.url?.absoluteString)!

        
        if navigationAction.navigationType == WKNavigationType.linkActivated {
            
            //XFLog(message: jiaoYIArray)
            
            if self.url.contains("?") {
                self.url = self.url + ("&devtype=1&token=") + (token)
            } else {
                self.url = self.url + ("?devtype=1&token=") + (token)
            }
            
            jiaoYIArray.add(self.url)
            self.aaa(str: jiaoYIArray.lastObject as! String)
            
            decisionHandler(.cancel)
            
        } else {
            decisionHandler(.allow)
        }
    }
    
    //url---
    func aaa(str : String) -> Void {
        
        
        let vvv = JiaoYIVC()
        vvv.url = str
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vvv, animated: true)
    }

}
