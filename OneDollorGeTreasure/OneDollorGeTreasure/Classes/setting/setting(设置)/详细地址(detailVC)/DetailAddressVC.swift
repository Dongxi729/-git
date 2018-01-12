//
//  DetailAddressVC.swift
//  Alili
//
//  Created by 郑东喜 on 2017/1/13.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  详细地址

///全局地址变量
//addrCheck(adrid,name,tel,area,address)


import UIKit

///名字
var globalAddName = ""

///电话
var globalAddTel = ""

///地区 省市区
var globalArea = ""

///详细地址
var globalDetailArea = ""

///获取对应的索引
var detailAddindex : Int = 0


var diccccc = NSDictionary()

class DetailAddressVC: BaseViewController,DetailAddressCellDelegate,UITableViewDelegate,UITableViewDataSource {
    
    static let shared = DetailAddressVC()
    
    fileprivate lazy var tableView : UITableView = UITableView()
    
    //表格数据源
    fileprivate lazy var array : NSMutableArray  = {
        var data = NSMutableArray()
        
        return data
    }()
    
    ///无收获地址视图
    fileprivate var noneAddView : UIView = UIView()
    
    //导航栏设置还原
    override func viewWillAppear(_ animated: Bool) {
        
        
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        //文字颜色
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black]
        
        UIApplication.shared.statusBarStyle = .default
        
        super.viewWillAppear(animated)
        
        //加载数据在设置样式
        self.setdataAndUI()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        title = "我的收获地址"
        
        ///添加按钮
        let rightBtn = UIImageView.init(frame: CGRect(x: 0, y: 50, width: 25, height: 25))
        rightBtn.image = UIImage.init(named: "add")
        rightBtn.isUserInteractionEnabled = true
        
        let rightGes = UITapGestureRecognizer.init(target: self, action: #selector(editAddress))
        rightBtn.addGestureRecognizer(rightGes)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: rightBtn)

    }
    
}

// MARK:- 设置表格
extension DetailAddressVC {
    func setUI() -> Void {
        
//        let rect = CGRect.init(x: 0, y: 64, width: SW, height: SH - 64)
        tableView = UITableView.init(frame: self.view.bounds, style: .plain)
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        tableView.backgroundColor = commonBgColor
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
    }
}

///右边按钮
extension DetailAddressVC {
    @objc func editAddress() -> Void {
        ///修改全局变量地址的索引
        detailAddindex = -1
        
        acType = "add"
        
        DispatchQueue.main.async {
            self.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(GetGoodsVieController(), animated: true)
        }

    }
}

// MARK:- 表格代理方法代理事件
extension DetailAddressVC {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "cellID") as? DetailAddressCell
        
        if cell == nil {
            
            cell = DetailAddressCell(style: .default, reuseIdentifier: "cellID")

            cell?.delegate = self
        }
        
        let dic = self.array[indexPath.row] as! NSDictionary
        
        let mark = dic["def"] as? String
        
        if indexPath.row == 0 {
            
            cell?.defaultLab.textColor = commonBtnColor
            
            cell?.defaultLabIcon.image = UIImage.init(named: "select")
        } else if mark == "0" {
            
            cell?.defaultLab.textColor = UIColor.init(red: 290/255, green: 290/255, blue: 290/255, alpha: 1)
            cell?.defaultLabIcon.image = UIImage.init(named: "default_select")
        }
        
        ///文本赋值
        cell?.telLab.text = dic["shrphone"] as? String
        
        cell?.nameLabel.text = dic["shrname"] as? String
        
        cell?.addLab.text = dic["street"] as? String
        
        return cell!
    }
    
    //出现动画
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        
//        cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1)
//        
//        UIView.animate(withDuration: 0.75) {
//            cell.transform = CGAffineTransform.identity
//        }
//    }
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  DetailAddressCell.shared.height
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
}

extension DetailAddressVC {
    // MARK:- 判断当前数据源总数
     @objc fileprivate func dataZero() -> Void {
        if self.array.count == 0  {
            self.setNoneAddVC()
        }
    }
}

// MARK:- 表格cell代理事件
extension DetailAddressVC {
    func delSel(int: IndexPath) {
    
        ///删除
        //        ///取出返回默认的默认值
        let selectDIC = self.array[int.row] as? NSDictionary
        let selectIndex = selectDIC?["adrs"] as? String
        
        DetailAddModel.shared.deleteAddrs(delIndex: selectIndex!)
        
        self.array.removeObject(at: int.row)
        
        self.tableView.beginUpdates()
        self.tableView.deleteRows(at: [int], with: .left)
        self.tableView.endUpdates()
        
        //执行一次请求数据的操作，用来显示没有收获地址时的界面
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            DetailAddModel.shared.getDetailAddress { (totalAddressCount) in
                if totalAddressCount.count == 0 {
                    
                    self.noneAddView.removeFromSuperview()
                    
                    self.tableView.frame = CGRect.init(x: 0, y: 0, width: 0, height: 0)
                    //显示没有收获地址的界面
                    self.setNoneAddVC()
                } else {}
            }
        }
    }
    
    ///编辑图标按钮单机事件
    func editPassSEL(int: IndexPath) {
        acType = "upd"
        
        //XFLog(message: self.array)
        
        let selectDIC = self.array[int.row] as? NSDictionary
        let selectIndex = selectDIC?["adrs"] as? String
        
        globalAdrs = selectIndex!
        
        ///赋值
        detailAddindex = int.row
        
 
        
        DispatchQueue.main.async {
            self.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(GetGoodsVieController(), animated: true)
        }
        
    }
    
    
    ///默认设置按钮事件
    func defauPassSEL(int: IndexPath, btnSender: UIButton) {

        XFLog(message: int.row)
        
        ///取出返回默认的默认值
        let selectDIC = self.array[int.row] as? NSDictionary
        let selectIndex = selectDIC?["adrs"] as? String
        
        ///全局变量ID
        globalAdrs = selectIndex!
        
        ///赋值到全局变量
        
        //名字
        globalAddName = (selectDIC?["shrname"] as? String)!
        
        //电话号码
        globalAddTel = (selectDIC?["shrphone"] as? String)!
        
        //城市
        let cityStr = (selectDIC?["city"] as? String)!
        
        //省份
        let provinceStr = (selectDIC?["province"] as? String)!
        
        //地区
        let areaStr = (selectDIC?["area"] as? String)!
        
        globalArea = provinceStr + cityStr + areaStr
        
        globalDetailArea = (selectDIC?["street"] as? String)!
        
        diccccc = ["adrid" : globalAdrs,"name" : globalAddName,"tel" : globalAddTel,"area" : globalArea,"address" :globalDetailArea]
        
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "addressSet"), object: self, userInfo: diccccc as? [AnyHashable : Any])
        
        DetailAddModel.shared.setDefaultAdd(index: selectIndex!) { (array) in
            //返回yes在执行，重新获取数据，刷新表格
            if array == "yes" {
                //获取收获地址列表
                DetailAddModel.shared.getDetailAddress { (addressData) in
                    if addressData.count != 0 {
                        //找到默认的位置，重新排序数组的值
                        for i in 0..<addressData.count {
                            
                            let dic : NSDictionary = (addressData[i] as? NSDictionary)!
                            
                            for (_,k) in dic {
                                
                                let str : String = k as! String
                                
                                if str == "1" {
                                    addressData.exchangeObject(at: 0, withObjectAt: i)
                                    
                                    self.array = addressData
                                    
                                    ///真实数据
                                    localSave.set(self.array, forKey: addressArray)
                                    
                                    localSave.synchronize()
                                    
                                    //2.设置表格
                                    self.setUI()
                                
                                } else if str != "1" {
                                    self.array = addressData

                                    ///真实数据
                                    localSave.set(self.array, forKey: addressArray)
                                    
                                    localSave.synchronize()
                                    
                                    if self.tableView.bounds.width == 0 {
                                        
                                        //2.设置表格
                                        self.setUI()
                                    } else {
                                        self.tableView.reloadData()
                                    }
                                }
                            }
                        }
                        
                    } else {
                        if self.array.count == 0 {
//                            self.setNoneAddVC()
                        }
                    }
                }
            } else {}
        }
        
        //根据全局进行控制导航栏跳转的控制器
        if _symbolForH5chosssedef == "true" {

            let allVC = self.navigationController?.viewControllers

            let inventoryListVC = allVC![allVC!.count - 2]
            ///NineReplaceView,ShoppingViewController.swift
            
            if (inventoryListVC.isKind(of: ShoppingViewController.self)) ||
                (inventoryListVC.isKind(of: MainPageViewController.self)) ||
                (inventoryListVC.isKind(of: CategoryVC.self)) ||
                (inventoryListVC.isKind(of: YHJMainVC.self)) ||
                (inventoryListVC.isKind(of: ShoppingViewController.self)) {
                self.navigationController!.popToViewController(inventoryListVC, animated: true)
            }
            
            _symbolForH5chosssedef = "false"

        } else {}
    
    }
}



// MARK:- 没有收获地址的界面
extension DetailAddressVC {
    func setNoneAddVC() -> Void {
        
        self.tableView.removeFromSuperview()
        
        noneAddView = UIView.init(frame: CGRect.init(x: 0, y: 64, width: SW, height: SH - 64))
        view.addSubview(noneAddView)

        ///设置背景颜色
        self.tableView.separatorStyle = .none
        self.view.backgroundColor = commonBgColor
        
        let imgeView = UIImageView.init(frame: self.view.bounds)
        
        imgeView.frame = CGRect(x: SW * 0.1, y: SW * 0.1, width: SW * 0.28, height: SH * 0.35)
        imgeView.contentMode = .scaleAspectFit
        imgeView.image = UIImage.init(named: "addressShow")
        
        self.view.addSubview(imgeView)
        
        ///暂无收货地址label
        let perLab = UILabel()
        
        perLab.frame = CGRect(x: imgeView.RightX + 10, y: imgeView.frame.size.height * 0.55, width: SW - imgeView.Width - 30, height: 20)
        perLab.text = "暂无收获地址"
        perLab.font = UIFont.boldSystemFont(ofSize: 13 * screenScale)
        
        self.view.addSubview(perLab)
        
        
        ///点击提示按钮
        let alertLab = UILabel()
        alertLab.frame = CGRect(x: imgeView.RightX + 10, y: perLab.BottomY + 5, width: SW - imgeView.Width - 30, height: 20)
        alertLab.font = UIFont.boldSystemFont(ofSize: 13 * screenScale)
        alertLab.text = "赶紧去点击右上角的+添加吧~~"
        
        self.view.addSubview(alertLab)
    }
    
}

extension DetailAddressVC {
    fileprivate func setdataAndUI() -> Void {
        ///edgesForExtendedLayout------见网页链接
        self.edgesForExtendedLayout = UIRectEdge()
        
        
        ///获取收获地址列表
        DetailAddModel.shared.getDetailAddress { (addressData) in
            
            if addressData.count != 0 {
                
                ///删除没有的视图
                
                self.noneAddView.removeFromSuperview()
                
                //找到默认的位置，重新排序数组的值
                for i in 0..<addressData.count {
                    
                    let dic : NSDictionary = (addressData[i] as? NSDictionary)!
                    
                    for (_,k) in dic {
                        
                        let str : String = k as! String
                        
                        if str == "1" {
                            addressData.exchangeObject(at: 0, withObjectAt: i)
                            
                            self.array = addressData
                            
                            
                            ///真实数据
                            localSave.set(self.array, forKey: addressArray)
                            
                            localSave.synchronize()
                            
                            if self.tableView.bounds.width == 0 {
                                
                                //2.设置表格
                                self.setUI()
                            } else {
                                self.tableView.reloadData()
                            }
                            
                        
                        } else if str != "1" {
                            self.array = addressData
                            
                            
                            ///真实数据
                            localSave.set(self.array, forKey: addressArray)
                            
                            localSave.synchronize()
                            
                            if self.tableView.bounds.width == 0 {
                                
                                //2.设置表格
                                self.setUI()
                            } else {
                                self.tableView.reloadData()
                            }
                        }
                    }
                }
                
            } else if addressData.count == 0 {
                self.dataZero()
            }
        }
        
        //导航栏不隐藏
        self.navigationController?.navigationBar.isHidden = false
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
        
        //右手手势滑动关闭
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        view.backgroundColor = commonBgColor
    }
}
