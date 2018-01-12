//
//  ChangePassView.swift
//  DollBuy
//
//  Created by 郑东喜 on 2016/11/22.
//  Copyright © 2016年 郑东喜. All rights reserved.
//  修改密码

import UIKit

//设置代理
protocol ChangePassViewDelegate {
    //修改成功代理
    func changePassSucc()
}

class ChangePassView: UIView {
    //监听代理
    var delegate : ChangePassViewDelegate?
    

    //原始密码
    var tfOldPass: TfPlaceHolder = {
        let lab = TfPlaceHolder()
        lab.frame = CGRect(x: 45, y: 0, width: UIScreen.main.bounds.size.width - 60 , height: 45)
        //        lab.placeholder = "请输入您的手机号码"
        lab.plStrSize(str: "请输入您的原始密码", holderColor: UIColor.gray, textFontSize: 13)
        
        //文字左对齐
        lab.textAlignment = NSTextAlignment.left
        return lab
    }()
    
    
    //分割线
    lazy var line : UIView = {
        let lin = UIView()
        lin.frame = CGRect(x: 0, y: 45, width: UIScreen.main.bounds.size.width, height: 0.5)
        lin.backgroundColor = UIColor.lightGray
        return lin
    }()

    
    //新密码
    var tfnewPass: TfPlaceHolder = {
        let lab = TfPlaceHolder()
        lab.frame = CGRect(x: 45, y: 45, width: UIScreen.main.bounds.size.width - 60 , height: 45)
        lab.plStrSize(str: "请输入您的新密码", holderColor: UIColor.gray, textFontSize: 13)

        //文字左对齐
        lab.textAlignment = NSTextAlignment.left
        return lab
    }()
    
    //分割线
    lazy var newPassLine : UIView = {
        let lin = UIView()
        lin.frame = CGRect(x: 0, y: 90, width: UIScreen.main.bounds.size.width, height: 0.5)
        lin.backgroundColor = UIColor.lightGray
        return lin
    }()
    
    
    
    //确认密码
    var tfConfirmPass: TfPlaceHolder = {
        let lab = TfPlaceHolder()
        lab.frame = CGRect(x: 45, y: 90, width: UIScreen.main.bounds.size.width - 60 , height: 45)
        lab.plStrSize(str: "请再次输入您的密码", holderColor: UIColor.gray, textFontSize: 13)
        
        lab.tag = 113
        
        //文字左对齐
        lab.textAlignment = NSTextAlignment.left
        return lab
    }()
    
    //分割线
    lazy var tfConfirmLine : UIView = {
        let lin = UIView()
        lin.frame = CGRect(x: 0, y: 135, width: UIScreen.main.bounds.size.width, height: 0.5)
        lin.backgroundColor = UIColor.lightGray
        return lin
    }()
    

    //旧密码前置图片
    lazy var tfOldImg: UIImageView = {
        let img = UIImageView()
        //自适应放大
        img.contentMode = UIViewContentMode.scaleAspectFit
        img.frame = CGRect(x: 10, y: 10, width: 25, height: 25)
        

        img.contentMode = UIViewContentMode.scaleAspectFit
        return img
    }()
    
    //新密码前置图片
    lazy var tfNewImg: UIImageView = {
        let img = UIImageView()
        //自适应放大
        img.contentMode = UIViewContentMode.scaleAspectFit
        img.frame = CGRect(x: 7.5 + 2.5, y: 55, width: 25, height: 25)
        img.image = UIImage.init(named: "password")

        img.contentMode = UIViewContentMode.scaleAspectFit
        return img
    }()
    
    //再次输入密码前置图片
    lazy var tfConfirmImg: UIImageView = {
        let img = UIImageView()
        //自适应放大
        img.contentMode = UIViewContentMode.scaleAspectFit
        img.frame = CGRect(x: 10, y: 100, width: 25, height: 25)

        img.contentMode = UIViewContentMode.scaleAspectFit
        return img
    }()
    
    
    
    //验证码按钮
    lazy var saveBtn : UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor.orange
        btn.frame = CGRect(x: 7.5, y: 150, width: UIScreen.main.bounds.width - 15, height: 40)
        btn.backgroundColor = commonBtnColor
        btn.layer.cornerRadius = 8
        btn.setTitle("保存", for: .normal)
        btn.addTarget(self, action: #selector(ChangePassView.confirmSEL), for: .touchUpInside)
//        btn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        
        return btn
    }()
    
    //背景视图
    lazy var bgView : UIView = {
        let btn = UIView()
        
        return btn
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.setUI()
    }


}


extension ChangePassView {
    ///设置UI
    func setUI() -> Void {
        
        //原始密码前置图片
        tfOldImg.image = UIImage.init(named: "password")
        
        //新密码前置图片
        tfNewImg.image = UIImage.init(named: "password")
        
        //确认密码前置图片
        tfConfirmImg.image = UIImage.init(named: "password")
        
        //限制输入密码位数
        tfOldPass.setPass(setSecure: true, maxInput: 999)
        tfnewPass.setPass(setSecure: true, maxInput: 999)
        tfConfirmPass.setPass(setSecure: true, maxInput: 999)
        
        
        //背景视图
        bgView = UIView()
        bgView.frame = CGRect(x: 0, y: 90 + 45, width: SW, height: SH - 90)
        bgView.backgroundColor = UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1)
        addSubview(bgView)
        
        //旧密码
        addSubview(tfOldPass)
        addSubview(tfOldImg)
        addSubview(line)
        
        //新密码
        addSubview(tfnewPass)
        addSubview(tfNewImg)
        addSubview(newPassLine)
     
        //确认密码
        addSubview(tfConfirmPass)
        addSubview(tfConfirmImg)
        addSubview(tfConfirmLine)
        
        addSubview(saveBtn)
        
        
        //成为第一响应者
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            self.tfOldPass.becomeFirstResponder()
        }
    }
}

// MARK:- 单击事件
extension ChangePassView {
    //确定事件
    @objc func confirmSEL() -> Void {
        
        //停止编辑状态
        self.endEditing(true)

        ChangePassModel.shared.changePassSEL(tfOldPass: tfOldPass, tfNewPass: tfnewPass, tfComPass: tfConfirmPass) { (result) in

            if result == "密码修改成功" {
                //延时半秒再跳，防止跳转视图冲突

                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) {
                    self.delegate?.changePassSucc()
                }

            } else if result == "该账号已在异地登录，请重新登录" {
                


            }
        }
        
    }

}

