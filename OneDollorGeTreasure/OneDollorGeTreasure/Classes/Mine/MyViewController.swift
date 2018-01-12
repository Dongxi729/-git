//
//  MyViewController.swift
//  Alili
//
//  Created by 郑东喜 on 2017/1/13.
//  Copyright © 2017年 郑东喜. All rights reserved.
//

import UIKit

class MyViewController: TableBaseViewController {
    
    var myVCTBSource: [String] = [String]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    var myVCTBImg: [String] = [String]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    /// 已登录显示的界面
    @objc private func unloginAlert() {
        let vc = ZDXAlertController.init(title: "提示", message: "请登录", preferredStyle: .alert)
        vc.addAction(UIAlertAction.init(title: "好的", style: .default, handler: { (action) in
            MemModel.clearUserLocalDefaultData()
            let loginvc = LoginView()
            if let nav = self.navigationController {
                nav.pushViewController(loginvc, animated: true)
            }
        }))
        
        vc.addAction(UIAlertAction.init(title: "取消", style: .cancel, handler: { (action) in
            self.tabBarController?.selectedIndex = 0
        }))
        
        present(vc, animated: true, completion: nil)
    }
    
    lazy var refreshContr: UIRefreshControl = {
        let d : UIRefreshControl = UIRefreshControl.init(frame: self.view.bounds)
        d.addTarget(self, action: #selector(reloadInfoSel(sender:)), for: .valueChanged)
        return d
    }()
    
    /// 刷新个人信息
    @objc private func reloadInfoSel(sender : UIRefreshControl) {
        PersonInfoModel.shared.saveInfo(tfNickName: MemModel.shared().nickname, comfun: {[weak self] (model) in
            guard let weakSelf = self else {return}
            if model {
                weakSelf.tableView.reloadData()
                sender.endRefreshing()
            } else {
                sender.endRefreshing()
            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.tableView = UITableView.init(frame: self.view.bounds, style: .grouped)
        self.tableView.register(MyVCHeaderCell2.self, forCellReuseIdentifier: "cell")
        self.tableView.register(MyVCHeaderCell.self, forCellReuseIdentifier: "MyVCHeaderCell")
        //        self.tableView.isScrollEnabled = false
        if #available(iOS 11, *) {
            tableView.contentInsetAdjustmentBehavior = .never
            self.tableView.contentInset = UIEdgeInsets.zero
            
            tableView.estimatedRowHeight = 0
            tableView.estimatedSectionFooterHeight = 0
            tableView.estimatedSectionHeaderHeight = 0
        } else {
            self.tableView.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0)
        }
        
        self.tableView.addSubview(refreshContr)
        
        self.myVCTBSource = ["交易明细","兑换纪录","中奖记录","设置"]
        self.myVCTBImg = ["buyDetail","address","help","mine-setting-iconN"]
        
        
    }
    
    
    
    /// 刷新个人信息
    @objc private func reloadPersonInfoSel() {
        CCog()
        PersonInfoModel.shared.saveInfo(tfNickName: MemModel.shared().nickname, comfun: {[weak self] (model) in
            guard let weakSelf = self else {return}

            if model {
                weakSelf.tableView.reloadData()
            }
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        NetwrokTool.reloadPerson = false
        
        /// 移除通知
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        UIApplication.shared.statusBarStyle = .lightContent
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        /// 监听个人信息更新通知消息
        NotificationCenter.default.addObserver(self, selector: #selector(reloadPersonInfoSel), name: NSNotification.Name(rawValue: "reloadPersonInfo"), object: nil)
        
        /// 检查是否登录
        if let _ = localSave.object(forKey: userToken) as? String {
            
            if MemModel.personInfoReloadMark {
                CCog(message: "个人信息更新")
                PersonInfoModel.shared.saveInfo(tfNickName: MemModel.shared().nickname, comfun: {[weak self] (model) in
                    guard let weakSelf = self else {return}
                    
                    if model {
                        weakSelf.tableView.reloadData()
                    }
                })
                
                MemModel.personInfoReloadMark = false
            }
            
        } else {
            unloginAlert()
        }
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return myVCTBSource.count
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0.001
        } else {
            return 0.01
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            if SH == 812 {
                return 180 + 44
            } else {
                return 180
            }
        } else {
            return 45
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 && indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyVCHeaderCell") as! MyVCHeaderCell
            /// 赋值操作
            cell.myVCHeaderV.jifenSmallV.jifenLabel.text = MemModel.shared().integral
            cell.myVCHeaderV.nickName.text = MemModel.shared().nickname
            cell.myVCHeaderV.headImg.downloadURL(down: MemModel.shared().img) {[weak self] (imgData) in
                
                DispatchQueue.main.async {
                    cell.myVCHeaderV.headImg.image = UIImage.init(data: imgData)
                }
            }
            
            return cell
        }
        
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! MyVCHeaderCell2
            cell.myHeaderCell2Img.image = UIImage.init(named: self.myVCTBImg[indexPath.row])
            cell.myHeaderCellTitle.text = self.myVCTBSource[indexPath.row]
            return cell
        }
        
        return UITableViewCell.init()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section != 0 {
            switch self.myVCTBSource[indexPath.row] {
                
            /// ChangedRecordVC
            case "交易明细":
                self.navigationController?.pushViewController(JiaoYIVC(), animated: true)
                break
            case "兑换纪录":
                self.navigationController?.pushViewController(ChangedRecordVC(), animated: true)
                break
            case "收货地址":
                self.navigationController?.pushViewController(GetGoodsVieController(), animated: true)
                break
            case "中奖记录":
                self.navigationController?.pushViewController(AwardVC(), animated: true)
                break
            case "设置":
                self.navigationController?.pushViewController(SettingViewController(), animated: true)
                break
            default:
                return
            }
        }
    }
}

class MyVCHeaderCell: UITableViewCell {
    lazy var myVCHeaderV: MyViewheaderView = {
        let d : MyViewheaderView = MyViewheaderView()
        if SH == 812 {
            d.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 180 + 44)
        } else {
            d.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 180)
        }
        
        return d
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        self.selectedBackgroundView = UIView.init()
        contentView.addSubview(myVCHeaderV)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class MyVCHeaderCell2: UITableViewCell {
    
    lazy var myHeaderCell2Img: UIImageView = {
        let d : UIImageView = UIImageView.init(frame: CGRect.init(x: 12, y: 10, width: 25, height: 25))
        d.contentMode = .scaleAspectFit
        return d
    }()
    
    lazy var myHeaderCellTitle: UILabel = {
        let d: UILabel = UILabel.init(frame: CGRect.init(x: self.myHeaderCell2Img.RightX + 12, y: 10, width: SW / 2 , height: 25))
        d.font = UIFont.systemFont(ofSize: 13)
        return d
    }()
    
    lazy var myHeaderCellDisImg: UIImageView = {
        let d : UIImageView = UIImageView.init(frame: CGRect.init(x: SW - 15 - 10, y: 15, width: 15, height: 15))
        d.image = UIImage.init(named: "closuerimg")
        d.contentMode = .scaleAspectFit
        return d
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(myHeaderCell2Img)
        contentView.addSubview(myHeaderCellTitle)
        contentView.addSubview(myHeaderCellDisImg)
        selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

