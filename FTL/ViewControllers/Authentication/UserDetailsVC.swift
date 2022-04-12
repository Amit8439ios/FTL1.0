//
//  UserDetailsVC.swift
//  FTL
//
//  Created by amit toroi on 21/03/22.
//

import UIKit
import Alamofire
import SwiftyJSON
import Loaf

class UserDetailsVC: UIViewController {

    @IBOutlet var viewContant: UIView!
    
    @IBOutlet var viewDetails: UIView!
    @IBOutlet var viewName: UIView!
    @IBOutlet var txtFullName: UITextField!
    @IBOutlet var viewEmail: UIView!
    @IBOutlet var txtEmail: UITextField!
    @IBOutlet var viewReferral: UIView!
    @IBOutlet var txtReferral: UITextField!
    @IBOutlet var btnContinue: UIButton!
    
    var userId = ""
    var referralCode = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        txtReferral.delegate = self
        txtFullName.delegate = self
        txtEmail.delegate = self
        
        if referralCode != ""{
            txtReferral.text = referralCode
            txtReferral.isEnabled = false
            txtReferral.textColor = .gray
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        viewDetails.layer.cornerRadius = 24
        
        viewName.layer.cornerRadius = 24
        viewName.layer.borderWidth = 1
        viewName.layer.borderColor = UIColor(red: 128, green: 128, blue: 128, alpha: 1).cgColor
        viewEmail.layer.cornerRadius = 24
        viewReferral.layer.cornerRadius = 24
        btnContinue.layer.cornerRadius = 24
        
        
        viewDetails.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
    }

    @IBAction func btnContinueAct(_ sender: Any) {
        if (txtFullName.text!.isEmpty){
            Loaf("Please enter name", state: .custom(.init(backgroundColor: UIColor(red: 255/255, green: 235/255, blue: 204/255, alpha: 1),textColor: .red, icon:UIImage(named: "errorIcon") ,width: .screenPercentage(0.8))), sender: self).show(.custom(1.6))
        }
        else if(txtFullName.text!.count < 3) {
            Loaf("Please enter valid name", state: .custom(.init(backgroundColor: UIColor(red: 255/255, green: 235/255, blue: 204/255, alpha: 1),textColor: .red, icon:UIImage(named: "errorIcon") ,width: .screenPercentage(0.8))), sender: self).show(.custom(1.5))
        }
        else if (txtEmail.text!.isValidEmail){
            
            seveUserDetails()
    
        }else{
            Loaf("Enter valid Email", state: .custom(.init(backgroundColor: UIColor(red: 255/255, green: 235/255, blue: 204/255, alpha: 1),textColor: .red, icon:UIImage(named: "errorIcon") ,width: .screenPercentage(0.6))), sender: self).show(.custom(1.5))
        }
    }
}


extension UserDetailsVC: UITextFieldDelegate{
    
}


//MARK: extension for Api functions
extension UserDetailsVC{
    func seveUserDetails(){
        let url = Api_Constants.baseUrl + Api_Constants.saveDetails
        let param:[String:Any] = ["_id":self.userId,
                                  "fullName": self.txtFullName.text!,
                                  "email":self.txtEmail.text!,
                                  "referredBy":self.referralCode]
        ApiManager.saveUserDetails(url: url, params: param) {(response: JSON?, error:Error?, statusCode: Int) in
            if let error = error{
                print(error)
                return
            }
            if let response = response{
                if response["status"] == true{
                    print(response["data"]["profile"]["fullName"].stringValue)
                    let vc = HomeTabViewController.init(nibName: "HomeTabViewController", bundle: nil)
//                    vc.lblUserName.text = "Hi \(response["data"]["profile"]["fullName"].stringValue)!"
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                }else{
                    
                }
               
            }else{
                print("Somthing wrong")
            }
        }
    }
}
