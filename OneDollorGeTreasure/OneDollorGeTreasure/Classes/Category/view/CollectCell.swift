//
//  CollectCell.swift
//  MVVM
//
//  Created by 郑东喜 on 2017/2/3.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  右侧cell

import UIKit

class CollectCell: UICollectionViewCell {
    
    //文字
    lazy var tfLeftUp : UILabel = {
        let tf = UILabel()
        tf.frame = CGRect(x: 0, y:(SW * 0.75) / 3 * 0.7, width: (SW * 0.75) / 3 - 4, height: (SW * 0.75) / 3 * 0.25)
        tf.textAlignment = .center
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor.green.cgColor
        return tf
    }()
    
    //图片
    lazy var imgView : UIImageView = {
        let img = UIImageView()
        img.frame = CGRect(x: 0, y: 0, width: (SW * 0.75) / 3 - 4, height: (SW * 0.75) / 3 * 0.7)
        img.contentMode = .scaleAspectFit
        img.layer.borderColor = UIColor.red.cgColor
        img.layer.borderWidth = 1
        return img
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(tfLeftUp)
        addSubview(imgView)
        
        
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
