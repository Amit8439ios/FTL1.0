//
//  LeaguesVC.swift
//  FTL
//
//  Created by Varun Kumar Raghav on 29/03/22.
//

import UIKit

enum LeagueModes: String {
    case crypto = "CRYPTO"
    case stocks = "STOCKS"
}
enum MenuType {
    case bottomMenu
    case sideMenu
}

class LeaguesVC: UIViewController {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet var collectionView: UICollectionView!
    
    var isInTheSideBarMenu = false
    var menuType: MenuType = .bottomMenu
    
    var containerWidth = UIScreen.main.bounds.width
    
    var pageMenu : CAPSPageMenu?
    
    var leaguesArray: [LeagueModes] = [.crypto, .stocks]
    var selectedLeague: LeagueModes = .crypto
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialMethod()
        self.collectionViewSetup()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    //MARK: - initialSetup
    func collectionViewSetup() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(LeagueTypeBtnCell.createCellNib(), forCellWithReuseIdentifier: LeagueTypeBtnCell.cellIdentifier())
    }
    
    func initialMethod() {
        self.view.backgroundColor = bgBlue
        var controllerArray : [UIViewController] = []
        let titleArray = ["Hourly", "Daily", "Weekly"]
        for index in 0..<3 {
            let leagueListVC = LeagueListVC()
            leagueListVC.leagueType = selectedLeague
            leagueListVC.title = titleArray[index]
            controllerArray.append(leagueListVC)
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
        //self.contentView.addSubview(pageMenu!.view)
    }
    //MARK: - action and selector methods
    func showLeagueType(leagueType: LeagueModes) {
        selectedLeague = leagueType
        // self.contentView.willRemoveSubview(pageMenu!.view)
        self.pageMenu!.view.removeFromSuperview()
        self.initialMethod()
        self.collectionView.reloadData()
    }
}
//MARK: - collectionView delegate and datasource
extension LeaguesVC: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return leaguesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel(frame: CGRect.zero)
        label.font = regularFont
        label.text = leaguesArray[indexPath.item].rawValue
        label.sizeToFit()
        return CGSize(width: label.frame.width+5, height: 28)
    }
    
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    //        let size = CGSize(width: 96, height: 28)
    //        return size
    //    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: LeagueTypeBtnCell.cellIdentifier(), for: indexPath) as! LeagueTypeBtnCell
        let leagueType = leaguesArray[indexPath.row]
        cell.leagueTitleLbl.text = leagueType.rawValue
        // cell.leagueBtn.setTitle(leagueType.rawValue, for: .normal)
        cell.btnTapped = {
            self.showLeagueType(leagueType: leagueType)
        }
        if selectedLeague == leagueType {
            cell.leagueBtn.backgroundColor = black1
            cell.leagueTitleLbl.textColor = .white
            // cell.leagueBtn.setTitleColor(.white, for: .normal)
            cell.leagueBtn.isEnabled = false
        } else {
            cell.leagueBtn.backgroundColor = bgBlue3
            cell.leagueTitleLbl.textColor = black1
            cell.leagueBtn.setTitleColor(black1, for: .normal)
            cell.leagueBtn.isEnabled = true
        }
        return cell
    }
    
}
