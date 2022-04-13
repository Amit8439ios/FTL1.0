//
//  File.swift
//  FTL
//
//  Created by amit toroi on 20/03/22.
//

import Foundation
import Alamofire
import SwiftyJSON



class Connectivity {
    class func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}

class ApiManager: NSObject{
    
    class func getHeaderContentMulti() -> HTTPHeaders{
        let headers:HTTPHeaders = [
            "Content-Type":"multipart/form-data"
        ]
        return headers
    }
    
    //MARK: ISD Code Api
    class func getISDcode(url:String, completionHandler: @escaping (_ response:JSON?, _ error:Error?, _ status: Int) -> ()) {
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: nil).responseJSON{
            response in
//            print(response)
            switch response.result{
            case .success(_):
                if let data = response.value{
                            let json = JSON(data)
                            completionHandler(json,nil, response.response!.statusCode)
                        }
            case .failure(_):
//                completionHandler(nil, Error(msg: "Fail"), 400)
                print("Error: 400")
            }
            
        }
    }
    
    
    //MARK: Send OTP Api
    class func sendOTP(url:String, params: [String:Any], completionHandler: @escaping (_ response:JSON?, _ error:Error?, _ status: Int) -> ()) {
        print(params)
        AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON{
            response in
//            print(response)
            switch response.result{
            case .success(_):
                if let data = response.value{
                            let json = JSON(data)
                            completionHandler(json,nil, response.response!.statusCode)
                        }
            case .failure(_):
//                completionHandler(nil, Error(msg: "Fail"), 400)
                print("Error: 400")
            }
            
        }
    }
    
    
    //MARK: Verify OTP Api
    class func verifyOtp(url:String, params: [String:Any], completionHandler: @escaping (_ response:JSON?, _ error:Error?, _ status: Int) -> ()) {
        print(params)
        AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON{
            response in
//            print(response)
            switch response.result{
            case .success(_):
                if let data = response.value{
                            let json = JSON(data)
                            completionHandler(json,nil, response.response!.statusCode)
                        }
            case .failure(_):
//                completionHandler(nil, Error(msg: "Fail"), 400)
                print("Error: 400")
            }
            
        }
    }
    
    
    //MARK: Save User Details Api
    class func saveUserDetails(url:String, params: [String:Any], completionHandler: @escaping (_ response:JSON?, _ error:Error?, _ status: Int) -> ()) {
        AF.request(url, method: .patch, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON{
            response in
//            print(response)
            switch response.result{
            case .success(_):
                if let data = response.value{
                            let json = JSON(data)
                            completionHandler(json,nil, response.response!.statusCode)
                        }
            case .failure(_):
//                completionHandler(nil, Error(msg: "Fail"), 400)
                print("Error: 400")
            }
            
        }
    }
    
    
    //MARK: Get Referral Amount Api
    class func getreferralAmount(url:String, completionHandler: @escaping (_ response:JSON?, _ error:Error?, _ status: Int) -> ()) {
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: nil).responseJSON{
            response in
            switch response.result{
            case .success(_):
                if let data = response.value{
                            let json = JSON(data)
                            completionHandler(json,nil, response.response!.statusCode)
                        }
            case .failure(_):
                print("Error: 400")
            }
            
        }
    }
    
    //MARK: Get Wallet Balance Api
    class func getWalletBalance(url:String, completionHandler: @escaping (_ response:JSON?, _ error:Error?, _ status: Int) -> ()) {
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: nil).responseJSON{
            response in
            switch response.result{
            case .success(_):
                if let data = response.value{
                            let json = JSON(data)
                            completionHandler(json,nil, response.response!.statusCode)
                        }
            case .failure(_):
                print("Error: 400")
            }
            
        }
    }
    
    
    //MARK: Generate Token
    class func generateToken(url:String, completionHandler: @escaping (_ response:JSON?, _ error:Error?, _ status: Int) -> ()) {
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: nil).responseJSON{
            response in
            switch response.result{
            case .success(_):
                if let data = response.value{
                            let json = JSON(data)
                            completionHandler(json,nil, response.response!.statusCode)
                        }
            case .failure(_):
                print("Error: 400")
            }
            
        }
    }
    
    
    //MARK: get Wallet Transaction
    class func getWalletTransaction(url:String, completionHandler: @escaping (_ response:JSON?, _ error:Error?, _ status: Int) -> ()) {
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: nil).responseJSON{
            response in
            switch response.result{
            case .success(_):
                if let data = response.value{
                            let json = JSON(data)
                            completionHandler(json,nil, response.response!.statusCode)
                        }
            case .failure(_):
                print("Error: 400")
            }
            
        }
    }
    
    
    //MARK: add Money to wallet API
    class func addMoneyInWallet(url:String, params: [String:Any], completionHandler: @escaping (_ response:JSON?, _ error:Error?, _ status: Int) -> ()) {
        AF.request(url, method: .patch, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON{
            response in
//            print(response)
            switch response.result{
            case .success(_):
                if let data = response.value{
                            let json = JSON(data)
                            completionHandler(json,nil, response.response!.statusCode)
                        }
            case .failure(_):
                print("Error: 400")
            }
            
        }
    }
    
    
    //MARK: Redeem money to wallet
    class func redeemInWallet(url:String, params: [String:Any], completionHandler: @escaping (_ response:JSON?, _ error:Error?, _ status: Int) -> ()) {
        AF.request(url, method: .patch, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON{
            response in
//            print(response)
            switch response.result{
            case .success(_):
                if let data = response.value{
                            let json = JSON(data)
                            completionHandler(json,nil, response.response!.statusCode)
                        }
            case .failure(_):
                print("Error: 400")
            }
            
        }
    }
    
    //MARK: check KYC
    class func getKYCdetails(url:String, completionHandler: @escaping (_ response:JSON?, _ error:Error?, _ status: Int) -> ()) {
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: nil).responseJSON{
            response in
            switch response.result{
            case .success(_):
                if let data = response.value{
                            let json = JSON(data)
                            completionHandler(json,nil, response.response!.statusCode)
                        }
            case .failure(_):
                print("Error: 400")
            }
            
        }
    }
    
    //MARK: verify PAN Details
    class func verifyPAN(url:String, params: [String:Any], completionHandler: @escaping (_ response:JSON?, _ error:Error?, _ status: Int) -> ()) {
        AF.request(url, method: .patch, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON{
            response in
//            print(response)
            switch response.result{
            case .success(_):
                if let data = response.value{
                            let json = JSON(data)
                            completionHandler(json,nil, response.response!.statusCode)
                        }
            case .failure(_):
                print("Error: 400")
            }
            
        }
    }
    
    
    //MARK: Get Bank Details Api
    class func getBankDetails(url:String, completionHandler: @escaping (_ response:JSON?, _ error:Error?, _ status: Int) -> ()) {
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: nil).responseJSON{
            response in
            switch response.result{
            case .success(_):
                if let data = response.value{
                            let json = JSON(data)
                            completionHandler(json,nil, response.response!.statusCode)
                        }
            case .failure(_):
                print("Error: 400")
            }
            
        }
    }
    
    
    //MARK: Withdraw request Api
    class func withdrawRequest(url:String, params: [String:Any], completionHandler: @escaping (_ response:JSON?, _ error:Error?, _ status: Int) -> ()) {
        print(params)
        AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON{
            response in
//            print(response)
            switch response.result{
            case .success(_):
                if let data = response.value{
                            let json = JSON(data)
                            completionHandler(json,nil, response.response!.statusCode)
                        }
            case .failure(_):
//                completionHandler(nil, Error(msg: "Fail"), 400)
                print("Error: 400")
            }
            
        }
    }
    
    
    //MARK: Get Watchlist Api
    class func getWatchlist(url:String, completionHandler: @escaping (_ response:JSON?, _ error:Error?, _ status: Int) -> ()) {
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: nil).responseJSON{
            response in
            switch response.result{
            case .success(_):
                if let data = response.value{
                            let json = JSON(data)
                            completionHandler(json,nil, response.response!.statusCode)
                        }
            case .failure(_):
                print("Error: 400")
            }
            
        }
    }
}
