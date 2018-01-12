//
//  BindPhoneModel.swift
//  DollBuy
//
//  Created by 郑东喜 on 2016/11/22.
//  Copyright © 2016年 郑东喜. All rights reserved.
//  绑定手机号模型

import UIKit

class BindPhoneModel: NSObject {
    static let shared = BindPhoneModel()
    
    //绑定手机
    var bindPhone = ""
    
    //外部闭包变量
    var comfun:((_ _data:String)->Void)?
    
    func BindPhoneSEL(tfAuto : UITextField,tfNum : UITextField,comfun:((_ _data:String)->Void)?) -> Void {
        

            self.comfun = comfun
        
            if localSave.object(forKey: userToken) as? String != nil {
            let uToken = localSave.object(forKey: userToken) as! String
            
            let param = ["token" : uToken,
                         "phone" : tfNum.text!,
                         "code" : tfAuto.text!] as [String : String]
            
            if tfNum.text?.characters.count == 0 {

                CustomAlertView.shared.alertWithTitle(strTitle: tfNumIsNull)
                return
                
            } else if Encryption.checkTelNumber(tfNum.text) == false {

                CustomAlertView.shared.alertWithTitle(strTitle: tfNumNotCor)
                return
            } else if tfAuto.text?.characters.count == 0 {

                CustomAlertView.shared.alertWithTitle(strTitle: tfAutoNull)
                return
            } else {
                postWithPath(path: bdURL, paras: param, success: { (response) in
                    //判读返回值是否为空
                    guard let dic = response as? NSDictionary else {
                        return
                    }
                    
                    //XFLog(message: dic)

                        //提取提示语
                        let alertmsg = dic["resultmsg"] as! String
                        //暴漏结果
                        comfun!(alertmsg)
                        
                        if alertmsg == "绑定成功" {
                            MBManager.showBriefAlert(bindSuccess)

                        } else if alertmsg == "不可绑定" {

                            MBManager.showBriefAlert("绑定失败")
                        } else if alertmsg == "短信验证码错误" {

                            MBManager.showBriefAlert(tfAuthWrong)
                        } else if alertmsg == "该手机号已存在" {

                            MBManager.showBriefAlert(phoneHaved)
                            
                        } else {
                            MBManager.showBriefAlert(unKnown)
                    }

                }, failure: { (error) in
                    self.comfun!(error.localizedDescription)
                })
                
            }
        } else {
            CustomAlertView.shared.alertWithTitle(strTitle: "已退出")

            self.comfun!("token不存在")

        }
    }
}
