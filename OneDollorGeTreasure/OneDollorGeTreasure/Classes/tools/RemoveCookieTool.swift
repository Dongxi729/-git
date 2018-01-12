//
//  RemoveCookieTool.swift
//  MJMarket
//
//  Created by 郑东喜 on 2017/9/22.
//  Copyright © 2017年 郑东喜. All rights reserved.
//

import UIKit
import WebKit

class RemoveCookieTool: NSObject {
    
    class func removeCookie() {
        if #available(iOS 9.0, *) {
            
            let websiteDataTypes = WKWebsiteDataStore.allWebsiteDataTypes()
            let dateForm = NSDate.init(timeIntervalSince1970: 0)
            
            
            WKWebsiteDataStore.default().removeData(ofTypes: websiteDataTypes, modifiedSince: dateForm as Date, completionHandler: {
                
            })
            
        } else {
            
            var libraryPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, false).first!
            libraryPath += "/Cookies"
            URLCache.shared.removeAllCachedResponses()
        }
    }
}
