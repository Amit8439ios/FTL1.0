//
//  ButtonExtension.swift
//  FTL
//
//  Created by amit toroi on 30/03/22.
//

import Foundation
import UIKit

extension UIButton{
    @objc func corner(button:UIButton){
        button.layer.cornerRadius = button.bounds.height/2
    }
    
    
    @objc func input(textField: UITextField) {
        self.setTitle("PAY \(textField.text!)", for: .normal)
    }
}
