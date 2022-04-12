//
//  ProfileVC.swift
//  FTL
//
//  Created by amit toroi on 22/03/22.
//

import UIKit

class ProfileVC: UIViewController {

    @IBOutlet var btnInviteNow: UIButton!
    @IBOutlet var viewInvite: UIView!
    @IBOutlet var viewInviteDetails: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        viewInvite.isHidden = true
        viewInviteDetails.layer.cornerRadius = 20
    }

    @IBAction func btnInviteNowAct(_ sender: Any) {
        viewInvite.isHidden = false
    }
    @IBAction func btnBackInviteAct(_ sender: Any) {
        viewInvite.isHidden = true
    }
    
}
