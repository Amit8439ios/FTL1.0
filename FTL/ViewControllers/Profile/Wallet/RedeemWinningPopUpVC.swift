//
//  RedeemWinningPopUpVC.swift
//  FTL
//
//  Created by amit toroi on 24/03/22.
//

import UIKit
protocol Redeem_winnings{
    func transferToWallet()
    func WidthdrawToBank()
}

class RedeemWinningPopUpVC: UIViewController {

    var redeemWinning:Redeem_winnings!
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    override func viewWillAppear(_ animated: Bool) {
        let percent = 54/100 * UIScreen.main.bounds.height
        self.view.frame = CGRect(x: 0, y: percent, width: UIScreen.main.bounds.width, height:UIScreen.main.bounds.height - percent)
        
        self.view.layer.cornerRadius = 15
    }

    @IBAction func btnTransferToWallet(_ sender: Any) {
        self.dismiss(animated: true){
            self.redeemWinning.transferToWallet()
        }
    }
    
    @IBAction func btnWithdrawToBank(_ sender: Any) {
        self.dismiss(animated: true){
            self.redeemWinning.WidthdrawToBank()
        }
    }
    
}
