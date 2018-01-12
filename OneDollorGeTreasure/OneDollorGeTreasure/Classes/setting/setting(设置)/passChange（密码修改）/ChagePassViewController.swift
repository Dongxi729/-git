//
//  ChagePassViewController.swift
//  DollBuy
//
//  Created by 郑东喜 on 2016/11/22.
//  Copyright © 2016年 郑东喜. All rights reserved.
//  修改密码控制器

import UIKit

class ChagePassViewController: TableBaseViewController,ChangePassViewDelegate {
    
    
    //导航栏设置还原
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
        
        //继承基础类的代理
//        self.t_delegate = self
        
        //取消返回手势,防止用户不小心返回页面，输入的个人信息丢失
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false

    }
    
    //页面结束后，恢复左滑手势
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.view.endEditing(true)

        
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        //设置标题
        self.navigationItem.title = "修改密码"
        
        //修改导航栏背景色
        self.navigationController?.navigationBar.barTintColor =
            UIColor.white
        
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        
        //设置样式
        setUI()
    }

}


extension ChagePassViewController {
    func setUI() -> Void {
        let changPassV = ChangePassView()
        
        //继承代理
        changPassV.delegate = self
        changPassV.frame = view.bounds
        view.addSubview(changPassV)
    }
}

// MARK:- 接听代理
extension ChagePassViewController {
    /// 修改密码成功
    func changePassSucc() {
        //返回首页
        let allVC = self.navigationController?.viewControllers
        
        let inventoryListVC = allVC![allVC!.count - 2]
        
        if (inventoryListVC.isKind(of: SettingViewController.self)) {
            self.navigationController!.popToViewController(inventoryListVC, animated: true)
        } else {
            
            self.navigationController!.popToRootViewController(animated: true)
        }
    }
}
