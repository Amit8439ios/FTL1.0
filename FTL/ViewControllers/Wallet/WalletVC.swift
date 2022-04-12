//
//  WalletVC.swift
//  FTL
//
//  Created by amit toroi on 22/03/22.
//

import UIKit

class WalletVC: UIViewController, Redeem_winnings {

    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var view1: UIView!
    @IBOutlet var view1Height: NSLayoutConstraint!
    @IBOutlet var lblWinnings: UILabel!
    @IBOutlet var viewPlayOff: UIView!
    @IBOutlet var btnPlayoff: UIView!
    @IBOutlet var btnRedeemWinning: UIButton!
    @IBOutlet var btnSeeHistory: UIButton!
    
    @IBOutlet var view2: UIView!
    @IBOutlet var lblWalletBalance: UILabel!
    @IBOutlet var view2Referral: UIView!
    @IBOutlet var btnReferral: UIButton!
    @IBOutlet var btnAddMoney: UIButton!
    @IBOutlet var btnSeetransaction: UIButton!
    
    @IBOutlet var view3: UIView!
    @IBOutlet var lblGetRupee: UILabel!
    @IBOutlet var viewReferralCode: UIView!
    @IBOutlet var lblreferralCode: UILabel!
    @IBOutlet var btnCopy: UIButton!
    @IBOutlet var btnInviteNow: UIButton!
    
    let x = 10
    override func viewDidLoad() {
        super.viewDidLoad()

        if x == 0{
            btnRedeemWinning.isHidden = true
            view1Height.constant = 142
        }else{
            btnRedeemWinning.isHidden = false
            view1Height.constant = 214
            
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        
        view1.layer.cornerRadius = 20
        viewPlayOff.layer.cornerRadius = 16
        btnRedeemWinning.layer.cornerRadius = btnRedeemWinning.bounds.height/2
        
        view2.layer.cornerRadius = 20
        view2Referral.layer.cornerRadius = 16
        btnAddMoney.layer.cornerRadius = btnAddMoney.bounds.height/2
        
        view3.layer.cornerRadius = 20
        lblGetRupee.text = "Get \u{20B9}10"
        viewReferralCode.layer.cornerRadius = viewReferralCode.bounds.height/2
        btnInviteNow.layer.cornerRadius = btnInviteNow.bounds.height/2
        
    }

    func transferToWallet() {
        let vc = TransferToWalletVC.init(nibName: "TransferToWalletVC", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func WidthdrawToBank() {
        let vc = WithdrawToBankVC.init(nibName: "WithdrawToBankVC", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnAddMoneyAct(_ sender: Any) {
        let vc = AddMoneyVC.init(nibName: "AddMoneyVC", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnRedeemWinningsAct(_ sender: Any) {
        let vc = RedeemWinningPopUpVC.init(nibName: "RedeemWinningPopUpVC", bundle: nil)
        vc.redeemWinning = self
        self.navigationController?.present(vc, animated: true )
    }
    @IBAction func btnSeeHistoryAct(_ sender: Any) {
        let vc = WinningHistoryVC.init(nibName: "WinningHistoryVC", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btnSeeTransactionAct(_ sender: Any) {
        let vc = TransactionHistoryVC.init(nibName: "TransactionHistoryVC", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnReferralAct(_ sender: Any) {
        scrollView.setContentOffset(CGPoint(x: 0, y: scrollView.contentSize.height-600 ), animated: true)
    }
}
