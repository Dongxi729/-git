//
//  LoginUpView.swift
//  DollBuy
//
//  Created by 郑东喜 on 2016/11/17.
//  Copyright © 2016年 郑东喜. All rights reserved.
//  登陆页面上班部分uiview自定义

import UIKit

//代理
protocol LoginUpViewDelegate {
    ///注册单机事件
    func rigSEL()
    
    ///注册忘记密码事件
    func forSEL()
    
    ///登陆事件
    func logSE()
    
    ///接收登陆成功返回值
    func logSuc()
}


class LoginUpView: UIView,UITextFieldDelegate {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //中间视图
        self.cView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //中间视图
    var centerView = UIView()
    
    //设置代理监听按钮事件
    var delegate : LoginUpViewDelegate?
    
    //当前全局变量
    var tfNum = UITextField()
    
    var tfPass = UITextField()
}

// MARK:- 中间视图
extension LoginUpView {
    
    
    func cView() -> Void {
        
        //中间视图宽度2
        let centerViewW = (SW - 30)
        
        centerView = UIView(frame: CGRect(x: 15, y: centerViewW * 0.25 , width: centerViewW, height: centerViewW * 0.60))
        //        centerView.backgroundColor = UIColor.white
        self.addSubview(centerView)
        
        //添加中间视图控件
        addControls()
    }
    
    //添加中间的控件
    func addControls() -> Void {
        
        
        //电话号码前置图片
        let personImg = UIImageView(frame: CGRect(x: 15, y: -5, width: 30, height: 30))
        //        personImg.backgroundColor = UIColor.black
        personImg.image = UIImage.init(named: "user")
        centerView.addSubview(personImg)
        
        
        //电话号码
        let tfNum = CustomTF.init(frame: CGRect(x: 50, y: 2 - 5, width: centerView.frame.size.width - 50, height: 30))
        

        tfNum.plStrSize(str: "请输入您的手机号", holderColor: UIColor.gray, textFontSize: 13)
        //限制输入长度
        tfNum.setPass(setSecure: false, maxInput: 11)
        
        //全局变量赋值
        self.tfNum = tfNum
        centerView.addSubview(tfNum)
        
        //分割线
        let separateLine = UIView(frame: CGRect(x: 10, y: tfNum.frame.size.height - 3, width: centerView.frame.size.width - 20, height: 1))
        
        //设置为灰色
        separateLine.backgroundColor = UIColor.lightGray
        centerView.addSubview(separateLine)
        
        
        //密码(账号的高度加上三倍的margin)
        let tfPass = TFFF.init(frame: CGRect(x: 50, y: 45, width: centerView.frame.size.width - 50, height: 30))
        
        tfPass.plStrSize(str: "请输入您的密码", holderColor: .gray, textFontSize: 13)
        tfPass.isSecureTextEntry = true
        
        //全局变量赋值
        self.tfPass = tfPass
        centerView.addSubview(tfPass)
        
        
        //忘记密码前置图片
        let passImg = UIImageView(frame: CGRect(x: 15, y: 30 + 13, width: 30, height: 30))
        
        passImg.image = UIImage.init(named: "pass")
        centerView.addSubview(passImg)
        
        //分割线(上面高度相加在加上分割线距离控件的间距)
        let separateLineTwo = UIView(frame: CGRect(x: 10, y: tfNum.frame.size.height + tfPass.frame.size.height + 15, width: centerView.frame.size.width - 20, height: 1))
        
        //设置为灰色
        separateLineTwo.backgroundColor = UIColor.lightGray
        centerView.addSubview(separateLineTwo)
        
        //登陆按钮
        let loginBtn = UIButton(frame: CGRect(x: 10, y: tfNum.frame.size.height + tfPass.frame.size.height + 40, width: centerView.frame.size.width - 20, height: 45))
        
        loginBtn.backgroundColor = commonBtnColor
        loginBtn.layer.cornerRadius = 10
        
        
        //添加登陆事件
        
        loginBtn.addTarget(self, action: #selector(LoginUpView.logSEL(sender:)), for: .touchUpInside)
        loginBtn.setTitle("登录", for: .normal)
        centerView.addSubview(loginBtn)
        
        //手机号注册

        let rW = loginBtn.BottomY + 5
        let rigiLabel = UILabel(frame: CGRect(x: loginBtn.LeftX, y: rW, width: SW / 3, height: 30))

        rigiLabel.text = "手机号注册"
        rigiLabel.font = UIFont.systemFont(ofSize: 13 * screenScale)
        rigiLabel.textColor = commonBtnColor
        centerView.addSubview(rigiLabel)
        
        //忘记密码
        let forLabel = UILabel(frame: CGRect(x: Int(centerView.frame.size.width - (SW / 3) - 10)
            , y: Int(rW), width: Int(SW / 3), height: 30))
        forLabel.font = UIFont.systemFont(ofSize: 13 * screenScale)

        
        forLabel.text = "忘记密码?"
        forLabel.textAlignment = NSTextAlignment.right
        centerView.addSubview(forLabel)
        
        
        
        //注册label添加手势
        //单机手势，使其可以跳转页面
        let riglabelTapGes = UITapGestureRecognizer.init(target: self, action: #selector(LoginUpView.rigisterClickLabel))
        
        //添加手势交互
        rigiLabel.isUserInteractionEnabled = true
        
        rigiLabel.addGestureRecognizer(riglabelTapGes)
        
        //忘记密码label添加手势
        //单机手势，使其可以跳转页面
        let forlabelTapGes = UITapGestureRecognizer.init(target: self, action: #selector(LoginUpView.forClickLabel))
        
        //添加手势交互
        forLabel.isUserInteractionEnabled = true
        
        forLabel.addGestureRecognizer(forlabelTapGes)
        
        
        //添加工具栏
        let toolBar = ToolBar()
        toolBar.seToolBarWithOne(confirmTitle: "完成", comfirmSEL: #selector(cancelBtn), target: self)
        
        tfNum.inputAccessoryView = toolBar
        tfPass.inputAccessoryView = toolBar
        
        //设置键盘类型
        tfNum.keyboardType = .numberPad
    }
    
    /// 工具类取消按钮
    @objc func cancelBtn() {
        // Put something here
        self.endEditing(true)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
    
}

// MARK:- label手势事件
extension LoginUpView {
    //注册label事件单机响应
    @objc func rigisterClickLabel() -> Void {
        delegate?.rigSEL()
        
    }
    
    //忘记密码label事件单机响应
    @objc func forClickLabel() -> Void {
        
        delegate?.forSEL()
    }
    
    @objc func logSEL(sender : UIButton) -> Void {
        
        sender.isUserInteractionEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            sender.isUserInteractionEnabled = true
        }
    
        self.endEditing(true)
        
        //模型传值
        LoginModel.shared.login(tfNum: self.tfNum, tfPass: self.tfPass) {[weak self] (loginStatus) in
            guard let weakSelf = self else {return}
            
            CCog(message: loginStatus)
            if loginStatus {
                weakSelf.delegate?.logSE()
                weakSelf.delegate?.logSuc()
            }
        }
    }
}

// MARK:- 底部label位置
extension LoginUpView {
    //底部label位置
    fileprivate func bottomLabel() -> Void {

        
        //对特殊机型尺寸进行适配
        //判断机型
        let deviceType = UIDevice.current.deviceType
        
        //适配4S,由于4s的屏幕比例比较特殊
        if deviceType == .iPhone4S {
            
            //左边的线
            let leftView = UIView(frame: CGRect(x: 15, y: SH * 0.6 , width: self.frame.size.width * 0.3 - 5, height: 1))
            leftView.backgroundColor = UIColor.lightGray
            self.addSubview(leftView)
            
            //右边的线d
            let rightView = UIView(frame: CGRect(x: self.frame.size.width * 0.625 + 15, y: SH * 0.6, width: self.frame.size.width * 0.3 - 5, height: 1))
            rightView.backgroundColor = UIColor.lightGray
            self.addSubview(rightView)
            
            let bottLabel = UILabel.init(frame: CGRect(x: 0.0, y: SH * 0.6 - 10, width: self.frame.size.width, height: 2 * 10))
            bottLabel.text = "使用第三方登陆"
            bottLabel.textColor = UIColor.lightGray
            bottLabel.textAlignment = NSTextAlignment.center
            bottLabel.font = UIFont.systemFont(ofSize: 13 * screenScale)
            
            self.addSubview(bottLabel)
        } else {
            
            //左边的线
            let leftView = UIView(frame: CGRect(x: 15, y: self.frame.size.height - 10 , width: self.frame.size.width * 0.3 - 5, height: 1))
            leftView.backgroundColor = UIColor.lightGray
            self.addSubview(leftView)
            
            //右边的线d
            let rightView = UIView(frame: CGRect(x: self.frame.size.width * 0.625 + 15, y: self.frame.size.height - 10, width: self.frame.size.width * 0.3 - 5, height: 1))
            rightView.backgroundColor = UIColor.lightGray
            self.addSubview(rightView)
            
            let bottLabel = UILabel.init(frame: CGRect(x: 0.0, y: self.frame.size.height - 20, width: self.frame.size.width, height: 2 * 10))
            bottLabel.text = "使用第三方登陆"
            bottLabel.textColor = UIColor.lightGray
            bottLabel.textAlignment = NSTextAlignment.center
            bottLabel.font = UIFont.systemFont(ofSize: 13 * screenScale)
            
            self.addSubview(bottLabel)
        }
        
    }
}



