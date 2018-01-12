//
//  CustomAlertView.swift
//  AleartView
//
//  Created by 郑东喜 on 2016/12/2.
//  Copyright © 2016年 郑东喜. All rights reserved.
//

import UIKit

class CustomAlertView: UIView {
    
    static let shared = CustomAlertView()
    
    var alertView = ZDXAlertController()
    
    var test:(_ : ()->Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CustomAlertView {
    
    /// 显示标题
    ///
    /// - Parameter strTitle: 标题
    func alertWithTitle(strTitle : String) -> Void {

        alertView = ZDXAlertController.init(title: strTitle, message: nil, preferredStyle: .alert)

        //显示提示框
        UIApplication.shared.keyWindow?.rootViewController?.present(alertView, animated: true, completion: nil)
        
        self.dissmiss()

    }
    
    
    /// 带菊花的警告提示视图
    ///
    /// - Parameter strTitle: 标题
    func alertWithIndica(strTitle : String) -> Void {
        
        alertView = ZDXAlertController.init(title: strTitle, message: nil, preferredStyle: .alert)
        
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        alertView.view.addSubview(activityIndicator)
        
        
        let xConstraint = NSLayoutConstraint(item: activityIndicator, attribute: .centerX, relatedBy: .equal, toItem: alertView.view, attribute: .centerX, multiplier: 1, constant: 0)
        
        
        let yConstraint = NSLayoutConstraint(item: activityIndicator, attribute: .centerY, relatedBy: .equal, toItem: alertView.view, attribute: .centerY, multiplier: 1, constant: 0)
        
        NSLayoutConstraint.activate([ xConstraint, yConstraint])
        
        
        activityIndicator.isUserInteractionEnabled = false
        
        activityIndicator.startAnimating()
        
        
        let height: NSLayoutConstraint = NSLayoutConstraint(item: alertView.view, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 80)
        
        
        alertView.view.addConstraint(height);
        
        
        //显示提示框
        UIApplication.shared.keyWindow?.rootViewController?.present(alertView, animated: true, completion: nil)
        
        //        self.dissmiss()
        
    }

    /// 带菊花的警告提示视图
    ///
    /// - Parameter strTitle: 标题
    func alertWithIndicator(strTitle : String) -> Void {
        
        alertView = ZDXAlertController.init(title: strTitle, message: nil, preferredStyle: .alert)
        
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        alertView.view.addSubview(activityIndicator)
        
        
        let xConstraint = NSLayoutConstraint(item: activityIndicator, attribute: .centerX, relatedBy: .equal, toItem: alertView.view, attribute: .centerX, multiplier: 1, constant: 0)
        
        
        let yConstraint = NSLayoutConstraint(item: activityIndicator, attribute: .centerY, relatedBy: .equal, toItem: alertView.view, attribute: .centerY, multiplier: 1.4, constant: 0)
        
        NSLayoutConstraint.activate([ xConstraint, yConstraint])
        
        
        activityIndicator.isUserInteractionEnabled = false
        
        activityIndicator.startAnimating()
        
        
        let height: NSLayoutConstraint = NSLayoutConstraint(item: alertView.view, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 80)
        
        
        alertView.view.addConstraint(height);

        
        //显示提示框
        UIApplication.shared.keyWindow?.rootViewController?.present(alertView, animated: true, completion: nil)
        
//        self.dissmiss()
        
    }
    
    
    /// 关闭提示框
    ///
    /// - Parameters:
    ///   - strTitle: 标题
    ///   - test: 闭包函数
    func closeWithAlert(strTitle : String,test:(_ : ()->Void)?)-> Void {
        
        self.test = test
        alertView = ZDXAlertController.init(title: strTitle, message: nil, preferredStyle: .alert)
        
        alertView.addAction(UIAlertAction.init(title: "登录", style: .default, handler: { (nil) in
            test!()
        }))
        
        alertView.addAction(UIAlertAction.init(title: "取消", style: .default, handler: { (nil) in
            
            let mainVC = MainViewController()
            
            UIApplication.shared.keyWindow?.rootViewController = mainVC
            
            let tabBarController = UIApplication.shared.keyWindow?.rootViewController as! UITabBarController
            tabBarController.selectedIndex = 0
        }))
        
        //显示提示框
//        UIApplication.shared.keyWindow?.rootViewController?.present(alertView, animated: true, completion: nil)
        
        presentViewController(alert: alertView, animated: true, completion: nil)

    }
    
    
    
    /// 提示框，手动关闭
    ///
    /// - Parameter strTitle: 标题
    func alertAfterDown(strTitle : String) -> Void {
        alertView = ZDXAlertController.init(title: strTitle, message: nil, preferredStyle: .alert)
        
        //显示提示框
        UIApplication.shared.keyWindow?.rootViewController?.present(alertView, animated: true, completion: nil)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dissmiss()
    }
    

    /// 消失
    func dissmiss() -> Void {
        //两秒钟后自动消失
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            UIApplication.shared.keyWindow?.rootViewController?.dismiss(animated: false, completion: nil)
        }

    
    }
}

private func presentViewController(alert: ZDXAlertController, animated flag: Bool, completion: (() -> Void)?) -> Void {
    UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: flag, completion: completion)
    
}

func warningAlert2(title: String, message: String ){
    let alert = ZDXAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.actionSheet)
    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:  { (action) -> Void in
    }))
    
    presentViewController(alert: alert, animated: true, completion: nil)
}
