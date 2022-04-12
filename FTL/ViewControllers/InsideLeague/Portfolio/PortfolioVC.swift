//
//  PortfolioVC.swift
//  FTL
//
//  Created by Varun Kumar Raghav on 04/04/22.
//

import UIKit

enum Portfolio: String {
    case holdings = "HOLDINGS"
    case orders = "ORDERS"
    case pendingOrders = "PENDING ORDERS"
}

class PortfolioVC: UIViewController {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet var collectionView: UICollectionView!
    
    var selectedVCtag: Int?
    var isInTheSideBarMenu = false
    var containerWidth = UIScreen.main.bounds.width
    var leaguetype: LeagueModes = .stocks
    var portfolioVCs: [Portfolio] = [.holdings, .orders, .pendingOrders]
    var selectedPortfolio: Portfolio = .holdings
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // self.initialMethod()
        self.loadInitialVC()
        self.collectionViewSetup()
    }
    
    //MARK: - initialSetup
    func collectionViewSetup() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(LeagueTypeBtnCell.createCellNib(), forCellWithReuseIdentifier: LeagueTypeBtnCell.cellIdentifier())
    }
    
    func loadInitialVC() {
        selectedVCtag = 100
        let holdingsVC = HoldingsVC()
        holdingsVC.leagueType = self.leaguetype
        addViewController(holdingsVC)
    }
    func addViewController(_ childController: UIViewController) {
        removeViewController()
        let navController = UINavigationController(rootViewController: childController)
        navController.setNavigationBarHidden(true, animated: false)
        addChild(navController)
        let frame = CGRect(x: 0, y: 0, width: containerWidth, height: containerView.frame.height)
        navController.view.frame = frame
        containerView.setSubviewOnTheView(navController.view)
        navController.didMove(toParent: self)
    }
    func removeViewController() {
        for viewController in self.containerView.subviews {
            viewController.removeFromSuperview()
        }
    }
    func initialMethod() {
        self.view.backgroundColor = bgBlue
    }
    //MARK: - action and selector methods
    func showVCType(portfolio: Portfolio) {
        switch portfolio {
        case .holdings:
            let vc = HoldingsVC()
            vc.leagueType = self.leaguetype
            self.addViewController(vc)
        case .pendingOrders:
            let vc = OrderVC()
            vc.datacount = 0
            vc.leagueType = self.leaguetype
            self.addViewController(vc)
        case .orders:
            let vc = OrderVC()
            vc.leagueType = self.leaguetype
            self.addViewController(vc)
        }
        selectedPortfolio = portfolio
        self.collectionView.reloadData()
    }
}

//MARK: - collectionView delegate and datasource
extension PortfolioVC: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return portfolioVCs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel(frame: CGRect.zero)
        label.font = regularFont
        label.text = portfolioVCs[indexPath.item].rawValue
        label.sizeToFit()
        return CGSize(width: label.frame.width+5, height: 28)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: LeagueTypeBtnCell.cellIdentifier(), for: indexPath) as! LeagueTypeBtnCell
        let vcType = portfolioVCs[indexPath.row]
        cell.leagueTitleLbl.text = vcType.rawValue
        cell.btnTapped = {
            self.showVCType(portfolio: vcType)
        }
        if selectedPortfolio == vcType {
            cell.leagueBtn.backgroundColor = black1
            cell.leagueTitleLbl.textColor = .white
            cell.leagueBtn.isEnabled = false
        } else {
            cell.leagueBtn.backgroundColor = bgBlue3
            cell.leagueTitleLbl.textColor = black1
            cell.leagueBtn.isEnabled = true
        }
        return cell
    }
}
