//
//  ServerVC.swift
//  Alili
//
//  Created by 郑东喜 on 2017/12/18.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  服务区

import UIKit

class ServerVC: WKBaseViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
        
        if let nav = navigationController?.viewControllers.count {
            CCog(message: nav)
            if nav == 2 {
                self.webView.frame = CGRect.init(x: 0,
                                                 y: 0,
                                                 width: SW,
                                                 height: SH - (self.navigationController?.navigationBar.Height)! - UIApplication.shared.statusBarFrame.height)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        loadFirst(loadURl: self.url, firstUrl: server_URL)
    }
}

