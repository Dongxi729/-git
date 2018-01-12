//
//  MainPageViewController.swift
//  DollarBuy
//
//  Created by 郑东喜 on 2016/11/6.
//  Copyright © 2016年 郑东喜. All rights reserved.
//  首页轮播图

import UIKit
import WebKit


class MainPageViewController : WKBaseViewController {
    
    /// 遮盖曾
    lazy var mainMaskV: UIView = {
        let d: UIView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SW, height: UIApplication.shared.statusBarFrame.height))
        d.backgroundColor = #colorLiteral(red: 0.9434959292, green: 0.3252089322, blue: 0.3240017891, alpha: 1)
        return d
    }()
    
    
    
    //设置导航栏样式
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        if let nav = navigationController?.viewControllers.count {
            
            CCog(message: nav)
            if nav > 1 {
                self.navigationController?.setNavigationBarHidden(false, animated: true)
                self.navigationController?.navigationBar.barTintColor = UIColor.white
                //文字颜色
                self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black]
                
                UIApplication.shared.statusBarStyle = .default
            } else {
                webView.frame = CGRect.init(x: 0, y: UIApplication.shared.statusBarFrame.height, width: SW, height: SH - UIApplication.shared.statusBarFrame.height)
                progressView.frame = CGRect.init(x: 0, y: UIApplication.shared.statusBarFrame.height
                    , width: SW, height: 20)

                ///状态栏背景色
                self.navigationController?.navigationBar.barTintColor = commonBtnColor
                //文字颜色
                self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
                
                UIApplication.shared.statusBarStyle = .lightContent
                self.navigationController?.setNavigationBarHidden(true, animated: true)
                
            }
        }
        
        if let nav = navigationController?.viewControllers.count {
            
            UIApplication.shared.keyWindow?.addSubview(mainMaskV)
            mainMaskV.isHidden = true

        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.mainMaskV.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadFirst(loadURl: self.url, firstUrl: firPage_URL)
        
    }
}
