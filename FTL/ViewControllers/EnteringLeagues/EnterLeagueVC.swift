//
//  EnterLeagueVC.swift
//  FTL
//
//  Created by Varun Kumar Raghav on 29/03/22.
//

import UIKit

enum LeagueDetails: String {
    case prizeBreakup = "Prize breakup"
    case rules = "Rules"
    case leaderBoard = "Leaderboard"
}

class EnterLeagueVC: UIViewController {
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var backBtnImg: UIImageView!
    @IBOutlet weak var titleLblLeadingContraint: NSLayoutConstraint!
    
    
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var bottomView: MYGradientView!
    
    @IBOutlet weak var leagueModeLbl: UILabel!
    @IBOutlet weak var freqLbl: UILabel!
    @IBOutlet weak var leagueModeView: UIView!
    @IBOutlet weak var freqView: UIView!
    
    @IBOutlet weak var prizePoolLbl: UILabel!
    @IBOutlet weak var prizeLbl: UILabel!
    @IBOutlet weak var startTimeLbl: UILabel!
    
    @IBOutlet weak var balanceLbl: UILabel!
    @IBOutlet weak var enterBtn: UIButton!
    
    
    var isInTheSideBarMenu = false
    var menuType: MenuType = .bottomMenu
    
    
    var containerWidth = UIScreen.main.bounds.width
    
    var pageMenu : CAPSPageMenu?
    
    var titleArray:[LeagueDetails] = [.prizeBreakup, .rules, .leaderBoard]
    
    //var leaguesArray: [LeagueModes] = [.crypto, .stocks]
    var selectedLeague: LeagueModes = .stocks
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialMethod()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if menuType == .sideMenu {
            self.bottomView.isHidden = true
            self.backBtn.isHidden = true
            self.backBtnImg.isHidden = true
            self.titleLblLeadingContraint.constant = 18
        }
        self.initialSetup()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    //MARK: - initialSetup
    
    func initialSetup() {
        self.view.backgroundColor = bgBlue
        self.leagueModeLbl.text = selectedLeague.rawValue
        
        if self.selectedLeague == .crypto {
            self.titleLbl.text = "Crypto League"
            leagueModeLbl.textColor = cryptoStatusDark
            leagueModeView.backgroundColor = cryptoStatusLight
            freqLbl.textColor = cryptoStatusDark
            freqView.backgroundColor = cryptoStatusLight
        } else {
            self.titleLbl.text = "Stock League"
            leagueModeLbl.textColor = stockStatusDark
            leagueModeView.backgroundColor = stockStatusLight
            freqLbl.textColor = stockStatusDark
            freqView.backgroundColor = stockStatusLight
        }
        
    }
    
    func initialMethod() {
        var controllerArray : [UIViewController] = []
        for title in titleArray {
            var vc = UIViewController()
            switch title {
            case .prizeBreakup:
                vc = PrizebreakupVC()
            case .leaderBoard:
                vc = LeaderBoardVC()
            case .rules:
                vc = RulesVC()
            }
            vc.title = title.rawValue
            controllerArray.append(vc)
        }
        let parameters: [CAPSPageMenuOption] = [
            //.menuItemWidth(screenWidth/5),
            .scrollMenuBackgroundColor(UIColor.clear),
            .selectedMenuItemLabelColor(UIColor.black),
            .unselectedMenuItemLabelColor(UIColor.gray),
            .bottomMenuHairlineColor(UIColor.clear),
            .viewBackgroundColor(UIColor.clear),
            .selectionIndicatorColor(UIColor.black),
            .menuItemFont(UIFont.init(name: "Poppins-Regular", size: 12)!),
            .menuItemWidthBasedOnTitleTextWidth(true),
            .menuMargin(20),
            .menuHeight(30)
            
        ]
        if menuType == .sideMenu {
            pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x: 0.0, y: 0.0, width: containerWidth, height: self.contentView.frame.height), pageMenuOptions: parameters)
        } else {
            pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x: 0.0, y: 0.0, width: containerWidth, height: self.contentView.frame.height), pageMenuOptions: parameters)
        }
        self.contentView.setSubviewOnTheView(pageMenu!.view)
        //  self.contentView.addSubview(pageMenu!.view)
    }
    //MARK: - action methods
    @IBAction func backBtnAction(sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func enterBtnAction(sender: UIButton){
        let vc = Sidebar()
        vc.leaguetype = selectedLeague
        self.navigationController?.pushViewController(vc, animated: true)
        //        FTLAppDelegate.navigationController.pushViewController(Sidebar(), animated: true)
    }
}
