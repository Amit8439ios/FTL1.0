//
//  OrderVC.swift
//  FTL
//
//  Created by Varun Kumar Raghav on 04/04/22.
//

import UIKit

class OrderVC: UIViewController {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var noDataLbl: UILabel!
    @IBOutlet var noDataView: UIView!
    @IBOutlet var noDataDesc: UILabel!
    
    var leagueType: LeagueModes = .crypto
    var stocks = [StockModel]()
    var cryptos = [CryptoModel]()
    var datacount = 1
    
    //MARK: - lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // self.initialMethod()
        // self.loadStocksArray()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //        self.initialMethod()
        self.loadStocksArray()
    }
    //MARK: - initial setup Methods
    func loadStocksArray() {
        if leagueType == .stocks {
            let stock1 = StockModel(title: "Reliance Industries", subtitle: "RELIANCE", stockPrice: 710.00, statusPercent: 20.12)
            let stock2 = StockModel(title: "Axis Bank", subtitle: "AXISBANK", stockPrice: 230.30, statusPercent: 13.00)
            let stock3 = StockModel(title: "Tata Steel", subtitle: "TATASTEEL", stockPrice: 45.00, statusPercent: 15.01)
            stocks.append(stock1)
            stocks.append(stock2)
            stocks.append(stock3)
        } else {
            let crypto1 = CryptoModel(title: "Ethereum", subtitle: "ETH", cryptoPrice: 710.00, statusPercent: 20.12)
            let crypto2 = CryptoModel(title: "Neiuera", subtitle: "NRS", cryptoPrice: 230.30, statusPercent: 13.00)
            let crypto3 = CryptoModel(title: "Bitcoin", subtitle: "BIT", cryptoPrice: 45.00, statusPercent: 15.01)
            cryptos.append(crypto1)
            cryptos.append(crypto2)
            cryptos.append(crypto3)
        }
        self.initialMethod()
    }
    
    func initialMethod() {
        if (stocks.count>0 || cryptos.count>0){
            self.noDataView.isHidden = true
            self.tableView.isHidden = false
        } else {
            self.noDataView.isHidden = false
            self.tableView.isHidden = true
            if leagueType == .stocks {
                noDataLbl.text = "You haven’t traded any stocks yet"
            } else {
                noDataLbl.text = "You haven’t traded any cryptos yet"
            }
        }
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.register(OrdersCell.createCellNib(), forCellReuseIdentifier: OrdersCell.cellIdentifier())
    }
    
}
// MARK: - tableView Delegate and datasource
extension OrderVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if leagueType == .stocks {
            return stocks.count
        } else {
            return cryptos.count
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: OrdersCell.cellIdentifier()) as? OrdersCell else { return UITableViewCell() }
        if leagueType == .stocks {
            let stockObj = stocks[indexPath.row]
            cell.titleLbl.text = stockObj.title
            cell.descLbl.text = stockObj.subtitle
            cell.amountLbl.text = stockObj.stockPrice.withCommas()
        } else {
            let cryptoObj = cryptos[indexPath.row]
            cell.titleLbl.text = cryptoObj.title
            cell.descLbl.text = cryptoObj.subtitle
            cell.amountLbl.text = cryptoObj.cryptoPrice.withCommas()
        }
        return cell
    }
    
}
