//
//  StockModel.swift
//  FTL
//
//  Created by Varun Kumar Raghav on 31/03/22.
//

import Foundation

class StockModel {
    var title: String
    var subtitle: String
    var stockPrice: Double
    var isSelected: Bool
    var statusPercent: Double
    
    init(title: String, subtitle: String, stockPrice: Double, isSelected: Bool = false, statusPercent: Double){
        self.title = title
        self.subtitle = subtitle
        self.stockPrice = stockPrice
        self.isSelected = isSelected
        self.statusPercent = statusPercent
    }
}

class CryptoModel {
    var title: String
    var subtitle: String
    var cryptoPrice: Double
    var isSelected: Bool
    var statusPercent: Double
    
    init(title: String, subtitle: String, cryptoPrice: Double, isSelected: Bool = false, statusPercent: Double){
        self.title = title
        self.subtitle = subtitle
        self.cryptoPrice = cryptoPrice
        self.isSelected = isSelected
        self.statusPercent = statusPercent
    }
}
