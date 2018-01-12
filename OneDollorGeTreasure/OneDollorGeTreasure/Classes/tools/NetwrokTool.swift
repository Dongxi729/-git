//
//  NetwrokTool.swift
//  Alili
//
//  Created by 郑东喜 on 2017/12/16.
//  Copyright © 2017年 郑东喜. All rights reserved.
//

import UIKit

class NetwrokTool: NSObject {
    /// 更新用户标识
    static var reloadPerson = false
    
    class func requestWithPost(postwithParam : [String : Any],postWithUrl : String,
                               finishedWithDic : @escaping (_ dic : NSDictionary) -> ()) {
        if postWithUrl == logoutURL {
            MBManager.showLoading()
        }
        
        postWithPath(path: postWithUrl, paras: postwithParam, success: { (response) in
            
            CCog(message: response)
            
            if postWithUrl == sendMsgUrl {
                finishedWithDic((response as? NSDictionary)!)
            }
            
            if let resultCode = (response as? NSDictionary)?.object(forKey: "resultcode") as? String,
            let resultMsg = (response as? NSDictionary)?.object(forKey: "resultmsg") as? String {
                /// 请求成功
                MBManager.hideAlert()
                if resultCode == "0" {
                    /// 特殊处理，退出的时候，修改密码,没返回data字段
                    if postWithUrl == logoutURL ||
                        postWithUrl == xgPass ||
                        postWithUrl == addressUrl ||
                        postWithUrl == bdURL ||
                        postWithUrl == forgetPassUrl {
                        finishedWithDic(NSDictionary.init())
                    }
                    
                    
                    /// 更新用户信息标识
                    if postWithUrl == loginUrl || postWithUrl == updpersoninfoURL || postWithUrl == couponURL {
                        reloadPerson  = true
                    }
                    
                    if let dataDic = (response as? NSDictionary)?.object(forKey: "data") as? NSDictionary {
                        finishedWithDic(dataDic)
                    }
                }
                
                /// 异地登陆
                if resultCode == "40107" {
                    NetwrokTool.loginUnknow()
                }
                
                if postWithUrl == updpersoninfoURL {
                    return
                }
                
                if postWithUrl != couponURL || postWithUrl != updpersoninfoURL {
                    MBManager.showBriefAlert(resultMsg)
                } 
            }
        }) { (error) in
            finishedWithDic(NSDictionary.init())
//            MBManager.hideAlert()
            CCog(message: error.localizedDescription)
            MBManager.showBriefAlert(netWrong)
        }
    }
    
    /// 异地登录
    class func loginUnknow() {
        MBManager.hideAlert()
//        //清楚单例中的值（暂时只清楚出问题的。。。）
//        LoginModel.shared.personData = nil
//
//        //删除本地token
//        localSave.removeObject(forKey: userToken)
//        localSave.removeObject(forKey: personInfo)
//        localSave.removeObject(forKey: personAddData)
//        localSave.removeObject(forKey: jifenArray)
//        MemModel.clearUserLocalDefaultData()
//        localSave.synchronize()
        
        //移除通知函数
        NotificationCenter.default.removeObserver(self)
        
        //清楚本地数据
        if let appDomain = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: appDomain)
        }
        _uName = "点击登陆"
        let nav = NaVC.init(rootViewController: LoginView())
       
        let alertVC = UIAlertController.init(title: "提示", message: "账号在异地登录，请重新登录", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction.init(title: "好的", style: .default, handler: { (action) in
            
            UIApplication.shared.keyWindow?.rootViewController = nav
            
        }))

        UIApplication.shared.keyWindow?.rootViewController?.present(alertVC, animated: true, completion: nil)
    }
}
