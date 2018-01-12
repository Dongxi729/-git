//
//  ChangedRecordVC.swift
//  DollBuy
//
//  Created by 郑东喜 on 2016/11/30.
//  Copyright © 2016年 郑东喜. All rights reserved.
//  兑换记录

import UIKit

import WebKit

class ChangedRecordVC: WKBaseViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        ///禁用左滑返回手势
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        //若导航栏的子页面数量大于1，则设置第一面的导航栏颜色为白色，其他为橘色
        if (self.navigationController?.viewControllers.count)! > 1 {
            self.navigationController?.navigationBar.barTintColor = UIColor.white
            //文字颜色
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black]
            
            UIApplication.shared.statusBarStyle = .default
        } else {
            
            ///状态栏背景色
            self.navigationController?.navigationBar.barTintColor = commonBtnColor
            
            //文字颜色
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
            
            UIApplication.shared.statusBarStyle = .lightContent
        }
    }
    
    /// 正常加载
    var changeLoadNormal = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationItem.title = "兑换记录"
        
        if !changeLoadNormal {
            loadFirst(loadURl: self.url, firstUrl: changeRocordURL)
        } else {
            token = localSave.object(forKey: userToken) as? String ?? ""
            
            if url.contains("?") {
                url = url + ("&devtype=1&token=") + (token)
            } else {
                url = url + ("?devtype=1&token=") + (token)
            }
            
            self.webView.load(URLRequest.init(url: URL.init(string: url)!))
            
//            if NetStatusModel.netStatus == 0 {
//                self.webView.load(URLRequest.init(url: URL.init(string: url)!, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 20.0))
//            } else {
//                self.webView.load(URLRequest.init(url: URL.init(string: url)!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 20.0))
//            }
        }
    }
    
}



import UIKit

import WebKit

class JiaoYIVC: WKBaseViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        ///禁用左滑返回手势
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        //若导航栏的子页面数量大于1，则设置第一面的导航栏颜色为白色，其他为橘色
        if (self.navigationController?.viewControllers.count)! > 1 {
            self.navigationController?.navigationBar.barTintColor = UIColor.white
            //文字颜色
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black]
            
            UIApplication.shared.statusBarStyle = .default
        } else {
            
            ///状态栏背景色
            self.navigationController?.navigationBar.barTintColor = commonBtnColor
            
            //文字颜色
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
            
            UIApplication.shared.statusBarStyle = .lightContent
        }
    }
    
    /// 正常加载
    var changeLoadNormal = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if !changeLoadNormal {
            loadFirst(loadURl: self.url, firstUrl: jiaoyiURL)
        } else {
            token = localSave.object(forKey: userToken) as? String ?? ""
            
            if url.contains("?") {
                url = url + ("&devtype=1&token=") + (token)
            } else {
                url = url + ("?devtype=1&token=") + (token)
            }

            self.webView.load(URLRequest.init(url: URL.init(string: url)!))
        }
    }
    
}


import UIKit

import WebKit

class AwardVC: WKBaseViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        ///禁用左滑返回手势
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        //若导航栏的子页面数量大于1，则设置第一面的导航栏颜色为白色，其他为橘色
        if (self.navigationController?.viewControllers.count)! > 1 {
            self.navigationController?.navigationBar.barTintColor = UIColor.white
            //文字颜色
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black]
            
            UIApplication.shared.statusBarStyle = .default
        } else {
            
            ///状态栏背景色
            self.navigationController?.navigationBar.barTintColor = commonBtnColor
            
            //文字颜色
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
            
            UIApplication.shared.statusBarStyle = .lightContent
        }
    }
    
    /// 正常加载
    var changeLoadNormal = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationItem.title = "中奖记录"
        
        loadUrlWithNetStatus(loadUrl: awardURL)
        token = localSave.object(forKey: userToken) as? String ?? ""
        
        
        if url.contains("?") {
            url = awardURL + ("&devtype=1&token=") + (token)
        } else {
            url = awardURL + ("?devtype=1&token=") + (token)
        }
        
        self.webView.load(URLRequest.init(url: URL.init(string: url)!))
    }
}


