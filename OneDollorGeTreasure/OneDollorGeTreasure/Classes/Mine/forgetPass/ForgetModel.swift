//
//  ForgetModel.swift
//  DollBuy
//
//  Created by 郑东喜 on 2016/11/21.
//  Copyright © 2016年 郑东喜. All rights reserved.
//  忘记密码模型

import UIKit

class ForgetModel: NSObject {
    
    //单例初始化
    static let shared = ForgetModel()
}

extension ForgetModel {
    /**
     ## 忘记密码
     封装忘记密码业务逻辑
     
     - tfNum            电话号码
     - tfPass           密码
     - tfConfirmPass    确认密码
     */
    func forgetPass(tfNum : UITextField,tfAuto : UITextField,tfPass : UITextField,tfConfirmPass : UITextField,
                    _com:@escaping (_ _data:Bool)->()) -> Void {
        
        if tfNum.text?.count == 0 {
            toast(alrtMSg: tfNumIsNull)
            return
        } else if tfAuto.text?.count == 0 {
            toast(alrtMSg: tfAutoNull)
            return
            
        } else if tfPass.text?.count == 0 {
            toast(alrtMSg: tfPassNull)
            return
        } else if tfConfirmPass.text?.count == 0 {
            toast(alrtMSg: confirPassNotNull)
            return
        } else if Encryption.checkTelNumber(tfNum.text) == false {
            toast(alrtMSg: tfNumNotCor)
            return
        } else if tfPass.text != tfConfirmPass.text {
            toast(alrtMSg: passTwoChekc)
            return
        } else if Encryption.checkTelNumber(tfNum.text) == true {
            let params = ["code":tfAuto.text ?? "",
                          "newpwd":tfPass.text!.md5(),
                          "phone":tfNum.text ?? ""] as [String : Any]

            NetwrokTool.requestWithPost(postwithParam: params, postWithUrl: forgetPassUrl, finishedWithDic: { (response) in
                _com(true)
                CCog(message: response)
            })
        }
    }
}
