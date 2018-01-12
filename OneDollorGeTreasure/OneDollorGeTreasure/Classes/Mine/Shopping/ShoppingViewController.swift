//
//  ShoppingViewController.swift
//  DollBuy
//
//  Created by 郑东喜 on 2016/12/2.
//  Copyright © 2016年 郑东喜. All rights reserved.
//  购物车界面

import UIKit
import WebKit


class ShoppingViewController : WKBaseViewController {
    
    /// 已登录显示的界面
    @objc private func unloginAlert() {
        let vc = ZDXAlertController.init(title: "提示", message: "请登录", preferredStyle: .alert)
        vc.addAction(UIAlertAction.init(title: "好的", style: .default, handler: { (action) in
            MemModel.clearUserLocalDefaultData()
            let loginvc = LoginView()
            if let nav = self.navigationController {
                nav.pushViewController(loginvc, animated: true)
            }
        }))
        
        vc.addAction(UIAlertAction.init(title: "取消", style: .cancel, handler: { (action) in
            self.tabBarController?.selectedIndex = 0
        }))
        
        present(vc, animated: true, completion: nil)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        /// 检查是否登录
        if let _ = localSave.object(forKey: userToken) as? String {
        } else {
            unloginAlert()
        }
        
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
            if nav == 1 {
                var aaa = ""
                if shooppingCarURL.contains("?") {
                    aaa = shooppingCarURL + ("&devtype=1&token=") + (token)
                } else {
                    aaa = shooppingCarURL + ("?devtype=1&token=") + (token)
                }
                
                self.webView.load(URLRequest.init(url: URL.init(string: aaa)!))
                
                self.webView.frame = CGRect.init(x: 0, y: 0, width: SW, height: SH - UIApplication.shared.statusBarFrame.height - (navigationController?.navigationBar.Height)! - (tabBarController?.tabBar.frame.size.height)!)
            }
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if let nav = navigationController?.viewControllers.count {
            
            if nav > 1 {
                self.webView.load(URLRequest.init(url: URL.init(string: self.url)!))
            }
        }
    }
}
