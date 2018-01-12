//
//  ForgerPassViewController.swift
//  FFF
//
//  Created by 郑东喜 on 2016/11/28.
//  Copyright © 2016年 郑东喜. All rights reserved.
//  忘记密码控制器

import UIKit

class ForgerPassViewController: BaseViewController,ForgetViewDelegate {

    //视图即将开始，回复导航栏设置
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //隐藏导航栏
        self.navigationController?.navigationBar.isHidden = false
        
        //设置导航栏背景颜色透明
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
        
        //集成基础类的方法
//        self.delegate = self
        
        //取消返回手势,防止用户不小心返回页面，输入的个人信息丢失
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }

    
    //页面结束后，恢复左滑手势
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }

    
    var v = ForgetView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //标题
        self.navigationItem.title = "忘记密码"

        // Do any additional setup after loading the view.
        
        //设置视图
        setView()
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.navigationController!.popToRootViewController(animated: true)
    }


}

extension ForgerPassViewController {
    func setView() -> Void {
        
        if #available(iOS 11, *) {
            v.frame = CGRect(x: 0, y: 64, width: SW, height: SH - 64)
        } else {
            v.frame = CGRect(x: 0, y: 0, width: SW, height: SH - 0)
        }
        
        if SH == 812 {
            v.frame = CGRect(x: 0, y: 0, width: SW, height: SH - 0)
        }
        v.delegate = self
        view.addSubview(v)
    }
}


// MARK:- 接收代理
extension ForgerPassViewController {
    /// 找回密码成功
    func findPassSuccess() {

        self.navigationController?.pushViewController(LoginView(), animated: true)
    }
}

// MARK:- 实现基础类代理的方法
//extension ForgerPassViewController {
//    func click() {
//        
//        let alert = UIAlertController.init(title: "提示", message: "您确定要放弃当前编辑的内容么?", preferredStyle: .alert)
//        
//        
//        alert.addAction(UIAlertAction.init(title: "放弃编辑", style: .destructive, handler: { (nil) in
//            //            self.navigationController!.popViewController(animated: true)
//            // pop here
//            if let navController = self.navigationController {
//                navController.popViewController(animated: true)
//            }
//        }))
//        
//        alert.addAction(UIAlertAction.init(title: "留在此页", style: .default, handler: nil))
//        
//        self.present(alert, animated: true, completion: nil)
//        
//        
//    }
//}
