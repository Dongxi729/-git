//
//  MyCardsVC.swift
//  Alili
//
//  Created by 郑东喜 on 2017/9/11.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  我的优惠券

import UIKit

class MyCardsVC: UIViewController {

    
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
    
    lazy var rightItem: UIBarButtonItem = {
        let d: UIBarButtonItem = UIBarButtonItem.init(title: "兑换优惠券", style: .plain, target: self, action: #selector(exchangeCards))
        return d
    }()
    
    /// 兑换优惠券
    @objc private func exchangeCards() {
        self.navigationController?.pushViewController(MyExchangeVC(), animated: true)
    }
    
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white

        // Do any additional setup after loading the view.
        title = "我的优惠券"
        self.navigationItem.rightBarButtonItem = rightItem
    }
}




