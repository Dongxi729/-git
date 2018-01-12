//
//  AddressModel.swift
//  Alili
//
//  Created by 郑东喜 on 2018/1/5.
//  Copyright © 2018年 郑东喜. All rights reserved.
// 地址模型
/*
 area = "东湖区";
 city = "南昌市";
 province = "江西省";
 shrname = "哦哦哦";
 shrphone = 13352658556;
 street = "某件安静";
 */

import UIKit

class AddressModel: NSObject {

    /// 收货人区
    var area : String {
        let dd = ddd["area"] as? String
        return dd ?? ""
    }

    /// 收货人城市
    var city : String {
        let dd = ddd["city"] as? String
        return dd ?? ""
    }

    /// 收货人姓名
    var shrname : String {
        let dd = ddd["shrname"] as? String
        return dd ?? ""
    }

    /// 收货人省份
    var province : String {
        let dd = ddd["province"] as? String
        return dd ?? ""
    }

    /// 收货人手机号
    var shrphone : String {
        let dd = ddd["shrphone"] as? String
        return dd ?? ""
    }

    /// 街道
    var street : String {
        let dd = ddd["street"] as? String
        return dd ?? ""
    }

    private  var ddd : [String : Any] {
        set {
            self.ddd = localSave.object(forKey: "userAddress") as? [String : Any] ?? [:]
        }
        get {
            var zdx = [String : Any]()
            if let localUserDic = localSave.object(forKey: "userAddress") as? [String : Any] {
                zdx = localUserDic
            }
            return zdx
        }
    }
    
    // KVC 字典转模型
    init(dict: [String: Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}


class MemAddressModel: NSObject {
    static var account_model : AddressModel?
    class func shared() -> AddressModel {
        return  AddressModel.init(dict: localSave.object(forKey: "userAddress") as? [String : Any] ?? [:])
    }
}
