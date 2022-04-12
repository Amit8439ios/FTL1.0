//
//  WithdrawToBankVC.swift
//  FTL
//
//  Created by amit toroi on 26/03/22.
//

import UIKit

class WithdrawToBankVC: UIViewController {

    @IBOutlet var mainView: UIView!
    @IBOutlet var lblTotalWinnings: UILabel!
    @IBOutlet var viewEnterAmount: UIView!
    @IBOutlet var btnFullAmount: UIButton!
    @IBOutlet var btnWithdraw: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        mainView.layer.cornerRadius = 24
        mainView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        viewEnterAmount.layer.cornerRadius = viewEnterAmount.bounds.height/2
        btnFullAmount.layer.cornerRadius = btnFullAmount.bounds.height/2
        btnFullAmount.layer.borderWidth = 1
        btnFullAmount.layer.borderColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1).cgColor
        btnWithdraw.layer.cornerRadius = btnWithdraw.bounds.height/2
        
    }
    @IBAction func btnBackAct(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
