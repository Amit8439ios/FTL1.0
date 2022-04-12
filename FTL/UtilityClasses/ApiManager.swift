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
    
}
