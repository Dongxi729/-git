//
//  UndelLineLabel.swift
//  DollBuy
//
//  Created by 郑东喜 on 2016/11/18.
//  Copyright © 2016年 郑东喜. All rights reserved.
//  带下划线的label

import UIKit

class UndelLineLabel: UILabel {

    override var text: String? {
        didSet {
            guard let text = text else { return }
            let textRange = NSMakeRange(0, text.count)
            let attributedText = NSMutableAttributedString(string: text)
            attributedText.addAttribute(NSAttributedStringKey.underlineStyle , value: NSUnderlineStyle.styleSingle.rawValue, range: textRange)
            // Add other attributes if needed
            self.attributedText = attributedText
        }
    }

}
