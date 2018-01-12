//
//  MyAccountModel.swift
//  DollBuy
//
//  Created by 郑东喜 on 2016/12/6.
//  Copyright © 2016年 郑东喜. All rights reserved.
//  我的积分模型

import UIKit

class MyAccountModel: NSObject {
    
    static let shared = MyAccountModel()
    
    ///积分数据源
    var accountArray = NSMutableArray()
    
    var jifennn = ""

    //将登陆状态传给闭包
    
    //外部闭包变量
    var comfun:((_ _data:String)->Void)?
    
    /**
     ## 登陆
     主要实现了登陆封装逻辑
     
     - tfNum    电话号码
     - tfPass   密码
     */
    func getAccout(_com:((_ _data:String)->Void)?) -> Void {
        

//        accountArray = [["b": "456", "a": "123", "c": "2010-10-09"], ["b": "456", "a": "123", "c": "2010-10-09"], ["b": "456", "a": "123", "c": "2010-10-09"]]
        
        comfun = _com

        guard let token = localSave.object(forKey: userToken) as? String else {
            return
        }

        //请求参数
        let params = ["token": token]

        
            postWithPath(path: integrallogURL, paras: params, success: { (response) in
                
            //判读返回值是否为空
            guard let dic = response as? NSDictionary else {
                return
            }


                //提取提示语
                let resultCode = dic["resultcode"] as! String
                
                //XFLog(message: "resultCode = ",file: resultCode)
                
                //返回正确
                if resultCode == "0" {
                    guard let resultMsg = dic["resultmsg"] as? String else {
                        return
                    }
                    
                    
                    if resultMsg == "请求成功" {

                        assert(true, "执行我的积分模型")
                        
                        let dic2 = dic["data"] as! NSDictionary

                    
                        AccountTableViewCell.shared.dataArr = dic2["list"] as! NSArray
                        
                        
                        localSave.set(dic2["list"] as! NSArray, forKey: jifenArray)
                        localSave.synchronize()

                        self.jifennn = dic2["myintegral"] as! String
                        
                        localSave.set(dic2["myintegral"] as! String, forKey: "jifen")
                        localSave.synchronize()

                        
                        guard let array = dic2["list"] as? NSMutableArray else {
                            
                            return
                        }

                        
                        self.accountArray = array
                        
                        //传值
                        self.comfun!(self.jifennn)
                        
                        //存入本地
                        localSave.set(array, forKey: jifenArray)
                        localSave.synchronize()
                        
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
                CustomAlertView.shared.dissmiss()
                
//                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
//                    CustomAlertView.shared.alertWithTitle(strTitle: "网络异常")
//                }
        })

    }
}
