//
//  LeagueListVC.swift
//  FTL
//
//  Created by Varun Kumar Raghav on 23/03/22.
//

import UIKit

class LeagueListVC: UIViewController {
    @IBOutlet var tableView: UITableView!
    var leagueType: LeagueModes = .crypto
    var walletBalance = 50
    var cryptoLeagueFees = [50,100,50]
    var stockLeagueFees = [50,100,50]

    
 //MARK: - lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialMethod()
    }
//MARK: - initial setup Methods
    func initialMethod() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.register(LeagueCell.createCellNib(), forCellReuseIdentifier: LeagueCell.cellIdentifier())
        
        self.tableView.register(HeaderTitleCell.createCellNib(), forCellReuseIdentifier: HeaderTitleCell.cellIdentifier())
        
        self.tableView.register(SuperLeagueCell.createCellNib(), forCellReuseIdentifier: SuperLeagueCell.cellIdentifier())
        
    }

}
// MARK: - tableView Delegate and datasource
extension LeagueListVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = self.tableView.dequeueReusableCell(withIdentifier: HeaderTitleCell.cellIdentifier()) as? HeaderTitleCell else { return nil }
        headerView.titleLbl.text = "ONGOING LEAGUES"
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: LeagueCell.cellIdentifier()) as? LeagueCell else { return UITableViewCell() }
        
        guard let superCell = self.tableView.dequeueReusableCell(withIdentifier: SuperLeagueCell.cellIdentifier()) as? SuperLeagueCell else {
            return UITableViewCell()
        }
        let cryptoFee = cryptoLeagueFees[indexPath.row]
        let stockFee = stockLeagueFees[indexPath.row]
        
        cell.entryBtnTap = {
            if self.walletBalance >= stockFee {
                let vc = EnterLeagueVC()
                vc.selectedLeague = self.leagueType
                FTLAppDelegate.navigationController.pushViewController(vc, animated: true)
            } else {
                let alertVC = LowBalanceAlertVC()
                alertVC.modalPresentationStyle = .overCurrentContext
                alertVC.modalTransitionStyle = .crossDissolve
                FTLAppDelegate.navigationController.present(alertVC, animated: true, completion: nil)
            }
            
        }
        superCell.entryBtnTap = {
            if self.walletBalance >= cryptoFee {
                let vc = EnterLeagueVC()
                vc.selectedLeague = self.leagueType
                FTLAppDelegate.navigationController.pushViewController(vc, animated: true)
            } else {
                let alertVC = LowBalanceAlertVC()
                alertVC.modalPresentationStyle = .overCurrentContext
                alertVC.modalTransitionStyle = .crossDissolve
                FTLAppDelegate.navigationController.present(alertVC, animated: true, completion: nil)
            }
        }
        if leagueType == .stocks {
            cell.amountLbl.text = "₹"+String(stockFee)
            if indexPath.row == 1 {
                cell.statusView.backgroundColor = goldLight
                cell.statusLbl.text = "ENTRY CLOSED"
                cell.statusImg.isHidden = true
                cell.statuslabelLeadingConstraint.constant = 8.0
            }
            if indexPath.row == 0 {
                cell.titleLBL.text = "INDIA STOCKS"
                cell.titleView.backgroundColor = goldLight
                cell.titleLBL.textColor = gold
                cell.statusView.backgroundColor = goldLight
                cell.statusLbl.text = "CLOSES IN 04.25"
            }
            return cell
        } //else if leagueType == .crypto {
        else {
            cell.titleLBL.text = "CRYPTO"
            cell.amountLbl.text = "₹"+String(cryptoFee)
            if indexPath.row == 1 {
                cell.statusView.backgroundColor = goldLight
                cell.statusLbl.text = "ENTRY CLOSED"
                cell.statusImg.isHidden = true
                cell.statuslabelLeadingConstraint.constant = 8.0
            }
            if indexPath.row == 0 {
                cell.titleView.backgroundColor = goldLight
                cell.titleLBL.textColor = gold
                cell.statusView.backgroundColor = goldLight
                cell.statusLbl.text = "CLOSES IN 04.25"
            }
            if indexPath.row == 2 {
                superCell.amountLbl.text = "₹"+String(cryptoFee)
                superCell.leagueStatusLbl.text = "SUPERLEAGUE"
                superCell.statusLbl.text = "FILLING FAST"
                return superCell
            } else {
                return cell
            }
        }
    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        FTLAppDelegate.navigationController.popViewController(animated: true)
//    }
    
}

