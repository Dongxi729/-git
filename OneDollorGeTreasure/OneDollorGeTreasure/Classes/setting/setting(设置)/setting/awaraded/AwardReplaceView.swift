//
//  AwardReplaceView.swift
//  DollBuy
//
//  Created by 郑东喜 on 2016/12/11.
//  Copyright © 2016年 郑东喜. All rights reserved.
//  中奖纪录参照Awardrecordvc

import UIKit
import WebKit

class AwardReplaceView: WKBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlStr = zhongjiangArray.lastObject
        
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

            
            if self.url.contains("?") {
                self.url = self.url + ("&devtype=1&token=") + (token)
            } else {
                self.url = self.url + ("?devtype=1&token=") + (token)
            }
            
            zhongjiangArray.add(url)
            aaa(str: zhongjiangArray.lastObject as! String)
            
            decisionHandler(.cancel)
            
        } else {
            decisionHandler(.allow)
            
        }
    }
    
    //url---
    func aaa(str : String) -> Void {
        
        
        let vvv = AwadedRecordVC()
        vvv.url = str
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vvv, animated: true)
    }

}
