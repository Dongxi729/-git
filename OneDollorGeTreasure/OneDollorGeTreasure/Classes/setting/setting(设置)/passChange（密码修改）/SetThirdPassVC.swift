//
//  SetThirdPassVC.swift
//  DollBuy
//
//  Created by 郑东喜 on 2016/12/9.
//  Copyright © 2016年 郑东喜. All rights reserved.
//  设置第三方授权平台密码

import UIKit

class SetThirdPassVC: BaseViewController {
    
    //原始密码
    var tfPass: TfPlaceHolder = {
        let lab = TfPlaceHolder()
        lab.frame = CGRect(x: 50, y: 64, width: UIScreen.main.bounds.size.width - 60 , height: 45)
        lab.plStrSize(str: "请输入您的密码", holderColor: UIColor.gray, textFontSize: 13)
        lab.setPass(setSecure: true, maxInput: 999)
        //文字左对齐
        lab.textAlignment = NSTextAlignment.left
        return lab
    }()
    
    
    //分割线
    lazy var line : UIView = {
        let lin = UIView()
        lin.frame = CGRect(x: 0, y: 45 + 64, width: UIScreen.main.bounds.size.width, height: 0.5)
        lin.backgroundColor = UIColor.lightGray
        return lin
    }()
    
    
    //新密码
    var tfConPass: TfPlaceHolder = {
        let lab = TfPlaceHolder()
        lab.frame = CGRect(x: 50, y: 45 + 64, width: UIScreen.main.bounds.size.width - 60 , height: 45)
        lab.plStrSize(str: "请再次输入您的新密码", holderColor: UIColor.gray, textFontSize: 13)
        lab.setPass(setSecure: true, maxInput: 999)
        //文字左对齐
        lab.textAlignment = NSTextAlignment.left
        return lab
    }()
    
    //分割线
    lazy var newPassLine : UIView = {
        let lin = UIView()
        lin.frame = CGRect(x: 0, y: 90 + 64, width: UIScreen.main.bounds.size.width, height: 0.5)
        lin.backgroundColor = UIColor.lightGray
        return lin
    }()
    

    //分割线
    lazy var tfConfirmLine : UIView = {
        let lin = UIView()
        lin.frame = CGRect(x: 0, y: 135 + 64, width: UIScreen.main.bounds.size.width, height: 0.5)
        lin.backgroundColor = UIColor.lightGray
        return lin
    }()
    
    
    //旧密码前置图片
    lazy var tfOldImg: UIImageView = {
        let img = UIImageView()
        //自适应放大
        img.contentMode = UIViewContentMode.scaleAspectFit
        img.frame = CGRect(x: 10, y: 10 + 64, width: 25, height: 25)
        img.image = UIImage.init(named: "password")
        
        img.contentMode = UIViewContentMode.scaleAspectFit
        return img
    }()
    
    //新密码前置图片
    lazy var tfNewImg: UIImageView = {
        let img = UIImageView()
        //自适应放大
        img.contentMode = UIViewContentMode.scaleAspectFit
        img.frame = CGRect(x: 10, y: 55 + 64, width: 25, height: 25)
        img.image = UIImage.init(named: "password")
        //        img.backgroundColor = UIColor.red
        img.contentMode = UIViewContentMode.scaleAspectFit
        return img
    }()
    
    
    //保存按钮
    lazy var saveBtn : UIButton = {
        let btn = UIButton()
        btn.frame = CGRect(x: 15, y: 175 , width: UIScreen.main.bounds.width - 30, height: 40)
        btn.backgroundColor = commonBtnColor
        btn.layer.cornerRadius = 8
        btn.setTitle("保存", for: .normal)
        btn.addTarget(self, action: #selector(self.setPass), for: .touchUpInside)
//        btn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        
        return btn
    }()

    //背景视图
    lazy var bgView : UIView = {
        let btn = UIView()
        
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "设置第三方登陆密码"
        
        view.backgroundColor = UIColor.white
        
        setUI()
        
    }

}


// MARK:- 设置控件
extension SetThirdPassVC {
    func setUI() -> Void {
        
        bgView.frame = CGRect(x: 0, y: 155, width: SW, height: SH - 160)
        bgView.backgroundColor = commonBgColor
        view.addSubview(bgView)
        
        //第一响应者
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            self.tfPass.becomeFirstResponder()
        }
        
        view.addSubview(tfPass)
        view.addSubview(tfConPass)
        view.addSubview(line)
        view.addSubview(newPassLine)
        view.addSubview(tfNewImg)
        view.addSubview(tfOldImg)
        view.addSubview(saveBtn)
    }

    //确定事件（设置密码）
    @objc func setPass() -> Void {
        
        //停止编辑状态
        self.view.endEditing(true)

        if tfPass.text?.characters.count == 0 {

            MBManager.showBriefAlert(tfPassNull)
        } else if tfConPass.text?.characters.count == 0 {
            MBManager.showBriefAlert(confirPassNotNull)
            
        } else if tfPass.text != tfConPass.text {
            MBManager.showBriefAlert(passTwoChekc)
            
        } else {
            BindPhoneSecrectModel.shared.bindSecrect(passStr: tfPass.text!) { (result) in
                
                //不可设置密码
            if result == "密码设置成功" {

                //改变单例的值
                    BindPhoneModel.shared.bindPhone = "true"
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                            self.navigationController?.popToRootViewController(animated: true)
                        })
                
                } else if result == "该账号已在异地登录，请重新登录" {
                    
                    CustomAlertView.shared.closeWithAlert(strTitle: loginError, test: {
                        logoutModel.shared.logoutSEL(comfun: { (result) in
                            let nav = NaVC.init(rootViewController: LoginView())
                            UIApplication.shared.keyWindow?.rootViewController = nav
                        })
                    })
                }
            }

        }
        
        
    }
    
}
