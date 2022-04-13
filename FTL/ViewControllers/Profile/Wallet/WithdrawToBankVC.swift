//
//  WithdrawToBankVC.swift
//  FTL
//
//  Created by amit toroi on 26/03/22.
//

import UIKit
import Loaf
import MBProgressHUD
import IQKeyboardManagerSwift
import SwiftyJSON

class WithdrawToBankVC: UIViewController {

    @IBOutlet var mainView: UIView!
    @IBOutlet var lblTotalWinnings: UILabel!
    @IBOutlet var viewEnterAmount: UIView!
    @IBOutlet weak var txtEnterAmount: UITextField!
    @IBOutlet weak var checkBoxCircle: UIImageView!
    @IBOutlet var btnFullAmount: UIButton!
    @IBOutlet var btnWithdraw: UIButton!
    
    @IBOutlet weak var lblBankName: UILabel!
    @IBOutlet weak var lblAccountNumber: UILabel!
    
    var totalWinnings = "0"
    
//    MARK: - Lifecycle method
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchBankAccount()
        txtEnterAmount.addTarget(self, action: #selector(enableBtn), for: .editingChanged)
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        mainView.layer.cornerRadius = 24
        mainView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        viewEnterAmount.corner(view: viewEnterAmount)
        btnFullAmount.corner(button: btnFullAmount)
        btnFullAmount.layer.borderWidth = 1
        btnFullAmount.layer.borderColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1).cgColor
        btnWithdraw.isEnabled = false
        btnWithdraw.backgroundColor = UIColor(red: 115/255, green: 61/255, blue: 204/255, alpha: 0.5)
        btnWithdraw.corner(button: btnWithdraw)
        
        checkBoxCircle.image = UIImage(named: "circle")
        
        lblTotalWinnings.text = "\u{20b9} \(totalWinnings)"
        
    }
    
//    MARK: - action and selector method
    
    @objc func enableBtn(){
        if txtEnterAmount.text == ""{
            btnWithdraw.isEnabled = false
            btnWithdraw.backgroundColor = UIColor(red: 115/255, green: 61/255, blue: 204/255, alpha: 0.5)
        }else{
            btnWithdraw.isEnabled = true
            btnWithdraw.backgroundColor = UIColor(red: 115/255, green: 61/255, blue: 204/255, alpha: 1)
        }
    }
    
    @IBAction func btnFullAmountAct(_ sender: Any) {
        txtEnterAmount.text = totalWinnings
    }
    
    @IBAction func btnCheckBoxAct(_ sender: Any) {
        if checkBoxCircle.image == UIImage(named: "circle"){
            checkBoxCircle.image = UIImage(named: "checkedCircle")
        }else{
            checkBoxCircle.image = UIImage(named: "circle")
        }
    }
    
    
    
    @IBAction func btnBackAct(_ sender: Any) {
        let controllers = self.navigationController?.viewControllers
          for vc in controllers! {
            if vc is HomeTabViewController {
                self.navigationController?.popToViewController(vc as! HomeTabViewController, animated: true)
            }
          }
    }
    @IBAction func btnWithdrawAct(_ sender: Any) {
        let x = Int(txtEnterAmount.text!)!
        let y = Int(totalWinnings)!
        if x>y{
            Loaf("can't withdraw more the winnings", state: .custom(.init(backgroundColor: loafErrorBg,textColor: .red, icon:UIImage(named: "errorIcon") ,width: .screenPercentage(0.9))), sender: self).show(.custom(1.5))
        }else if checkBoxCircle.image == UIImage(named: "circle"){
            Loaf("select bank account", state: .custom(.init(backgroundColor: loafErrorBg,textColor: .red, icon:UIImage(named: "errorIcon") ,width: .screenPercentage(0.9))), sender: self).show(.custom(1.5))
        }else{
            withdrawToBank()
        }
    }
}


//  MARK: APi integration
extension WithdrawToBankVC{
    func fetchBankAccount(){
        if Connectivity.isConnectedToInternet(){
            let userId = UserDefaults.standard.value(forKey: "userId") as! String
        let url = Api_Constants.baseUrl + Api_Constants.getBankDetail+"?userId="+"\(userId)"
            
            MBProgressHUD.showAdded(to: self.view, animated: true)
            
        ApiManager.getBankDetails(url: url) {(response: JSON?, error:Error?, statusCode: Int) in
            if let error = error{
                MBProgressHUD.hide(for: self.view, animated: true)
                return
            }
            if let response = response{
                print(response)
                if response["status"] == true{
                    self.lblBankName.text! = response["data"]["bankName"].stringValue
                    let AccountNum = response["data"]["accountNo"].stringValue
                    self.lblAccountNumber.text = "XXXXXXXXXX\(AccountNum.suffix(4))"
                    
                }else{
                    
                    Loaf(response["msg"].stringValue, state: .custom(.init(backgroundColor: loafErrorBg,textColor: .red, icon:UIImage(named: "errorIcon") ,width: .screenPercentage(0.8))), sender: self).show(.custom(1.5))
                }
                
            }else{
                MBProgressHUD.hide(for: self.view, animated: true)
                
            }
        }
            MBProgressHUD.hide(for: self.view, animated: true)
        }else{
            MBProgressHUD.hide(for: self.view, animated: true)
            Loaf("Active internet connection required", state: .custom(.init(backgroundColor: UIColor(red: 255/255, green: 235/255, blue: 204/255, alpha: 1),textColor: .red, icon:UIImage(named: "errorIcon") ,width: .screenPercentage(0.9))), sender: self).show(.custom(1.5))
        }
    }
    
    /// <#Description#>
    func withdrawToBank(){
        if Connectivity.isConnectedToInternet(){
        let url = Api_Constants.baseUrl + Api_Constants.requestTransfer
            let param = ["userId": UserDefaults.standard.value(forKey: "userId") as! String, "amount": self.txtEnterAmount.text!] as [String : Any]
        MBProgressHUD.showAdded(to: self.view, animated:true)
            ApiManager.withdrawRequest(url: url, params: param){ [self]
            (response: JSON?, error:Error?, statusCode: Int) in
            if let error = error{
                print(error)
                MBProgressHUD.hide(for: self.view, animated: true)
                return
            }
            if let response = response {
                print(response)
                if response["status"] == true{
//                    MBProgressHUD.hide(for: self.view, animated: true)
                    Loaf(response["msg"].stringValue, state: .custom(.init(backgroundColor: loafSuccBg,textColor: loafSucctextColor, icon:UIImage(named: "successIcon") ,width: .screenPercentage(0.7))), sender: self).show(.custom(1.5)){ _ in
                        self.navigationController?.popViewController(animated: true)
                    }
                    
                }else{
//                    MBProgressHUD.hide(for: self.view, animated: true)
                    Loaf(response["msg"].stringValue, state: .custom(.init(backgroundColor: loafErrorBg,textColor: .red, icon:UIImage(named: "errorIcon") ,width: .screenPercentage(0.5))), sender: self).show(.custom(1.5))
                }
//                MBProgressHUD.hide(for: self.view, animated: true)
                }
            }
        }
        MBProgressHUD.hide(for: self.view, animated: true)
    }
}
