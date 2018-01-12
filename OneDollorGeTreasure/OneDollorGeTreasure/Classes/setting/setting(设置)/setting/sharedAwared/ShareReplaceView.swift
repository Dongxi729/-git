//
//  ShareReplaceView.swift
//  DollBuy
//
//  Created by 郑东喜 on 2016/12/11.
//  Copyright © 2016年 郑东喜. All rights reserved.
//  分享替换视图

import UIKit

import WebKit


class ShareReplaceView: WKBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlStr = fenxiangArray.lastObject
        
        let url = URL.init(string: urlStr as! String)
        
        
        DispatchQueue.main.async {
            
            TestNet.shared.getNetStatus(comfun: { (result) in
                if result.rawValue == "worked" {
                    
                    DispatchQueue.main.async {
                        
                        self.urlRequestCache = NSURLRequest(url: url!, cachePolicy: NSURLRequest.CachePolicy.useProtocolCachePolicy, timeoutInterval: 10)
                        self.webView.load(self.urlRequestCache as URLRequest)
                        
                    }
                    
                } else {
                    
                    DispatchQueue.main.async {
                        
                        self.urlRequestCache = NSURLRequest.init(url: url!, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 0)
                        self.webView.load(self.urlRequestCache as URLRequest)
                        
                    }
                    
                }
                
            })
            
        }
        
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        url = (navigationAction.request.url?.absoluteString)!
        
        if navigationAction.navigationType == WKNavigationType.linkActivated {
            
            //如果为本身或者本身携带#的url进行自身刷新。
            if url == shareGiftURL {
                
                //自刷新
                self.webView.load(URLRequest.init(url: URL.init(string: url)!))
                
                fenxiangArray.removeAllObjects()
                
            } else {
                
                //取出本地token，进行拼接
                if (localSave.object(forKey: userToken) != nil) {
                    let token = localSave.object(forKey: userToken) as! String
                    
                    if url.contains("?") {
                        url = url + ("&token=") + (token)
                    } else {
                        url = url + ("?&token=") + (token)
                    }
                } else {}
                
                
                fenxiangArray.add(url)
                aaa(str: fenxiangArray.lastObject as! String)
            }
            
            decisionHandler(.cancel)
            
        } else {
            decisionHandler(.allow)
            
        }
    }
    
    //url---
    func aaa(str : String) -> Void {
        
        
        let vvv = SharedVC()
        vvv.url = str
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vvv, animated: true)
    }
}
