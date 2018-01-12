//
//  ImgWithRound.swift
//  MD5
//
//  Created by 郑东喜 on 2016/11/23.
//  Copyright © 2016年 郑东喜. All rights reserved.
//

import UIKit

extension UIImage {



    /**
     设置圆形图片
     - returns: 圆形图片
     */
    func isCircleImage() -> UIImage {
        //开始图形上下文
        UIGraphicsBeginImageContextWithOptions(self.size, false, UIScreen.main.scale)
        //获取图形上下文
        let contentRef:CGContext = UIGraphicsGetCurrentContext()!
        //设置圆形
//        let rect = CGRect(0, 0, self.frame.size.width, self.frame.size.height)
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        //根据 rect 创建一个椭圆
        contentRef.addEllipse(in: rect)
        //裁剪
        contentRef.clip()
        //将原图片画到图形上下文

        self.draw(in: rect)
        //从上下文获取裁剪后的图片
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        //关闭上下文
        UIGraphicsEndImageContext()
        return newImage
    }
}

