//
//  ISDCodeModel.swift
//  FTL
//
//  Created by amit toroi on 20/03/22.
//

import Foundation
import SwiftyJSON

class ISDCodeModel:NSObject{
    var countryCode = ""
    var countryName = ""
    var isdCode = ""
    var countryFlag = ""
    
    
    class func isdCodeDataModel(dataArray :JSON) -> ISDCodeModel {

            
            let obj = ISDCodeModel()
            
            obj.countryCode = dataArray["countryCode"].stringValue
            obj.countryName = dataArray["countryName"].stringValue
            obj.isdCode = dataArray["isdCode"].stringValue
            obj.countryFlag = dataArray["countryFlag"].stringValue
        
        return obj
    }
}
