//
//  PersonInfoViewController.swift
//  DollBuy
//
//  Created by 郑东喜 on 2016/11/23.
//  Copyright © 2016年 郑东喜. All rights reserved.
//  编辑个人资料

import UIKit

class PersonInfoViewController: BaseViewController {
    
    //cell的文字
    var headImgLabel: UILabel = {
        let lab = UILabel()
        lab.frame = CGRect(x: 15, y: 15 + 0, width: 0, height: 30)
        lab.text = "头像"
        lab.sizeToFit()
        lab.font = UIFont.boldSystemFont(ofSize: 14)
        //文字左对齐
        lab.textAlignment = NSTextAlignment.left
        
        return lab
    }()
    
    //分割线
    lazy var line : UIView = {
        let lin = UIView()
        lin.frame = CGRect(x: 0, y: 60 + 0, width: UIScreen.main.bounds.size.width, height: 0.5)
        lin.backgroundColor = UIColor.lightGray
        return lin
    }()
    
    //头像按钮
    lazy var headImg : UIImageView = {
        let img = UIImageView()
        img.frame = CGRect(x: SW - 15 - 50, y: 5 + 0, width: 50, height: 50)
        
        //裁剪图片
        img.layer.masksToBounds = true
        img.layer.cornerRadius = 25
        
        //允许交互
        img.isUserInteractionEnabled = true
        //添加手势
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(PersonInfoViewController.seleImgSEL))
        img.addGestureRecognizer(tapGes)
        return img
    }()
    
    
    //昵称
    lazy var nickName : UILabel = {
        let lab = UILabel()
        lab.frame = CGRect(x: 15, y: 75 + 0, width: 80, height: 30)
        
        lab.font = UIFont.boldSystemFont(ofSize: 14)
        //文字左对齐
        lab.textAlignment = NSTextAlignment.left
        lab.text = "昵称"
        lab.sizeToFit()
        return lab
        
    }()
    
    //昵称
    lazy var tfNickName : TfPlaceHolder = {
        let lab = TfPlaceHolder()
        return lab
        
    }()
    
    //背景视图
    lazy var bgView : UIView = {
        let view = UIView()
        
        view.frame = CGRect(x: 0, y: 0, width: SW, height: 70 + 44)
        view.backgroundColor = UIColor.white
        return view
    }()
    
    //导航栏设置还原&&加载单例种变化的值
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //继承基础类的代理
        //取消返回手势,防止用户不小心返回页面，输入的个人信息丢失
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "编辑个人资料"
        
        view.backgroundColor = UIColor.init(red: 229/255, green: 229/255, blue: 229/255, alpha: 1)
        
        self.navigationController?.navigationBar.backgroundColor = UIColor.white
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "保存", style: .plain, target: self, action: #selector(PersonInfoViewController.saveInfo))
        
        setUI()
    }
    
    //视图即将消失，退出编辑状态
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.view.endEditing(true)
        
        self.headImg.image = nil
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        self.headImg.image = nil
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}


extension PersonInfoViewController {
    func setUI() -> Void {
        
        tfNickName.frame = CGRect(x: nickName.RightX + 15, y: 75 + 0, width: SW - nickName.Width - 45, height: 20)
        
        //文字左对齐
        tfNickName.textAlignment = NSTextAlignment.right
        
        //设置提示文字大小
        tfNickName.plStrSize(str: "请输入您的昵称", holderColor: UIColor.gray, textFontSize: 13)
        
        //背景视图---白色
        view.addSubview(bgView)
        
        //头像文字
        view.addSubview(headImgLabel)
        
        
        //线条
        view.addSubview(line)
        
        view.addSubview(headImg)
        
        view.addSubview(nickName)
        
        view.addSubview(tfNickName)
        
        /// 赋值操作
        self.tfNickName.text = MemModel.shared().nickname
        
        self.headImg.downloadURL(down: MemModel.shared().img) {[weak self] (imgData) in
            guard let weakSelf = self else {return}
            DispatchQueue.main.async {
                weakSelf.headImg.image = UIImage.init(data: imgData)
            }
        }
    }
    
    //验证码事件
    @objc private func seleImgSEL() -> Void {
        CCog()
        UploadHeadTool.shared.choosePic { (data, resultData) in
            CCog(message: data.count)
            self.headImg.image = UIImage.init(data: data)
            
        }
    }
    
    //保存个人信息
    @objc fileprivate func saveInfo() {
        PersonInfoModel.shared.saveInfo(tfNickName: tfNickName.text ?? "") { (result) in
            
            if result {
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: {
                    let allVC = self.navigationController?.viewControllers
                    
                    let inventoryListVC = allVC![allVC!.count - 2]
                    
                    if (inventoryListVC.isKind(of: SettingViewController.self)) {
                        CCog()
                        self.navigationController!.popToViewController(inventoryListVC, animated: true)
                        /// 改变个人信息标识
                        MemModel.personInfoReloadMark = true
                        
                    } else {
                        CCog()
                        self.navigationController!.popToRootViewController(animated: true)
                    }
                })
            }
        }
    }
}

