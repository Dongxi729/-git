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
    func goodInfo(tfName : UITextField,tfNum : UITextField,tfProvince : UITextField,tfCity : UITextField,tfcityLocal : UITextField,tfArea : UITextField,tfDetailAddress : UITextView,_com:@escaping (_ _data:Bool)->()) -> Void {
        
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
        
        if tfName.text?.count == 0 {
            toast(alrtMSg: addPeronNotNull)
            return
        } else if tfNum.text?.count == 0 {
            toast(alrtMSg: tfNumIsNull)
            return
        } else if Encryption.checkTelNumber(tfNum.text) == false {
            toast(alrtMSg: tfNumNotCor)
            return
        } else if tfProvince.text?.count == 0 {
            toast(alrtMSg: provinceNull)
            return
            
        } else if tfCity.text?.count == 0 {
            toast(alrtMSg: cityNull)
            return
            
        } else if tfArea.text?.count == 0 {
            toast(alrtMSg: areaNull)
            return
            
        } else if tfDetailAddress.text?.count == 0 {
            toast(alrtMSg: detailAddNull)
            return
            
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
            
            NetwrokTool.requestWithPost(postwithParam: localParams ?? ["" : ""], postWithUrl: addressUrl, finishedWithDic: { (response) in
                _com(true)
            })
        }
    }
}
