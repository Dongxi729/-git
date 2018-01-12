
//
//  RigisterView.swift
//  DollBuy
//
//  Created by 郑东喜 on 2016/11/22.
//  Copyright © 2016年 郑东喜. All rights reserved.
//  注册视图

import UIKit

// MARK:- 代理
protocol RigisterDelegate {
    
    //注册成功
    func rigSuccess()
    
    //注册成功
    func rigWebView()
}

class RigisterView: UIView {

    var delegate : RigisterDelegate?
    
    static let shared = RigisterView()
    
    /// 默认注册事项打钩
    override func awakeFromNib() {
        seleBtnImg.isHidden = localSave.bool(forKey: agreeLaw)
    }
    
    //手机号
    var tfNum: TfPlaceHolder = {
        let lab = TfPlaceHolder()
        lab.frame = CGRect(x: 50, y: 0, width: UIScreen.main.bounds.size.width - 60 , height: 45)
        
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
    var tfAuto: TfPlaceHolder = {
        let lab = TfPlaceHolder()
        lab.frame = CGRect(x: 50, y: 45, width: UIScreen.main.bounds.size.width - 50 - 15 - 100 , height: 45)
        lab.plStrSize(str: "请输入您的验证码", holderColor: UIColor.gray, textFontSize: 13)
        
        //文字左对齐
        lab.textAlignment = NSTextAlignment.left
        return lab
    }()
    
    //验证码按钮
    lazy var yzmBtn : CountDownBtn = {
        let btn = CountDownBtn()

        btn.frame = CGRect(x: SW - 15 - 100, y: 52.5, width: 100, height: 30)

        btn.addTarget(self, action: #selector(whenSendBtnClicked(button:)), for: .touchUpInside)

        btn.backgroundColor = commonBtnColor
        btn.layer.cornerRadius = 8
        btn.setTitle("获取验证码", for: .normal)

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
    
    
    //昵称
    var tfNickName: TfPlaceHolder = {
        let lab = TfPlaceHolder()
        lab.frame = CGRect(x: 50, y: 90, width: UIScreen.main.bounds.size.width - 60 , height: 45)
        lab.plStrSize(str: "请输入您的昵称", holderColor: UIColor.gray, textFontSize: 13)
        
        
        //文字左对齐
        lab.textAlignment = NSTextAlignment.left
        return lab
    }()
    
    //昵称前置图片
    lazy var nickNameImg: UIImageView = {
        let img = UIImageView()
        //自适应放大
        img.contentMode = UIViewContentMode.scaleAspectFit
        img.frame = CGRect(x: 10, y: 100, width: 25, height: 25)
        return img
    }()
    
    //密码
    var tfPass: TfPlaceHolder = {
        let lab = TfPlaceHolder()
        lab.frame = CGRect(x: 50, y: 135, width: UIScreen.main.bounds.size.width - 60 , height: 45)
        lab.plStrSize(str: "请输入您的密码", holderColor: UIColor.gray, textFontSize: 13)
        
        lab.setPass(setSecure: true, maxInput: 16)
        
        //文字左对齐
        lab.textAlignment = NSTextAlignment.left
        return lab
    }()
    
    //确认密码
    var tfConfirmPass: TfPlaceHolder = {
        let lab = TfPlaceHolder()
        lab.frame = CGRect(x: 50, y: 180, width: UIScreen.main.bounds.size.width - 60 , height: 45)
        lab.plStrSize(str: "请再次输入您的密码", holderColor: UIColor.gray, textFontSize: 13)
        lab.setPass(setSecure: true, maxInput: 16)
        
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
    lazy var tfNumImg: UIImageView = {
        let img = UIImageView()
        //自适应放大
        img.contentMode = UIViewContentMode.scaleAspectFit
        img.frame = CGRect(x: 10, y: 10, width: 25, height: 25)
        return img
    }()
    
    //新密码前置图片
    lazy var tfAutoImg: UIImageView = {
        let img = UIImageView()
        //自适应放大
        img.contentMode = UIViewContentMode.scaleAspectFit
        img.frame = CGRect(x: 10, y: 55, width: 25, height: 25)
        
        return img
    }()
    
    //再次输入密码前置图片
    lazy var tfPassImg: UIImageView = {
        let img = UIImageView()
        //自适应放大
        img.contentMode = UIViewContentMode.scaleAspectFit
        img.frame = CGRect(x: 10, y: 190, width: 25, height: 25)
        
        return img
    }()
    
    //再次输入密码前置图片
    lazy var tfConPassImg: UIImageView = {
        let img = UIImageView()
        //自适应放大
        img.contentMode = UIViewContentMode.scaleAspectFit
        img.frame = CGRect(x: 10, y: 145, width: 25, height: 25)

        return img
    }()
    
    //分割线
    lazy var tfConfirmPassLine : UIView = {
        let lin = UIView()
        lin.frame = CGRect(x: 0, y: 180, width: UIScreen.main.bounds.size.width, height: 0.5)
        lin.backgroundColor = UIColor.lightGray
        return lin
    }()
    

    
    //分割线
    lazy var nickNameLine : UIView = {
        let lin = UIView()
        lin.frame = CGRect(x: 0, y: 180 + 45, width: UIScreen.main.bounds.size.width, height: 0.5)
        lin.backgroundColor = UIColor.lightGray
        return lin
    }()
    
    
    //复选框
    lazy var seleBtn : UIButton = {
        let btn = UIButton()
        btn.frame = CGRect(x: 15, y: 187.5 + 45, width: 15, height: 15)
        btn.backgroundColor = UIColor.clear
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 2
        
        return btn
    }()
    
    //复选框图片
    lazy var seleBtnImg : UIImageView = {
        let btn = UIImageView()
        btn.frame = CGRect(x: 15, y: 187.5 + 45, width: 15, height: 15)
        btn.image = UIImage.init(named: "correct")
        return btn
    }()
    
    //注意事项文字前半段不加单机事件
    lazy var frontNotiLabel : UILabel = {
        let lab = UILabel()
        lab.frame = CGRect(x: 18 + 15, y: 187 + 45, width: 72, height: 15)
        lab.text = "我已阅读并同意"
        //        lab.layer.borderWidth = 1
        //        lab.sizeToFit()
        lab.font = UIFont.systemFont(ofSize: 10)
        return lab
    }()
    
    //注意事项文字后半段加单机事件
    lazy var backNotiLabel : UndelLineLabel = {
        let lab = UndelLineLabel()
        lab.text = "服务协议"
        lab.textColor = commonBtnColor
        lab.font = UIFont.systemFont(ofSize: 10)
        lab.isUserInteractionEnabled = true
        //单机手势，使其可以跳转页面
        let tapGes = UITapGestureRecognizer.init(target: self, action: #selector(RigisterView.clickLabelSEL))
        lab.addGestureRecognizer(tapGes)
        
        return lab
    }()

    
    
    //保存按钮
    lazy var saveBtn : UIButton = {
        let btn = UIButton()
        btn.backgroundColor = commonBtnColor
        btn.frame = CGRect(x: 7.5, y: 230 + 45, width: UIScreen.main.bounds.width - 15, height: 40)
        btn.backgroundColor = commonBtnColor
        btn.layer.cornerRadius = 8
        btn.setTitle("保存", for: .normal)
        btn.addTarget(self, action: #selector(RigisterView.confirmSEL), for: .touchUpInside)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        
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
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }

}


extension RigisterView {
    func setUI() -> Void {
        
        //复选框事件
        seleBtn.addTarget(self, action: #selector(RigisterView.autoAgreeSEL(sender:)), for: .touchUpInside)

        
        self.backgroundColor = UIColor.white
        
      backNotiLabel.frame = CGRect(x: frontNotiLabel.frame.size.width + 18 + 15, y: 187 + 45, width: 72, height: 15)
        
        //限定输入长度
        //手机号11位
        tfNum.setPass(setSecure: false, maxInput: 11)
        
        //验证码6位
        tfAuto.setPass(setSecure: false, maxInput: 6)
        
        //密码16位
        tfPass.setPass(setSecure: true, maxInput: 999)
        
        //确认密码
        tfConfirmPass.setPass(setSecure: true, maxInput: 999)
        
        //手机号
        tfNumImg.image = UIImage.init(named: "perInfo")
        
        //密码
        tfPassImg.image = UIImage.init(named: "password")
        
        //确认密码
        tfConPassImg.image = UIImage.init(named: "password")
        
        //昵称
        nickNameImg.image = UIImage.init(named: "perInfo")
        
        //验证码
        tfAutoImg.image = UIImage.init(named: "yzm")
        
        //背景视图
        bgView = UIView()
        bgView.frame = CGRect(x: 0, y: 255, width: SW, height: SH)
        bgView.backgroundColor = UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1)
        
        
        //延时执行第一响应
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            self.tfNum.becomeFirstResponder()
        }
        
        
        //设置键盘类型
        tfNum.keyboardType = .numberPad
        tfAuto.keyboardType = .numberPad
        
        addSubview(bgView)
        
        //手机号
        addSubview(tfNum)
        addSubview(tfNumImg)
        addSubview(line)
        
        //验证码
        addSubview(tfAuto)
        addSubview(tfAutoImg)
        addSubview(newPassLine)
        addSubview(yzmBtn)
        
        //密码
        addSubview(tfPass)
        addSubview(tfPassImg)
        addSubview(tfConfirmLine)
        
        //确认密码
        addSubview(tfConfirmPass)
        addSubview(tfConPassImg)
        addSubview(tfConfirmPassLine)
        

        //昵称
        addSubview(tfNickName)
        addSubview(nickNameImg)
        addSubview(nickNameLine)
        
        //同意协议
        addSubview(seleBtnImg)
        addSubview(seleBtn)
        addSubview(frontNotiLabel)
        addSubview(backNotiLabel)
        
        
        //保存按钮
        addSubview(saveBtn)
    }
}

extension RigisterView {
    //确定事件
    @objc func confirmSEL() -> Void {
        
        RigisterModel.shared.rigister(tfNum: tfNum, tfAuto: tfAuto, tfPass: tfPass, tfconfirmPass: tfConfirmPass, tfNickName: tfNickName) { (result) in
            CCog(message: result)
            
            if result {
                //更新主控制器
                let mainTabBarVC = MainViewController()
                UIApplication.shared.keyWindow?.rootViewController = mainTabBarVC
            }
        }
    }
    
    
    //验证码同意事件
    @objc func autoAgreeSEL(sender : UIButton) -> Void {

        sender.isSelected = !localSave.bool(forKey: agreeLaw)
        
        if sender.isSelected {
            self.seleBtnImg.isHidden = true
            localSave.set(sender.isSelected, forKey: agreeLaw)
        } else {
            self.seleBtnImg.isHidden = false
            localSave.set(sender.isSelected, forKey: agreeLaw)
        }
        localSave.synchronize()
    }
    
    //注册协议
    @objc func clickLabelSEL() -> Void {

        self.delegate?.rigWebView()
    }
}

extension RigisterView {
    @objc func whenSendBtnClicked(button: CountDownBtn) {
        self.endEditing(true)
        
        SendAutoModel.shared.sendForgetAuto(sendType: 1, tfNum: tfNum) {[weak self] (isSuccess) in
            
            guard let weakSelf = self else {return}
            if isSuccess {
                button.initwith(color: commonBtnColor, title: "发送验证码", superView: weakSelf)
            }
        }
    }
}

