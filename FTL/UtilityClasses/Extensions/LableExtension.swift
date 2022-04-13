//
//  LableExtension.swift
//  FTL
//
//  Created by amit toroi on 30/03/22.
//

import Foundation
import UIKit

extension UILabel{
    @objc func inputt(lbl: UILabel){
        if lbl.text == ""{
            self.text = "\u{20b9} 0"
        }else{
        self.text = "\u{20b9} \(lbl.text!)"
        }
    }
    
    
    
}
