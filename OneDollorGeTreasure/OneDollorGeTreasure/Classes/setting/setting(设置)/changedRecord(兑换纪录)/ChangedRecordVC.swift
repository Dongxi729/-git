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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationItem.title = "兑换记录"
    
//        webView.load(URLRequest.init(url: URL.init(string: commaddURl(adUrl: changeRocordURL))!))
        
        token = localSave.object(forKey: userToken) as? String ?? ""
        var aaa = ""
        if changeRocordURL.contains("?") {
            aaa = changeRocordURL + ("&devtype=1&token=") + (token)
        } else {
            aaa = changeRocordURL + ("?devtype=1&token=") + (token)
        }
        CCog(message: aaa)
        
        if NetStatusModel.netStatus == 0 {
            CCog()
            self.webView.load(URLRequest.init(url: URL.init(string: aaa)!, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 5.0))
        } else {
            CCog()
            self.webView.load(URLRequest.init(url: URL.init(string: aaa)!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 5.0))
        }
    }
}
