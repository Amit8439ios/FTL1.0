//
//  AddMoneyVC.swift
//  FTL
//
//  Created by amit toroi on 23/03/22.
//

import UIKit

class AddMoneyVC: UIViewController {

    @IBOutlet var view1: UIView!
    @IBOutlet var viewEnterAmount: UIView!
    @IBOutlet var btn50: UIButton!
    @IBOutlet var btn100: UIButton!
    @IBOutlet var btn250: UIButton!
    @IBOutlet var btn500: UIButton!
    @IBOutlet var btn1000: UIButton!
    @IBOutlet var txtAmount: UITextField!
    @IBOutlet var btnPay: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.txtAmount.addTarget(btnPay, action: #selector(UIButton.input(textField:)), for: .editingChanged)
        
    }

    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.isNavigationBarHidden = true
        
        view1.layer.cornerRadius = 24
        view1.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        viewEnterAmount.layer.cornerRadius = viewEnterAmount.bounds.height/2
        
        btn50.layer.cornerRadius = btn50.bounds.height/2
        btn50.layer.borderWidth = 1
        btn50.layer.borderColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1).cgColor
        btn100.layer.cornerRadius = btn100.bounds.height/2
        btn100.layer.borderWidth = 1
        btn100.layer.borderColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1).cgColor
        btn250.layer.cornerRadius = btn250.bounds.height/2
        btn250.layer.borderWidth = 1
        btn250.layer.borderColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1).cgColor
        btn500.layer.cornerRadius = btn500.bounds.height/2
        btn500.layer.borderWidth = 1
        btn500.layer.borderColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1).cgColor
        btn1000.layer.cornerRadius = btn1000.bounds.height/2
        btn1000.layer.borderWidth = 1
        btn1000.layer.borderColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1).cgColor
    }

    
    
    @IBAction func btnBackAct(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnPay(_ sender: Any) {
        print("Money Added")
    }
}


extension AddMoneyVC: UITextFieldDelegate{
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
    return true
    }
}

extension UIButton{
    @objc func input(textField: UITextField) {
        self.setTitle("PAY \(textField.text!)", for: .normal)
        }
}
