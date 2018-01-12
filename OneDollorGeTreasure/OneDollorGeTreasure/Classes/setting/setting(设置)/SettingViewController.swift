//
//  SettingViewController.swift
//  DollBuy
//
//  Created by 郑东喜 on 2016/11/17.
//  Copyright © 2016年 郑东喜. All rights reserved.
//  设置页面

import UIKit

protocol SettingViewControllerDelegate {
    func back()
}

class SettingViewController: TableBaseViewController,SettingCellDelegate,UIViewControllerPreviewingDelegate {
    
    var delegate : SettingViewControllerDelegate?
    
    // 用户手势点 对应需要突出显示的rect
    // 用户手势点 对应的indexPath
    var sourceRect : CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)
    var indexPath : NSIndexPath? = nil
    
    ///是否可用
    fileprivate var istouchAvaliable : Bool = false
    
    //表格数据源
    lazy var dataArr : NSMutableArray = {
        var data = NSMutableArray()
        data = ["编辑个人资料","密码修改","绑定手机号","我的收获地址","清除缓存"]
        
        return data
    }()
    
    //图片
    lazy var imgName : NSMutableArray = {
        var data = NSMutableArray()
        data = ["perInfo","password","phone","address","cache"]
        
        return data
    }()
    
    var setIndexPath : IndexPath?
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)    }
    
    //导航栏设置还原
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
        
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        
        //禁用返回手势
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        //先从单例中匹配，若不匹配从本地缓存的资料查找
        if BindPhoneModel.shared.bindPhone == "true" {
            dataArr = ["编辑个人资料","密码修改","绑定手机号","我的收获地址","清除缓存"]
        } else {
            
            //获取授权登陆信息
            guard let personData = localSave.object(forKey: thirdLoginInfo) as? NSDictionary else {
                return
            }
            
            guard let telNum = personData["password"] as? NSString else {
                return
            }
            
            //判断手机号是否为空，动态进行
            if telNum == "false" {
                dataArr = ["编辑个人资料","设置绑定密码","绑定手机号","我的收获地址","清除缓存"]
            } else {
                dataArr = ["编辑个人资料","密码修改","绑定手机号","我的收获地址","清除缓存"]
            }
        }
        
    }
    
    deinit {
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "bindSuccess"), object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //标题
        self.navigationItem.title = "设置"
        
        let assignLabel = UILabel.init(frame: CGRect(x: 0, y: SH - 30, width: SW - 30, height: 30))
        assignLabel.text = "Copyright© 2013-2016 锐掌Ie9e.com 版权所有"
        assignLabel.textAlignment = .center
        self.tableView.addSubview(assignLabel)
        
        //设置表格样式
        setStyle()
    }
    
}

// MARK:- 表格代理和方法
extension SettingViewController {
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0:
            return dataArr.count
        case 1:
            return 1
            
        default:
            return 1
        }
    }
    
    //设置section 间距
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 1
    }
    
    //出现动画
    //    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    //
    //        cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1)
    //
    //        UIView.animate(withDuration: 0.5) {
    //            cell.transform = CGAffineTransform.identity
    //        }
    //    }
    
    //设置数据源
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "cellID") as? SettingCell
        if cell == nil {
            cell = SettingCell(style: .default, reuseIdentifier: "cellID")
            tableView.separatorStyle = UITableViewCellSeparatorStyle.none
            //监听代理
            cell?.delegate = self
            
            self.setIndexPath = indexPath

            ///注册预览视图代理
            if #available(iOS 9.0, *) {
                ///根据是否可用进行注册
                if self.traitCollection.forceTouchCapability == .available {
                    registerForPreviewing(with: self, sourceView: cell!)
                } else {
                    
                }
                
            } else {
                // Fallback on earlier versions
            }
            
            cell?.imgView.image = UIImage.init(named: imgName[indexPath.row] as! String)
        }
        
        switch indexPath.section {
        //第一组时，显示
        case 0:
            cell?.btn.isHidden = true
            cell?.nameLabel.text = dataArr[indexPath.row] as? String
            cell?.versonLabel.isHidden = true
            
        //            //第二组时，不显示
        case 2:
            cell?.versonLabel.isHidden = false
            cell?.backgroundColor = UIColor.clear
            cell?.disclosureImg.isHidden = true
            cell?.line.isHidden = true
            cell?.btn.isHidden = true
            cell?.imgView.isHidden = true
        default:
            cell?.backgroundColor = UIColor.clear
            cell?.line.isHidden = true
            cell?.imgView.isHidden = true
            cell?.nameLabel.isHidden = true
            cell?.disclosureImg.isHidden = true
            cell?.versonLabel.isHidden = true
            break
        }
        
        if indexPath.section == 0 && indexPath.row == 4 {
            cell?.clearCaheLabel.isHidden = false
            cell?.disclosureImg.isHidden = true
            cell?.indicator.isHidden = false
            cell?.indicator.startAnimating()
        } else {
            cell?.clearCaheLabel.isHidden = true
            cell?.indicator.isHidden = true
        }
        
        return (cell)!
        
    }
    
    //设置行高
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView.init()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        //编辑个人资料
        case 0:
            self.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(PersonInfoViewController(), animated: true)
            
            break
            
        //密码修改
        case 1:
            
            //先判断单例是否为空
            if PersonInfoModel.shared.bindPhone != "" {
                
                //判断单例是否存储对应的值
                if PersonInfoModel.shared.bindPhone == "true" {
                    self.hidesBottomBarWhenPushed = true
                    
                    self.navigationController?.pushViewController(ChagePassViewController(), animated: true)
                    
                    return
                }
            }
            
            
            if localSave.object(forKey: "bindPhone") != nil {
                self.hidesBottomBarWhenPushed = true
                
                self.navigationController?.pushViewController(SetThirdPassVC(), animated: true)
                return
            }
            
            
            guard let personData = localSave.object(forKey: thirdLoginInfo) as? NSDictionary else {
                //没有第三方登陆资料进入默认设置密码页面
                self.hidesBottomBarWhenPushed = true
                
                self.navigationController?.pushViewController(ChagePassViewController(), animated: true)
                
                return
            }
            
            //取出密码
            guard let passs = personData["password"] as? NSString else {
                
                return
            }
            
            //取出号码
            guard let phone = personData["phone"] as? String else {
                return
            }
            
            
            if phone == "" || phone.characters.count == 0 {
                CustomAlertView.shared.alertWithTitle(strTitle: "请先绑定手机号")
            }
            
            //判断手机号是否为空
            if passs == "false" {
                self.hidesBottomBarWhenPushed = true
                
                self.navigationController?.pushViewController(SetThirdPassVC(), animated: true)
            } else {
                self.hidesBottomBarWhenPushed = true
                
                self.navigationController?.pushViewController(ChagePassViewController(), animated: true)
                
            }
            break
        //绑定手机号
        case 2:
            
            //检测单例中是否有值，已绑定手机号码，若单例没有，从本地取判断
            //1.PersonInfoModel.shared.bindPhone = list["password"] as? String（值为false）,可以单击跳转到绑定手机号码界面,若已绑定，提示已绑定
            
            if PersonInfoModel.shared.bindPhone == "true" {
                
                if localSave.object(forKey: "bindPhone") != nil {
                    var bindPhone = localSave.object(forKey: "bindPhone") as! NSString
                    //替换指定字符为****
                    let range = NSMakeRange(4, 4)
                    
                    bindPhone = bindPhone.replacingCharacters(in: range, with: "****") as NSString
                    
                    let alertView = ZDXAlertController.init(title: "提示", message: "已绑定手机号:\(bindPhone)", preferredStyle: .alert)
                    alertView.addAction(UIAlertAction.init(title: "确定", style: .default, handler: nil))
                    
                    self.present(alertView, animated: true, completion: nil)
                }
                
            }
            
            
            guard let personData = localSave.object(forKey: thirdLoginInfo) as? NSDictionary else {
                
                guard let personData = localSave.object(forKey: personInfo) as? NSDictionary else {
                    return
                }
                
                guard var telNum = personData["phone"] as? NSString else {
                    
                    return
                }
                
                //判断手机号是否为空
                if telNum == "" {
                    self.hidesBottomBarWhenPushed = true
                    
                    self.navigationController?.pushViewController(BindPhoneNumViewController(), animated: true)
                    
                } else {
                    //替换指定字符为****
                    let range = NSMakeRange(4, 4)
                    
                    telNum = telNum.replacingCharacters(in: range, with: "****") as NSString
                    
                    let alertView = ZDXAlertController.init(title: "提示", message: "已绑定手机号:\(telNum)", preferredStyle: .alert)
                    alertView.addAction(UIAlertAction.init(title: "确定", style: .default, handler: nil))
                    
                    self.present(alertView, animated: true, completion: nil)
                }
                
                return
            }
            
            guard var telNum = personData["phone"] as? NSString else {
                
                return
            }
            
            //判断手机号是否为空
            if telNum == "" {
                self.hidesBottomBarWhenPushed = true
                
                self.navigationController?.pushViewController(BindPhoneNumViewController(), animated: true)
                
            } else {
                //替换指定字符为****
                let range = NSMakeRange(4, 4)
                
                telNum = telNum.replacingCharacters(in: range, with: "****") as NSString
                
                let alertView = ZDXAlertController.init(title: "提示", message: "已绑定手机号:\(telNum)", preferredStyle: .alert)
                alertView.addAction(UIAlertAction.init(title: "确定", style: .default, handler: nil))
                
                self.present(alertView, animated: true, completion: nil)
            }
            
            break
            
        //收货地址
        case 3:
            self.hidesBottomBarWhenPushed = true
            
            self.navigationController?.pushViewController(DetailAddressVC(), animated: true)
            break
            
        //清除缓存
        case 4:
            
            //1。弹出警告框
            let alertVC = ZDXAlertController.init(title: "提示", message: "确定清除吗?", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction.init(title: "确定", style: .destructive, handler: { (_) in
                SDImageCache.shared().clearDisk(onCompletion: {
                    
                    self.tableView.reloadData()
                    
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "clearDone"), object: self, userInfo: ["value" : "yes"])
                })
            }))
            
            alertVC.addAction(UIAlertAction.init(title: "取消", style: .destructive, handler: { (_) in
                
            }))
            
            self.present(alertVC, animated: true, completion: nil)
            
            break
        default:
            break
        }
    }
    
}



// MARK:- 设置表格样式
extension SettingViewController {
    @objc fileprivate func setStyle() -> Void {
        tableView = UITableView(frame: CGRect.init(x: 0, y: 64, width: SW, height: SH - 64 - 30), style: .grouped)
    }
}


// MARK:- 监听代理函数
extension SettingViewController {
    
    
    func logoutSel() {
        let alert = ZDXAlertController.init(title: "提示", message: "您确定退出么?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction.init(title: "退出", style: .destructive, handler: { (nil) in
            
            logoutModel.shared.logoutSEL { (result) in
                
                //XFLog(message: result)
                if result == "退出成功" {
                    
                    //删除本地token
                    localSave.removeObject(forKey: userToken)
                    localSave.synchronize()
                    
                    //清楚本地数据
                    if let appDomain = Bundle.main.bundleIdentifier {
                        UserDefaults.standard.removePersistentDomain(forName: appDomain)
                    }
                    
                    DispatchQueue.main.async {
                        let mainVC = MainViewController()
    
                        mainVC.mvc = MyVC()
    
                        UIApplication.shared.keyWindow?.rootViewController = mainVC
                        
                        Animated.vcWithTransiton(vc: mainVC, animatedType: "kCATransitionFade", timeduration: 1.0)
                    }
                    
                } else if result == "该账号已在异地登录，请重新登录" {
                    
                }
                
            }
            
        }))
        
        alert.addAction(UIAlertAction.init(title: "取消", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}


// MARK:- 3d touch
extension SettingViewController {
    
    ///获取用户手势点所在cell的下标。同时判断手势点是否超出tableView响应范围。
    func getShouldShowRectAndIndexPathWithLocation(location : CGPoint) -> Bool {
        let row : NSInteger = Int(location.y - 20) / 50
        self.sourceRect = CGRect(x: 0, y: row * 50 + 20, width: Int(SW), height: 50)
        self.indexPath = NSIndexPath.init(item: row, section: 0)
        
        // 如果row越界了，返回NO 不处理peek手势
        return row >= self.dataArr.count ? false : true
    }
    
    ///提交视图
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        
        self.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(viewControllerToCommit, animated: true)
        
    }
    
    ///预览视图
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        
        if self.istouchAvaliable == true {
            
            // 获取用户手势点所在cell的下标。同时判断手势点是否超出tableView响应范围。
            if !self.getShouldShowRectAndIndexPathWithLocation(location: location) {
                return nil
            }
            
            if #available(iOS 9.0, *) {
                guard let cell = previewingContext.sourceView as? SettingCell else {
                    return nil
                }
                
                switch cell.nameLabel.text ?? ""
                {
                case "编辑个人资料":
                    let touchVC = PersonInfoViewController()
                    
                    touchVC.preferredContentSize = CGSize.init(width: 0, height: SH - 64 * 2 - 50)
                    return touchVC
                case "我的收获地址":
                    let drawTouchVC = DetailAddressVC()
                    drawTouchVC.preferredContentSize = CGSize.init(width: 0, height: SH - 64 * 2 - 50)
                    return drawTouchVC
                    
                default:
                    return nil
                }
                
                
            } else {
                // Fallback on earlier versions
            }
            
            
        } else {
            //弹出提示框
            let sheet = ZDXAlertController(title: nil, message: "请在设置中打开3d touch", preferredStyle: .alert)
            
            let tempAction = UIAlertAction(title: "确定", style: .cancel) { (action) in
                
                let url = NSURL.init(string: UIApplicationOpenSettingsURLString)
                
                if UIApplication.shared.openURL(url! as URL) {
                    UIApplication.shared.openURL(url! as URL)
                }
                
            }
            sheet.addAction(tempAction)
            self.present(sheet, animated: true, completion: nil)
            
            return nil
        }
        return nil
    }
    
    ///检测屏幕是否触发
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        
        ///检查3d touch是否可用
        if #available(iOS 9.0, *) {
            if self.traitCollection.forceTouchCapability == .available {
                //XFLog(message: "检测到")
                self.istouchAvaliable = true
            } else if self.traitCollection.forceTouchCapability == .unavailable {
                //XFLog(message: "未检测到")
                self.istouchAvaliable = false
            } else {
                //XFLog(message: "未检测")
                self.istouchAvaliable = false
            }
        } else {
            // Fallback on earlier versions
        }
        
    }
    
}


