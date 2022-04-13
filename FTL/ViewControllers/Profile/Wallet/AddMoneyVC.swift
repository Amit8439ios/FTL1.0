//
//  AddMoneyVC.swift
//  FTL
//
//  Created by amit toroi on 23/03/22.
//

import UIKit
import CFSDK
import SwiftyJSON
import Loaf
import IQKeyboardManagerSwift
import MBProgressHUD

class AddMoneyVC: UIViewController {

    @IBOutlet var view1: UIView!
    @IBOutlet weak var lblWalletBalance: UILabel!
    @IBOutlet var viewEnterAmount: UIView!
    @IBOutlet var btn50: UIButton!
    @IBOutlet var btn100: UIButton!
    @IBOutlet var btn250: UIButton!
    @IBOutlet var btn500: UIButton!
    @IBOutlet var btn1000: UIButton!
    @IBOutlet var txtAmount: UITextField!
    @IBOutlet var btnPay: UIButton!
    @IBOutlet weak var lblLoadAmount: UILabel!
    @IBOutlet weak var lblWinnings: UILabel!
    @IBOutlet weak var lblTotalPaid: UILabel!
    
    @IBOutlet weak var imgCheckBox: UIImageView!
    
    
    var walletBalance = ""
    var winnings = ""
    
    let userId = UserDefaults.standard.value(forKey: "userId") as! String
    var orderId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
       txt()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.isNavigationBarHidden = true
        
        view1.layer.cornerRadius = 24
        view1.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        
        viewEnterAmount.layer.cornerRadius = viewEnterAmount.bounds.height/2
        
        btnPay.corner(button: btnPay)
        
        btn50.corner(button: btn50)
        btn50.layer.borderWidth = 1
        btn50.layer.borderColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1).cgColor
        btn100.corner(button: btn100)
        btn100.layer.borderWidth = 1
        btn100.layer.borderColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1).cgColor
        btn250.corner(button: btn250)
        btn250.layer.borderWidth = 1
        btn250.layer.borderColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1).cgColor
        btn500.corner(button: btn500)
        btn500.layer.borderWidth = 1
        btn500.layer.borderColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1).cgColor
        btn1000.corner(button: btn1000)
        btn1000.layer.borderWidth = 1
        btn1000.layer.borderColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1).cgColor
        txtAmount.attributedPlaceholder = NSAttributedString(
            string: "enter amount",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray, .font:UIFont.systemFont(ofSize: 12) ]
        )
        
        self.imgCheckBox.image = UIImage(named: "UncheckBox")
        
        lblWalletBalance.text = walletBalance
        lblWinnings.text = "- \u{20b9} \(winnings)"
        
    }

    func txt(){
        self.txtAmount.addTarget(btnPay, action: #selector(UIButton.input(textField:)), for: .editingChanged)
        self.txtAmount.addTarget(lblLoadAmount, action: #selector(UILabel.inputt(lbl:)), for: .editingChanged)
        self.txtAmount.addTarget(lblTotalPaid, action: #selector(UILabel.inputt(lbl:)), for: .editingChanged)
    }
    
    @IBAction func btnBackAct(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btn50Act(_ sender: Any) {
        details(amount: btn50.title(for: .normal)!)
    }
    @IBAction func btn100Act(_ sender: Any) {
        details(amount: btn100.title(for: .normal)!)
    }
    @IBAction func btn250Act(_ sender: Any) {
        details(amount: btn250.title(for: .normal)!)
    }
    @IBAction func btn500Act(_ sender: Any) {
        details(amount: btn500.title(for: .normal)!)
    }
    @IBAction func btn1000Act(_ sender: Any) {
        details(amount: btn1000.title(for: .normal)!)
    }
    
    @IBAction func btnCheckBoxAct(_ sender: Any) {
        if txtAmount.text == ""{
            Loaf("Please enter amount", state: .custom(.init(backgroundColor: UIColor(red: 255/255, green: 235/255, blue: 204/255, alpha: 1),textColor: .red, icon:UIImage(named: "errorIcon") ,width: .screenPercentage(0.7))), sender: self).show(.custom(1.5))
        }else{
        if imgCheckBox.image == UIImage(named: "UncheckBox"){
            self.imgCheckBox.image = UIImage(named: "CheckBox")
            let x = Int(self.txtAmount.text!)!
            let y = Int(self.winnings)!
            lblTotalPaid.text = "\u{20b9} \(x-y)"
            btnPay.setTitle("PAY \(x-y)", for: .normal)
        }else{
            self.imgCheckBox.image = UIImage(named: "UncheckBox")
            lblTotalPaid.text = "\u{20b9}  \(self.txtAmount.text!)"
            btnPay.setTitle("PAY \(self.txtAmount.text!)", for: .normal)
        }
        }
    }
    
    @IBAction func btnPay(_ sender: Any) {
        if Int(txtAmount.text!)! ?? 0 > Int(winnings)!{
        generateToken()
        }else{
            print("redeem api")
        }
    }
    
    func details(amount:String){
        self.txtAmount.text = "\(amount)"
        self.lblLoadAmount.text = "\u{20b9} \(amount)"
        self.lblTotalPaid.text = "\u{20b9} \(amount)"
        btnPay.setTitle("PAY \(amount)", for: .normal)
    }
    
}


extension AddMoneyVC{
    func generateToken(){
        if Connectivity.isConnectedToInternet(){
            
            let totalPaid = self.lblTotalPaid.text!
            let url = Api_Constants.baseUrl + Api_Constants.generateToken+"?userId=\(userId)&orderAmount=\(totalPaid.dropFirst(2))"
            print(totalPaid)
        ApiManager.generateToken(url: url) {(response: JSON?, error:Error?, statusCode: Int) in
            if let error = error{
                return
            }
            if let response = response{
//                print(response)
                self.orderId = response["data"]["orderId"].stringValue
                let inputParams = ["appId": "14378240b48259b0c1c988887f287341",
                                   "orderId": response["data"]["orderId"].stringValue,
                                   "tokenData" : response["data"]["token"].stringValue,
                                   "orderAmount": "\(totalPaid.dropFirst(2))",
                                   "customerName": "Amit",
                                   "orderNote": "Order Note",
                                   "orderCurrency": "INR",
                                   "customerPhone": "8439931327",
                                   "customerEmail": "sample@gmail.com",
                                   "notifyUrl": "https://test.gocashfree.com/notify"]
//                print(inputParams)
                CFPaymentService().doWebCheckoutPayment(params: inputParams, env:"PROD" , callback: self)
            }else{
                Loaf("Not able to generate token", state: .custom(.init(backgroundColor: UIColor(red: 255/255, green: 235/255, blue: 204/255, alpha: 1),textColor: .red, icon:UIImage(named: "errorIcon") ,width: .screenPercentage(0.8))), sender: self).show(.custom(1.5))
            }
        }
        }else{
            Loaf("Active internet connection required", state: .custom(.init(backgroundColor: UIColor(red: 255/255, green: 235/255, blue: 204/255, alpha: 1),textColor: .red, icon:UIImage(named: "errorIcon") ,width: .screenPercentage(0.9))), sender: self).show(.custom(1.5))
        }
    }
}


extension AddMoneyVC:ResultDelegate{
    func onPaymentCompletion(msg: String) {
        let jsonData = msg.data(using: .utf8)
        do{
            let json = try JSONSerialization.jsonObject(with: jsonData!, options: []) as? NSDictionary ?? [:]
            var response = ""
            for key in json.allKeys{
                response += "\(key) : \(json[key] as? String ?? "")\n"
            }
                print(response)
            if json["txStatus"] as! String == "SUCCESS"{
                let orderAmount:Double = Double(json["orderAmount"] as! String)!
                
                if imgCheckBox.image == UIImage(named: "CheckBox"){
                    addMoney(orderId:json["orderId"] as! String, orderAmount: orderAmount, winningAmount:Double(self.winnings)!, userId:self.userId)
                }else{
                    addMoney(orderId:json["orderId"] as! String, orderAmount: json["orderAmount"] as! Double, winningAmount:0.0, userId:self.userId)
                }
                
            }else{
                Loaf("Payment fail", state: .custom(.init(backgroundColor: UIColor(red: 255/255, green: 235/255, blue: 204/255, alpha: 1),textColor: .red, icon:UIImage(named: "errorIcon") ,width: .screenPercentage(0.4))), sender: self).show(.custom(1.5))


            }
        }catch{
            print("Payment Can't be possible")
        }
        print(msg)
 }
    
    
    func addMoney(orderId:String, orderAmount:Double, winningAmount:Double, userId:String){
        let url = Api_Constants.baseUrl + Api_Constants.addMoneyToWallet
        let param = [
            "userId":userId,
            "orderId":orderId,
            "bankAmount": orderAmount,
            "winningAmount":winningAmount] as [String : Any]
        ApiManager.addMoneyInWallet(url: url, params: param){
            (response: JSON?, error:Error?, statusCode: Int) in
            if let error = error{
                print(error)
                return
            }
            if let response = response {
                if response["status"] == true{
                    print(response)
                    
                }else{
                    
                }
            }
        }
    }
    
    
}
