//
//  OtpVC.swift
//  FTL
//
//  Created by amit toroi on 20/03/22.
//

import UIKit
import Alamofire
import SwiftyJSON
import Loaf

class OtpVC: UIViewController {

    @IBOutlet var btnBack: UIButton!
    @IBOutlet var viewDetails: UIView!
    @IBOutlet var lblMobileNumber: UILabel!
    
    @IBOutlet var txtField1: UITextField!
    @IBOutlet var txtField2: UITextField!
    @IBOutlet var txtField3: UITextField!
    @IBOutlet var txtField4: UITextField!
    
    @IBOutlet var btnResendOTP: UIButton!
    @IBOutlet var lblCountDown: UILabel!
    var isdCode = ""
    var mobileNumber = ""
    
    var timeRemaining:Int = 90
    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        txtField1.delegate = self
        txtField2.delegate = self
        txtField3.delegate = self
        txtField4.delegate = self
        
        txtField1.addTarget(self, action: #selector(self.textFieldDidChangeSelection(textField: )), for: UIControl.Event.editingChanged)
        txtField2.addTarget(self, action: #selector(self.textFieldDidChangeSelection(textField: )), for: UIControl.Event.editingChanged)
        txtField3.addTarget(self, action: #selector(self.textFieldDidChangeSelection(textField: )), for: UIControl.Event.editingChanged)
        txtField4.addTarget(self, action: #selector(self.textFieldDidChangeSelection(textField: )), for: UIControl.Event.editingChanged)
     

    }
    override func viewWillAppear(_ animated: Bool) {
        viewDetails.layer.cornerRadius = 24
        viewDetails.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        lblMobileNumber.text = "Enter the OTP sent via SMS on \(isdCode) \(mobileNumber)"
        txtField1.becomeFirstResponder()
        
        txtField1.layer.borderWidth = 1
        txtField1.layer.cornerRadius = 8
        txtField1.layer.borderColor = UIColor(red: 128, green: 128, blue: 128, alpha: 1).cgColor
        txtField1.backgroundColor = .white
        
        txtField2.layer.borderWidth = 1
        txtField2.layer.cornerRadius = 8
        txtField2.layer.borderColor = UIColor(red: 128, green: 128, blue: 128, alpha: 1).cgColor
        txtField2.backgroundColor = .white
        
        txtField3.layer.borderWidth = 1
        txtField3.layer.cornerRadius = 8
        txtField3.layer.borderColor = UIColor(red: 128, green: 128, blue: 128, alpha: 1).cgColor
        txtField3.backgroundColor = .white
        
        txtField4.layer.borderWidth = 1
        txtField4.layer.cornerRadius = 8
        txtField4.layer.borderColor = UIColor(red: 128, green: 128, blue: 128, alpha: 1).cgColor
        txtField4.backgroundColor = .white
        lblCountDown.isHidden = true
        
    }
    
    @objc func steps(){
        if timeRemaining > 0{
            timeRemaining -= 1
        }else{
            lblCountDown.isHidden = true
            btnResendOTP.isEnabled = true
        }

        lblCountDown.text = " in \(timeRemaining) sec"
    }
    
    
    
    @IBAction func btnBackAct(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnResendOtpAct(_ sender: Any) {
        btnResendOTP.isEnabled = false
        lblCountDown.isHidden = false
        ReSendOTP()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(steps), userInfo: nil, repeats: true)
        
    }
    
}


extension OtpVC: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 1
        let currentString1: NSString = (textField.text ?? "") as NSString
        let newString: NSString =
            currentString1.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
    
    @objc private func textFieldDidChangeSelection(textField: UITextField){
        let text = textField.text
        
        if text?.utf16.count == 1{
            switch textField {
            case txtField1:
                txtField2.becomeFirstResponder()
                break
            case txtField2:
                txtField3.becomeFirstResponder()
                break
            case txtField3:
                txtField4.becomeFirstResponder()
                break
            case txtField4:
                txtField4.becomeFirstResponder()
                verifyOtp()
                
                break
            default:
                break
            }
        }
        if text?.utf16.count == 0{
            switch textField{
            case txtField4:
                txtField3.becomeFirstResponder()
                break
            case txtField3:
                txtField2.becomeFirstResponder()
                break
            case txtField2:
                txtField1.becomeFirstResponder()
                break
                
            default:
                break
            }
        }
    }

}



extension OtpVC{
    func verifyOtp(){
        let url = Api_Constants.baseUrl+Api_Constants.verfifyOtp
        let param:[String:Any] = ["mobile":self.mobileNumber,
                                  "isdCode": self.isdCode,
                                  "otp":self.txtField1.text!+self.txtField2.text!+self.txtField3.text!+self.txtField4.text!]
        ApiManager.verifyOtp(url: url, params: param) {(response: JSON?, error:Error?, statusCode: Int) in
            if let error = error{
                print(error)
                return
            }
            if let response = response{
                if response["status"] == true{
                    print(response)
                    UserDefaults.standard.set(response["data"]["_id"].stringValue, forKey: "userId")
                    let userName = response["data"]["profile"]["fullName"].stringValue
                    if userName == ""{
                    let vc = UserDetailsVC.init(nibName: "UserDetailsVC", bundle: nil)
                    
                    vc.userId = response["data"]["_id"].stringValue
                    vc.referralCode = response["data"]["referralCode"].stringValue
                    self.navigationController?.pushViewController(vc, animated: true)
                    }else{
                        let vc = HomeTabViewController.init(nibName: "HomeTabViewController", bundle: nil)
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }else{
                    Loaf("Wrong OTP", state: .custom(.init(backgroundColor: UIColor(red: 255/255, green: 235/255, blue: 204/255, alpha: 1),textColor: .red, icon:UIImage(named: "errorIcon") ,width: .screenPercentage(0.45))), sender: self).show(.custom(1.5))
                }
               
            }else{
                print("Somthing wrong")
            }
        }
    }
    
    
    func ReSendOTP(){
        if Connectivity.isConnectedToInternet() {
        let url = Api_Constants.baseUrl + Api_Constants.sendOtp
            let param:[String:Any] = ["isdCode":self.isdCode,"mobile":self.mobileNumber]
        ApiManager.sendOTP(url: url, params: param ) {(response: JSON?, error:Error?, statusCode: Int) in
            if let error = error{
                print(error)
                return
            }
            if let response = response{
//                print(response)
                if response["status"] == true {
                    Loaf("OTP send successfully", state: .custom(.init(backgroundColor: UIColor(red: 217/255, green: 255/255, blue: 223/255, alpha: 1),textColor: UIColor(red: 0/255, green: 128/255, blue: 20/255, alpha: 1), icon:UIImage(named: "successIcon") ,width: .screenPercentage(0.7))), sender: self).show(.custom(1.5))
                }
            }else{
                print("Somthing wrong")
            }
            
        }
        }else{
            Loaf("Active internet connection required", state: .custom(.init(backgroundColor: UIColor(red: 255/255, green: 235/255, blue: 204/255, alpha: 1),textColor: .red, icon:UIImage(named: "errorIcon") ,width: .screenPercentage(0.9))), sender: self).show(.custom(1.5))
        }
    }
}
