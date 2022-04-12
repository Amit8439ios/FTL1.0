//
//  Sidebar.swift
//  GoGuards
//
//  Created by Varun Kumar Raghav on 21/12/21.
//

import UIKit

class Sidebar: UIViewController {
    
    @IBOutlet var marketLbl: CustomRotateLabel!
    @IBOutlet var marketBtn: UIButton!
    
    @IBOutlet var watchlistLbl: CustomRotateLabel!
    @IBOutlet var watchlistBtn: UIButton!
    
    @IBOutlet var portfolioLbl: CustomRotateLabel!
    @IBOutlet var portfolioBtn: UIButton!
    
    
    @IBOutlet var leaderBoardLbl: CustomRotateLabel!
    @IBOutlet var leaderBoardBtn: UIButton!
    
    @IBOutlet var leagueDetailsLbl: CustomRotateLabel!
    @IBOutlet var leagueDetailsBtn: UIButton!
    
    @IBOutlet var containerView: UIView!
    //    @IBOutlet var tabBgImg: UIImageView!
    let containerWidth = UIScreen.main.bounds.width-50
    
    var leaguetype: LeagueModes = .stocks
    
    let selectedColor = black1
    var selectedVCtag: Int?
    //
    //MARK: - lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialMethod()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadInitialVC()
    }
    
    //MARK: - initial setup Methods
    
    func initialMethod() {
        self.loadInitialVC()
    }
    
    func loadInitialVC() {
        selectedVCtag = 100
        self.changeColorToInitialState()
        let marketVC = MarketVC()
        marketVC.selectedLeague = self.leaguetype
        marketVC.menuType = .sideMenu
        marketVC.containerWidth = containerWidth
        changeButtonImage(title: marketLbl)
        addViewController(marketVC)
    }
    
    func addViewController(_ childController: UIViewController) {
        removeViewController()
        let navController = UINavigationController(rootViewController: childController)
        navController.setNavigationBarHidden(true, animated: false)
        addChild(navController)
        let frame = CGRect(x: 0, y: 0, width: containerWidth, height: containerView.frame.height)
        navController.view.frame = frame
        containerView.setSubviewOnTheView(navController.view)
        // containerView.addSubview(navController.view)
        navController.didMove(toParent: self)
    }
    
    func removeViewController() {
        for viewController in self.containerView.subviews {
            viewController.removeFromSuperview()
        }
    }
    
    func changeButtonImage(title: CustomRotateLabel) {
        //        UIView.animate(withDuration: 0.2,
        //                       animations: {
        //            title.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        //        },
        //                       completion: { _ in
        //            UIView.animate(withDuration: 0.2) {
        //                title.transform = CGAffineTransform.identity
        //            }
        //        })
        title.textColor = selectedColor
        title.font = mediumFont
    }
    func changeColorToInitialState () {
        marketLbl.textColor = .darkGray
        marketLbl.font = regularFont
        watchlistLbl.textColor = .darkGray
        watchlistLbl.font = regularFont
        portfolioLbl.textColor = .darkGray
        portfolioLbl.font = regularFont
        leaderBoardLbl.textColor = .darkGray
        leaderBoardLbl.font = regularFont
        leagueDetailsLbl.textColor = .darkGray
        leagueDetailsLbl.font = regularFont
        
    }
    //MARK: - action Methods
    @IBAction func tabButtonAction(_ sender: UIButton) {
        self.changeColorToInitialState()
        switch sender.tag {
        case 100:
            selectedVCtag = 100
            changeButtonImage(title: marketLbl)
            let marketVC = MarketVC()
            marketVC.selectedLeague = self.leaguetype
            marketVC.menuType = .sideMenu
            marketVC.containerWidth = containerWidth
            addViewController(marketVC)
        case 101:
            selectedVCtag = 101
            changeButtonImage(title: watchlistLbl)
            let watchListVC = InsideWatchlistVC()
            watchListVC.leagueType = self.leaguetype
            addViewController(watchListVC)
        case 102:
            selectedVCtag = 102
            changeButtonImage(title: portfolioLbl)
            let portfolioVC = PortfolioVC()
            portfolioVC.leaguetype = self.leaguetype
            // watchlistVC.menuType = .sideMenu
            portfolioVC.containerWidth = containerWidth
            addViewController(portfolioVC)
        case 103:
            selectedVCtag = 103
            changeButtonImage(title: leaderBoardLbl)
            let leaderBoardVC = InsiderLeaderBoardVC()
            // leaderBoardVC.menuType = .sideMenu
            //  leaderBoardVC.containerWidth = containerWidth
            addViewController(leaderBoardVC)
        case 104:
            selectedVCtag = 103
            changeButtonImage(title: leagueDetailsLbl)
            let leagueDetailsVC = EnterLeagueVC()
            leagueDetailsVC.titleArray = [.prizeBreakup, .rules]
            leagueDetailsVC.selectedLeague = self.leaguetype
            leagueDetailsVC.menuType = .sideMenu
            leagueDetailsVC.containerWidth = containerWidth
            addViewController(leagueDetailsVC)
        default:
            break
        }
    }
    
    @IBAction func backBtnAction(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
}

// MARK: - RotationView

@IBDesignable
class CustomRotationView: UIView {
    @IBInspectable var rotation: Double = 0 {
        didSet {
            rotateView(rotation: rotation)
        }
    }
    func rotateView(rotation: Double)  {
        self.transform = CGAffineTransform(rotationAngle: CGFloat(.pi/2 + rotation))
    }
}

@IBDesignable
class CustomRotateButton: UIButton {
    @IBInspectable var rotation: Double = 0 {
        didSet {
            rotateButton(rotation: rotation)
        }
    }
    func rotateButton(rotation: Double)  {
        self.transform = CGAffineTransform(rotationAngle: CGFloat(.pi/2 + rotation))
    }
}
@IBDesignable
class CustomRotateLabel: UILabel {
    @IBInspectable var rotation: CGFloat = 0 {
        didSet {
            rotateLabel(radians: CGFloat.pi*rotation/180)
        }
    }
    func rotateLabel(radians: CGFloat)  {
        self.transform = CGAffineTransform(rotationAngle: radians)
    }
}
@IBDesignable
class CustomRotateImage: UIImageView {
    @IBInspectable var rotation: Double = 0 {
        didSet {
            rotateImage(rotation: rotation)
        }
    }
    func rotateImage(rotation: Double)  {
        self.transform = CGAffineTransform(rotationAngle: CGFloat(.pi/2 + rotation))
    }
}

