//
//  BindPhoneView.swift
//  DollBuy
//
//  Created by 郑东喜 on 2016/11/22.
//  Copyright © 2016年 郑东喜. All rights reserved.
//  绑定手机号视图

import UIKit

// MARK:- 设置代理
protocol BindPhoneDelegate {
    //接收绑定成功
    func bindSuccess()
    
    //接收绑定成功
    func bindSecreSuccess()
    
    //返回
    func back()
}

class BindPhoneView: UIView {
    
    //设置代理
    var delegate : BindPhoneDelegate?
    
    
    //手机号码
    var tfNum: TfPlaceHolder = {
        let lab = TfPlaceHolder()
        lab.frame = CGRect(x: 50, y: 0, width: UIScreen.main.bounds.size.width - 60 , height: 45)
        //        lab.placeholder = "请输入您的手机号码"
        lab.plStrSize(str: "请输入您的手机号码", holderColor: UIColor.gray, textFontSize: 13)
        
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
    
    //验证码
    var tfAuth: TfPlaceHolder = {
        let lab = TfPlaceHolder()
        lab.frame = CGRect(x: 50, y: 45, width: UIScreen.main.bounds.size.width - 100 - 15 - 50 , height: 45)
        lab.plStrSize(str: "请输入您的验证码", holderColor: UIColor.gray, textFontSize: 13)
        
        //文字左对齐
        lab.textAlignment = NSTextAlignment.left
        return lab
    }()
    
    //密码
    var tfPass: TfPlaceHolder = {
        let lab = TfPlaceHolder()
        lab.frame = CGRect(x: 50, y: 90, width: UIScreen.main.bounds.size.width - 60 , height: 45)
        lab.plStrSize(str: "请输入您的密码", holderColor: UIColor.gray, textFontSize: 13)
        lab.setPass(setSecure: true, maxInput: 16)
        
        //文字左对齐
        lab.textAlignment = NSTextAlignment.left
        return lab
    }()
    
    //密码前置图片
    lazy var tfPassImg: UIImageView = {
        let img = UIImageView()
        //自适应放大
        img.contentMode = UIViewContentMode.scaleAspectFit
        img.frame = CGRect(x: 7.5, y: 97.5, width: 30, height: 30)

        return img
    }()
    
    //分割线
    lazy var tfPassLine : UIView = {
        let lin = UIView()
        lin.frame = CGRect(x: 0, y: 135, width: UIScreen.main.bounds.size.width, height: 0.5)
        lin.backgroundColor = UIColor.lightGray
        return lin
    }()
    
    
    //验证码按钮
    lazy var yzmBtn : CountDownBtn = {
        let btn = CountDownBtn()

        btn.frame = CGRect(x: SW - 15 - 100, y: 52.5, width: 100, height: 30)
        btn.backgroundColor = commonBtnColor
        btn.layer.cornerRadius = 8
        btn.setTitle("获取验证码", for: .normal)
        btn.addTarget(self, action: #selector(autoSEL(sender:)), for: .touchUpInside)
        
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        
        return btn
    }()
    
    //分割线
    lazy var newPassLine : UIView = {
        let lin = UIView()
        lin.frame = CGRect(x: 0, y: 90, width: UIScreen.main.bounds.size.width, height: 0.5)
        lin.backgroundColor = UIColor.lightGray
        return lin
    }()
    

    //手机号前置图片
    lazy var tfOldImg: UIImageView = {
        let img = UIImageView()
        //自适应放大
        img.contentMode = UIViewContentMode.scaleAspectFit
        img.frame = CGRect(x: 10, y: 10, width: 25, height: 25)

        img.contentMode = UIViewContentMode.scaleAspectFit
        return img
    }()
    
    //验证码前置图片
    lazy var tfNewImg: UIImageView = {
        let img = UIImageView()
        //自适应放大
        img.contentMode = UIViewContentMode.scaleAspectFit
        img.frame = CGRect(x: 10, y: 55, width: 25, height: 25)
        return img
    }()

    
    //保存按钮
    lazy var saveBtn : UIButton = {
        let btn = UIButton()
        btn.frame = CGRect(x: 15, y: 110, width: UIScreen.main.bounds.width - 30, height: 40)
        btn.backgroundColor = commonBtnColor
        btn.layer.cornerRadius = 8
        btn.setTitle("保存", for: .normal)
         
        btn.addTarget(self, action: #selector(BindPhoneView.confirmSEL), for: .touchUpInside)
//        btn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        
        return btn
    }()
    
    
    //背景视图
    lazy var bgView : UIView = {
        let btn = UIView()
        
        return btn
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        
        self.setUI()

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}

extension BindPhoneView {
    func setUI() -> Void {
        
        tfOldImg.image = UIImage.init(named: "perInfo")
        tfNewImg.image = UIImage.init(named: "yzm")
        
        bgView = UIView()
        bgView.frame = CGRect(x: 0, y: 90, width: SW, height: SH)
        bgView.backgroundColor = UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1)
        addSubview(bgView)
        
        //设置键盘类型
        tfNum.keyboardType = .numberPad
        tfAuth.keyboardType = .numberPad

        
        //手机号
        addSubview(tfNum)
        addSubview(tfOldImg)
        addSubview(line)
        
        //验证码
        addSubview(tfAuth)
        addSubview(tfNewImg)
        addSubview(newPassLine)
        addSubview(yzmBtn)
        
        //保存按钮
        addSubview(saveBtn)
        
        //成为第一响应者
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) {
            self.tfNum.becomeFirstResponder()
        }
        
        
        //长度限制
        tfNum.setPass(setSecure: false, maxInput: 11)
        tfAuth.setPass(setSecure: false, maxInput: 6)
    }
}


// MARK:- 单击事件
extension BindPhoneView {
    //验证码事件
    @objc func autoSEL(sender : CountDownBtn) -> Void {
        SendAutoModel.shared.sendForgetAuto(sendType: 3, tfNum: tfNum) { (result) in
            
            self.endEditing(true)
            if result == "true" {
                sender.initwith(color: commonBtnColor, title: "发送验证码", superView: self)
            }
        }
    }
    
    //确定事件
    @objc func confirmSEL() -> Void {
        
        
        //请求绑定手机号事件
        BindPhoneModel.shared.BindPhoneSEL(tfAuto: tfAuth, tfNum: tfNum) { (result) in

            if result == "绑定成功" {
            
//            if result == "短信验证码错误" {
                //存入本地，方便没有
                localSave.set(self.tfNum.text, forKey: "bindPhone")
                localSave.synchronize()
                
                
                //改变单例，下次进入不可进入绑定手机号，防止误操作
                PersonInfoModel.shared.bindPhone = "true"
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: { 
                    self.delegate?.bindSuccess()
                })

            }


        }
        

    }
}


