//
//  StatusBarCheck.swift
//  Alili
//
//  Created by 郑东喜 on 2016/12/18.
//  Copyright © 2016年 郑东喜. All rights reserved.
//

import UIKit

enum NetworkStates : Int {
    case NetworkStatesNone, // 没有网络
    NetworkStates2G, // 2G
    NetworkStates3G, // 3G
    NetworkStates4G, // 4G
    NetworkStatesWIFI // WIFI
}

class StatusBarCheck: NSObject {
    
    static let shared = StatusBarCheck()
    
    var comfun:((_ _data:String)->Void)?

}

extension StatusBarCheck {
    /// 网络检测
    ///
    /// - Parameter _com: 返回网络的状态参数
    func networkingStatesFromStatebar(_com:@escaping (_ _data:String)->Void) -> Void {
        comfun = _com
        
        let children = ((UIApplication.shared.value(forKeyPath: "statusBar")! as AnyObject).value(forKeyPath: "foregroundView")! as AnyObject).subviews
        // 保存网络状态
        var type = 0
        
        for child: AnyObject in children! {
            if (child as AnyObject).isKind(of: (NSClassFromString("UIStatusBarDataNetworkItemView")?.class())!) {
                
                type = (child.value(forKey: "dataNetworkType") as! Int)
            }
        }
        
        
        var stateString = "wifi"
        
        switch type {
        case 0:
            stateString = "notReachable"
            break
            
        case 1:
            stateString = "2G"
            break
            
        case 2:
            stateString = "3G"
            break
            
        case 3:
            stateString = "4G"
            break
            
        case 4:
            stateString = "LTE"
            break
            
        case 5:
            stateString = "wifi"
            break
        default:
            break
        }
        
        comfun!(stateString)

    }
}
