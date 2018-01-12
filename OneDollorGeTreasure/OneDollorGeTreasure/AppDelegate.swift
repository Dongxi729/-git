//
//  AppDelegate.swift
//  OneDollorGeTreasure
//
//  Created by 郑东喜 on 2018/1/5.
//  Copyright © 2018年 郑东喜. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //创建window
        UIApplication.shared.isStatusBarHidden = false
        setMainBar()
        return true
    }
    
    func setMainBar() -> Void {
        // 创建window
        
        window = UIWindow.init(frame: UIScreen.main.bounds)
        
        window?.makeKeyAndVisible()
        
        let customtabbar = MainViewController()
        window?.rootViewController = customtabbar
        
        
        // 设置全局颜色
        UITabBar.appearance().tintColor = commonBtnColor
        UINavigationBar.appearance().tintColor = commonBtnColor
    }
}

