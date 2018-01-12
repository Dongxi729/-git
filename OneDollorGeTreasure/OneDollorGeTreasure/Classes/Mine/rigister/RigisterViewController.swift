//
//  RigisterViewController.swift
//  DollBuy
//
//  Created by 郑东喜 on 2016/11/22.
//  Copyright © 2016年 郑东喜. All rights reserved.
//  注册控制器

import UIKit

class RigisterViewController: TableBaseViewController,RigisterDelegate,TableDelegate {
    
    var rigV = RigisterView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //隐藏导航栏
        self.navigationController?.navigationBar.isHidden = false
        
        //设置导航栏背景颜色透明
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
        
        //继承基础类的代理
        self.t_delegate = self 
    }
    
    //页面结束后，恢复左滑手势
    override func viewWillDisappear(_ animated: Bool) {
        
        //XFLog(message: viewWillDisappear)
        super.viewWillDisappear(animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //设置标题
        self.navigationItem.title = "注册"
        
        //修改导航栏背景色
        self.navigationController?.navigationBar.barTintColor =
            UIColor.white
                tableView.separatorStyle = UITableViewCellSeparatorStyle.none

        setUI()
    }

}

// MARK:- 设置UI
extension RigisterViewController{
    func setUI() -> Void {
        rigV = RigisterView()
        
        rigV.frame = view.bounds
        
        rigV.delegate = self
        view.addSubview(rigV)
    }
}

// MARK:- 监听代理
extension RigisterViewController {
    func rigSuccess() {
        
        LoginModel.shared.loginStatus = "true"
        
        self.navigationController!.popToRootViewController(animated: true)
    }
    
    //跳转注册网页链接
    func rigWebView() {

        aaa(str: rigURL)
        
    }
    
    func aaa(str : String) -> Void {
        
        let vvv = RigisterAgreeWebView()
        vvv.url = rigURL

        self.navigationController?.pushViewController(vvv, animated: true)
     
        
    }
}

// MARK:- 实现基类的方法
extension RigisterViewController {
    func click() {
        
    }

}
