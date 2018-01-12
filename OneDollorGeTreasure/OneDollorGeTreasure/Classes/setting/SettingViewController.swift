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
    
    var setIndexPath : IndexPath?
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    @objc func popVC() {
        navigationController?.popViewController(animated: true)
    }
    
    //导航栏设置还原
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        print(type(of: self),#line,AccountModel.shareAccount()?.img as! String)
        
        self.navigationController?.navigationBar.isHidden = false
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
        
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: #imageLiteral(resourceName: "back"), style: .plain, target: self, action: #selector(popVC))
        
        //禁用返回手势
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "bindSuccess"), object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //标题
        self.navigationItem.title = "设置"
        
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
    //设置数据源
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "cellID") as? SettingCell
        if cell == nil {
            cell = SettingCell(style: .default, reuseIdentifier: "cellID")
            tableView.separatorStyle = UITableViewCellSeparatorStyle.none
            //监听代理
            cell?.delegate = self
            self.setIndexPath = indexPath
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
            self.navigationController?.pushViewController(PersonInfoViewController(), animated: true)
            break
        //密码修改
        case 1:
            self.navigationController?.pushViewController(ChagePassViewController(), animated: true)
            break
        //收货地址
        case 2:
            self.navigationController?.pushViewController(GetGoodsVieController(), animated: true)
            break
        //清除缓存
        case 3:
            
            
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
            CCog()
//            AccountModel.logout()
//            AddressModel.logout()
        }))
        
        alert.addAction(UIAlertAction.init(title: "取消", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
