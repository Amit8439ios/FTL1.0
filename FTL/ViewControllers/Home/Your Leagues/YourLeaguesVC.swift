//
//  YourLeaguesVC.swift
//  FTL
//
//  Created by Varun Kumar Raghav on 25/03/22.
//

import UIKit

enum LeagueStatus {
    case ongoing
    case upcoming
    case previous
}

class YourLeaguesVC: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var ongoingBtn: UIButton!
    @IBOutlet var upcomingBtn: UIButton!
    @IBOutlet var previousBtn: UIButton!
    @IBOutlet var noDataView: UIView!
    @IBOutlet var bgImage: UIImageView!
    @IBOutlet var gotoLeagueBtn: UIButton!
    @IBOutlet var noLeagueDescrtiptionLbl: UILabel!
    
    var leagueStatus: LeagueStatus = .ongoing
    
    var ongoingLeagueCount = 0
    var upcomingLeagueCount = 2
    var previousLeagueCount = 3
    
    //MARK: - lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialMethod()
    }
    
    //MARK: - initial setup Methods
    func initialMethod() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.register(YourLeagueCell.createCellNib(), forCellReuseIdentifier: YourLeagueCell.cellIdentifier())
        
        self.tableView.register(PreviouLeagueCell.createCellNib(), forCellReuseIdentifier: PreviouLeagueCell.cellIdentifier())
        
        self.setupBtn(leagueStatus: leagueStatus)
        self.dataTest(leagueStatus: leagueStatus, and: ongoingLeagueCount)
    }
    
    //MARK: - to test whether data is available or not
    
    func dataTest(leagueStatus: LeagueStatus, and dataCount: Int){
        switch leagueStatus {
        case .ongoing:
            if ongoingLeagueCount==0{
                self.tableView.isHidden = true
                self.noDataView.isHidden = false
                self.noLeagueDescrtiptionLbl.text = "You haven't joined any ongoing leagues."
                self.gotoLeagueBtn.setTitle("SEE ONGOING LEAGUES", for: .normal)
                
                self.bgImage.image = UIImage(named: "whitebgcard")
            } else {
                noDataView.isHidden = true
                self.tableView.isHidden = false
                self.bgImage.image = UIImage(named: "homeTableBG")
            }
        case .upcoming:
            if upcomingLeagueCount==0{
                self.tableView.isHidden = true
                noDataView.isHidden = false
                self.noLeagueDescrtiptionLbl.text = "You haven't joined any upcoming leagues."
                self.gotoLeagueBtn.setTitle("SEE UPCOMING LEAGUES", for: .normal)
                self.bgImage.image = UIImage(named: "whitebgcard")
                
            } else {
                noDataView.isHidden = true
                self.tableView.isHidden = false
                self.bgImage.image = UIImage(named: "homeTableBG")
            }
        case .previous:
            if previousLeagueCount==0{
                self.tableView.isHidden = true
                noDataView.isHidden = false
                self.noLeagueDescrtiptionLbl.text = "You haven't joined any previous leagues."
                self.gotoLeagueBtn.setTitle("SEE PREVIOUS LEAGUES", for: .normal)
                self.bgImage.image = UIImage(named: "whitebgcard")
                
            } else {
                noDataView.isHidden = true
                self.tableView.isHidden = false
                self.bgImage.image = UIImage(named: "homeTableBG")
            }
        }
        self.tableView.reloadData()
    }
    
    //MARK: - action methods and selectors
    @IBAction func showLeagues(sender: UIButton) {
        switch sender.tag {
        case 100:
            leagueStatus = .ongoing
            setupBtn(leagueStatus: .ongoing)
            self.dataTest(leagueStatus: leagueStatus, and: self.ongoingLeagueCount)
        case 101:
            leagueStatus = .upcoming
            setupBtn(leagueStatus: .upcoming)
            self.dataTest(leagueStatus: leagueStatus, and: self.upcomingLeagueCount)
        case 102:
            leagueStatus = .previous
            setupBtn(leagueStatus: .previous)
            self.dataTest(leagueStatus: leagueStatus, and: previousLeagueCount)
        default:
            break
        }
    }
    
    @IBAction func gotoleaguesBtnAction(sender: UIButton) {
        
    }
    
}
// MARK: - tableView Delegate and datasource
extension YourLeaguesVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch leagueStatus {
        case .ongoing:
            return ongoingLeagueCount
        case .upcoming:
            return upcomingLeagueCount
        case .previous:
            return previousLeagueCount
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if leagueStatus == .previous {
            return 125
        } else {
            return 144
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch leagueStatus {
        case .ongoing:
            guard let cell = self.tableView.dequeueReusableCell(withIdentifier: YourLeagueCell.cellIdentifier()) as? YourLeagueCell else { return UITableViewCell() }
            cell.playBtnTap = {
                FTLAppDelegate.navigationController.pushViewController(EnterLeagueVC(), animated: true)
            }
            if indexPath.row == 0 {
                cell.freqencyLbl.text = "DAILY"
                cell.titleView.backgroundColor = goldLight
                cell.titleLBL.textColor = gold
                cell.statusView.backgroundColor = goldLight
                cell.statusLbl.text = "CLOSES IN 04.25"
            }
            if indexPath.row == 1 {
                cell.freqencyLbl.text = "MONTHLY"
                cell.statusView.backgroundColor = goldLight
                cell.statusLbl.text = "ENTRY CLOSED"
                cell.statusImg.isHidden = true
                cell.statuslabelLeadingConstraint.constant = 8.0
            }
            return cell
        case .upcoming:
            guard let cell = self.tableView.dequeueReusableCell(withIdentifier: YourLeagueCell.cellIdentifier()) as? YourLeagueCell else { return UITableViewCell() }
            cell.rankLbl.isHidden = true
            cell.rankTitleLbl.isHidden = true
            cell.playBtnTap = {
                FTLAppDelegate.navigationController.pushViewController(EnterLeagueVC(), animated: true)
            }
            if indexPath.row == 1 {
                cell.freqencyLbl.text = "MONTHLY"
                cell.statusView.backgroundColor = goldLight
                cell.statusLbl.text = "ENTRY CLOSED"
                cell.statusImg.isHidden = true
                cell.statuslabelLeadingConstraint.constant = 8.0
            }
            if indexPath.row == 0 {
                cell.freqencyLbl.text = "DAILY"
                cell.titleView.backgroundColor = goldLight
                cell.titleLBL.textColor = gold
                cell.statusView.backgroundColor = goldLight
                cell.statusLbl.text = "CLOSES IN 04.25"
            }
            return cell
        case .previous:
            guard let cell = self.tableView.dequeueReusableCell(withIdentifier: PreviouLeagueCell.cellIdentifier()) as? PreviouLeagueCell else { return UITableViewCell() }
            cell.rankLbl.text = "453454"
            if indexPath.row == 0 {
                cell.rankLbl.text = "1"
                cell.rankImg.isHidden = false
                cell.freqencyLbl.text = "DAILY"
            }
            return cell
        }
    }
    
}
//MARK: - other setup
extension YourLeaguesVC {
    func setupBtn(leagueStatus: LeagueStatus){
        switch leagueStatus {
        case .ongoing:
            self.ongoingBtn.backgroundColor = black1
            self.ongoingBtn.setTitleColor(.white, for: .normal)
            self.upcomingBtn.backgroundColor = bgBlue3
            self.upcomingBtn.setTitleColor(black1, for: .normal)
            self.previousBtn.backgroundColor = bgBlue3
            self.previousBtn.setTitleColor(black1, for: .normal)
        case .upcoming:
            self.ongoingBtn.backgroundColor = bgBlue3
            self.ongoingBtn.setTitleColor(black1, for: .normal)
            self.upcomingBtn.backgroundColor = black1
            self.upcomingBtn.setTitleColor(.white, for: .normal)
            self.previousBtn.backgroundColor = bgBlue3
            self.previousBtn.setTitleColor(black1, for: .normal)
        case .previous:
            self.ongoingBtn.backgroundColor = bgBlue3
            self.ongoingBtn.setTitleColor(black1, for: .normal)
            self.upcomingBtn.backgroundColor = bgBlue3
            self.upcomingBtn.setTitleColor(black1, for: .normal)
            self.previousBtn.backgroundColor = black1
            self.previousBtn.setTitleColor(.white, for: .normal)
        }
    }
}
