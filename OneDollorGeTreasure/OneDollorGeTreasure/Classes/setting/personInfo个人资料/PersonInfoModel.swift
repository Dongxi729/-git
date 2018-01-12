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
    
    func saveInfo(tfNickName : UITextField,comfun:@escaping (_ xx : Bool)->()) -> Void {
        
        
        guard let token = localSave.object(forKey: userToken) as? String else {
            MBManager.showBriefAlert("请先登陆")
            return
        }
        let param = ["token" : token,
                     "nickname" : tfNickName.text!]

        //判断所填信息是否符合发送网络请求
        if tfNickName.text?.count == 0 {
            toast(alrtMSg: nickNameNotNull)
        } else {
            
            NetwrokTool.requestWithPost(postwithParam: param, postWithUrl: updpersoninfoURL, finishedWithDic: { (response) in
                if response.count == 0 {
                    return
                } else {
                    comfun(true)
                }
            })
        }
    }
}
