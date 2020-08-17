//
//  AlamofireError.swift
//  WeatherMe
//
//  Created by Valeriy Kovalevskiy on 8/17/20.
//  Copyright © 2020 Valeriy Kovalevskiy. All rights reserved.
//

import Foundation
import Alamofire

class AlamofireError: Error {
    
    var code = 0
    var message = ""
    var fields: String?
    
    init?(errorDict: [String : Any]) {
        if let code = errorDict["code"] as? Int {
            self.code = code
        }
        switch code {
        case 100, 103, 104, 105:
            message = "Server Error"
        case 101:
            message = "Your app version is outdated. Please download a new version from appstore."
        case 102:
            message = "Invalid access token"
        case 200:
            message = "Invalid Login"
        case 201:
            message = "Invalid Password"
        case 203:
            message = "Access Forbiden"
        case 400:
            message = "Invalid login or password"
        case 503:
            message = "OOPSie we scrued up somewhere. Please inform the support team."
        case -1001:
            message = "Request timed out"
        case -1009:
            message = "No internet connection"
        default:
            if let message = errorDict["code"] as? String {
                self.message = message
            } else {
                message = "Unknown error"
            }
        }
    }
    
    init(from code: Int) {
        self.code = code
        switch code {
        case 400, 403:
            message = "Invalid login or password"
        case 503:
            message = "OOPSie we scrued up somewhere. Please inform the support team."
        case 401:
            message = "Invalid login or password"
        case -1001:
            message = "Request timed out"
        case -1009, 0:
            message = "No internet connection"
        default:
            message = "Unknown error"
        }
    }
    
    init(message: String) {
        self.message = message
        self.code = 0
    }
    
    init(code: Int, message: String) {
        self.message = message
        self.code = code
    }
    
    static func unknownError() -> AlamofireError {
        return AlamofireError(code: 0, message: "Unknown error")
    }
    
    static func handleErrorWith(_ responseData: Data?,
                                error: Error?,
                                errorHandler: NetworkErrorHandler) {
        do {
            if let responseData = responseData, let errorData = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String : Any] {
                
                if let imError = AlamofireError(errorDict: errorData) {
                    errorHandler(imError)
                } else {
                    errorHandler(AlamofireError.unknownError())
                }
            } else {
                if let error = error as? AFError, let code = error.responseCode {
                    errorHandler(AlamofireError(from: code))
                } else {
                    errorHandler(AlamofireError.unknownError())
                }
            }
        }
        catch _ {
            
            if let error = error {
                let err = AlamofireError(message: error.localizedDescription)
                if let error = error as? AFError, let code = error.responseCode {
                    err.code = code
                }
                errorHandler(err)
            } else {
                errorHandler(AlamofireError.unknownError())
            }
        }
    }
    
}
