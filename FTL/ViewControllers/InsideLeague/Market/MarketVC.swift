//
//  MarketVC.swift
//  FTL
//
//  Created by Varun Kumar Raghav on 31/03/22.
//

import UIKit

class MarketVC: UIViewController {
    @IBOutlet var titleLbl: UILabel!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet var searcBtn: UIButton!
    @IBOutlet var searchBtnImage: UIImageView!
    
    var isInTheSideBarMenu = false
    var menuType: MenuType = .bottomMenu
    
    var containerWidth = UIScreen.main.bounds.width
    
    var pageMenu : CAPSPageMenu?
    
    var leaguesArray: [LeagueModes] = [.crypto, .stocks]
    var selectedLeague: LeagueModes = .crypto
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialMethod()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    //MARK: - initialSetup
    func initialMethod() {
        self.view.backgroundColor = bgBlue
        if selectedLeague == .stocks {
            self.titleLbl.text = "India Market"
        } else {
            self.titleLbl.text = "Crypto Market"
        }
        var controllerArray : [UIViewController] = []
        let titleArray = ["Large Cap", "Mid Cap", "Small Cap","Item 4"]
        for index in 0..<4 {
            // var vc: UIViewController
            switch index {
            case 0:
                let vc = MarketListVC()
                vc.leagueType = self.selectedLeague
                vc.title = titleArray[index]
                controllerArray.append(vc)
            case 1:
                let vc = MarketListVC()
                vc.leagueType = self.selectedLeague
                vc.title = titleArray[index]
                controllerArray.append(vc)
            case 2:
                let vc = MarketListVC()
                vc.leagueType = self.selectedLeague
                vc.title = titleArray[index]
                controllerArray.append(vc)
            case 3:
                let vc = MarketListVC()
                vc.leagueType = self.selectedLeague
                vc.title = titleArray[index]
                controllerArray.append(vc)
            default:
                break
            }
            
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
    @IBAction func searchBtnAction(sender: UIButton){
        UIView.animate(withDuration: 0.2,
                       animations: {
            self.searcBtn.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
            self.searchBtnImage.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        },
                       completion: { _ in
            UIView.animate(withDuration: 0.2) {
                self.searcBtn.transform = CGAffineTransform.identity
                self.searchBtnImage.transform = CGAffineTransform.identity
                
            }
        })
        
        let vc = SearchingVC()
        vc.leagueType = selectedLeague
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .coverVertical
        FTLAppDelegate.navigationController.present(vc, animated: true, completion: nil)
    }
}
