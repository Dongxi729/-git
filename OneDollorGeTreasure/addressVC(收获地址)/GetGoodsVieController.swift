//
//  GetGoodsVieController.swift
//  DollBuy
//
//  Created by 郑东喜 on 2016/11/23.
//  Copyright © 2016年 郑东喜. All rights reserved.
//  收货地址控制器

import UIKit

class GetGoodsVieController: TableBaseViewController,GetGoodViewDelegate {
    func backToGood() {
        CCog()
        if let nav = self.navigationController {
            nav.popViewController(animated: true)
        }
    }
    
    
    var v = GetGoodView()
    
    //导航栏设置还原
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //取消返回手势,防止用户不小心返回页面，输入的个人信息丢失
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        self.navigationController?.navigationBar.isHidden = false
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
        
    }
    
    //页面结束后，恢复左滑手势
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.view.endEditing(true)
        
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "我的收货地址"
        
        view.backgroundColor = commonBgColor
        
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.white
        setUI()
        
        setStyle()
    }
}


extension GetGoodsVieController {
    /// 设置UI
    func setUI() -> Void {
        v.frame = view.bounds
        v.delegate = self
        view.addSubview(v)
    }
}


extension GetGoodsVieController {
    
    /// 设置表格样式
    func setStyle() -> Void {
        
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
    }
}
