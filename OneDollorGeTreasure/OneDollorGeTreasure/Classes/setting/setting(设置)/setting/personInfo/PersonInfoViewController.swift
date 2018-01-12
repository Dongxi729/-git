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
        lab.frame = CGRect(x: 15, y: 15, width: 0, height: 30)
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
        lin.frame = CGRect(x: 0, y: 60 , width: UIScreen.main.bounds.size.width, height: 0.5)
        lin.backgroundColor = UIColor.lightGray
        return lin
    }()
    
    //头像按钮
    lazy var headImg : UIImageView = {
        let img = UIImageView()
        img.frame = CGRect(x: SW - 15 - 50, y: 5 , width: 50, height: 50)
        
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
        lab.frame = CGRect(x: 15, y: 75 , width: 80, height: 30)
        
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
//        lab.frame = CGRect(x:  SW - 15 * 2, y: 75 + 64, width: 180, height: 30)
//        
//        //文字左对齐
//        lab.textAlignment = NSTextAlignment.right
//        
//        //设置提示文字大小
//        lab.plStrSize(str: "请输入您的昵称", holderColor: UIColor.gray, textFontSize: 13)
//
//        lab.sizeToFit()
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
       
        
        //取消返回手势,防止用户不小心返回页面，输入的个人信息丢失
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        if PersonInfoModel.shared.personImg != nil {
            let headURL = PersonInfoModel.shared.personImg
            
            DispatchQueue.main.async {
                
                if headURL != nil {
                    if !(headURL?.contains(comStrURL))! {
                        self.headImg.image = #imageLiteral(resourceName: "nav_5")
                    } else {
                        CCog(message: comStrURL)
                        CCog(message: headURL ?? "")
                        self.headImg.downloadWithUrl(url: headURL!)
                    }
                }
            }
        }
        
        //单例获取值
        if PersonInfoModel.shared.nickName != nil {
            self.tfNickName.text = PersonInfoModel.shared.nickName
        } else {}
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
        
        tfNickName.frame = CGRect(x: nickName.RightX + 15, y: 75 , width: SW - nickName.Width - 45, height: 20)
        
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
        
        //从本地获取用户的个人信息
        guard let dic = (localSave.object(forKey: personInfo) as? NSDictionary) else {
            return
        }
        
        tfNickName.text = dic["nickname"] as? String
        
        //从本地加载服务器的头像地址
        let headImgURL = dic["img"] as! String
        
        //默认从本地加载图片
        if localSave.object(forKey: headImgCache) != nil {
            let imgData = localSave.object(forKey: headImgCache) as! Data

            headImg.image = UIImage.init(data: imgData as Data)
        } else {
            DispatchQueue.main.async {
                DownImgTool.shared.downImgWithURLShowToImg(urlStr: headImgURL, imgView: self.headImg)
            }
        }
    }
}

//单机监听事件
extension PersonInfoViewController {
    
    //验证码事件
    @objc fileprivate func seleImgSEL() -> Void {

        
        UploadHeadTool.shared.choosePic { (data, resultData) in

            self.headImg.image = UIImage.init(data: data)

            //上传好的头像地址
            let headUrl = (resultData["data"] as! NSDictionary)["img"] as! String
            
            //传给单例
            PersonInfoModel.shared.personImg = headUrl
            
            //传给单例--头像地址
            PersonInfoModel.shared.nickName = self.tfNickName.text
        }
    }
    
    //保存个人信息
    @objc fileprivate func saveInfo() {
        PersonInfoModel.shared.saveInfo(tfNickName: tfNickName) { (result) in

            //XFLog(message: "个人信息",file: result)
            
            if result == "成功" {
                
                PersonInfoModel.shared.nickName = self.tfNickName.text
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: {
                    
                    let allVC = self.navigationController?.viewControllers
                    
                    let inventoryListVC = allVC![allVC!.count - 2]
                    
                    if (inventoryListVC.isKind(of: SettingViewController.self)) {
                        self.navigationController!.popToViewController(inventoryListVC, animated: true)
                    } else {
                            self.navigationController!.popToRootViewController(animated: true)
                    }
                })
            }
        }
    }
}



extension UIImageView {
    func downloadWithUrl(url : String) {
        //创建URL对象
        let url = URL(string:url)!
        //创建请求对象
        let request = URLRequest(url: url)
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request, completionHandler: {
            (data, response, error) -> Void in
            if error != nil{
                print(error.debugDescription)
            } else {
                //将图片数据赋予UIImage
                let img = UIImage(data:data!)
                self.image = img
            }
        }) as URLSessionTask
        
        //使用resume方法启动任务
        dataTask.resume()
        
    }
}


