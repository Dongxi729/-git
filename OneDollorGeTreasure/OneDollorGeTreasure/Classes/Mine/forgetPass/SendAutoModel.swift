//
//  SendAutoModel.swift
//  DollBuy
//
//  Created by 郑东喜 on 2016/11/21.
//  Copyright © 2016年 郑东喜. All rights reserved.
//  发送验证码模型

import UIKit



class SendAutoModel: NSObject {
    static let shared = SendAutoModel()


    /**
     ## 发送忘记密码验证码
     封装发送验证码业务逻辑
     
     - tfNum    电话号码
     */
    func sendForgetAuto(sendType : Int,tfNum : UITextField,
                        _com:@escaping (_ isSendSuccess:Bool)->()) -> Void {
        
        //检查验证码是否为空
        if tfNum.text?.count == 0 {
            
            toast(alrtMSg: tfNumIsNull)
            return
        } else if Encryption.checkTelNumber(tfNum.text) == false {
            toast(alrtMSg: tfNumNotCor)
            return
            
        } else if Encryption.checkTelNumber(tfNum.text) == true {
            
            let params = ["type": sendType,
                          "phone":tfNum.text!] as [String : Any]
            
            NetwrokTool.requestWithPost(postwithParam: params, postWithUrl: sendMsgUrl, finishedWithDic: { (response) in
               CCog(message: response)
                if let resultMsg = (response as NSDictionary?)?.object(forKey: "resultmsg") as? String {
                    
                    toast(alrtMSg: resultMsg)
                }
                
                if let resultcode = (response as NSDictionary?)?.object(forKey: "resultcode") as? String {
                    CCog(message: resultcode)
                    if resultcode == "0" {
                        _com(true)
                    }
                }
            })
        }
    }
}
