//
//  BindPhoneSecrectModel.swift
//  DollBuy
//
//  Created by 郑东喜 on 2016/11/28.
//  Copyright © 2016年 郑东喜. All rights reserved.
//  绑定第三方授权账号密码模型

import UIKit

class BindPhoneSecrectModel: NSObject {

    static let shared = BindPhoneSecrectModel()
    
    //外部闭包变量
    var comfun:((_ _data:String)->Void)?
    
    func bindSecrect(passStr : String,comfun:((_ _data:String)->Void)?) -> Void {
        //本地取token
        guard let token = localSave.object(forKey: userToken) as? String else {
            return
        }
        
        let params = ["token" : token,
                      "pwd" : passStr.md5()]
        
        if passStr.characters.count == 0 {
            CustomAlertView.shared.alertWithTitle(strTitle: tfPassNull)

        } else {
            postWithPath(path: setacctURL, paras: params, success: { (response) in
                self.comfun = comfun
                
                guard let dic = response as? NSDictionary else {
                    return
                }
                
                //XFLog(message: dic)
                

                //提取提示语
                guard let alertmsg = dic["resultmsg"] as? String else {
                    return
                }
                
                //提取提示语
                guard (dic["resultcode"] as? String) != nil else {
                    return
                }


                    //接收返回的值
                    self.comfun!(alertmsg)

                    if alertmsg == "成功" {

                    } else if alertmsg == "缺少密码参数" {
                        MBManager.showBriefAlert(tfPassNull)
                        
                    } else if alertmsg == "密码设置成功" {
                        MBManager.showBriefAlert("密码设置成功")
                    
                    } else if alertmsg == "不可设置密码" {
                        MBManager.showBriefAlert("不可设置密码")
                    
                    } else {
                        MBManager.showBriefAlert(unKnown)
                    
                }

                self.comfun!(alertmsg)
            }) { (error) in
                self.comfun!(error.localizedDescription)
               
            }

        }
        
        
    }
}
