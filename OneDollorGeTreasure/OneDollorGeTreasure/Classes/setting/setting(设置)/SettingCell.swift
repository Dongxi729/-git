//
//  SettingCell.swift
//  DollBuy
//
//  Created by 郑东喜 on 2016/11/17.
//  Copyright © 2016年 郑东喜. All rights reserved.
//  设置页面cell

import UIKit
import WebKit

// MARK:- 设置代理
protocol SettingCellDelegate {
//    func showLogVC()
    func logoutSel()
}

class SettingCell: UITableViewCell {
    
    //文件夹缓存地址
    fileprivate lazy var cacheSaveStr = ""
    
    //监听代理
    var delegate : SettingCellDelegate?
    
    //cell的文字
    var nameLabel: UILabel = {
        let lab = UILabel()
        lab.frame = CGRect(x: 50, y: 0, width: 200, height: 45)
        
        //文字左对齐
        lab.textAlignment = NSTextAlignment.left
        lab.font = UIFont.systemFont(ofSize: 14)
        return lab
    }()
    
    lazy var indicator: UIActivityIndicatorView = {
        let d : UIActivityIndicatorView  = UIActivityIndicatorView.init(frame: self.clearCaheLabel.frame)
        d.activityIndicatorViewStyle = .gray
        return d
    }()
    
    //前置图片
    lazy var imgView: UIImageView = {
        let img = UIImageView()
        //自适应放大
        img.contentMode = UIViewContentMode.scaleAspectFit
        img.frame = CGRect(x: 10, y: 10, width: 25, height: 25)
        return img
    }()
    
    //分割线
    lazy var line : UIView = {
       let lin = UIView()
        lin.frame = CGRect(x: 0, y: 45, width: UIScreen.main.bounds.size.width, height: 0.5)
       lin.backgroundColor = UIColor.lightGray
        return lin
    }()
    
    //退出按钮
    lazy var btn : UIButton = {
        let btn = UIButton()
        btn.backgroundColor = commonBtnColor
        btn.setTitle("退出", for: .normal)
        //退出按钮
        btn.frame = CGRect(x: 15, y: 0, width: Int(UIScreen.main.bounds.width - 30), height: 40)
        //单机事件
        
        btn.addTarget(self, action: #selector(SettingCell.logout), for: .touchUpInside)
        btn.layer.cornerRadius = 10
        return btn
    }()
    

    //尖角
    lazy var disclosureImg : UIImageView = {
        let img = UIImageView()
        
        img.contentMode = UIViewContentMode.scaleAspectFit
        img.frame = CGRect(x: UIScreen.main.bounds.width - 30, y: 7.5, width: 15, height: 30)
        
        return img
    }()
    
    //版本号
    lazy var versonLabel : UILabel = {
        let versonLabel = UILabel()
        
        versonLabel.font = UIFont.systemFont(ofSize: 10)
        versonLabel.textColor = UIColor.gray
        versonLabel.textAlignment = .center
    

        return versonLabel
    }()
    
    ///清除缓存文本
    lazy var clearCaheLabel : UILabel = {
        let cacheLable : UILabel = UILabel.init(frame: CGRect.init(x: 12, y: 10 * 1.25, width: SW - 2 * 12, height: 20))
        
        cacheLable.font = UIFont.systemFont(ofSize: 14)
        cacheLable.text = "正在计算中..."
        cacheLable.textAlignment = .right
        ///清除缓存
        
        

        return cacheLable
    }()
    

    
    
    //重写构造方法
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        ///接收缓存消息
        NotificationCenter.default.addObserver(self, selector: #selector(cacheSEL(notifi:)), name: NSNotification.Name(rawValue: "clearDone"), object: nil)

        disclosureImg.image = UIImage.init(named: "closuerimg")
        
        
        //设置系统版本号位置大小
        versonLabel.frame = CGRect.init(x: 0, y: -15, width: SW, height: 25)
        
        //获取系统版本号
        let sysverson = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
        
        //拼接label的值
        versonLabel.text = "Copyright© 2013-2017 锐掌Ie9e.com 版权所有 " + "V" + sysverson!
        
        addSubview(nameLabel)
        addSubview(imgView)
        addSubview(line)
        addSubview(btn)
        addSubview(disclosureImg)

        addSubview(clearCaheLabel)
        
        //系统版本
        addSubview(versonLabel)
        
        //去除高亮效果
        self.selectionStyle = .none
        
        DispatchQueue.global(qos: .default).async {
            
            let cacheSize : UInt = SDImageCache.shared().getSize()
            //2.获取ios 本地文件library缓存大小
            var paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first! as NSString
            paths = paths.replacingOccurrences(of: "file:///", with: "/") as NSString
            
            self.cacheSaveStr = paths as String
            
            //1.本地文件大小统计
            let localFileSize = paths.fileSize()
            
            let localCacheNum = Float(localFileSize + UInt64(cacheSize)) / 1024 / 1024
            DispatchQueue.main.async {
                self.clearCaheLabel.text = NSString.localizedStringWithFormat("%.2fMB", localCacheNum) as String
            }
        }
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(false, animated: false)
    }
}

//单机监听事件
extension SettingCell {
    @objc fileprivate func logout() -> Void {
        self.delegate?.logoutSel()
    }
    
    @objc fileprivate func cacheSEL(notifi : NSNotification) -> Void {
        
        let dic = notifi.userInfo
        
        let result = dic?["value"] as? String
        if result == "yes" {
            
            
            
            DispatchQueue.main.async {
                
                //缓存机制:http://www.jianshu.com/p/186a3b236bc9
                if #available(iOS 9.0, *) {

                    let websiteDataTypes = WKWebsiteDataStore.allWebsiteDataTypes()
                    let dateForm = NSDate.init(timeIntervalSince1970: 0)
                    
                    
                    WKWebsiteDataStore.default().removeData(ofTypes: websiteDataTypes, modifiedSince: dateForm as Date, completionHandler: {
                        self.clearCaheLabel.text = "0.0MB"
                        
                    })
                    
                    /**
                     WKWebsiteDataTypeDiskCache,
                     
                     WKWebsiteDataTypeOfflineWebApplicationCache,
                     
                     WKWebsiteDataTypeMemoryCache,
                     
                     WKWebsiteDataTypeLocalStorage,
                     
                     WKWebsiteDataTypeCookies,
                     
                     WKWebsiteDataTypeSessionStorage,
                     
                     WKWebsiteDataTypeIndexedDBDatabases,
                     
                     WKWebsiteDataTypeWebSQLDatabases

                     */
                    
                } else {
                    // Fallback on earlier versions
                    /**
                     
                     NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
                     NSString *cookiesFolderPath = [libraryPath stringByAppendingString:@"/Cookies"];
                     NSError *errors;
                     [[NSFileManager defaultManager] removeItemAtPath:cookiesFolderPath error:&errors];

                     */
                    
                    var libraryPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, false).first!
                    libraryPath += "/Cookies"
                    
                    do {
                        //let result = try FileManager.default.removeItem(atPath: libraryPath)
//                        print(result)
                        
                    } catch {
                        showWithAlert(alertStr: error.localizedDescription + "\((#file as NSString).lastPathComponent):(\(#line))")
                    }
                    URLCache.shared.removeAllCachedResponses()
                }
            }
        }
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "clearDone"), object: nil)
        
    }
}










