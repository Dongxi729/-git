//
//  LoginView.swift
//  DollBuy
//
//  Created by 郑东喜 on 2016/11/21.
//  Copyright © 2016年 郑东喜. All rights reserved.
//  登陆主控制器

import UIKit


protocol loginViewDelegate {
    //改变导航栏标题
    func logSuccess()
    
    //关闭当前视图
    func closeSelf()
}

class LoginView: TableBaseViewController,LoginUpViewDelegate,TableDelegate {
    /// 支付失败
    internal func payFail() {
        
    }
    
    /// 用户退出支付
    internal func payExit() {
        
    }
    
    /// 支付成功
    internal func paySuccess() {
        
    }
    
    var delegate : loginViewDelegate?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //文字颜色
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedStringKey.foregroundColor: UIColor.black]
        
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        
        UIApplication.shared.statusBarStyle = .default
        
        let btnn = UIButton()
        btnn.frame = CGRect(x: 15, y: 64, width: 20, height: 20)
        
        btnn.addTarget(self, action:#selector(self.fooButtonTapped), for: .touchUpInside)
        
        btnn.setBackgroundImage(UIImage.init(named: "close"), for: .normal)
        btnn.setBackgroundImage(UIImage.init(named: "close"), for: .highlighted)
        
        let rightFooBarButtonItem : UIBarButtonItem = UIBarButtonItem.init(customView: btnn)
        
        //显示左上角图标
        self.navigationItem.leftBarButtonItem = rightFooBarButtonItem
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        self.navigationController?.navigationBar.isHidden = false
        
        self.navigationItem.title = "登录"
        
        //继承基础类的代理
        self.t_delegate = self
        
        //取消返回手势,防止用户不小心返回页面，输入的个人信息丢失
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    
    //页面结束后，恢复左滑手势
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    
    deinit {
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "123"), object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //标题
        let centerTitle = UILabel()
        centerTitle.frame = CGRect(x: 0, y: 25, width: UIScreen.main.bounds.width, height: 30)
        centerTitle.font = UIFont.boldSystemFont(ofSize: 16)
        
        centerTitle.text = "登陆"
        centerTitle.textAlignment = NSTextAlignment.center
        
        setUpView()
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
    }
    
    //关闭当前视图
    func dismiss() -> Void {
        delegate?.closeSelf()
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func setUpView() -> Void {
        
        let upView = LoginUpView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.55 ))
        
        //判断机型
        let deviceType = UIDevice.current.deviceType
        
        switch deviceType {
        case .iPhone4S:
            
            upView.frame = CGRect(x: 0, y: -40, width: SW, height: SH * 0.5)
            break
        default:
            
            break
        }
        
        //监听代理
        upView.delegate = self
        
        view.addSubview(upView)
    }
    //注册事件
    func rigSEL() {
        self.navigationController?.pushViewController(RigisterViewController(), animated: true)
    }
    
    //忘记密码事件
    func forSEL() {
        self.navigationController?.pushViewController(ForgerPassViewController(), animated: true)
    }
    ///登陆事件
    func logSE() {
        /// 根据本地token判断
//        if let userToken = localSave.object(forKey: userToken) as? String {
            // 发送通知
//            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadWebVewNeed"), object: nil)
//
//            if let nav = self.navigationController {
//                if nav.viewControllers.count > 1 {
//                    nav.popViewController(animated: true)
//                }
//            }
//        } else {
            //切换主控制器（或者说刷新控制器）
            let mainVC = MainViewController()
            UIApplication.shared.keyWindow?.rootViewController = mainVC
//        }
    }
    
    func logSuc() {
        self.dismiss()
    }
    
    func qqLoginCallBack() {
        self.dismiss()
        self.navigationController!.popToRootViewController(animated: true)
        
    }
    
    //微信登陆成功回调
    func WXLoginCallBack() {
        self.dismiss()
        
        self.navigationController!.popToRootViewController(animated: true)
        
    }
    
    func click() {
        
        let mainVC = MainViewController()
        
        UIApplication.shared.keyWindow?.rootViewController = mainVC
        
        if let tabBarController = UIApplication.shared.keyWindow?.rootViewController as? UITabBarController {
            tabBarController.selectedIndex = 0
        }
    }
}
