//
//  ChangePassModel.swift
//  DollBuy
//
//  Created by 郑东喜 on 2016/11/22.
//  Copyright © 2016年 郑东喜. All rights reserved.
//  修改密码模型

import UIKit

class ChangePassModel: NSObject {
    
    //外部闭包变量
    var comfun:((_ _data:String)->Void)?
    
    //单例
    static let shared = ChangePassModel()
    
    /**
     ## 修改密码
     封装修改密码业务逻辑
     
     - tfOldPass    旧密码
     - tfNewPass    新密码
     */
    func changePassSEL(tfOldPass :UITextField,tfNewPass :UITextField,tfComPass : UITextField,comfun:((_ _data:String)->Void)?) -> Void {
        self.comfun = comfun
        
        if localSave.object(forKey: userToken) as? String != nil {
            let token = localSave.object(forKey: userToken) as! String

            //XFLog(message: token)
            if tfOldPass.text?.characters.count == 0 {
                CustomAlertView.shared.alertWithTitle(strTitle: tfPassNull)
                
            } else if tfNewPass.text?.characters.count == 0 {

                CustomAlertView.shared.alertWithTitle(strTitle: passNewNil)
                
            } else if tfComPass.text?.characters.count == 0 {
                CustomAlertView.shared.alertWithTitle(strTitle: confirmPassNull)
            
            } else if tfNewPass.text != tfComPass.text {
                CustomAlertView.shared.alertWithTitle(strTitle: passTwoChekc)
                
            } else {

                let param = ["oldpwd": tfOldPass.text!.md5(),
                             "newpwd" : tfNewPass.text!.md5(),
                             "token" : token]
                
                CustomAlertView.shared.alertAfterDown(strTitle: "密码修改中...")
                postWithPath(path: xgPass, paras: param, success: { (response) in
                    guard let dic = response as? NSDictionary else {
                        return
                    }
                    
                    //提取提示语
                    let resultCode = dic["resultcode"] as! String
                    
                    
                
                    if resultCode == "0" {
                        //提取提示语
                        let alertmsg = dic["resultmsg"] as! String
                        
                        //获取请求的值
                        self.comfun!(alertmsg)
                        
                        if alertmsg == "原始密码错误" {
                            
                            CustomAlertView.shared.dissmiss()
                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) {
                                CustomAlertView.shared.alertWithTitle(strTitle: passNotCor)
                            }
                            
                        } else if alertmsg == "该账号已在异地登录，请重新登录" {
                            
                            CustomAlertView.shared.dissmiss()
                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) {
                                
                                //刷新猪控制器
                                CustomAlertView.shared.closeWithAlert(strTitle: loginError, test: {
                                    let nav = NaVC.init(rootViewController: LoginView())
                                    UIApplication.shared.keyWindow?.rootViewController = nav
                                })
                            }
                            
                        } else if alertmsg == "密码修改成功" {
                            
                            CustomAlertView.shared.dissmiss()
                            
                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) {
                                CustomAlertView.shared.alertWithTitle(strTitle: changePassSuccess)
                            }
                            
                        } else {
                            CustomAlertView.shared.dissmiss()
                            
                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: {
                                CustomAlertView.shared.alertWithTitle(strTitle: unKnown)
                            })
                        }

                    
                    } else {
                        
                        let alMsg = dicc[resultCode]
                        
                        if resultCode == "40107" {
                            CustomAlertView.shared.dissmiss()
                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) {
                                
                                //刷新猪控制器
                                CustomAlertView.shared.closeWithAlert(strTitle: loginError, test: {
                                    let nav = NaVC.init(rootViewController: LoginView())
                                    UIApplication.shared.keyWindow?.rootViewController = nav
                                })
                            }
                            
                        } else {
                            CustomAlertView.shared.dissmiss()

                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: {
                                CustomAlertView.shared.alertWithTitle(strTitle: alMsg!)
                            })
                        }
                        

                    }
                    
                    
                }, failure: { (error) in
                    
                    CustomAlertView.shared.dissmiss()
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
                        CustomAlertView.shared.alertWithTitle(strTitle: netWrong)
                    }
                })
                
            }
            
        } else {
            
            self.comfun!("token不存在")
            return
        }
    }
}
