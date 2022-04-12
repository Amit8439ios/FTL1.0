//
//  TransferToWalletVC.swift
//  FTL
//
//  Created by amit toroi on 24/03/22.
//

import UIKit

class TransferToWalletVC: UIViewController {

    @IBOutlet var mainView: UIView!
    @IBOutlet var lblTotalWinnings: UILabel!
    @IBOutlet var viewEnterAmount: UIView!
    @IBOutlet var lblWalletBalance: UILabel!
    @IBOutlet var lblTransferAmount: UILabel!
    @IBOutlet var lblNewWalletBalance: UILabel!
    @IBOutlet var btnTransferToWallet: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.isNavigationBarHidden = true
        
        mainView.layer.cornerRadius = 24
        mainView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        viewEnterAmount.layer.cornerRadius = viewEnterAmount.bounds.height/2
        btnTransferToWallet.layer.cornerRadius = btnTransferToWallet.bounds.height/2
    }
    
    @IBAction func btnBackAct(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
        
        
    }
}
