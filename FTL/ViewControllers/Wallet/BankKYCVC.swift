//
//  BankKYCVC.swift
//  FTL
//
//  Created by amit toroi on 24/03/22.
//

import UIKit

class BankKYCVC: UIViewController {

    @IBOutlet var viewPANnumber: UIView!
    @IBOutlet var btnPANverify: UIButton!
    @IBOutlet var viewEnterAccount: UIView!
    @IBOutlet var viewReEnterAccount: UIView!
    @IBOutlet var viewIFSC: UIView!
    @IBOutlet var btnConfirm: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }


    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        viewPANnumber.layer.cornerRadius = viewPANnumber.bounds.height/2
        btnPANverify.layer.cornerRadius = btnPANverify.bounds.height/2
        viewEnterAccount.layer.cornerRadius = viewEnterAccount.bounds.height/2
        viewReEnterAccount.layer.cornerRadius = viewReEnterAccount.bounds.height/2
        viewIFSC.layer.cornerRadius = viewIFSC.bounds.height/2
        btnConfirm.layer.cornerRadius = btnConfirm.bounds.height/2
    }

    @IBAction func btnBackAct(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnPANverifyAct(_ sender: Any) {
    }
    
    @IBAction func btnConfirmAct(_ sender: Any) {
    }
    
}
