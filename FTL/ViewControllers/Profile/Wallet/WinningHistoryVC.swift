//
//  WinningHistoryVC.swift
//  FTL
//
//  Created by amit toroi on 25/03/22.
//

import UIKit
import Loaf
import SwiftyJSON
import MBProgressHUD

class WinningHistoryVC: UIViewController, UITableViewDelegate {

    @IBOutlet var winningHistoryTable: UITableView!
    
    var winningArr = [WinningHoistoryModel]()
    
    //MARK: Lifecycle Method
    override func viewDidLoad() {
        super.viewDidLoad()

        winningHistoryTable.register(UINib(nibName: "WinningHistoryCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        winningHistoryTable.delegate = self
        winningHistoryTable.dataSource = self
        
        getWalletTransactions()
        
        
       
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        winningHistoryTable.layer.cornerRadius = 24
        winningHistoryTable.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        winningHistoryTable.backgroundColor = .white
        self.winningHistoryTable.separatorColor = UIColor.clear
    }
    
    
    //MARK: - action and selector methods
    func convertISO(isoTime:String) -> String{
//        let inputDate = "2020-08-22T18:55:36Z"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: isoTime) ?? Date()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeZone = .current
        let localDate = dateFormatter.string(from: date)
//        cell.lblWithdrawDate.text = localDate
        return localDate
    }
    
    
    @IBAction func btnBackAct(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

//MARK: - tableView delegate and datasource
extension WinningHistoryVC:UITableViewDataSource, UITextFieldDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return winningArr.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = winningHistoryTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WinningHistoryCell
        let obj:WinningHoistoryModel = winningArr[indexPath.row]
        cell.transactionName.text = obj.desc
        if obj.transactionType == "Dr"{
            cell.lblAmount.text = "- \u{20b9} \(obj.amount)"
        }else{
            cell.lblAmount.text = "\u{20b9} \(obj.amount)"
        }
        
        cell.transactionDate.text = self.convertISO(isoTime:obj.createdAt)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
}


//MARK: API intigration
extension WinningHistoryVC{
    func getWalletTransactions(){
    if Connectivity.isConnectedToInternet(){
        let userId = UserDefaults.standard.value(forKey: "userId") as! String
    let url = Api_Constants.baseUrl + Api_Constants.getWalletTransactions+"?userId="+"\(userId)&walletType=Winning"
        MBProgressHUD.showAdded(to: self.view, animated: true)
    ApiManager.getWalletTransaction(url: url) {(response: JSON?, error:Error?, statusCode: Int) in
        if let error = error{
            MBProgressHUD.hide(for: self.view, animated: true)
            return
        }
        if let response = response{
            print(response)
            if response["status"] == true{
                MBProgressHUD.hide(for: self.view, animated: true)
                let x = response["data"]["transactions"]
                if x.count == 0{
                    self.winningHistoryTable.isHidden = true
                }else{
                for i in 0...x.count-1{
                    let obj:WinningHoistoryModel = WinningHoistoryModel.winningHistoryDataModel(dataArray: x[i])
                    self.winningArr.append(obj)
                }
                }
                self.winningHistoryTable.reloadData()
            }
        }else{
            MBProgressHUD.hide(for: self.view, animated: true)
            Loaf("Not able to get amount", state: .custom(.init(backgroundColor: UIColor(red: 255/255, green: 235/255, blue: 204/255, alpha: 1),textColor: .red, icon:UIImage(named: "errorIcon") ,width: .screenPercentage(0.8))), sender: self).show(.custom(1.5))
        }
    }
    }else{
        MBProgressHUD.hide(for: self.view, animated: true)
        Loaf("Active internet connection required", state: .custom(.init(backgroundColor: UIColor(red: 255/255, green: 235/255, blue: 204/255, alpha: 1),textColor: .red, icon:UIImage(named: "errorIcon") ,width: .screenPercentage(0.9))), sender: self).show(.custom(1.5))
    }
}
}
