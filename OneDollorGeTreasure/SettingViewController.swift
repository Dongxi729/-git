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

class SettingViewController: TableBaseViewController,SettingCellDelegate {
    
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
        data = ["编辑个人资料","密码修改","我的收获地址","清除缓存"]
        
        return data
    }()
    
    //图片
    lazy var imgName : NSMutableArray = {
        var data = NSMutableArray()
        data = ["perInfo","password","address","cache"]
        
        return data
    }()
    
    //导航栏设置还原
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
        
        //禁用返回手势
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backBtn = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 80, height: 45))
        backBtn.addTarget(self, action: #selector(setBackSel), for: .touchUpInside)
        backBtn.setImage(#imageLiteral(resourceName: "back"), for: .normal)
        
        let backItem = UIBarButtonItem.init(customView: backBtn)
        
        //标题
        self.navigationItem.title = "设置"
        self.tableView = UITableView.init(frame: self.view.frame, style: .grouped)
        self.navigationItem.leftBarButtonItem =  backItem
    }
    
    @objc private func setBackSel() {
        if let nav = self.navigationController {
            nav.popViewController(animated: true)
        }
    }
    
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
    
    //文件夹缓存地址
    private lazy var cacheSaveStr = ""
    
    //设置数据源
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "cellID") as? SettingCell
        if cell == nil {
            cell = SettingCell(style: .default, reuseIdentifier: "cellID")
            tableView.separatorStyle = UITableViewCellSeparatorStyle.none
            //监听代理
            cell?.delegate = self
            
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
        } else {
            cell?.clearCaheLabel.isHidden = true
        }
        
        if indexPath.section == 0 && indexPath.row == 3 {
            cell?.disclosureImg.isHidden = true
            ///清除缓存文本
            cell?.clearCaheLabel.isHidden = false
            
            ///清除缓存
            DispatchQueue.main.async {
                
                //2.获取ios 本地文件library缓存大小
                var paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first! as NSString
                paths = paths.replacingOccurrences(of: "file:///", with: "/") as NSString
                
                self.cacheSaveStr = paths as String
                
                //1.本地文件大小统计
                let localFileSize = paths.fileSize()
                
                let localCacheNum = Float(localFileSize) / 1024 / 1024
                
                cell?.clearCaheLabel.text = NSString.localizedStringWithFormat("%.2fMB", localCacheNum) as String
            }
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
            if let nav = self.navigationController {
                nav.pushViewController(PersonInfoViewController(), animated: true)
            }
            break
            
        //密码修改
        case 1:
            if let nav = self.navigationController {
                nav.pushViewController(ChagePassViewController(), animated: true)
            }
            
            break
            
        //收货地址
        case 2:
            if let nav = self.navigationController {
                nav.pushViewController(GetGoodsVieController(), animated: true)
            }
            break
            
        //清除缓存
        case 3:
            
            //1。弹出警告框
            let alertVC = UIAlertController.init(title: "提示", message: "确定清除吗?", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction.init(title: "确定", style: .destructive, handler: { (_) in
                let cell = tableView.cellForRow(at: indexPath) as! SettingCell
                RemoveCookieTool.removeCookie()
                cell.clearCaheLabel.text = "0.0MB"
            }))
            
            alertVC.addAction(UIAlertAction.init(title: "取消", style: .destructive, handler: { (_) in
                
            }))
            
            self.present(alertVC, animated: true, completion: nil)
            
            break
        default:
            break
        }
    }

    func logoutSel() {
        let alert = UIAlertController.init(title: "提示", message: "您确定退出么?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction.init(title: "退出", style: .destructive, handler: { (nil) in
            CCog(message: "退出操作")
            MemModel.clearUserLocalDefaultData()
//            RemoveCookieTool.removeCookie()
           
            UIApplication.shared.keyWindow?.rootViewController = MainViewController()
        }))
        
        alert.addAction(UIAlertAction.init(title: "取消", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}


