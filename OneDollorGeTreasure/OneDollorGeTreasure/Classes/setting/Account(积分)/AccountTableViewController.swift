//
//  AccountTableViewController.swift
//  MD5
//
//  Created by 郑东喜 on 2016/11/24.
//  Copyright © 2016年 郑东喜. All rights reserved.
// 我的积分控制器

import UIKit

class AccountTableViewController: TableBaseViewController {
    
    static let shared = AccountTableViewController()
    
    //表格数据源
    lazy var dataArr : NSArray = {
        var data = NSArray()

        return data
    }()
    
    
    //导航栏设置还原
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //导航栏不隐藏
        self.navigationController?.navigationBar.isHidden = false
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
        
        //右手手势滑动关闭
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        //XFLog(message: dataArr)
        
        if ((localSave.object(forKey: jifenArray)) != nil) {
            self.dataArr = localSave.object(forKey: jifenArray) as! NSArray
            //XFLog(message: "执行了")
        } else {
            return
        }
        
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "我的积分"
        tableView.tableFooterView = UIView()
        
    }
}

// MARK:- 表格头
extension AccountTableViewController {

    //头视图
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return AccountHeaderVIew()
    }

    //表格头视图高度
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {

        return 145 + 16
    }

}


// MARK: - Table view data source
extension AccountTableViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataArr.count
    }
    //行高
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell(style: .default, reuseIdentifier: "cellID") as? AccountTableViewCell
        
        if cell == nil {
            cell = AccountTableViewCell(style: .default, reuseIdentifier: "cellID")
            cell?.selectionStyle = UITableViewCellSelectionStyle.none

            
            let dic = dataArr[indexPath.row] as! NSDictionary
            
            //设置cell的文字
            cell?.tfLeftUp.text = dic["reason"] as? String
            cell?.tfLeftDown.text = dic["time"] as? String
            cell?.tfRightCenter.text = dic["result"] as? String
            
            //判断颜色
            if NSString(string: (cell?.tfRightCenter.text!)!).contains("-") {
                cell?.tfRightCenter.textColor = UIColor.black
            } else {
                cell?.tfRightCenter.textColor = UIColor.red
            }
        }
        
        return cell!
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        [tableView deselectRowAtIndexPath:indexPath animated:YES];// 取消选中
//        tableView.deselectRow(at: indexPath, animated: true)
    }

}

