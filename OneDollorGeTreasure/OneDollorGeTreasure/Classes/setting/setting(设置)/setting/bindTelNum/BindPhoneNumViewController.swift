//
//  BindPhoneNumViewController.swift
//  DollBuy
//
//  Created by 郑东喜 on 2016/11/22.
//  Copyright © 2016年 郑东喜. All rights reserved.
//  绑定手机号住控制器

import UIKit


class BindPhoneNumViewController: TableBaseViewController,BindPhoneDelegate {
    
    
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
        
        view.endEditing(true)
        
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.init(red: 229/255, green: 229/255, blue: 229/255, alpha: 1)
        
        
        //设置标题
        self.navigationItem.title = "绑定手机号"
        
        //修改导航栏背景色
        self.navigationController?.navigationBar.barTintColor =
            UIColor.white
        
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        setUI()
    }

}

// MARK:- 设置UI
extension BindPhoneNumViewController{
    /// 设置UI
    func setUI() -> Void {
        let bindPhoneV = BindPhoneView()
        bindPhoneV.delegate = self
        bindPhoneV.frame = view.bounds
        view.addSubview(bindPhoneV)
    }
}

// MARK:- 获取代理事件
extension BindPhoneNumViewController {
    /// 绑定手机号成功
    func bindSuccess() {
        //XFLog(message: "触发绑定成功事件")
        self.navigationController?.pushViewController(SetThirdPassVC(), animated: true)
    }
    
    /// 绑定密码成功
    func bindSecreSuccess() {
        //XFLog(message: "绑定密码成功事件")
        
        self.navigationController!.popViewController(animated: true)
    }
    
    
    ///
    func back() {
        self.navigationController!.popViewController(animated: true)
    }
}

