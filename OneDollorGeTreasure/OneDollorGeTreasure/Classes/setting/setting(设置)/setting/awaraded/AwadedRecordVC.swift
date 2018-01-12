//
//  AwadedRecordVC.swift
//  DollBuy
//
//  Created by 郑东喜 on 2016/11/30.
//  Copyright © 2016年 郑东喜. All rights reserved.
//  中奖纪录

import UIKit

import WebKit


class AwadedRecordVC: WKBaseViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.title = "中奖纪录"

        
        if zhongjiangArray.count > 1 {
            let urlStr = zhongjiangArray.lastObject
            
            webView.load(URLRequest.init(url: URL.init(string: urlStr as! String)!))
        } else {
            DispatchQueue.main.async {
                
                
                let urlStr = awardURL + "?devtype=1" + "&token=" + self.token
                
                let url = URL.init(string: urlStr)
                
                if awardURL.contains(comStrURL) {
                    
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
                } else {
                    CustomAlertView.shared.alertWithTitle(strTitle: "请下拉刷新")
                }
            }
        }
    }
    

    
    /// 拦截URL
    ///
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        url = (navigationAction.request.url?.absoluteString)!

        //XFLog(message: url)
        
        
        if navigationAction.navigationType == WKNavigationType.linkActivated {
            
            //判断是否包含问号，对应格式进行URL拼接
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
    
    /// 控制器取对应的url跳转
    ///
    func aaa(str : String) -> Void {
        
        let vvv = AwardReplaceView()
        vvv.url = str
        
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vvv, animated: true)
        self.hidesBottomBarWhenPushed = false
        
    }
    

}
