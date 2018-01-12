//
//  CoTool.swift
//  DollarBuy
//
//  Created by 郑东喜 on 2016/11/7.
//  Copyright © 2016年 郑东喜. All rights reserved.
//  为label添加下划线 （富文本）

import UIKit

class CoTool: NSObject {
    static let shareInstance = CoTool()
    
    //uilabel添加下划线
    func labelWithUnderLine(text : String) -> NSAttributedString {
        let str1 = NSMutableAttributedString(string: text)
        let range1 = NSRange(location: 0, length: str1.length)
        let number = NSNumber(value:NSUnderlineStyle.styleSingle.rawValue)//此处需要转换为NSNumber 不然不对,rawValue转换为integer
        str1.addAttribute(NSAttributedStringKey.underlineStyle, value: number, range: range1)
        str1.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.black, range: range1)
        return str1
    }
}
