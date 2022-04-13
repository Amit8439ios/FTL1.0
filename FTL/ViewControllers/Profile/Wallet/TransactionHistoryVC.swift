//
//  TransactionHistoryVC.swift
//  FTL
//
//  Created by amit toroi on 25/03/22.
//

import UIKit
import SwiftyJSON
import Loaf
import MBProgressHUD

class TransactionHistoryVC: UIViewController {

    var transactionArr = [TransactionHoistoryModel]()
    
    @IBOutlet var transactionHistoryTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

         transactionHistoryTable.register(UINib(nibName: "TransactionHistoryCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        transactionHistoryTable.delegate = self
        transactionHistoryTable.dataSource = self
        
        getWalletTransactions()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        transactionHistoryTable.layer.cornerRadius = 24
        transactionHistoryTable.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        transactionHistoryTable.backgroundColor = .white
        self.transactionHistoryTable.separatorColor = UIColor.clear
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
extension TransactionHistoryVC: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactionArr.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = transactionHistoryTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TransactionHistoryCell
        let obj:TransactionHoistoryModel = transactionArr[indexPath.row]
        cell.aboutTransaction.text = obj.desc
        if obj.transactionType == "Dr"{
            cell.lblTransactionAmount.text = "- \u{20b9} \(obj.amount)"
        }else{
            cell.lblTransactionAmount.text = "\u{20b9} \(obj.amount)"
        }
        
        cell.lbltransactionDate.text = convertISO(isoTime: obj.createdAt)
        
        return cell

    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}


//MARK: - API intigration
extension TransactionHistoryVC{
    func getWalletTransactions(){
    if Connectivity.isConnectedToInternet(){
        let userId = UserDefaults.standard.value(forKey: "userId") as! String
    let url = Api_Constants.baseUrl + Api_Constants.getWalletTransactions+"?userId="+"\(userId)&walletType=Main"
        MBProgressHUD.showAdded(to: self.view, animated: true)
    ApiManager.getWalletTransaction(url: url) {(response: JSON?, error:Error?, statusCode: Int) in
        if let error = error{
            MBProgressHUD.hide(for: self.view, animated: true)
            return
        }
        if let response = response{
//            print(response)
            MBProgressHUD.hide(for: self.view, animated: true)
            if response["status"] == true{
                let x = response["data"]["transactions"]
                if x.count == 0{
                    self.transactionHistoryTable.isHidden = true
                }else{
                for i in 0...x.count-1{
                    let obj:TransactionHoistoryModel = TransactionHoistoryModel.transactionHistoryDataModel(dataArray: x[i])
                    self.transactionArr.append(obj)
                }
                }
                self.transactionHistoryTable.reloadData()
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
