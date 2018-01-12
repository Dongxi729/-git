//
//  RigisterModel.swift
//  DollBuy
//
//  Created by 郑东喜 on 2016/11/22.
//  Copyright © 2016年 郑东喜. All rights reserved.
//  注册模型

import UIKit

class RigisterModel: NSObject {
    
    static let shared = RigisterModel()
    //新用户
    var isNew = "false"
    
    /**
     ## 注册
     封装了注册逻辑
     
     - tfNum            电话号码
     - tfAuto           验证码
     - tfPass           密码
     - tfconfirmPass    确认密码
     */
    func rigister(tfNum : UITextField,tfAuto : UITextField, tfPass : UITextField,tfconfirmPass : UITextField,tfNickName : UITextField,_com:@escaping (_ _data:Bool)->()) -> Void {
        
        let bool = localSave.bool(forKey: agreeLaw)
        
        if tfNum.text?.count == 0 {
            toast(alrtMSg: tfNumIsNull)
            return
        } else if Encryption.checkTelNumber(tfNum.text) == false {
            toast(alrtMSg: tfNumNotCor)
            return
        } else if tfAuto.text?.count == 0 {
            toast(alrtMSg: tfAutoNull)
            return
            
        } else if tfPass.text?.count == 0 {
            toast(alrtMSg: tfPassNull)
            return
            
        } else if tfconfirmPass.text?.count == 0 {
            toast(alrtMSg: confirPassNotNull)
            return
            
        } else if tfPass.text != tfconfirmPass.text {
            toast(alrtMSg: passTwoChekc)
            return
        } else if tfNickName.text?.count == 0 {
            toast(alrtMSg: nickNameNotNull)
            return
        } else if Encryption.checkTelNumber(tfNum.text) == true && bool == false {
            
            /**
             注册成功，恭喜您成为一元预购的新成员
             缺少验证码
             短信验证码错误
             手机号已被注册
             缺少手机号参数或手机格式错误或为11位数字
             */
            let params = ["deviceid":deviceID,
                          "devtype": deviceTpye,
                          "nickname" : tfNickName.text ?? "",
                          "phone":tfNum.text ?? "",
                          "password":tfPass.text?.md5() ?? "",
                          "code":tfAuto.text ?? ""] as [String : Any]
            
            NetwrokTool.requestWithPost(postwithParam: params, postWithUrl: rigisterUrl, finishedWithDic: { (dataSource) in
                if dataSource.count != 0 {
                    _com(true)
                    LoginModel.shared.loginStatus = "true"
                    RigisterModel.shared.isNew = "true"
                    
                    //存储账号、密码
                    localSave.set(tfNum.text, forKey: localName)
                    
                    localSave.set(tfPass.text, forKey: localPass)
                    
                    localSave.synchronize()
                    if let token = dataSource["token"] as? String {
                        
                        //存储用户动态标识ID
                        localSave.set(token, forKey: userToken)
                        localSave.synchronize()
                    }
                    
                    
                    //提取用户收获地址
                    if let addDic = dataSource["address"] as? NSDictionary {
                        localSave.set(addDic, forKey: "userAddress")
                        localSave.synchronize()
                    }
                    
                    
                    
                    //提取用户个人信息
                    if let  pData = dataSource["user"] as? NSDictionary {
                        localSave.set(pData, forKey: "userInfo")
                        localSave.synchronize()
                    }
                }
            })
        }
    }
}
