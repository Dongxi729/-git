//
//  AccountModel.swift
//  MJMarket
//
//  Created by 郑东喜 on 2017/9/14.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  用户模型

/*
 img = "http://yungou.ie1e.com/UploadFile/image/20180104082615.png";
 integral = "999900.00";
 nickname = 15000000;
 password = true;
 phone = 15000000001;
 */

import UIKit

class AccountModel: NSObject {
    
    /// 头像地址
    var img: String {
        let dd = ddd["img"] as? String
        return dd ?? ""
    }
    
    private  var ddd : [String : Any] {
        set {
            self.ddd = localSave.object(forKey: "userInfo") as? [String : Any] ?? [:]
        }
        get {
            var zdx = [String : Any]()
            if let localUserDic = localSave.object(forKey: "userInfo") as? [String : Any] {
                zdx = localUserDic
            }
            return zdx
        }
    }
    
    /// 积分
    var integral : String {
        let dd = ddd["integral"] as? String
        return dd ?? ""
    }
    
    /// 昵称
    var nickname : String {
        let dd = ddd["nickname"] as? String
        return dd ?? ""
    }
    
    /// 手机号
    var phone : String {
        let dd = ddd["phone"] as? String
        return dd ?? ""
    }
    
    var password : String {
        let dd = ddd["password"] as? String
        return dd ?? ""
    }
    
    // KVC 字典转模型
    init(dict: [String: Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}


class MemModel: NSObject {

    static var tmpUrl : String = ""
    
    /// 是否来自购物车
    static var isGotoCard = false
    
    /// 是否异地登录重新加载
    static var shouldReloadFromOrigin = false
    
    static var account_model : AccountModel?
    
    /// 个人信息刷新标识
    static var personInfoReloadMark = false
    
    class func shared() -> AccountModel {
        return  AccountModel.init(dict: localSave.object(forKey: "userInfo") as? [String : Any] ?? [:])
    }
    
    /// 清除本地用户存的数据
    class func clearUserLocalDefaultData() {
        localSave.removeObject(forKey: "userAddress")
        localSave.removeObject(forKey: "userInfo")
        localSave.removeObject(forKey: userToken)
        localSave.synchronize()
    }
    
}
