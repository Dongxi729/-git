//
//  TableBaseViewController.swift
//  Fuck
//
//  Created by 郑东喜 on 2016/12/10.
//  Copyright © 2016年 郑东喜. All rights reserved.
//  表格基础类

import UIKit

//代理事件,拦截点击事件
protocol TableDelegate {
    func click() -> Void
}

class TableBaseViewController: UITableViewController,UIGestureRecognizerDelegate {
    
    var t_delegate : TableDelegate?
    var closeShow = "true"
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let btnn = UIButton()
        btnn.frame = CGRect(x: 15, y: 64, width: 20, height: 20)
        
        btnn.addTarget(self, action:#selector(BaseViewController.fooButtonTapped), for: .touchUpInside)
        
        if closeShow == "true" {
            btnn.setBackgroundImage(UIImage.init(named: "back"), for: .normal)
            btnn.setBackgroundImage(UIImage.init(named: "back"), for: .highlighted)
        } else if closeShow == "false" {
            btnn.setBackgroundImage(UIImage.init(named: "close"), for: .normal)
            btnn.setBackgroundImage(UIImage.init(named: "close"), for: .highlighted)
        }

        let rightFooBarButtonItem : UIBarButtonItem = UIBarButtonItem.init(customView: btnn)
        
        if self.navigationController == nil {
            return
        }
        
        //当子页面数大于1 时，显示左上角的箭头图标
        if (self.navigationController?.viewControllers.count)! > 1 {
            self.navigationItem.setLeftBarButton(rightFooBarButtonItem, animated: true)
        }
        
        //启用滑动返回（swipe back）
        self.navigationController?.interactivePopGestureRecognizer!.delegate = self
    }

    //修复返回失效
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        
        if gestureRecognizer == self.navigationController?.interactivePopGestureRecognizer {
            return (self.navigationController?.viewControllers.count)! > 1
        }
        return true
    }
    
    @objc func fooButtonTapped(){
        
        self.t_delegate?.click()
        
        if self.navigationController == nil {
            return
        }
        
        
        self.navigationController!.popViewController(animated: true)
    }
    

}
