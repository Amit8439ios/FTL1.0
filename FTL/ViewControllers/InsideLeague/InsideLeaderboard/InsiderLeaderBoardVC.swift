//
//  InsiderLeaderBoardVC.swift
//  FTL
//
//  Created by Varun Kumar Raghav on 04/04/22.
//

import UIKit

class InsiderLeaderBoardVC: UIViewController {
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
extension InsiderLeaderBoardVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            guard let headerView = self.tableView.dequeueReusableCell(withIdentifier: LeaderBoardCell.cellIdentifier()) as? LeaderBoardCell else { return nil }
            headerView.playerImg.isHidden = true
            headerView.playerLeadingConstraint.constant = 20.0
            headerView.rankLbl.textColor = grey
            headerView.portfolioLbl.textColor = grey
            headerView.playerLbl.textColor = grey
            headerView.rankLbl.text = "RANK"
            headerView.portfolioLbl.text = "PORTFOLIO"
            headerView.playerLbl.text = "PLAYER"
            return headerView
        } else {
            return nil
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 20
        } else {
            return 0
        }
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 1{
            return 110
        } else {
            return 10
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return datacount
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: LeaderBoardCell.cellIdentifier()) as? LeaderBoardCell else { return UITableViewCell() }
        if indexPath.section == 0 {
            cell.rankLbl.text = String(15)
            cell.portfolioLbl.text = "1,25,000"
            cell.playerLbl.text = "You"
            cell.playerImg.image = UIImage(named: "you")
        } else {
            cell.rankLbl.text = String(indexPath.row+1)
            cell.portfolioLbl.text = "4,25,000"
            cell.playerLbl.text = "Barkha Singh"
        }
        return cell
    }
    
}
