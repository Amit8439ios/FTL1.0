//
//  Validation.swift
//  Mockstoc
//
//  Created by amit toroi on 19/08/21.
//

import Foundation
import UIKit

class Validation {
    
    static func isBlank(for text: String?) -> Bool {
        return text?.trim().count == 0
    }
    
    static func isValidSiretNo(for no: String) -> Bool {
        return no.trim().replacingOccurrences(of: " ", with: "").count >= 14
    }
    
    static func isValidNumber(for no: String) -> Bool {
        let pattern = "^[A-Z]{2}[ -][0-9]{1,2}(?: [A-Z])?(?: [A-Z]*)? [0-9]{4}$"
        let noTest = NSPredicate(format:"SELF MATCHES %@", pattern)
        return noTest.evaluate(with: no.trim())
    }
    
    static func isValidEmail(for email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email.trim())
    }
    
    static func isValidPassword(for password: String) -> Bool {
        let passRegex = "^(?=.[a-z])(?=.[A-Z])(?=.\\d)(?=.[$@$!%?&#])[A-Za-z\\d$@$!%?&#]{8,30}"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passRegex)
        return passwordTest.evaluate(with: password)
    }
    
    static func isPasswordMatched(for password: String, for rePassword: String) -> Bool {
        return password.trim() == rePassword.trim()
    }
    
    static func isValidDate(dateString: String) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.none
        dateFormatter.locale = Locale(identifier: "fr")
        if let _ = dateFormatter.date(from: dateString) {
            return true
        } else {
            return false
        }
    }
    
    static func isValidName(value: String) -> Bool {
        let nameRegex = ".[^A-Za-z ]."
        let nameTest = NSPredicate(format: "SELF MATCHES %@", nameRegex)
        return nameTest.evaluate(with: value)
    }
    
    static func isValidMobileNumber(value: String) -> Bool {
        let PHONE_REGEX = "^[0-9]{6,14}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: value.trim())
        return result
    }
    
    static func isPostalCodeNumber(value: String) -> Bool {
        let PHONE_REGEX = "^[0-9]{5}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: value.trim())
        return result
    }
    static func isCvvNumber(value: String) -> Bool {
        let PHONE_REGEX = "^[0-9]{3,4}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: value.trim())
        return result
    }
}


extension String{
    func trim() -> String{
        return self.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
    }
    
    var isPhonenumber : Bool{
        do{
            let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.phoneNumber.rawValue)
            let matches = detector.matches(in: self, options: [], range: NSMakeRange(0, self.count))
            if let res = matches.first{
                return res.resultType == .phoneNumber && res.range.location == 0 && res.range.location == self.count && self.count == 10
            }else{
                return false
            }
        }catch{
            return false
        }
    }
    
    var isValidEmail: Bool{
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    var isValidName:Bool {
        let nameRegex = ".[^A-Za-z ]."
        let nameTest = NSPredicate(format: "SELF MATCHES %@", nameRegex)
        return nameTest.evaluate(with: self)
    }
}


//extension Date{
//    var millisecondsSince1970:Int64 {
//        let currentDate = NSDate()
//        let dateFormatter = DateFormatter()
//        let date = dateFormatter.date(from: dateFormatter.string(from: currentDate as Date))
//        let nowDouble = date!.timeIntervalSince1970
//            return Int64((nowDouble).rounded())
//        }
//}
