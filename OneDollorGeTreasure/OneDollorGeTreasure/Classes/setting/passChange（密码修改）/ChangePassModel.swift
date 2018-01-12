//
//  ChangePassModel.swift
//  DollBuy
//
//  Created by 郑东喜 on 2016/11/22.
//  Copyright © 2016年 郑东喜. All rights reserved.
//  修改密码模型

import UIKit

class ChangePassModel: NSObject {
    
    //单例
    static let shared = ChangePassModel()
    
    /**
     ## 修改密码
     封装修改密码业务逻辑
     
     - tfOldPass    旧密码
     - tfNewPass    新密码
     */
    func changePassSEL(tfOldPass :UITextField,tfNewPass :UITextField,tfComPass : UITextField,comfun:@escaping (_ _data:Bool)->()) -> Void {
        
        if localSave.object(forKey: userToken) as? String != nil {
            let token = localSave.object(forKey: userToken) as! String
            
            //XFLog(message: token)
            if tfOldPass.text?.count == 0 {
                toast(alrtMSg: tfPassNull)
                return
            } else if tfNewPass.text?.count == 0 {
                toast(alrtMSg: passNewNil)
                return
            } else if tfComPass.text?.count == 0 {
                toast(alrtMSg: confirmPassNull)
                return
            } else if tfNewPass.text != tfComPass.text {
                toast(alrtMSg: passTwoChekc)
                return
            } else {
                let param = ["oldpwd": tfOldPass.text!.md5(),
                             "newpwd" : tfNewPass.text!.md5(),
                             "token" : token]
                NetwrokTool.requestWithPost(postwithParam: param, postWithUrl: xgPass, finishedWithDic: { (response) in
                    comfun(true)
                })
            }
        }
    }
}
