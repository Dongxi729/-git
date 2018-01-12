//
//  PersonInfoModel.swift
//  DollBuy
//
//  Created by 郑东喜 on 2016/11/23.
//  Copyright © 2016年 郑东喜. All rights reserved.
//  个人资料模型

import UIKit

class PersonInfoModel: NSObject {
    //单例
    static let shared = PersonInfoModel()
    
    //外部闭包变量
    var comfun:((_ _data:String)->Void)?
    
    //个人头像信息---
    var personImg : String?
    
    //个人字典信息
    var personDicInfo : NSDictionary?
    
    //昵称
    var nickName : String?
    
    //绑定手机
    var bindPhone : String?
    
    //积分
    var jifen : String?
    
    //个人信息字典
    
    func saveInfo(tfNickName : UITextField,comfun:((_ _data:String)->Void)?) -> Void {
        
        //接收闭包内存地址
        self.comfun = comfun
        
        guard let token = localSave.object(forKey: userToken) as? String else {
            MBManager.showBriefAlert("请先登陆")
            
            return
        }
        
        
        let param = ["token" : token,
                     "nickname" : tfNickName.text!]

        //判断所填信息是否符合发送网络请求
        if tfNickName.text?.characters.count == 0 {
        
            CustomAlertView.shared.alertWithTitle(strTitle: nickNameNotNull)
        } else {
            postWithPath(path: updpersoninfoURL, paras: param, success: { (response) in
                
                guard let dic = response as? NSDictionary else {
                    return
                }
                
                //XFLog(message: dic)
                
                //提取提示语
                let resultCode = dic["resultcode"] as! String
                
                if resultCode == "0" {
                    
                    //提取提示语
                    guard let alertmsg = dic["resultmsg"] as? String else {
                        return
                    }
                    
                    
                    if alertmsg == "成功" {
                        CustomAlertView.shared.alertWithTitle(strTitle: setPerInfoSuc)
                        
                    
                        //信息同步
                        LoginAfterSygn.shared.loginSygn()
                    }
                    //接收返回的值
                    self.comfun!(alertmsg)

                } else {
                    
                    let alMsg = dicc[resultCode]
                    
                    if resultCode == "40107" {
                        CustomAlertView.shared.dissmiss()
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) {
                            
                            //刷新猪控制器
                            CustomAlertView.shared.closeWithAlert(strTitle: loginError, test: {
                                
                                logoutModel.shared.logoutWithOutAlert()
                                
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
                self.comfun!(error.localizedDescription)
                
                CustomAlertView.shared.alertWithTitle(strTitle: netWrong)

            })
        }
    }
}
