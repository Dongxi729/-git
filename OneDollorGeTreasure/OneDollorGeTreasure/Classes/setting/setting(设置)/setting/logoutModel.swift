//
//  logoutModel.swift
//  DollBuy
//
//  Created by 郑东喜 on 2016/11/22.
//  Copyright © 2016年 郑东喜. All rights reserved.
//  退出模型

import UIKit

class logoutModel: NSObject {
    
    //外部闭包变量
    var comfun:((_ _data:String)->Void)?
    
    //实例化
    static let shared = logoutModel()
    
    /// 退出模型
    ///
    /// - Parameter comfun: 传值返回的值
    func logoutSEL(comfun:((_ _data:String)->Void)?) -> Void {
        self.comfun = comfun
        
        if localSave.object(forKey: userToken) as? String != nil {
            let uToken = localSave.object(forKey: userToken) as! String
            
            let param = ["token" : uToken] as [String : String]
            
            
            postWithPath(path: logoutURL, paras: param, success: { (response) in
                
                CCog(message: response)
                
                //判读返回值是否为空
                guard let dic = response as? NSDictionary else {
                    return
                }
                
                //提取提示语
                if  let resultCode = dic["resultcode"] as? String, let alertMsg = dic["resultmsg"] as? String {
                    if resultCode == "0" {
                        //删除本地token
                        localSave.removeObject(forKey: userToken)
                        localSave.removeObject(forKey: personInfo)
                        localSave.removeObject(forKey: personAddData)
                        localSave.removeObject(forKey: jifenArray)
                        localSave.synchronize()
                        
                        //清楚单例中的值（暂时只清楚出问题的。。。）
                        LoginModel.shared.personData = nil
                        
                        PersonInfoModel.shared.personImg = nil
                        PersonInfoModel.shared.personDicInfo = nil
                        PersonInfoModel.shared.nickName = nil
                        PersonInfoModel.shared.bindPhone = nil
                        
                        //清除URL保存的值
                        mainIndexArray.removeAllObjects()
                        fwqArray.removeAllObjects()
                        commuArray.removeAllObjects()
                        shoppingCarArray.removeAllObjects()
                        jiaoYIArray.removeAllObjects()
                        zhongjiangArray.removeAllObjects()
                        duihuanArray.removeAllObjects()
                        fenxiangArray.removeAllObjects()
                        separateArrey.removeAllObjects()
                        
                        //清楚本地数据
                        if let appDomain = Bundle.main.bundleIdentifier {
                            UserDefaults.standard.removePersistentDomain(forName: appDomain)
                        }
                        
                        _refresh = 0
                        //改变内存中用户名
                        _uName = "单机登陆"
                        
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: {
                            //暴漏结果
                            comfun!(alertMsg)
                        })
                    }
                    
                    if resultCode == "40107" {
                        comfun!("该账号已在异地登录，请重新登录")
                    }
                }
            }, failure: { (_) in
                
            })
        }
    }
    
    /// 同步信息登陆
    func logoutWithOutAlert() -> Void {
        
        if localSave.object(forKey: userToken) as? String != nil {
            let uToken = localSave.object(forKey: userToken) as! String
            
            let param = ["token" : uToken] as [String : String]
            
            postWithPath(path: logoutURL, paras: param, success: { (response) in
                //判读返回值是否为空
                guard let dic = response as? NSDictionary else {
                    return
                }
                
                //提取提示语
                let alertmsg = dic["resultmsg"] as! String
                
                if alertmsg  == "退出成功" {
                    
                    
                    CustomAlertView.shared.dissmiss()
                    
                    //删除本地token
                    localSave.removeObject(forKey: userToken)
                    localSave.removeObject(forKey: personInfo)
                    localSave.removeObject(forKey: personAddData)
                    localSave.removeObject(forKey: jifenArray)
                    localSave.synchronize()
                    
                    //清楚单例中的值（暂时只清楚出问题的。。。）
                    LoginModel.shared.personData = nil
                    
                    PersonInfoModel.shared.personImg = nil
                    PersonInfoModel.shared.personDicInfo = nil
                    PersonInfoModel.shared.nickName = nil
                    PersonInfoModel.shared.bindPhone = nil
                    
                    //清除URL保存的值
                    mainIndexArray.removeAllObjects()
                    fwqArray.removeAllObjects()
                    commuArray.removeAllObjects()
                    shoppingCarArray.removeAllObjects()
                    jiaoYIArray.removeAllObjects()
                    zhongjiangArray.removeAllObjects()
                    duihuanArray.removeAllObjects()
                    fenxiangArray.removeAllObjects()
                    separateArrey.removeAllObjects()
                    //清楚本地数据
                    if let appDomain = Bundle.main.bundleIdentifier {
                        UserDefaults.standard.removePersistentDomain(forName: appDomain)
                    }
                }
            }, failure: { (error) in
            })
        }
    }
}
