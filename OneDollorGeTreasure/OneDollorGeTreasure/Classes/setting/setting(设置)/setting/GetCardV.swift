//
//  GetCardV.swift
//  Alili
//
//  Created by 郑东喜 on 2017/10/26.
//  Copyright © 2017年 郑东喜. All rights reserved.
//

import UIKit

protocol GetCardVDelegate {
    func getCardV()
}
class GetCardV: UIView,UITableViewDelegate,UITableViewDataSource {
    
    var getCardVDelegate : GetCardVDelegate?
    
    lazy var bgView: UIView = {
        let d : UIView = UIView.init(frame: UIScreen.main.bounds)
        d.backgroundColor = UIColor.black
        d.alpha = 0
        return d
    }()
    
    var dataSource : [SomeStruct] = [SomeStruct.init(name: ["coupon_id" : 1,
                                                        "full_money" : "50.00",
                                                        "limit_date" : "2017.10.20-2017.10.25",
                                                        "reduce_money" : "20.00",
                                                        "title": "优惠券名称cs1"])]{
        didSet {
            self.getCards_TBV.reloadData()
        }
    }
    

    
    /// 关闭按钮
    lazy var getCard_rightCloseBtn: UIButton = {
        let d : UIButton = UIButton.init(frame: CGRect.init(x: self.Width * 0.8, y: self.Height * 0.2, width: self.Height * 0.1, height: self.Height * 0.1))
        d.addTarget(self, action: #selector(getCard_closeSELF), for: .touchUpInside)
        return d
    }()
    
    @objc func getCard_closeSELF() {
        UIView.animate(withDuration: 0.1, animations: {
            self.alpha = 0
            self.bgView.alpha = 0
        }) { (finished) in
            self.bgView.removeFromSuperview()
            self.removeFromSuperview()
            
        }

    }
    
    lazy var getCardBgV: UIImageView = {
        let d : UIImageView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: 300 * SCREEN_SCALE, height: 300 * SCREEN_SCALE * (503 / 497)))
        d.image = #imageLiteral(resourceName: "yhj")
        d.center = self.center
        d.contentMode = .scaleAspectFit
        return d
    }()
    
    lazy var seeMore: UIButton = {
        let d : UIButton = UIButton.init(frame: CGRect.init(x: self.Width * 0.5 - self.Width * 0.1, y: self.getCards_TBV.BottomY + 5, width: self.Width * 0.2, height: 30 * SCREEN_SCALE))
        d.backgroundColor = UIColor.colorWithHexString("C07327")
        d.addTarget(self, action: #selector(seeMoreFunc), for: .touchUpInside)
        d.titleLabel?.font = UIFont.systemFont(ofSize: 10 * SCREEN_SCALE)
        d.layer.cornerRadius = 10
        d.clipsToBounds = true
        d.setTitle("查看更多", for: .normal)
        return d
    }()
    
    @objc private func seeMoreFunc() {
        self.getCard_closeSELF()
        self.getCardVDelegate?.getCardV()
    }
    
    
    lazy var getCards_TBV: UITableView = {
        
        let d : UITableView = UITableView.init(frame: CGRect.init(x: self.Width * 0.1, y: self.Height * 0.585, width:  300 * SCREEN_SCALE * 0.8 , height: self.Height * 0.1), style: .plain)
        d.delegate = self
        d.backgroundColor = UIColor.clear
        d.dataSource = self
        d.separatorStyle = .none
        d.register(GetCardCell.self, forCellReuseIdentifier: "GetCardCell")
        return d
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(bgView)
        
        UIView.animate(withDuration: 0.25, animations: {
            self.bgView.alpha = 0.2
        }) { (finished) in
            self.addSubview(self.getCardBgV)
            self.addSubview(self.getCard_rightCloseBtn)
            self.addSubview(self.getCards_TBV)
            self.addSubview(self.seeMore)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75.7895
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GetCardCell") as! GetCardCell
        cell.backgroundColor = UIColor.clear
        
        cell.getCard_moneyDesLab.text = "满" + String(self.dataSource[indexPath.row].name!["full_money"] as? String ?? "") + "元可用"
        cell.getCard_moneyLabel.text = "¥" + String(self.dataSource[indexPath.row].name!["reduce_money"] as? String ?? "")
        cell.getCard_moneyLabel.sizeToFit()
        cell.getCard_freshMeat.text =  self.dataSource[indexPath.row].name!["title"]  as? String ?? ""
        cell.getCardDescLabel.text = self.dataSource[indexPath.row].name!["limit_date"] as? String ?? ""
        
        if let limit_str = self.dataSource[indexPath.row].name!["limit_date"] as? String {
            if limit_str.characters.count > 11 {
                let xxxxx = limit_str
                var indexxx = 0
                
                for cahe in xxxxx {
                    indexxx += 1
                    if cahe == "-" {
                        print(indexxx)
                        let range2 = NSRange.init(location: 0, length: indexxx)
                        var xxxxx2 : NSString = xxxxx as NSString
                        xxxxx2 = xxxxx2.replacingCharacters(in: range2, with: "") as NSString
                        CCog(message: localSave.object(forKey: localName) as? String ?? "")
                        cell.getCardDescLabel.text = String(((xxxxx2 as String) as String) + "到期" + "\n" )
                    }
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (self.dataSource.count)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.getCard_closeSELF()
        self.getCardVDelegate?.getCardV()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

