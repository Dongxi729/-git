//
//  GetGoodModel.swift
//  DollBuy
//
//  Created by 郑东喜 on 2016/11/23.
//  Copyright © 2016年 郑东喜. All rights reserved.
//  收获地址模型
///传给JS addrCheck(adrid,name,tel,area,address)

import UIKit

class GetGoodModel: NSObject {
    //单例
    static let shared = GetGoodModel()
    
    
    //外部闭包变量
    var comfun:((_ _data:String)->Void)?
    
    //判断是添加还是修改参数接口
    var ac = ""
    
    //收货人
    var shrName : String?
    
    //手机号码
    var shrphone : String?
    
    //省份
    var province : String?
    
    //城市
    var city : String?
    
    //地区
    var area : String?
    
    //详细地址
    var street : String?
    
    //货物信息字典
    var addDic : NSDictionary?
    
    
    
    ///传的参数
    var localParams : [String : Any]?

    //请求收货地址
    func goodInfo(tfName : UITextField,tfNum : UITextField,tfProvince : UITextField,tfCity : UITextField,tfcityLocal : UITextField,tfArea : UITextField,tfDetailAddress : UITextView,_com:@escaping (_ _data:String)->Void) -> Void {
        
        self.comfun = _com
    
        //提取本地用户收获地址信息
        guard let addDic = localSave.object(forKey: personAddData) as? NSDictionary else {
            return
        }
        //根据请求回来的地区的值是否为空，动态判断接口为更新还是添加
        if addDic["area"] as? String == "" {
            self.ac = "add"
        } else {
            self.ac = "upd"
        }

        if tfName.text?.characters.count == 0 {
            
            CustomAlertView.shared.alertWithTitle(strTitle: addPeronNotNull)
            
        } else if tfNum.text?.characters.count == 0 {
            CustomAlertView.shared.alertWithTitle(strTitle: tfNumIsNull)
            
        } else if Encryption.checkTelNumber(tfNum.text) == false {
            
            CustomAlertView.shared.alertWithTitle(strTitle: tfNumNotCor)
            
        } else if tfProvince.text?.characters.count == 0 {
            CustomAlertView.shared.alertWithTitle(strTitle: provinceNull)
            
        } else if tfCity.text?.characters.count == 0 {
            CustomAlertView.shared.alertWithTitle(strTitle: cityNull)
            
        } else if tfArea.text?.characters.count == 0 {
            CustomAlertView.shared.alertWithTitle(strTitle: areaNull)
            
        } else if tfDetailAddress.text?.characters.count == 0 {
            CustomAlertView.shared.alertWithTitle(strTitle: detailAddNull)
            
        }  else if localSave.object(forKey: userToken) as? String != nil {
            let token = localSave.object(forKey: userToken) as! String
            
            //临时设置默认的标识
            var isdefault : String = ""
            
            if issetBtn == true {

                isdefault = "1"
            } else {
                isdefault = "0"
            }
            
            
            ///增加
            if acType == "add" {
                let param = ["token":token,
                             "ac" : acType,
                    "province" : tfProvince.text!,
                    "city" : tfCity.text!,
                    "area" : tfArea.text!,
                    "street" : tfDetailAddress.text!,
                    "shrname" : tfName.text!,
                    "shrphone" : tfNum.text!,
                    ///由控件决定
                    "def" : isdefault,
                    ] as [String : Any]
                
                localParams = param
                
                ///更新
            } else if acType == "upd" {
                let param = ["token":token,
                             "ac" : acType,
                    "province" : tfProvince.text!,
                    "city" : tfCity.text!,
                    "area" : tfArea.text!,
                    "street" : tfDetailAddress.text!,
                    "shrname" : tfName.text!,
                    "shrphone" : tfNum.text!,
                    ///由控件决定
                    "def" : isdefault,
                    "adrs" : globalAdrs,
                    ] as [String : Any]
                
                localParams = param
            }
            

            localSave.set(localParams, forKey: personAddData)
            localSave.synchronize()

            
            
            //创建新的收获地址，覆盖登陆后获取的，使 用户切换收货地址时，保持一致信息
            postWithPath(path: addressUrl, paras: localParams, success: { (response) in

                guard let dic = response as? NSDictionary else {
                    return
                }

                //XFLog(message: dic)
                
                //提取提示语
                let resultCode = dic["resultcode"] as! String
                
                if resultCode == "0" {
                    //修改地址错误时的提示语
                    guard let changeWrongMsg = dic["msg"] as? String else {
                        
                        //提取提示语
                        guard let alertmsg = dic["resultmsg"] as? String else {
                            return
                        }

                        //保存信息到闭包
                        self.comfun!(alertmsg)
                        
                        if alertmsg == "添加地址成功" {
                            
                            CustomAlertView.shared.alertWithTitle(strTitle: addressAddSuccess)
                            ///获取收获地址列表
//                            DetailAddModel.shared.getDetailAddress()
                        } else if alertmsg == "修改地址成功" {
                            
                            CustomAlertView.shared.alertWithTitle(strTitle: addresUpdateSuccess)
                            
                            ///获取收获地址列表
//                            DetailAddModel.shared.getDetailAddress()
                            
                        } else {
                            CustomAlertView.shared.dissmiss()
                            
                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: {
                                CustomAlertView.shared.alertWithTitle(strTitle: unKnown)
                            })
                        }
                        
                        
                        return
                    }
                    
                    //保存信息到闭包
                    self.comfun!(changeWrongMsg)
                    
                    if changeWrongMsg == "尝试修改地址不存在" {
                        
                        CustomAlertView.shared.alertWithTitle(strTitle: changeAddressFail)
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
            
            
        } else {
            MBManager.showBriefAlert("登陆后才可查看收获信息")
            return
        }
    }
    
    

}
