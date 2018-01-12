//
//  PhotoScrollView.swift
//  Alili
//
//  Created by 郑东喜 on 2017/1/15.
//  Copyright © 2017年 郑东喜. All rights reserved.
//

import UIKit

class PhotoScrollView: UIScrollView,UIScrollViewDelegate {
    var _image:UIImage!
    
    var image:UIImage! {
        
        get {
            
            return self._image
        }
        
        set {
            
            _image = newValue
            
            let imgView:UIImageView = self.viewWithTag(100) as! UIImageView

            imgView.image = image
            
        }
        
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        
        
        let imgView:UIImageView! = UIImageView(frame: self.bounds)
        
        imgView.contentMode = .scaleAspectFit
        imgView.tag = 100
        
        self.addSubview(imgView)
        
        
        
        //取消滑动条
        
        self.showsHorizontalScrollIndicator = false
        
        self.showsVerticalScrollIndicator = false
        
        self.delegate = self
        

        //设置最大、最小缩放比例
        
        self.maximumZoomScale = 3
        
        self.minimumZoomScale = 1

    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
    }

    
}
