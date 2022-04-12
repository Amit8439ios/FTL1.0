//
//  LowBalanceAlertVC.swift
//  FTL
//
//  Created by Varun Kumar Raghav on 28/03/22.
//

import UIKit

class LowBalanceAlertVC: UIViewController {
    @IBOutlet var titleLbl: UILabel!
    @IBOutlet var subTitle: UILabel!
    @IBOutlet var descriptionImg: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialMethod()
    }
    //MARK: - initial setup
    func initialMethod() {
        
    }
    //MARK: - action Method
    @IBAction func addMoneyBtnTapped(sender: UIButton){
        //Navigate to addMoney screen
        self.dismiss(animated: true){
            FTLAppDelegate.navigationController.pushViewController(AddMoneyVC(), animated: true)
        }
    }
}
