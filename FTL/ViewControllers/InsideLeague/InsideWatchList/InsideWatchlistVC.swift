//
//  InsideWatchlistVC.swift
//  FTL
//
//  Created by Varun Kumar Raghav on 02/04/22.
//

import UIKit

class InsideWatchlistVC: UIViewController {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var noDataView: UIView!
    
    
    var stocks = [StockModel]()
    var cryptos = [CryptoModel]()
    
    var datacount = 1
    var leagueType: LeagueModes = .stocks
    
    //MARK: - lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialMethod()
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
        
    }
    
    func initialMethod() {
        if datacount>0 {
            self.noDataView.isHidden = true
            self.tableView.isHidden = false
        } else {
            self.noDataView.isHidden = false
            self.tableView.isHidden = true
        }
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.register(InsideWatchlistCell.createCellNib(), forCellReuseIdentifier: InsideWatchlistCell.cellIdentifier())
    }
    
}
// MARK: - tableView Delegate and datasource
extension InsideWatchlistVC: UITableViewDelegate, UITableViewDataSource {
    
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
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: InsideWatchlistCell.cellIdentifier()) as? InsideWatchlistCell else { return UITableViewCell() }
        if leagueType == .stocks {
            let stockObj = stocks[indexPath.row]
            cell.titileLbl.text = stockObj.title
            cell.subtitleLbl.text = stockObj.subtitle
            cell.priceLbl.text = stockObj.stockPrice.withCommas()
            cell.statusLbl.text = String(stockObj.statusPercent)
            cell.starBtnTap = {
                self.stocks.remove(at: indexPath.row)
                self.tableView.reloadData()
            }
        } else {
            let cryptoObj = cryptos[indexPath.row]
            cell.titileLbl.text = cryptoObj.title
            cell.subtitleLbl.text = cryptoObj.subtitle
            cell.priceLbl.text = cryptoObj.cryptoPrice.withCommas()
            cell.statusLbl.text = String(cryptoObj.statusPercent)
            cell.starBtnTap = {
                self.cryptos.remove(at: indexPath.row)
                self.tableView.reloadData()
            }
        }
        
        return cell
    }
    
}
