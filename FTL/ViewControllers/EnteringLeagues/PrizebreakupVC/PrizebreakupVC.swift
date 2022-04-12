//
//  PrizebreakupVC.swift
//  FTL
//
//  Created by Varun Kumar Raghav on 29/03/22.
//

import UIKit

class PrizebreakupVC: UIViewController {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var noDataLbl: UILabel!
    var datacount = 10
    
    //MARK: - lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialMethod()
    }
    //MARK: - initial setup Methods
    func initialMethod() {
        if datacount>0 {
            self.noDataLbl.isHidden = true
            self.tableView.isHidden = false
        } else {
            self.noDataLbl.isHidden = false
            self.tableView.isHidden = true
        }
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.register(PrizebreakupCell.createCellNib(), forCellReuseIdentifier: PrizebreakupCell.cellIdentifier())
        
    }
    
    
}
// MARK: - tableView Delegate and datasource
extension PrizebreakupVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = self.tableView.dequeueReusableCell(withIdentifier: PrizebreakupCell.cellIdentifier()) as? PrizebreakupCell else { return nil }
        headerView.lineLbl.isHidden = true
        // headerView.rankLbl.font =  UIFont(name: "Popins-Regular", size: 10)
        // headerView.winningLbl.font =  UIFont(name: "Popins-Regular", size: 10)
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 110
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datacount
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: PrizebreakupCell.cellIdentifier()) as? PrizebreakupCell else { return UITableViewCell() }
        //        let font = UIFont(name: "Popins-Regular", size: 12)
        //        cell.rankLbl.font = font
        cell.rankLbl.textColor = black1
        //        cell.winningLbl.font = font
        cell.winningLbl.textColor = black1
        cell.rankLbl.text = String(indexPath.row+1)
        cell.winningLbl.text = "₹" + String((indexPath.row*520)+(1))
        return cell
    }
    
}
