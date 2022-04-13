//
//  ApiConstants.swift
//  FTL
//
//  Created by amit toroi on 20/03/22.
//

import Foundation


class Api_Constants{
    
    static let baseUrl = "https://ftlbackend.herokuapp.com/"
    
    static let cashFreeAppId = "14378240b48259b0c1c988887f287341"
    
    //MARK: Login APIs
    static let getIsdCode  = "internal/getISDCodes"
    static let sendOtp = "users/sendOTP"
    static let verfifyOtp = "users/verifyOTP"
    static let saveDetails = "users/saveBasicDetail"
    
    //MARK: Wallet APIs
    static let getReferralAmount = "internal/getReferralAmount"
    static let getWalletBalance = "wallet/getWalletBalance"
    static let generateToken = "wallet/generateToken"
    static let getWalletTransactions = "wallet/getWalletTransactions"
    static let addMoneyToWallet = "wallet/addMoney"
    static let redeemToWallet = "wallet/redeemWinnings"
    static let isKYC = "wallet/getKYC"
    static let registerDocument = "wallet/registerDocument"
    static let getBankDetail = "wallet/getBankDetail"
    static let requestTransfer = "wallet/requestTransfer"
    
//    MARK: Watchlist APIs
    static let getWatchlist = "watchlist/getWatchlist"
}
