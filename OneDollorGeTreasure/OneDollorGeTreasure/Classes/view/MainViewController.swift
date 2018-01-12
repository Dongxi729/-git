//
//  MainViewController.swift
//  DollarBuy
//
//  Created by 郑东喜 on 2016/11/6.
//  Copyright © 2016年 郑东喜. All rights reserved.
//  用来布局tabbarcontroller 四个子页面

import UIKit


class MainViewController: BaseTabbarVC  {
    
    
    var mvc = UIViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpSubViews()
        
        
        self.tabBar.isTranslucent = false
        
        /// 赋值通用的导航栏高度
    }
}

// MARK:- 设置子界面
extension MainViewController {
    func setUpSubViews() -> Void {
        
        //为每个子页面独立添加导航栏
        let mainPageVC = NaVC.init(rootViewController: MainPageViewController())
        
        //禁用半透明
        mainPageVC.navigationBar.isTranslucent = false

        let shopVc = NaVC.init(rootViewController: ShoppingViewController())
        //禁用半透明
        shopVc.navigationBar.isTranslucent = false
        
        
        ///服务区
        let categoryVC = NaVC.init(rootViewController:CategoryVC())
        categoryVC.navigationBar.isTranslucent = false
        
        /// 交流区
        let serverVC = NaVC.init(rootViewController:ServerVC())
        serverVC.navigationBar.isTranslucent = false
        
        //我的模块
        let meVC = NaVC.init(rootViewController: MyViewController())
        meVC.navigationBar.isTranslucent = false
        
        
        self.setupChildVC(mainPageVC, title: "首页", imageName: "nav_1", selectImageName: "nav_1_on")

        self.setupChildVC(categoryVC, title: "服务区", imageName: "nav_2", selectImageName: "nav_2_on")
        
        self.setupChildVC(serverVC, title: "交流区", imageName: "nav_2", selectImageName: "nav_2_on")
        
        self.setupChildVC(shopVc, title: "购物车", imageName: "nav_4", selectImageName: "nav_4_on")

        self.setupChildVC(meVC, title: "我的", imageName: "nav_5", selectImageName: "nav_5_on")
    }
    
    
    //添加子页面
    func setupChildVC(_ childVC: UIViewController,title: String,imageName: String,selectImageName: String) {
        
        childVC.title = title
        childVC.tabBarItem.image = UIImage.init(named: imageName)
        //        不在渲染图片
        childVC.tabBarItem.selectedImage = UIImage.init(named: selectImageName)?.withRenderingMode(.alwaysOriginal)
        
        self.addChildViewController(childVC)
    }
}



