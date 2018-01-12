//
//  DownImgTool.swift
//  DollBuy
//
//  Created by 郑东喜 on 2016/11/23.
//  Copyright © 2016年 郑东喜. All rights reserved.
//  下载图片工具类

import UIKit


extension UIImageView {
    
    func downloadURL(down : String,finished: @escaping (_ imgData : Data)->()) {
        CCog(message: down)
        if down.count > 10 {
            
            //请求
            let request = URLRequest(url: URL.init(string: down)!)
            let session = URLSession.shared
            
            let dataTask = session.dataTask(with: request) { (imgdat, response, errorrr) in
                if errorrr == nil {
                    if let res = response as? HTTPURLResponse {
                        CCog(message: res.statusCode)
                        switch res.statusCode {
                        case 200:
                            
                            finished(imgdat!)
                            break
                        case 404:
                            let ddd = UIImagePNGRepresentation(#imageLiteral(resourceName: "nav_5"))
                            finished(ddd!)
                            break
                        default:
                            return
                        }
                    }
                } else {
                    if localSave.object(forKey: headImgCache) != nil {
                        if let imgData = localSave.object(forKey: headImgCache) as? Data {
                            finished(imgdat ?? UIImagePNGRepresentation(#imageLiteral(resourceName: "nav_5"))!)
                        }
                    }
                }
            }
            dataTask.resume()
        }
    }
}
