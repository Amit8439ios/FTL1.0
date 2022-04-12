//
//  SearchingVC.swift
//  FTL
//
//  Created by Varun Kumar Raghav on 31/03/22.
//

import UIKit

class SearchingVC: BaseController {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchTextField: UITextField!
    
    var leagueType: LeagueModes = .stocks
    
    var stocks = [StockModel]()
    var searchStocks = [StockModel]()
    
    var cryptos = [CryptoModel]()
    var searchCryptos = [CryptoModel]()
    
    
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
            for item in stocks {
                searchStocks.append(item)
            }
        } else {
            let crypto1 = CryptoModel(title: "Ethereum", subtitle: "ETH", cryptoPrice: 710.00, statusPercent: 20.12)
            let crypto2 = CryptoModel(title: "Neiuera", subtitle: "NRS", cryptoPrice: 230.30, statusPercent: 13.00)
            let crypto3 = CryptoModel(title: "Bitcoin", subtitle: "BIT", cryptoPrice: 45.00, statusPercent: 15.01)
            cryptos.append(crypto1)
            cryptos.append(crypto2)
            cryptos.append(crypto3)
            for item in cryptos {
                searchCryptos.append(item)
            }
        }
        
    }
    
    func initialMethod() {
        self.searchTextField.delegate = self
        self.initializeHideKeyboard()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.register(WatchListCell.createCellNib(), forCellReuseIdentifier: WatchListCell.cellIdentifier())
        
        self.tableView.register(HeaderTitleCell.createCellNib(), forCellReuseIdentifier: HeaderTitleCell.cellIdentifier())
    }
    // MARK: - action and selector methods
    
    @IBAction func backBtnAction(sender: UIButton) {
        self.view.endEditing(true)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func searchBtnAction(sender: UIButton) {
        self.view.endEditing(true)
    }
    
}
// MARK: - tableView Delegate and datasource
extension SearchingVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if leagueType == .stocks {
            return searchStocks.count
        } else {
            return searchCryptos.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headercell = self.tableView.dequeueReusableCell(withIdentifier: HeaderTitleCell.cellIdentifier()) as! HeaderTitleCell
        headercell.titleLbl.text = "TOP PICKS"
        return headercell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: WatchListCell.cellIdentifier()) as? WatchListCell else { return UITableViewCell() }
        
        if leagueType == .stocks {
            let stockObj = stocks[indexPath.row]
            cell.titileLbl.text = stockObj.title
            cell.subtitleLbl.text = stockObj.subtitle
            cell.priceLbl.text = stockObj.stockPrice.withCommas()
            cell.statusLbl.text = String(stockObj.statusPercent)
            cell.starBtnTap = {
                if !stockObj.isSelected {
                    stockObj.isSelected = true
                    cell.starImg.image = starDark
                } else {
                    stockObj.isSelected = false
                    cell.starImg.image = starWhite
                }
            }
        } else {
            let cryptoObj = cryptos[indexPath.row]
            cell.titileLbl.text = cryptoObj.title
            cell.subtitleLbl.text = cryptoObj.subtitle
            cell.priceLbl.text = cryptoObj.cryptoPrice.withCommas()
            cell.statusLbl.text = String(cryptoObj.statusPercent)
            cell.starBtnTap = {
                if !cryptoObj.isSelected {
                    cryptoObj.isSelected = true
                    cell.starImg.image = starDark
                } else {
                    cryptoObj.isSelected = false
                    cell.starImg.image = starWhite
                }
            }
        }
        return cell
    }
    
}
//MARK: - textfield delegate methods
extension SearchingVC: UITextFieldDelegate {
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        self.searchTextField.resignFirstResponder()
        self.searchTextField.text = ""
        if leagueType == .stocks {
            searchStocks.removeAll()
            for item in stocks {
                searchStocks.append(item)
            }
        } else {
            searchCryptos.removeAll()
            for item in cryptos {
                searchCryptos.append(item)
            }
        }
        self.tableView.reloadData()
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if self.searchTextField.text?.count != 0 {
            if leagueType == .stocks {
                self.searchStocks.removeAll()
                for stock in stocks {
                    let range = stock.title.lowercased().range(of: textField.text!, options: .caseInsensitive, range: nil, locale: nil)
                    if range != nil {
                        self.searchStocks.append(stock)
                    }
                }
            } else {
                self.searchCryptos.removeAll()
                for crypto in cryptos {
                    let range = crypto.title.lowercased().range(of: textField.text!, options: .caseInsensitive, range: nil, locale: nil)
                    if range != nil {
                        self.searchCryptos.append(crypto)
                    }
                }
            }
            
        }
        self.tableView.reloadData()
        return true
    }
}
