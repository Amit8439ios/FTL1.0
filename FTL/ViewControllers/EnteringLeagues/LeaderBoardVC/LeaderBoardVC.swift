//
//  LeaderBoardVC.swift
//  FTL
//
//  Created by Varun Kumar Raghav on 29/03/22.
//

import UIKit

class LeaderBoardVC: UIViewController {
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
        
        self.tableView.register(LeaderBoardCell.createCellNib(), forCellReuseIdentifier: LeaderBoardCell.cellIdentifier())
    }
    
}
// MARK: - tableView Delegate and datasource
extension LeaderBoardVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = self.tableView.dequeueReusableCell(withIdentifier: LeaderBoardCell.cellIdentifier()) as? LeaderBoardCell else { return nil }
        headerView.playerImg.isHidden = true
        headerView.rankLbl.textColor = grey
        headerView.portfolioLbl.textColor = grey
        headerView.playerLbl.textColor = grey
        headerView.playerLeadingConstraint.constant = 20.0
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
        return 50
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: LeaderBoardCell.cellIdentifier()) as? LeaderBoardCell else { return UITableViewCell() }
        
        cell.rankLbl.text = String(indexPath.row+1)
        cell.portfolioLbl.text = "4,25,000"
        cell.playerLbl.text = "Barkha Singh"
        return cell
    }
    
}
