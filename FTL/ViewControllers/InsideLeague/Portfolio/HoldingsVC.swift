//
//  HoldingsVC.swift
//  FTL
//
//  Created by Varun Kumar Raghav on 04/04/22.
//

import UIKit

class HoldingsVC: UIViewController {
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var investmentLbl: UILabel!
    @IBOutlet var currentAmountLbl: UILabel!
    @IBOutlet var tradingCashLbl: UILabel!
    @IBOutlet var profitLossLbl: UILabel!
    @IBOutlet var currentStatusLbl: UILabel!
    @IBOutlet var currentStatusView: UIView!
    @IBOutlet var currentStatusImg: UIImageView!
    @IBOutlet var totalLbl: UILabel!
    @IBOutlet var noDataLbl: UILabel!
    @IBOutlet var noDataView: UIView!
    @IBOutlet var noDataDesc: UILabel!
    @IBOutlet var navView: UIView!
    @IBOutlet var containerView: UIView!
    
    var leagueType: LeagueModes = .crypto
    var stocks = [StockModel]()
    var cryptos = [CryptoModel]()
    
    //MARK: - lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // self.initialMethod()
        // self.loadStocksArray()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
            //  self.tableView.isHidden = false
            self.navView.isHidden = false
            self.containerView.isHidden = false
        } else {
            self.noDataView.isHidden = false
            self.containerView.isHidden = true
            //  self.tableView.isHidden = true
            self.navView.isHidden = true
            if leagueType == .stocks {
                noDataLbl.text = "You haven’t traded any stocks yet"
            } else {
                noDataLbl.text = "You haven’t traded any cryptos yet"
            }
        }
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.register(HoldingsCell.createCellNib(), forCellReuseIdentifier: HoldingsCell.cellIdentifier())
    }
    
}
// MARK: - tableView Delegate and datasource
extension HoldingsVC: UITableViewDelegate, UITableViewDataSource {
    
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
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: HoldingsCell.cellIdentifier()) as? HoldingsCell else { return UITableViewCell() }
        
        if leagueType == .stocks {
            let stockObj = stocks[indexPath.row]
            cell.titileLbl.text = stockObj.title
            cell.subtitleLbl.text = stockObj.subtitle
            cell.priceLbl.text = stockObj.stockPrice.withCommas()
            cell.statusLbl.text = String(stockObj.statusPercent)
        } else {
            let cryptoObj = cryptos[indexPath.row]
            cell.titileLbl.text = cryptoObj.title
            cell.subtitleLbl.text = cryptoObj.subtitle
            cell.priceLbl.text = cryptoObj.cryptoPrice.withCommas()
            cell.statusLbl.text = String(cryptoObj.statusPercent)
            
        }
        return cell
    }
    
}
