//
//  BankKYCVC.swift
//  FTL
//
//  Created by amit toroi on 24/03/22.
//

import UIKit
import MBProgressHUD
import SwiftyJSON
import Loaf

class BankKYCVC: UIViewController {

    @IBOutlet var viewPANnumber: UIView!
    @IBOutlet weak var txtPanCard: UITextField!
    @IBOutlet weak var imgCheckPan: UIImageView!
    @IBOutlet var btnPANverify: UIButton!
    @IBOutlet var viewEnterAccount: UIView!
    @IBOutlet weak var txtEnterAccount: UITextField!
    @IBOutlet weak var img1Account: UIImageView!
    @IBOutlet var viewReEnterAccount: UIView!
    @IBOutlet weak var txtReEnterAccount: UITextField!
    @IBOutlet weak var img2Account: UIImageView!
    @IBOutlet var viewIFSC: UIView!
    @IBOutlet weak var txtIFSC: UITextField!
    @IBOutlet weak var imgIFSC: UIImageView!
    @IBOutlet var btnConfirm: UIButton!
    
    var isPanVerified = false
    var isBankVerified = false
    
//    MARK: - Lifecycle Method
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }


    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        viewPANnumber.corner(view: viewPANnumber)
        btnPANverify.corner(button: btnPANverify)
        viewEnterAccount.corner(view: viewEnterAccount)
        viewReEnterAccount.corner(view: viewReEnterAccount)
        viewIFSC.corner(view: viewIFSC)
        btnConfirm.corner(button: btnConfirm)
        btnConfirm.isEnabled = false
        btnConfirm.backgroundColor = UIColor(red: 115/255, green: 61/255, blue: 204/255, alpha: 0.5)
//        print(isPanVerified)
//        print(isBankVerified)
        if (isPanVerified == true) && (isBankVerified == false){
            txtPanCard.text = "XXXXXXXXXX"
            self.imgCheckPan.image = UIImage(named: "successIcon")
            self.txtPanCard.isUserInteractionEnabled = false
            self.btnPANverify.setTitle("VERIFIED", for: .normal)
            self.btnPANverify.backgroundColor = grey
            self.btnPANverify.isEnabled = false
            btnConfirm.isEnabled = true
            btnConfirm.backgroundColor = UIColor(red: 115/255, green: 61/255, blue: 204/255, alpha: 1)
        }else if (isBankVerified == true) && (isPanVerified == false){
            txtEnterAccount.text = "XXXXXXXXXXX"
            txtReEnterAccount.text = "XXXXXXXXXXX"
            txtIFSC.text = "XXXXXXXXXXX"
            txtEnterAccount.isUserInteractionEnabled = false
            txtReEnterAccount.isUserInteractionEnabled = false
            txtIFSC.isUserInteractionEnabled = false
            img1Account.image = UIImage(named: "successIcon")
            img2Account.image = UIImage(named: "successIcon")
            imgIFSC.image = UIImage(named: "successIcon")
            btnConfirm.isEnabled = false
            btnConfirm.backgroundColor = UIColor(red: 115/255, green: 61/255, blue: 204/255, alpha: 0.5)
        }
    }
    
// MARK: - action and selector method
    
    @IBAction func btnBackAct(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnPANverifyAct(_ sender: Any) {
        verifyPAN()
        
    }
    
    @IBAction func btnConfirmAct(_ sender: Any) {
        if txtEnterAccount.text! == txtReEnterAccount.text!{
            verifyBank()
        }else{
            Loaf("Account number must be same", state: .custom(.init(backgroundColor: loafErrorBg,textColor: .red, icon:UIImage(named: "errorIcon") ,width: .screenPercentage(0.8))), sender: self).show(.custom(1.5))
        }
    }
    
}


//  MARK: - Api integration
extension BankKYCVC{
    func verifyPAN(){
        if Connectivity.isConnectedToInternet(){
        let url = Api_Constants.baseUrl + Api_Constants.registerDocument
            let doc = ["type":"panCard" ,"panCard": self.txtPanCard.text!] as [String:Any]
            let param = ["userId": UserDefaults.standard.value(forKey: "userId") as! String, "document":doc] as [String : Any]
        MBProgressHUD.showAdded(to: self.view, animated:true)
            ApiManager.verifyPAN(url: url, params: param){ [self]
            (response: JSON?, error:Error?, statusCode: Int) in
            if let error = error{
                print(error)
                MBProgressHUD.hide(for: self.view, animated: true)
                return
            }
            if let response = response {
                print(response)
                if response["status"] == true{
                    self.imgCheckPan.image = UIImage(named: "successIcon")
                    self.txtPanCard.isUserInteractionEnabled = false
                    self.btnPANverify.setTitle("VERIFIED", for: .normal)
                    self.btnPANverify.backgroundColor = grey
                    self.btnPANverify.isEnabled = false
                    self.btnConfirm.isEnabled = true
                    self.btnConfirm.backgroundColor = UIColor(red: 115/255, green: 61/255, blue: 204/255, alpha: 1)
                    if self.imgIFSC.image == UIImage(named: "successIcon"){
                        let vc = WithdrawToBankVC.init(nibName: "WithdrawToBankVC", bundle: nil)
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                    
                }else{
                    self.imgCheckPan.image = UIImage(named: "errorIcon")
                    Loaf(response["msg"].stringValue, state: .custom(.init(backgroundColor: loafErrorBg,textColor: .red, icon:UIImage(named: "errorIcon") ,width: .screenPercentage(0.8))), sender: self).show(.custom(1.5))
                }
                }else{
                    MBProgressHUD.hide(for: self.view, animated: true)
                }
            }
            MBProgressHUD.hide(for: self.view, animated: true)
        }
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    
    
    
    func verifyBank(){
        if Connectivity.isConnectedToInternet(){
        let url = Api_Constants.baseUrl + Api_Constants.registerDocument
            let doc = ["type":"bankDetail" ,"bankAccount": self.txtEnterAccount.text!, "ifsc":self.txtIFSC.text!] as [String:Any]
            let param = ["userId": UserDefaults.standard.value(forKey: "userId") as! String, "document":doc] as [String : Any]
        MBProgressHUD.showAdded(to: self.view, animated:true)
            ApiManager.verifyPAN(url: url, params: param){ [self]
            (response: JSON?, error:Error?, statusCode: Int) in
            if let error = error{
                print(error)
                MBProgressHUD.hide(for: self.view, animated: true)
                return
            }
            if let response = response {
                print(response)
                if response["status"] == true{
                    let vc = WithdrawToBankVC.init(nibName: "WithdrawToBankVC", bundle: nil)
                    FTLAppDelegate.navigationController.pushViewController(vc, animated: true)
                }else{
                    self.img1Account.image = UIImage(named: "errorIcon")
                    self.img2Account.image = UIImage(named: "errorIcon")
                    self.imgIFSC.image = UIImage(named: "errorIcon")
                    Loaf(response["msg"].stringValue, state: .custom(.init(backgroundColor: loafErrorBg,textColor: .red, icon:UIImage(named: "errorIcon") ,width: .screenPercentage(0.5))), sender: self).show(.custom(1.5))
                }
                }else{
                    MBProgressHUD.hide(for: self.view, animated: true)
                }
            }
            MBProgressHUD.hide(for: self.view, animated: true)
        }
        MBProgressHUD.hide(for: self.view, animated: true)
    }
}
