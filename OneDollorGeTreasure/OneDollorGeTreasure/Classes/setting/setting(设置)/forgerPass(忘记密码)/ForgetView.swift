//
//  ForgetView.swift
//  FFF
//
//  Created by 郑东喜 on 2016/11/28.
//  Copyright © 2016年 郑东喜. All rights reserved.
//  找回密码视图

import UIKit

protocol ForgetViewDelegate {
    //忘密码追回成功
    func findPassSuccess()
}


class ForgetView: UIView {

    //代理
    var delegate : ForgetViewDelegate?
    
    
    //手机号
    var tfNum = TfPlaceHolder()
    
    //密码
    var tfPass = TfPlaceHolder()
    
    //验证码
    var tfAuto = TfPlaceHolder()
    
    //确认密码
    var tfComPass = TfPlaceHolder()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK:- 设置视图
extension ForgetView {
    fileprivate func setUI() -> Void {
        
        let arr = ["请输入您的手机号码","请输入您的验证码","请输入您的密码","请再次输入您的密码"]

        var tf = TfPlaceHolder()

        var line = UIView()

        for i in 0..<arr.count {
            
            //前置图片
            let img = UIImageView()
            img.frame = CGRect(x: Int(10), y:Int(45 * i + 10), width: 25, height: 25)
//            img.backgroundColor = UIColor.gray
            img.tag = 200 + i
            
            
            //根据tag添加图片
            if img.tag == 200 {
                img.image = UIImage.init(named: "perInfo")
            } else if img.tag == 201 {
                img.image = UIImage.init(named: "yzm")
            } else if img.tag == 202 {
                img.image = UIImage.init(named: "password")
            } else if img.tag == 203 {
                img.image = UIImage.init(named: "password")
            }
            
            
            //布局前面。、中间
            
            tf = TfPlaceHolder(frame: CGRect(x: 30 + 15 , y: 45 * i, width: Int(UIScreen.main.bounds.width - 45), height: 45))
            tf.plStrSize(str: arr[i], holderColor: UIColor.gray, textFontSize: 13)
//            tf.placeholder = arr[i]
            tf.tag = 100 + i
            
            //第二行tf的宽度
            if i == 1 {
                tf.frame = CGRect(x: 30 + 15, y: 45 * i, width: Int(UIScreen.main.bounds.width - 165), height: 45)
            }

            //背景层
            let vie = UIView()
            vie.backgroundColor = UIColor.white
            vie.frame =  CGRect(x: 0 , y: 45 * i, width: Int(UIScreen.main.bounds.width), height: 45)
            
            self.addSubview(vie)
            self.addSubview(img)
            self.addSubview(tf)


            
            //设置线条
            if i == 1 || i == 2 || i == 3 {
                line = UIView(frame: CGRect(x: 0, y: 45 * i, width: Int(UIScreen.main.bounds.width), height: 1))
                
                line.backgroundColor = UIColor.gray
                
                self.addSubview(line)
            }
            
            //验证码按钮
            let yzmBtn = CountDownBtn()
            
            //设置验证码按钮
            if i == 1 {

                yzmBtn.frame = CGRect(x: Int(UIScreen.main.bounds.width - 100 - 15), y: 45 * i + 5, width: 100, height: 35)
                yzmBtn.backgroundColor = commonBtnColor
                yzmBtn.setTitle("获取验证码", for: .normal)
                yzmBtn.setTitle("获取验证码", for: .highlighted)
                yzmBtn.addTarget(self, action: #selector(whenSendBtnClicked(button:)), for: .touchUpInside)
                yzmBtn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
                yzmBtn.layer.cornerRadius = 8
                yzmBtn.layer.masksToBounds = true
            }
            addSubview(yzmBtn)
            
        
        }
        
        //背景视图
        let bgView = UIView()
        bgView.frame = CGRect(x: 0, y:  45 * 4 , width: SW, height: SH - 45 * 4 + 15)
        
        bgView.backgroundColor = commonBgColor
        addSubview(bgView)
        
        //保存按钮
        let saveBtn = UIButton()
        
        saveBtn.frame = CGRect(x: 15, y: 45 * 4 + 15, width: UIScreen.main.bounds.width - 30, height: 45)
        
        saveBtn.backgroundColor = commonBtnColor
        saveBtn.setTitle("确定", for: .normal)
        saveBtn.setTitle("确定", for: .highlighted)
        saveBtn.layer.cornerRadius = 8
        saveBtn.layer.masksToBounds = true
        
        saveBtn.addTarget(self, action: #selector(ForgetView.saveSEL), for: .touchUpInside)
        addSubview(saveBtn)

        

        //根据tag制取
        
        tfNum = viewWithTag(100) as! TfPlaceHolder
        tfPass = viewWithTag(102) as! TfPlaceHolder
        tfAuto = viewWithTag(101) as! TfPlaceHolder
        tfComPass = viewWithTag(103) as! TfPlaceHolder
        
        //限定输入长度
        tfNum.setPass(setSecure: false, maxInput: 11)
        tfAuto.setPass(setSecure: false, maxInput: 6)
        tfPass.setPass(setSecure: true, maxInput: 999)
        tfComPass.setPass(setSecure: true, maxInput: 999)
        
        //设置键盘类型
        tfNum.keyboardType = .numberPad
        tfAuto.keyboardType = .numberPad
        
        
        //成为第一响应者
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            self.tfNum.becomeFirstResponder()
        }
    }
}

// MARK:- 单机事件
extension ForgetView {

    @objc func saveSEL() -> Void {
        
        self.endEditing(true)
        
        ForgetModel.shared.forgetPass(tfNum: tfNum, tfAuto: tfAuto, tfPass: tfPass, tfConfirmPass: tfComPass) { (result) in

            if result == "你的密码修改成功" {
                //                nav?.navigationController!.popViewController(animated: true)
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: { 
                    self.delegate?.findPassSuccess()
                })
                
            }
        }
    }
}

// MARK:- 验证码事件
extension ForgetView {
    /// 验证码事件
    ///
    /// - Parameter button: 继承CountDownBtn，获得其属性与方法
    @objc func whenSendBtnClicked(button: CountDownBtn) {
        
        self.endEditing(true)
        SendAutoModel.shared.sendForgetAuto(sendType: 2, tfNum: tfNum) { (result) in
            
            if result == "true" {
                button.initwith(color: UIColor.orange, title: "发送验证码", superView: self)
            }
            
        }
    }
}
















