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
    func logoutSEL(comfun:@escaping (_ _data:Bool)->()) -> Void {
        
        if localSave.object(forKey: userToken) as? String != nil {
            let uToken = localSave.object(forKey: userToken) as! String
            
            let param = ["token" : uToken] as [String : String]
            

            logouFunc(param: param, logouSuccess: { (xxxx) in
                comfun(true)
            })
        }
    }
    
    @objc private func logouFunc(param: [String : Any],logouSuccess : @escaping (_ xxx : Bool)->()) {
        NetwrokTool.requestWithPost(postwithParam: param, postWithUrl: logoutURL, finishedWithDic: { (resultDic) in
            
            CCog(message: resultDic.count)
//            comfun(true)
            logouSuccess(true)
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
            //清楚本地数据
//            if let appDomain = Bundle.main.bundleIdentifier {
//                UserDefaults.standard.removePersistentDomain(forName: appDomain)
//            }
            
            _refresh = 0
            //改变内存中用户名
            _uName = "单机登陆"
        })
    }
    
    /// 同步信息登陆
    func logoutWithOutAlert() -> Void {
        
        if localSave.object(forKey: userToken) as? String != nil {
            let uToken = localSave.object(forKey: userToken) as! String
            
            let param = ["token" : uToken] as [String : String]
            
            logouFunc(param: param, logouSuccess: { (_) in })
        }
    }
}
