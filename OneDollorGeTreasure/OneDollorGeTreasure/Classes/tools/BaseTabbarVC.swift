//
//  BaseTabbarVC.swift
//  WebViewGoback
//
//  Created by 郑东喜 on 2017/2/24.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  修改tabbar的文字和图片位置

import UIKit

class BaseTabbarVC: UITabBarController {

    //存放子视图
    fileprivate var viewArray = [UIView]()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //在这里修改
    override func viewWillLayoutSubviews() {
        let myHeight = self.tabBar.frame.height
        
        ///调整tabbar文本的高度
        UITabBarItem.appearance().titlePositionAdjustment = UIOffsetMake(0.0, -3.0)
        
        
        //重新设置tabbar 的高度
        var frame = self.tabBar.frame
        frame.size.height = myHeight
        frame.origin.y = self.view.frame.size.height - myHeight
        self.tabBar.frame = frame
        self.tabBar.barStyle = .default
        
        //设置图片偏移，因为加高了tabbar-----只是修改tabbar的图片位置
        for i in 0..<self.tabBar.items!.count {
            let itm = self.tabBar.items![i]
            //            if i != 2 {
            //                itm.imageInsets = UIEdgeInsets(top: myHeight - 49 - 5, left: 0, bottom: -(myHeight - 49 - 5), right: 0)
            //
            //            } else {
            itm.imageInsets = UIEdgeInsets(top: 2, left: 0, bottom: -2, right: 0)
            //            }
            
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        
        self.viewArray.removeAll()
        
        for index in 0..<self.tabBar.subviews.count {
            
            let view = self.tabBar.subviews[index]
            self.viewArray.append(view)
        }
        
        for i in 0..<self.viewArray.count {
            
            let v = self.viewArray[i]
            v.layer.removeAllAnimations()
        }
        
    }
}
