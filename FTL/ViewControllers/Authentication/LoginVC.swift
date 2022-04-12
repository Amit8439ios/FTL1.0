//
//  LoginVC.swift
//  FTL
//
//  Created by ROHIT on 19/03/22.
//

import UIKit
import Foundation
import SwiftyJSON
import Alamofire
import Loaf

class LoginVC: UIViewController {

    @IBOutlet var contentView: UIView!
    @IBOutlet var viewMobile: UIView!
    @IBOutlet var imgPhone: UIImageView!
    @IBOutlet var viewPageController: UIView!
    @IBOutlet var viewMoblieText: UIView!
    @IBOutlet var btnISDCode: UIButton!
    @IBOutlet var btnGetstarted: UIButton!
    @IBOutlet var viewISDcode: UIView!
    @IBOutlet var lblISDcode: UILabel!
    @IBOutlet var txtMobileNumber: UITextField!
    @IBOutlet var btnTermAndCondition: UIButton!
    
    @IBOutlet var viewDetails: UIView!
    @IBOutlet var lblFirst: UILabel!
    @IBOutlet var lblSecond: UILabel!
    
    @IBOutlet var imgCheckBox: UIImageView!
    @IBOutlet var pickerView: UIPickerView!
    
    let vwCurrentPage = UIView()
    let vw1 = UIView()
    let vw2 = UIView()
    
    
    var arrISD = [ISDCodeModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        pickerView.delegate = self
        pickerView.dataSource = self
     
        getISDcode()
        
        pickerView.isHidden = true
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        viewMoblieText.layer.cornerRadius = 24
        viewMoblieText.layer.borderWidth = 1
        btnISDCode.setTitle("", for: .normal)
        btnGetstarted.layer.cornerRadius = 24
//        btnGetstarted.backgroundColor = UIColor(red: 0.45, green: 0.24, blue: 0.8, alpha: 0.4)
        viewISDcode.layer.cornerRadius = 16
        txtMobileNumber.attributedPlaceholder = NSAttributedString(
            string: "enter your mobile no.",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray, .font:UIFont.systemFont(ofSize: 12) ]
        )
        
        viewDetails.layer.cornerRadius = 24
        viewDetails.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        vwCurrentPage.frame = CGRect(x: 0, y: 0, width: 16, height: 4)
        vwCurrentPage.layer.cornerRadius = vwCurrentPage.bounds.height/2
        vwCurrentPage.backgroundColor = .black
        
        vw1.frame = CGRect(x: 20, y: 0, width: 4, height: 4)
        vw1.layer.cornerRadius = vw1.bounds.height/2
        vw1.backgroundColor = .gray
        
        vw2.frame = CGRect(x: 28, y: 0, width: 4, height: 4)
        vw2.layer.cornerRadius = vw2.bounds.height/2
        vw2.backgroundColor = .gray
        
        viewPageController.addSubview(vwCurrentPage)
        viewPageController.addSubview(vw1)
        viewPageController.addSubview(vw2)
        
        pickerView.backgroundColor = .white
        
        loopingImg()
    }
    
    
    func loopingImg(){
        imgPhone.image = UIImage(named: "phoneLeague1")
        DispatchQueue.main.asyncAfter(deadline: .now()+2){
            self.imgPhone.image = UIImage(named: "phoneLeague1")
            UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: { [self] in
                    self.imgPhone.image = UIImage(named: "phoneLeague2")
                    self.contentView.backgroundColor = UIColor(red: 255/255, green: 145/255, blue: 144/255, alpha: 1)
                    self.lblFirst.text = "Leagues"
                    self.lblSecond.text = "Start trading with virtual money and learn the ins and outs of the stock market"
                    vw1.frame = CGRect(x: 0, y: 0, width: 4, height: 4)
                    vwCurrentPage.frame = CGRect(x: 8, y: 0, width: 16, height: 4)
                
            }, completion: nil)
            DispatchQueue.main.asyncAfter(deadline: .now()+2){
                UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: { [self] in
                    
                        self.imgPhone.image = UIImage(named: "phoneLeague3")
                        self.contentView.backgroundColor = UIColor(red: 1/255, green: 216/255, blue: 148/255, alpha: 1)
                        self.lblFirst.text = "Win Rewards"
                        self.lblSecond.text = "Build your portfolio and get to the top of the leaderboards to win exciting rewards"
                    vw2.frame = CGRect(x: 8, y: 0, width: 4, height: 4)
                    vwCurrentPage.frame = CGRect(x: 16, y: 0, width: 16, height: 4)
                    
                }, completion: nil)
                DispatchQueue.main.asyncAfter(deadline: .now()+2){ [self] in
                    self.imgPhone.image = UIImage(named: "phoneLeague1")
                    self.contentView.backgroundColor = UIColor(red: 223/255, green: 203/255, blue: 255/255, alpha: 1)
                    self.lblFirst.text = "Welcome to FTL"
                    self.lblSecond.text = "Play virtual trading games on crypto and stocks"
                    vwCurrentPage.frame = CGRect(x: 0, y: 0, width: 16, height: 4)
                    vw1.frame = CGRect(x: 20, y: 0, width: 4, height: 4)
                    vw2.frame = CGRect(x: 28, y: 0, width: 4, height: 4)
                    loopingImg()
                }
            }
        }
    }
    
    @IBAction func btnChexBoxAct(_ sender: Any) {
        if imgCheckBox.image == UIImage(named: "UncheckBox"){
            imgCheckBox.image = UIImage(named: "CheckBox")
        }else {
            imgCheckBox.image = UIImage(named: "UncheckBox")
        }
    }
    
    @IBAction func btnISDAct(_ sender: Any) {
        if pickerView.isHidden{
            pickerView.isHidden = false
        }
        
    }
    
    @IBAction func btnTermNCondition(_ sender: Any) {
        guard let url = URL(string: "https://fantasytradingleague.com/terms-conditions.html") else { return }
        UIApplication.shared.open(url)
    }
    
    @IBAction func btnGetStartedAct(_ sender: Any) {
        if (txtMobileNumber.text!.count == 10) {
            if (imgCheckBox.image == UIImage(named: "CheckBox")){
                sendOTP()
            }else{
                print("term & condition")
                Loaf("please agree term & condition",state: .custom(.init(backgroundColor: UIColor(red: 255/255, green: 235/255, blue: 204/255, alpha: 1),textColor: .red, icon:UIImage(named: "errorIcon"), width: .screenPercentage(0.8))), sender: self).show(.custom(1.5))
            }
        }else{
            print("invalid Mobile")
            Loaf("enter valid mobile number", state: .custom(.init(backgroundColor: UIColor(red: 255/255, green: 235/255, blue: 204/255, alpha: 1),textColor: .red, icon:UIImage(named: "errorIcon"), width: .screenPercentage(0.76))), sender: self).show(.custom(1.5))
        }
    }
    
}


//MARK: Picker view for ISD code
extension LoginVC: UIPickerViewDelegate, UIPickerViewDataSource{
    
    internal func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrISD.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let obj:ISDCodeModel = arrISD[row]
        return obj.isdCode
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let obj:ISDCodeModel = arrISD[row]
        self.lblISDcode.text = obj.isdCode
        pickerView.isHidden = true
    }
    
}



//MARK: extension for APIs
extension LoginVC{
    func getISDcode(){
        if Connectivity.isConnectedToInternet(){
        let url = Api_Constants.baseUrl + Api_Constants.getIsdCode
        ApiManager.getISDcode(url: url) {(response: JSON?, error:Error?, statusCode: Int) in
            if let error = error{
                print(error)
                return
            }
            if let response = response{
                let x = response["data"]["isdCodes"]
                if response["status"] == true{
                    for i in 0...x.count-1{
                        let obj:ISDCodeModel = ISDCodeModel.isdCodeDataModel(dataArray: x[i])
                        self.arrISD.append(obj)
                    }
                }
                self.pickerView.reloadAllComponents()
            }else{
                print("Somthing wrong")
            }
        }
        }else{
            Loaf("Active internet connection required", state: .custom(.init(backgroundColor: UIColor(red: 255/255, green: 235/255, blue: 204/255, alpha: 1),textColor: .red, icon:UIImage(named: "errorIcon") ,width: .screenPercentage(0.9))), sender: self).show(.custom(1.5))
        }
    }
    
    
    func sendOTP(){
        if Connectivity.isConnectedToInternet() {
        let url = Api_Constants.baseUrl + Api_Constants.sendOtp
        let param:[String:Any] = ["isdCode":self.lblISDcode.text!,"mobile":self.txtMobileNumber.text!]
        ApiManager.sendOTP(url: url, params: param ) {(response: JSON?, error:Error?, statusCode: Int) in
            if let error = error{
                print(error)
                return
            }
            if let response = response{
                print(response)
                if response["status"] == true {
                    let vc = OtpVC.init(nibName: "OtpVC", bundle: nil)
                    vc.isdCode = self.lblISDcode.text!
                    vc.mobileNumber = self.txtMobileNumber.text!
                    self.navigationController?.pushViewController(vc, animated: true)
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
