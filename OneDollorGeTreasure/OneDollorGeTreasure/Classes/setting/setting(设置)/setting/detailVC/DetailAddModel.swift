//
//  DetailAddModel.swift
//  Alili
//
//  Created by 郑东喜 on 2017/1/13.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  我的收获地址(列表)

///传给JS addrCheck(adrid,name,tel,area,address)

import UIKit


///本地数组数据
var globalAddArray = NSMutableArray()

class DetailAddModel: NSObject {
    
    //单例
    static let shared = DetailAddModel()
    
    ///默认地址标识
    var defaultSyn : Bool = false
    
    //外部闭包变量- 详细地址
    var comfun:((_ _data:NSMutableArray)->Void)?
    
    //外部闭包变量- 默认地址收回
    var comfunDef:((_ _data : String)->Void)?
    
    func getDetailAddress(comfun:((_ _data:NSMutableArray)->Void)?) -> Void {
        
        self.comfun = comfun
        
        guard let token = localSave.object(forKey: userToken) as? String else {
            return
        }
        
        let params =
            ["token" : token,
             "ac" : "list"] as [String : Any]
        
        
        
        postWithPath(path: addressUrl, paras: params, success: { (response) in
            
            
            guard let dic = response as? NSDictionary else {
                return
            }

            guard let resultMsg = dic["resultmsg"] as? String else {
                return
            }
            
            
            if resultMsg == "请求成功" {
                
                let dic2 = dic["data"] as! NSDictionary

                globalAddArray = (dic2["list"] as! NSArray).mutableCopy() as! NSMutableArray

                
//                //获取临时的值
//                let temarray : NSMutableArray = (dic2["list"] as! NSArray).mutableCopy() as! NSMutableArray
//                
//                //找到默认的位置，重新排序数组的值
//                for i in 0..<temarray.count {
//                    
//                    let dic : NSDictionary = (temarray[i] as? NSDictionary)!
//                    
//                    for (_,k) in dic {
//
//                        let str : String = k as! String
//                        
//                        if str == "1" {
//                            temarray.exchangeObject(at: 0, withObjectAt: i)
//
//                        }
//                    }
//                }
//                
                
                //传给闭包
                self.comfun!((dic2["list"] as! NSArray).mutableCopy() as! NSMutableArray)
                

                
            } else {
                
            }

            
            
        }) { (error) in
            //XFLog(message: error)
        }
        
    }
    
    ///删除地址
    func deleteAddrs(delIndex : String) -> Void {
        
        ///取token
        guard let token = localSave.object(forKey: userToken) as? String else {
            return
        }
        
        ///获取地址编号adrs
        let params = ["token" : token,
                      "ac" : "del",
                      "adrs" : delIndex] as [String : Any]
        
        ///开始请求
        postWithPath(path: addressUrl, paras: params, success: { (response) in
            guard let dic = response as? NSDictionary else {
                return
            }
            //提取提示语
            let resultCode = dic["resultcode"] as! String
            
            if resultCode == "0" {
                //提取提示语
                guard let alertmsg = dic["resultmsg"] as? String else {
                    return
                }
                
                if alertmsg == "删除地址成功" {
                    globalAdrs = "删除地址成功"

                } else if alertmsg == "尝试删除地址失败" {
                    CustomAlertView.shared.alertWithTitle(strTitle:delAddrong )
                } else {
                    CustomAlertView.shared.alertWithTitle(strTitle: unKnown)
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
            
            
        }) { (error) in
            CustomAlertView.shared.alertWithTitle(strTitle: netWrong)
        }
    }
    
    ///设置默认
    func setDefaultAdd(index : String,confun:@escaping (_ _data : String) -> Void) -> Void {
        
        self.comfunDef = confun
        ///取token
        guard let token = localSave.object(forKey: userToken) as? String else {
            return
        }
        
        ///获取地址编号adrs
        let params = ["token" : token,
                      "ac" : "def",
                      "adrs" : index] as [String : Any]
        
        ///开始请求
        postWithPath(path: addressUrl, paras: params, success: { (response) in
            guard let dic = response as? NSDictionary else {
                return
            }

            
            //提取提示语
            let resultCode = dic["resultcode"] as! String
            
            if resultCode == "0" {
                
                //提取提示语
                guard let alertmsg = dic["resultmsg"] as? String else {
                    return
                }
                
                if alertmsg == "设置默认地址成功" {
                    
                    self.comfunDef!("yes")
                    globalSygSetDefault = "设置默认地址成功"

                } else {
                    CustomAlertView.shared.alertWithTitle(strTitle: unKnown)
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

        }) { (error) in
            CustomAlertView.shared.alertWithTitle(strTitle: netWrong)
        }

    }
    
}
