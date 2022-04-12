//
//  HomeTabViewController.swift
//  GoGuards
//
//  Created by Varun Kumar Raghav on 21/12/21.
//

import UIKit

class HomeTabViewController: UIViewController {
    
    @IBOutlet var leaguesImg: UIImageView!
    @IBOutlet var leaguesLbl: UILabel!
    @IBOutlet var leaguesBtn: UIButton!
    @IBOutlet var leaguesLine: UILabel!
    
    @IBOutlet var yourLeagImg: UIImageView!
    @IBOutlet var yourLeagLbl: UILabel!
    @IBOutlet var yourLeagBtn: UIButton!
    @IBOutlet var yourLeagLine: UILabel!
    
    @IBOutlet var watchlistImg: UIImageView!
    @IBOutlet var watchlistLbl: UILabel!
    @IBOutlet var watchlistBtn: UIButton!
    @IBOutlet var watchlistLine: UILabel!
    
    
    @IBOutlet var walletImg: UIImageView!
    @IBOutlet var wallletLbl: UILabel!
    @IBOutlet var walletBtn: UIButton!
    @IBOutlet var walletLine: UILabel!
    
    @IBOutlet var containerView: UIView!
    @IBOutlet var tabBgImg: UIImageView!
    
    let selectedColor = black1
    var selectedVCtag: Int?
    
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
        let leaguesVC = LeaguesVC()
        changeButtonImage(imageView: leaguesImg, title: leaguesLbl, line: leaguesLine)
        addViewController(leaguesVC)
    }
    
    func addViewController(_ childController: UIViewController) {
        removeViewController()
        let navController = UINavigationController(rootViewController: childController)
        navController.setNavigationBarHidden(true, animated: false)
        addChild(navController)
//        navController.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height-60)
//        containerView.setSubviewOnTheView(navController.view)
        navController.view.frame = containerView.bounds
        containerView.addSubview(navController.view)
        navController.didMove(toParent: self)
    }
    
    func removeViewController() {
        for viewController in self.containerView.subviews {
            viewController.removeFromSuperview()
        }
    }
    
    func changeButtonImage(imageView: UIImageView, title: UILabel, line: UILabel) {
        UIView.animate(withDuration: 0.2,
                       animations: {
            line.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
            title.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
            imageView.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        },
                       completion: { _ in
            UIView.animate(withDuration: 0.2) {
                line.transform = CGAffineTransform.identity
                title.transform = CGAffineTransform.identity
                imageView.transform = CGAffineTransform.identity
            }
        })
        //imageView.tintColor = selectedColor
        title.textColor = selectedColor
        title.font = mediumFont
        line.isHidden = false
    }
    func changeColorToInitialState () {
        leaguesLbl.textColor = .darkGray
        leaguesLbl.font = regularFont
        leaguesLine.isHidden = true
        yourLeagLbl.textColor = .darkGray
        yourLeagLbl.font = regularFont
        yourLeagLine.isHidden = true
        watchlistLbl.textColor = .darkGray
        watchlistLbl.font = regularFont
        watchlistLine.isHidden = true
        wallletLbl.textColor = .darkGray
        wallletLbl.font = regularFont
        walletLine.isHidden = true
    }
    //MARK: - action Methods
    @IBAction func tabButtonAction(_ sender: UIButton) {
        self.changeColorToInitialState()
        switch sender.tag {
        case 100:
            selectedVCtag = 100
            changeButtonImage(imageView: leaguesImg, title: leaguesLbl, line: leaguesLine)
            let leaguesVC = LeaguesVC()
            addViewController(leaguesVC)
        case 101:
            selectedVCtag = 101
            changeButtonImage(imageView: yourLeagImg, title: yourLeagLbl, line: yourLeagLine)
            let yourleaguesVC = YourLeaguesVC()
            addViewController(yourleaguesVC)
        case 102:
            selectedVCtag = 102
            changeButtonImage(imageView: watchlistImg, title: watchlistLbl, line: watchlistLine)
            // Add Watchlist here
           // let watchlistVC = StockLeaguesVC()
           // addViewController(watchlistVC)
        case 103:
            selectedVCtag = 103
            changeButtonImage(imageView: walletImg, title: wallletLbl, line: walletLine)
            let walletVC = WalletVC()
            addViewController(walletVC)
        default:
            break
        }
    }
    
}
