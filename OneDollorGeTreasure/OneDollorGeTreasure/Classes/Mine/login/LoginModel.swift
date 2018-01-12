//
//  LoginModel.swift
//  DollBuy
//
//  Created by 郑东喜 on 2016/11/21.
//  Copyright © 2016年 郑东喜. All rights reserved.
//  登陆模型

import UIKit


class LoginModel: NSObject {
    
    static let shared = LoginModel()
    
    //将登陆状态传给闭包
    
    //外部闭包变量
    var comfun:((_ _data:String)->Void)?
    
    //单例个人信息
    var personData : NSDictionary?
    
    //登陆状态
    var loginStatus : String?
    
    /**
     ## 登陆
     主要实现了登陆封装逻辑
     
     - tfNum    电话号码
     - tfPass   密码
     */
    func login(tfNum : UITextField,tfPass : UITextField,
               _com:@escaping (_ _data:Bool)->()) -> Void {
        
        if tfNum.text?.count == 0 {
            toast(alrtMSg: tfNumIsNull)
            return
            
        } else if Encryption.checkTelNumber(tfNum.text) == false {
            toast(alrtMSg: tfNumNotCor)
            return
        } else if tfPass.text?.count == 0 {
            toast(alrtMSg: tfPassNull)
            return
        } else if Encryption.checkTelNumber(tfNum.text) == true {
            
            //请求参数
            let params = ["phone" : tfNum.text!,
                          "password" : tfPass.text!.md5(),
                          "deviceid": deviceID,
                          "devtype" : deviceTpye] as [String : Any]
        
          
            loginFunc(loginInfo: params, dataReturn: { (isReturnData) in
                _com(isReturnData)
            })
        }
    }
    
    /// 登录方法
    @objc private func loginFunc(loginInfo : [String : Any],
                                 dataReturn : @escaping (_ xx : Bool)->()) {
        CCog(message: loginInfo)
        NetwrokTool.requestWithPost(postwithParam: loginInfo, postWithUrl: loginUrl, finishedWithDic: { (dataSource) in
            CCog(message: dataSource.count)
            
            if dataSource.count > 0 {
                if let token = dataSource["token"] as? String {
                    CCog(message: token)
                    //存储用户动态标识ID
                    localSave.set(token, forKey: userToken)
                    localSave.synchronize()
                }
                
                //提取用户收获地址
                if let addDic = dataSource["address"] as? [String : Any] {
                    localSave.set(addDic, forKey: "userAddress")
                    localSave.synchronize()
                }
                
                //提取用户个人信息
                if let pData = dataSource["user"] as? [String : Any] {
                    localSave.set(pData, forKey: "userInfo")
                    localSave.synchronize()
                }
                
                if localSave.object(forKey: userToken) != nil &&
                    localSave.object(forKey: "userInfo") != nil &&
                    localSave.object(forKey: "userAddress") != nil {
                    dataReturn(true)
                }
            }
        })
    }
}
