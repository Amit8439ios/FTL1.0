//
//  TransactionHoistoryModel.swift
//  FTL
//
//  Created by amit toroi on 12/04/22.
//

import Foundation
import SwiftyJSON

class TransactionHoistoryModel:NSObject{
    var _id = ""
    var userId = ""
    var orderId = ""
    var amount = 0
    var type = ""
    var transactionType = ""
    var desc = ""
    var createdAt = ""
    var updatedAt = ""
    
    class func transactionHistoryDataModel(dataArray :JSON) -> TransactionHoistoryModel {

        let obj = TransactionHoistoryModel()
            
        obj._id = dataArray["_id"].stringValue
        obj.userId = dataArray["userId"].stringValue
        obj.orderId = dataArray["orderId"].stringValue
        obj.amount = dataArray["amount"].intValue
        obj.type = dataArray["type"].stringValue
        obj.transactionType = dataArray["transactionType"].stringValue
        obj.desc = dataArray["desc"].stringValue
        obj.createdAt = dataArray["createdAt"].stringValue
        obj.updatedAt = dataArray["updatedAt"].stringValue
        
        return obj
    }
}
